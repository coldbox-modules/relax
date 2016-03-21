/**
* Copyright Ortus Solutions, Corp, All rights reserved
* www.ortussolutions.com
* ---
* The DSL Service
*/
component accessors="true" {
	// DI
	property name="Wirebox" inject="wirebox";
	property name="log" 		inject="logbox:logger:{this}";
	
	/**
	* Storage for API Definitions
	*/
	property name="APIDefinitions" type="struct";

	/**
	* Flag that tell us if the underlying application leverages session scope
	*/
	property name="sessionsEnabled" type="boolean";

	/**
	* The relax module's settings
	*/
	property name="settings" type="struct";

	/**
	* Constructor
	* @settings The relax module settings needed
	* @settings.inject coldbox:setting:relax
	*/
	function init( required settings ){

		VARIABLES.settings 			= ARGUMENTS.settings;
		VARIABLES.APIDefinitions 	= {};
		VARIABLES.sessionsEnabled 	= ARGUMENTS.settings.sessionsEnabled;
		
		return this;
	}

	/**
	* Get a listing of all the APIs in the resources folder
	*/
	query function listAPIs(){
		return directoryList( VARIABLES.settings.APILocationExpanded, false, "query", "", "asc" );
	}

	/**
	* Get an API definition
	* @name The name of the API to get.
	*/
	function getAPI( required name ){
		return VARIABLES.APIDefinitions[ ARGUMENTS.name ];
	}

    /**
    * Get the loaded API representation
    */
    function getLoadedAPI(){
		var apiName = getLoadedAPIName();

		// lazy load API if not in scope
		if( !structKeyExists( VARIABLES.APIDefinitions, apiName ) ){ loadAPI( apiName ); }
		// return it.
		return VARIABLES.APIDefinitions[ apiName ];
	}

	/**
	* Get the loaded API name
	*/
    string function getLoadedAPIName(){
    	if( !getSessionsEnabled() ){
    		return getDefaultAPIName();
    	}

    	return ( structKeyExistS( session, "relax-api" ) ? session[ "relax-api" ] : "" );
    }

    string function getDefaultAPIName(){
    	return getSettings().defaultAPI;
    }

    /**
    * Checks if an API is loaded or not, usually by checking the user's data
    */
	boolean function isLoadedAPI(){
		return ( len( getLoadedAPIName() ) ? true : false );
	}

	/**
	* Clears user data
	*/
	DSLService function clearUserData(){
		if( !getSessionsEnabled() ) return this;

		structDelete( session, "relax-api" );
		return this;
	}

	/**
	* Load an API into the service and get its representation. This can be a Relax.cfc or a Relax.json representation.
	* @name The API to load
	*/
	function loadAPI( required name ){
		var APIDirectory = VARIABLES.settings.APILocationExpanded & "/" & ARGUMENTS.name & "/"; 
		//determine if we have a legacy DSL configuration
		if( fileExists( APIDirectory & "Relax.cfc" ) ){
			var dataCFC = createObject( "component", VARIABLES.settings.APILocation & ".#ARGUMENTS.name#.Relax" );
		} else if ( fileExists( VARIABLES.settings.APILocationExpanded & "/#ARGUMENTS.name#/Relax.json" ) ) {
			var dataCFC = deserializeJSON( fileRead( APIDirectory & "Relax.json" ) );
		}

		// If we have a configure() then call it 
		if( !isNull( dataCFC ) && structKeyExists( dataCFC, "configure") ) processConfiguration( dataCFC );

		if( !isNull( dataCFC ) && isLegacyAPI( dataCFC ) ){
			/**
			* Legacy RelaxDSL API Checks
			* @deprecate v3.0.0
			**/
			loadDSLAPI( dataCFC );
			// Store the definitions
			VARIABLES.APIDefinitions[ ARGUMENTS.name ] = getWirebox().getInstance( "DSLTranslator@relax" ).translate( dataCFC );	

		} else {
			//OpenAPI Checks
			if( !isNull( dataCFC ) && structKeyExists( dataCFC.relax, "definition" ) ){
				VARIABLES.APIDefinitions[ ARGUMENTS.name ] = loadOpenAPI( APIDirectory & dataCFC.relax.definition );	
			} else if( isNull( dataCFC ) ){
				var mimeExtensions = [ 'json','yaml','yaml','json.cfm' ];
				//perform our naming convention type checks checks
				for( var ext in mimeExtensions ){			
					if( fileExists( APIDirectory & ARGUMENTs.name & "." & ext ) )	{
						VARIABLES.APIDefinitions[ ARGUMENTS.name ] = loadOpenAPI( APIDirectory & ARGUMENTs.name & "." & ext );
						break;
					}
				}
			}

		} 

		// Store user's selection
		if( getSessionsEnabled() ){
			session[ "relax-api" ] = ARGUMENTS.name;
		}

		return VARIABLES.APIDefinitions[ ARGUMENTs.name ];

	}

	private function isLegacyAPI( required any dataCFC ){

		return (
			(
				structKeyExists(dataCFC,"resources")
				&&
				arrayLen( dataCFC.resources )
			)
			or
			( 
				structKeyExists(dataCFC,"globalParameters")  
				&& 
				arrayLen( dataCFC.globalParameters )
			)
		);
	}

	private function loadOpenAPI( required string definitionFile ){
		return getWirebox( ).getInstance( "OpenAPIParser@relax" ).init( definitionFile );
	}

	private function loadDSLAPI( required any dataCFC ){

		// cleanup relax data
		if( !structKeyExists( dataCFC.relax, "validExtensions" ) ){
			dataCFC.relax.validExtensions = "";
		}
		if( !structKeyExists( dataCFC.relax, "throwOnInvalidExtension" ) ){
			dataCFC.relax.throwOnInvalidExtension = false;
		}

		// cleanup global headers
		if( !structKeyExists( dataCFC, "globalHeaders" ) ){
			dataCFC.globalHeaders = [];
		}
		// cleanup global parameters
		if( !structKeyExists( dataCFC, "globalParameters" ) ){
			dataCFC.globalParameters = [];
		}
		// cleanup of resources
		if( !structKeyExists( dataCFC, "resources" ) ){
			dataCFC.resources = [];
		}
		// cleanup entry point
		if( isSimpleValue( dataCFC.relax.entryPoint ) ){
			dataCFC.relax.entryPoint = { production = dataCFC.relax.entryPoint };
		}

		// Process resources
		for( var x=1; x lte arrayLen( dataCFC.resources ); x++ ){
			dataCFC.resources[ x ].resourceID = lcase( hash( dataCFC.resources[ x ].pattern ) );
			if( !structKeyExists( dataCFC.resources[ x ], "headers" ) ){
				dataCFC.resources[ x ].headers = [];
			}
			if( !structKeyExists( dataCFC.resources[ x ], "placeholders" ) ){
				dataCFC.resources[ x ].placeholders = [];
			}
			if( !structKeyExists( dataCFC.resources[ x ], "parameters" ) ){
				dataCFC.resources[ x ].parameters = [];
			}
			if( !structKeyExists( dataCFC.resources[ x ], "methods" ) ){
				dataCFC.resources[ x ].methods = "GET";
			}
			if( !structKeyExists( dataCFC.resources[ x ], "defaultMethod" ) ){
				dataCFC.resources[ x ].defaultMethod = "GET";
			}
			if( !structKeyExists( dataCFC.resources[ x ], "defaultFormat" ) ){
				dataCFC.resources[ x ].defaultFormat = "";
			}
			if( !structKeyExists( dataCFC.resources[ x ], "description" ) ){
				dataCFC.resources[ x ].description = "";
			}
			if( !structKeyExists( dataCFC.resources[ x ], "handler" ) ){
				dataCFC.resources[ x ].handler = "";
			}
			if( !structKeyExists( dataCFC.resources[ x ], "action" ) ){
				dataCFC.resources[ x ].action = "";
			}
			if( !structKeyExists( dataCFC.resources[ x ], "response" ) ){
				dataCFC.resources[ x ].response = {};
			}
		}
		
		return dataCFC;
	}

	/**
	* Process a relax configure method
	* @dataCFC The data CFC to process
	*/
	APIService function processConfiguration( required dataCFC ){

		// create language object
		var dsl = getWirebox().getInstance( "RelaxDSL@relax" );

		// decorate and mixin methods.
		dataCFC.injectMixin = VARIABLES.injectMixin;

		for(var key in dsl ){
			// only inject methods/properties that do not exist
			if( !structKeyExists( dataCFC, key ) ){

				// check if a UDF
				if( isCustomFunction( dsl[ key ] ) ){
					dataCFC.injectMixin( key, dsl[ key ] );
				}
				// else a property injection
				else{
					dataCFC[ key ] = dsl[ key ];
				}

			}
		}

		// process configuration
		dataCFC.configure();

		return this;
	}

	/**
	* Import a relax API
	* @collection The collection which includes the API name and JSON representation
	*/
	struct function processAPIImport( required struct collection ){
		var response = newResponse();

		// validate data
		if( !structKeyExists( collection, 'apiName' ) || !len( collection.apiName ) ){
			response.message = "A valid API name was not provided for the import request.  Could not continue.";
			return response;
		} else if ( !structKeyExists( collection, 'apiJSON' ) ){
			response.message = "A valid API name was not provided for the import request.  Could not continue.";
			return response;
		}else if( not isJSON( collection.apiJSON ) ){
			response.message = "The JSON representation is not valid JSON. Please try again.";
			return response;
		}

		// slugify name
		var apiName = getWirebox().getInstance( "HTMLHelper@coldbox" ).slugify( collection.apiName );

		var targetDir = VARIABLES.settings.APILocationExpanded & "/" & apiName;
		if( !directoryExists( targetDir ) ) directoryCreate( targetDir );

		
		//validate that our api document can be parsed
		try{		
			
			var parsedAPI = getWirebox().getInstance( "OpenAPIParser@relax" ).parse( deserializeJSON( collection.apiJSON ) );
		
		} catch( any e ){
		
			response.message = "The API provided could not be parsed according to the OpenAPI specification.  Please check your syntax and ensure all required keys are provided.";
			return response;
		
		}

		var targetFile = targetDir & "/" & apiName & ".json";

		fileWrite(targetFile, collection.apiJSON);

		response.data = {
			"name":apiName,
			"document":parsedAPI.getNormalizedDocument()	
		};
		
		response.success = true;

		return response;
	}

	/**
	* Injection method
	*/
	private function injectMixin( required name, required UDF ){
		variables[ ARGUMENTS.name ] = ARGUMENTS.UDF;
		this[ ARGUMENTS.name ] 		= ARGUMENTS.UDF;

		return this;
	}

	private function newResponse(){
		return {
			"success":false,
			"data":{},
			"message":"",
			"errors":[]
		};
	}

}