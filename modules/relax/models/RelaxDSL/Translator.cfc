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

	//variable mixins for translation
	include "translatorMixins.cfm";

	public function init(  ){
	  for( var templateDefault  in  VARIABLES.templateDefaults ){
	    structAppend( VARIABLES.openAPITemplate, templateDefault );
	  }
	}

	public function translate( required any dataCFC ){
		var OpenAPIParser = getWirebox().getInstance( "OpenAPIParser@relax" );

		var translation = duplicate(VARIABLES.openAPITemplate);

		translateGlobals( dataCFC, translation );

		translatePaths( dataCFC, translation );

		return OpenAPIParser.parse( translation );	
	}

	private void function translateGlobals( required any dataCFC, required struct translation ){
		var relax = dataCFC.relax
		for( var key in relax ){
			if( structKeyExists( translation, key) ) translation[ key ] = relax[ key ];
			if( structKeyExists( translation[ "info" ], key) ) translation["info"][ key ] = relax[ key ];			
		}

		translateMimeTypes( dataCFC, translation );

		translateSecurityDefinitions( dataCFC, translation );

		translateURLs( dataCFC, translation );

		translateHeaders( dataCFC, translation );

		processGlobalExtensions( dataCFC, translation );

	}

	private void function translateMimeTypes( required any dataCFC, required struct translation ){
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

	private void function translateSecurityDefinitions( required any dataCFC, required struct translation ){
		for ( var header in dataCFC.globalHeaders ){
			if( !structKeyExists( translation, "securityDefinitions" ) ) translation[ "securityDefinitions" ] = createObject( "java", "java.util.LinkedHashMap" );

			translation[ "securityDefinitions" ][ header[ "name" ] ] = {
				"type" : structKeyExists( header, "type" ) ? ( header[ "type" ] == "string" ? "basic" : header[ "type" ] ) : "basic",
				"name" : header[ "name" ],				
				"description" : structKeyExists( header, "description" ) ? header[ "description" ] : "",
				"in" : "header"
			}
			//override our special type if the header value is an api key
			if( findNoCase( header[ "name" ], "api" ) && findNocCase( header[ "nane" ], "key" ) ) translation[ "securityDefinitions" ][ header[ "name" ] ].type = "apiKey";
		}

	}

	private void function translateURLs( required any dataCFC, required struct translation ){
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

	private void function processGlobalExtensions( required any dataCFC, required struct translation ){
		var relax = dataCFC.relax;
		var extensions = [ "extensionDetection", "throwOnInvalidExtension", "entryPoint" ]

		for( var ext in extensions ){
			if( structKeyExists( relax, ext ) ){
				translation[ "x-" & trim(ext) ] = relax[ ext ];
			}
		}
	}


	private function translateHeaders ( required any dataCFC, required struct translation ){
		
	}

	private function translatePaths( required any dataCFC, required struct translation ){
		var resources = dataCFC.resources;

		for ( var resource in resources ){
			pathKey = translatePathKey( resource.pattern );

			structAppend( translation[ "paths" ], 
			{
				"#pathkey#" : {
					"x-coldbox-handler" : resource.handler,
					"x-resource-id": resource.resourceId
				}
			} );
			
			translatePathMethods( translation[ "paths" ][ pathKey ], resource, translation );
		}
		
	}

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

	private void function translatePathMethods( 
		required struct path, 
		required struct resource, 
		required struct translation 
	){

		//handle string action values for consistent formatting
		if( isSimpleValue( resource.action ) ) {
			var defaultAction = resource.action;
			resource.action = createObject( "java", "java.util.LinkedHashMap" );
			
			structAppend( resource.action, {
					"#resource.defaultMethod#": resource.action
			} );

			var allowedMethods = listToArray( resource.methods );

			for( method in allowedMethods ){
				if( method != resource.defaultMethod ){
					structAppend( resource.action, {
						"#method#" : resource.action[ resource.defaultMethod ]
					} );
				}
			}
		}

		//assembly begins
		for( var HTTPMethod in resource.action ){
			structAppend( path, {
				"#lcase( HTTPMethod )#" = {
					"description": structKeyExists( resource,"description" ) ? resource.description : "",
					"produces": translation["produces"],
					"responses" : createObject( "java", "java.util.LinkedHashMap" ),
					"parameters" : createObject( "java", "java.util.LinkedHashMap" )
				}
			} );

			//handle our URL placeholders
			for( var placeholder in resource.placeholders ){
				structAppend( path[ lcase( HTTPMethod ) ]["parameters"], {
					"#placeholder.name#" = {
						"in": "path",
						"description" : ( structKeyExists( placeholder,"description" ) ? placeholder.description : "" ),
						"required": javacast( "boolean", placeholder.required ),
						"type" : structKeyExists( placeholder, "type" ) ? placeholder.type : "string" ,
						"x-defaultValue" :	structKeyExists( placeholder, "defaultValue" ) ? placeholder.defaultValue : ""
					}
				} );
			}
		}

		//append parameter information to our paths
		processPathParameters( path, resource );

		//append schema as responses
		processPathSchemas( path, resource );

		//append samples as 

	}

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
					structAppend( path[ lcase( method ) ]["parameters"], {
						"#param.name#" = {
							"in": ( method == "GET" ? "query" : "formData" ),
							"description" : ( structKeyExists( param,"description" ) ? param.description : "" ),
							"required": javacast( "boolean", param.required ),
							"type": param.type
						}
					} );
				}
			}
		}
	}

	private function processPathSchemas( required path, required resource ){
		if( structKeyExists( resource.response, "schemas" ) ){
			for ( var schema in resource.response[ "schemas" ] ){
			
				//RelaxDSL doesn't provide status codes, so we'll use our defaults
				var schemaDefinition = {
					"description" : schema[ "description" ],
					"schema" : {
						"type" : "object"
					},
					"example" : createObject( "java", "java.util.LinkedHashMap" )
				}

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

				structAppend( schemaDefinition[ "example" ], {
					"#mimeType#" : body
				});


				for( var methodKey in path ){
					var methodPosition = arrayFindNoCase( VARIABLES.HTTPMethods, methodKey );
					if( methodPosition ){
						var statusCode = VARIABLES.HTTPMethodResponses[ methodPosition ];

						if( !structKeyExists( path[ methodKey ][ "responses" ], statusCode) ){
						
							structAppend( path[ methodKey ][ "responses" ], {
								"#statusCode#" : schemaDefinition
							} );
						
						} else if( structKeyExists( path[ methodKey ][ "responses" ], statusCode ) ) {

							if( structKeyExists( path[ methodKey ][ "responses" ][ statusCode ][ "example" ], mimeType ) ){
							
								structAppend( path[ methodKey ][ "responses" ], {
									"default" : schemaDefinition
								} );
							
							} else {

								structAppend( path[ methodKey ][ "responses" ][ statusCode ][ "example" ], schemaDefinition[ "example" ] );
							
							}
						
							
						
						}	
					}
				}

			}	
		}
	}




}