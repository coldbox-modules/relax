/**
* Copyright Ortus Solutions, Corp, All rights reserved
* www.ortussolutions.com
* ---
* Translator for RelaxDSL APIs in to OpenAPI Format
*  
* @deprecate v3.0.0
*/
component name="RelaxDSLTranslator" accessors="true" singleton{
	property name="wirebox" inject="wirebox";
	property name="moduleConfig" inject="coldbox:setting:relax";

	include "/relax/models/mixins/hashMap.cfm";

	public function onDIComplete(){
		/**
		* Variable mixins used in translation
		**/
		//We need to use Linked Hashmaps to maintain struct order for serialization and deserialization
		VARIABLES.openAPITemplate = createLinkedHashMap();

		VARIABLES.templateDefaults = [ 
		{"swagger": "2.0"},
		{
		  "info": {
		      "version": "",
		      "title": "",
		      "description": "",
		      "termsOfService": "",
		      "contact": createLinkedHashMap(),
		      "license": createLinkedHashMap()
		    }
		},
		{"host": ""},
		{"basePath": ""},
		{"schemes": []},
		{"consumes": ["application/json","multipart/form-data","application/x-www-form-urlencoded"]},
		{"produces": ["application/json"]},
		{"paths": createLinkedHashMap()}

		];

		//Utility arrays for default methods and responses
		VARIABLES.HTTPMethods = [ "GET", "PUT", "POST" , "PATCH" , "DELETE" , "HEAD" ];
		VARIABLES.HTTPMethodResponses = [ 200, 200, 201, 200, 204, 204 ];
		for( var templateDefault  in  VARIABLES.templateDefaults ){

			for( var key in templateDefault ){
				VARIABLES.openAPITemplate[key] =  templateDefault[ key ];	
			}
		}

	}



	/**
	* Translates a RelaxDSL CFC in to the OpenAPI specification
	* @param dataCFC 		The Relax.cfc object to translate
	**/
	public function translate( required any dataCFC ){

		var OpenAPIParser = getWirebox().getInstance( "OpenAPIParser@relax" );

		var translation = duplicate(VARIABLES.openAPITemplate);

		translateGlobals( ARGUMENTS.dataCFC, translation );

		translatePaths( ARGUMENTS.dataCFC, translation );

		return OpenAPIParser.parse( translation );	
	}

	/**
	* Translate RelaxDSL global variables in to the OpenAPI specification
	* @param dataCFC 		The Relax.cfc object to translate
	* @param translation 	The translation template to append dataCFC globals
	**/
	private void function translateGlobals( required any dataCFC, required translation ){
		
		var relax = ARGUMENTS.dataCFC.relax;

		for( var key in relax ){
			if( structKeyExists( translation, key ) ) translation[ key ] = relax[ key ];
			if( structKeyExists( translation[ "info" ], key ) ) translation[ "info" ][ key ] = relax[ key ];			
		}


		translateMimeTypes( dataCFC, translation );

		translateSecurityDefinitions( dataCFC, translation );

		translateURLs( dataCFC, translation );

		processGlobalExtensions( dataCFC, translation );

	}

	/**
	* Translate RelaxDSL mimetype annotations in to full mimetype values
	* @param dataCFC 		The Relax.cfc object to translate
	* @param translation 	The translation template to append dataCFC globals
	**/
	private void function translateMimeTypes( required any dataCFC, required translation ){
		var relax = dataCFC.relax;

		if( structKeyExists( relax, "validExtensions" ) ){
			translation[ "produces" ] = listToArray( relax.validExtensions );
		}

		for( var i = 1; i <= arrayLen( translation["produces"] ); i++ ){
			//skip valid mimetypes
			if( listLen( translation["produces"][ i ], "/" ) > 1 ) continue;

			if( !REFindNoCase( translation["produces"][ i ], "html|plain|template" ) ){
				translation["produces"][ i ] = "application/" & translation["produces"][ i ];
			} else {
				translation["produces"][ i ] = "text/" & translation["produces"][ i ];
			}
		}
	}

	/**
	* Translate RelaxDSL security headers in to OpenAPI security definitions
	* @param dataCFC 		The Relax.cfc object to translate
	* @param translation 	The translation template to append dataCFC globals
	**/
	private void function translateSecurityDefinitions( required any dataCFC, required translation ){
		for ( var header in dataCFC.globalHeaders ){
			if( !structKeyExists( translation, "securityDefinitions" ) ) translation[ "securityDefinitions" ] = createLinkedHashMap();

			translation[ "securityDefinitions" ][ header[ "name" ] ] = {
				"type" : structKeyExists( header, "type" ) ? ( header[ "type" ] == "string" ? "basic" : header[ "type" ] ) : "basic",
				"name" : header[ "name" ],				
				"description" : structKeyExists( header, "description" ) ? header[ "description" ] : "",
				"in" : "header"
			};
			//override our special type if the header value is an api key
			if( findNoCase( header[ "name" ], "api" ) && findNocCase( header[ "nane" ], "key" ) ) translation[ "securityDefinitions" ][ header[ "name" ] ].type = "apiKey";
		}

	}

	/**
	* Translate RelaxDSL entry points in to the OpenAPI specification
	* @param dataCFC 		The Relax.cfc object to translate
	* @param translation 	The translation template to append dataCFC globals
	**/
	private void function translateURLs( required any dataCFC, required translation ){
		var relax = dataCFC.relax;
		if( isSimpleValue( relax.entryPoint ) ) relax.entryPoint = { "production" : relax.entryPoint };
		for( var key in relax.entryPoint ){
			var entryPointArray = listToArray( replaceNoCase( relax.entryPoint[key] , "//", "/", "ALL"), "/" );
			translation[ "schemes" ] = listFirst( entryPointArray[ 1 ], ":" );
			arrayDeleteAt( entryPointArray, 1 );
			translation[ "host" ] = REReplaceNoCase( entryPointArray[ 1 ], "http://|https://", "", "ALL" );
			arrayDeleteAt( entryPointArray, 1 );
			translation[ "basePath" ] = "/";
			if( arrayLen( entryPointArray ) ) translation[ "basePath" ] = translation[ "basePath" ] & arrayToList( entryPointArray, "/" );
		}
	}

	/**
	* Translate RelaxDSL Coldbox attributes in to OpenAPI extensions
	* @param dataCFC 		The Relax.cfc object to translate
	* @param translation 	The translation template to append dataCFC globals
	**/
	private void function processGlobalExtensions( required any dataCFC, required translation ){
		var relax = dataCFC.relax;
		var extensions = [ "extensionDetection", "throwOnInvalidExtension", "entryPoint" ];

		for( var ext in extensions ){
			if( structKeyExists( relax, ext ) ){
				translation[ "x-" & trim(ext) ] = relax[ ext ];
			}
		}
	}

	/**
	* Translate RelaxDSL resources in to OpenAPI paths
	* @param dataCFC 		The Relax.cfc object to translate
	* @param translation 	The translation template to append dataCFC globals
	**/
	private function translatePaths( required any dataCFC, required translation ){
		var resources = dataCFC.resources;

		for ( var resource in resources ){
			pathKey = translatePathKey( resource.pattern );
			translation[ "paths" ].put( pathkey, {
				"x-resourceId": resource.resourceId
			} );
			
			translatePathMethods( translation[ "paths" ][ pathKey ], resource, translation );
		}
		
	}

	/**
	* Translate RelaxDSL Coldbox routes to use OpenAPI placeholders
	* @param pattern 		The pattern to be translated
	**/
	private string function translatePathKey( pattern ){
		var paths = listToArray( pattern, "/" );
		for ( var i = 1; i <= arrayLen( paths ); i++ ){
			var path = paths[ i ];
			if( left( path, 1 ) == ":" ){
				paths[ i ] = "{" & right( path, len( path )-1 ) & "}";
			}
		}

		return "/" & arrayToList( paths, "/" );
	}

	/**
	* Translate RelaxDSL resource patterns in to OpenAPI path methods
	* @param path 			The path struct to be appended
	* @param resource 		The RelaxDSL resource to be translated
	* @param translation 	The top-level translation object - used as a reference for params
	**/
	private void function translatePathMethods( 
		required struct path, 
		required struct resource, 
		required translation 
	){
		pathKey = translatePathKey( resource.pattern );

		//handle string action values for consistent formatting
		if( isSimpleValue( resource.action ) ) {

			resource.handlerMethod = resource.action;
			resource.action = createLinkedHashMap();
			resource.action.put( resource.defaultMethod, resource.action );

			var allowedMethods = listToArray( resource.methods );

			for( method in allowedMethods ){
				if( method != resource.defaultMethod ){
					resource.action.put( method, resource.action[ resource.defaultMethod ] );
				}
			}
		}

		//assembly begins
		for( var HTTPMethod in resource.action ){
			if( 
				!findNoCase( 'x-', HTTPMethod )
				&&
				structKeyExists( resource, "handlerMethod" ) 
				&& 
				isSimpleValue( resource.handlerMethod ) 
				&& 
				len( resource.handlerMethod ) 
				&&
				!isStruct( resource.handlerMethod )
			){
				var operationalAction = "." & resource.handlerMethod;
			} else {
				var operationalAction = "";
			}

			path.put( lcase( HTTPMethod ), {
				"description": structKeyExists( resource,"description" ) ? resource.description : "",
				"operationId" : resource.handler & operationalAction,
				"produces": translation["produces"],
				"responses" : createLinkedHashMap(),
				"parameters" : createLinkedHashMap(),
				"x-resourceId": lcase( hash( pathKey & lcase( HTTPMethod ) ) ),
				"x-coldbox-handler" : resource.handler
			});

			if( !len( trim( path[ lcase( HTTPMethod ) ][ "operationId" ] ) ) ){
				structDelete( path[ lcase( HTTPMethod ) ], "operationId" );
			}


			//handle our URL placeholders
			for( var placeholder in resource.placeholders ){
				path[ lcase( HTTPMethod ) ]["parameters"].put( placeholder.name, {
					"in": "path",
					"description" : ( structKeyExists( placeholder,"description" ) ? placeholder.description : "" ),
					"required": javacast( "boolean", placeholder.required ),
					"type" : structKeyExists( placeholder, "type" ) ? placeholder.type : "string" ,
					"x-defaultValue" :	structKeyExists( placeholder, "defaultValue" ) ? placeholder.defaultValue : ""
				} );
			}
		}

		//append parameter information to our paths
		processPathParameters( path, resource );

		//append schema as responses
		processPathSchemas( path, resource );

		//append samples as extended attributes
		processPathSamples( path, resource );

	}

	/**
	* Processes RelaxDSL resource parameters
	* @param path 			The OpenAPI doc path to append the params
	* @param resource 		The RelaxDSL resource
	**/
	private function processPathParameters( required path, resource ){
		for( var param in resource[ "parameters" ]){
			var appendTo = [];
			for( var method in VARIABLES.HTTPMethods ){
				if( findNoCase( " " & method & " " , param.description ) ){
					arrayAppend( appendTo, method );
				}
			}
			//append to all if we didn't find an HTTP method reference
			if( !arrayLen( appendTo ) ) appendTo = VARIABLES.HTTPMethods;

			for ( var method in appendTo ){
				if( structKeyExists( path, lcase( method ) ) ){
					path[ lcase( method ) ]["parameters"].put( param.name, {
						"in": ( method == "GET" ? "query" : "formData" ),
						"description" : ( structKeyExists( param,"description" ) ? param.description : "" ),
						"required": javacast( "boolean", param.required ),
						"type": param.type
					} );
				}
			}
		}
	}

	/**
	* Processes RelaxDSL resource schemas
	* @param path 			The OpenAPI doc path to append the schemas
	* @param resource 		The RelaxDSL resource
	**/
	private function processPathSchemas( required path, required resource ){
		if( structKeyExists( resource.response, "schemas" ) ){
			for ( var schema in resource.response[ "schemas" ] ){
			
				//RelaxDSL doesn't provide status codes, so we'll use our defaults
				var schemaDefinition = {
					"description" : schema[ "description" ],
					"schema" : {
						"type" : "object"
					},
					"examples" : createLinkedHashMap()
				};

				switch( schema[ "format" ] ){
					case "json":
						var body = deserializeJSON( schema[ "body" ]);
						var mimeType = "application/json";
						break;	
					case "xml":
						var body = schema[ "body" ];
						var mimeType = "application/xml";
	
						break;
					default:
						var body = schema[ "body" ];
						var mimeType = REFindNoCase( schema[ "format" ], "html|text|string" ) ? "text/" & schema[ "format" ] : "application/" & schema[ "format" ];			
				}

				schemaDefinition[ "examples" ].put( mimeType, body );


				for( var methodKey in path ){
					var methodPosition = arrayFindNoCase( VARIABLES.HTTPMethods, methodKey );
					if( methodPosition ){
						var statusCode = VARIABLES.HTTPMethodResponses[ methodPosition ];

						if( !structKeyExists( path[ methodKey ][ "responses" ], statusCode) ){
							
							path[ methodKey ][ "responses" ].put( javacast('string',statusCode), schemaDefinition );
						
						} else if( structKeyExists( path[ methodKey ][ "responses" ], statusCode ) ) {

							if( structKeyExists( path[ methodKey ][ "responses" ][ statusCode ][ "examples" ], mimeType ) ){
							
								path[ methodKey ][ "responses" ].put( "default", schemaDefinition );
							
							} else {

								path[ methodKey ][ "responses" ][ statusCode ][ "examples" ].put( mimeType, schemaDefinition[ "examples" ][ mimeType ] );							
							}
						
							
						
						}	
					}
				}

			}	
		}
	}

	/**
	* Processes RelaxDSL samples to the paths
	* @param path 			The OpenAPI doc path to append the samples
	* @param resource 		The RelaxDSL resource
	**/	
	private function processPathSamples( required path, required resource ){
		if( structKeyExists( resource.response, "samples" ) ){
			for ( var sample in resource.response[ "samples" ] ){
			
				//RelaxDSL doesn't provide status codes, so we'll use our defaults
				var sampleDefinition = {
					"description" : sample[ "description" ],
					"sample" : {
						"type" : "object"
					},
					"examples" : createLinkedHashMap()
				};

				switch( sample[ "format" ] ){
					case "json":
						var body = deserializeJSON( sample[ "body" ]);
						var mimeType = "application/json";
						break;	
					case "xml":
						var body = sample[ "body" ];
						var mimeType = "application/xml";
	
						break;
					default:
						var body = sample[ "body" ];
						var mimeType = REFindNoCase( sample[ "format" ], "html|text|string" ) ? "text/" & sample[ "format" ] : "application/" & sample[ "format" ];			
				}


				sampleDefinition[ "examples" ].put( mimeType, body );


				for( var methodKey in path ){
					var methodPosition = arrayFindNoCase( VARIABLES.HTTPMethods, methodKey );
					if( methodPosition ){
						var statusCode = VARIABLES.HTTPMethodResponses[ methodPosition ];
						
						if( !structKeyExists( path[ methodKey ], "x-request-samples" ) ){
							path[ methodKey ].put( "x-request-samples", sampleDefinition );
						} else {

							if( structKeyExists( path[ methodKey ][ "x-request-samples" ]["examples"], mimeType ) ){

								path[ methodKey ][ "x-request-samples" ]["examples"].put( "default", sampleDefinition[ "examples" ][ mimeType ] );
							
							} else {

								path[ methodKey ][ "x-request-samples" ]["examples"].put( mimeType, sampleDefinition[ "examples" ][ mimetype ] );
							
							}
						
							
						
						}	
					}
				}

			}	
		}
	}

}