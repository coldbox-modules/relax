/**
********************************************************************************
Copyright 2005-2007 by Luis Majano and Ortus Solutions, Corp
www.ortussolutions.com
********************************************************************************
* The DSL Service
*/
component accessors="true" singleton{

	// DI
	property name="log" 		inject="logbox:logger:{this}";
	property name="settings" 	inject="coldbox:setting:relax";
	
	// properties
	property name="APIDefinitions";

	/**
	* Constructor
	*/
	function init(){
		variables.APIDefinitions = {};
		return this;
	}

	/**
	* Get a listing of all the APIs in the resources folder
	*/
	query function listAPIs(){
		return directoryList( variables.settings.APILocationExpanded, false, "query", "", "asc" );
	}

	/**
	* Get an API definition
	* @name The name of the API to get.
	*/
	function getAPI( required name ){
		return variables.APIDefinitions[ arguments.name ];
	}

    /**
    * Get the loaded API representation
    */
    function getLoadedAPI(){
		var apiName = getLoadedAPIName();
		// lazy load API if not in scope
		if( NOT structKeyExists( variables.APIDefinitions, apiName ) ){ loadAPI( apiName ); }
		// return it.
		return variables.APIDefinitions[ apiName ];
	}

	/**
	* Get the loaded API name
	*/
    string function getLoadedAPIName(){
    	return ( structKeyExistS( session, "relax-api" ) ? session[ "relax-api" ] : "" );
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
		structDelete( session, "relax-api" );
		return this;
	}

	/**
	* Load an API into the service and get its representation. This can be a Relax.cfc or a Relax.json representation.
	* @name The API to load
	*/
	function loadAPI( required name ){
		var dataCFC = "";

		// Determine if we have CFC or JSON
		if( fileExists( variables.settings.APILocationExpanded & "/#arguments.name#/Relax.cfc" ) ){
			dataCFC = createObject( "component", variables.settings.APILocation & ".#arguments.name#.Relax" );
		} else if ( fileExists( variables.settings.APILocationExpanded & "/#arguments.name#/Relax.json" ) ){
			dataCFC = deserializeJSON( fileRead( variables.settings.APILocationExpanded & "/#arguments.name#/Relax.json" ) );
		} else {
			throw( message="The API you are trying to load: #arguments.name# does not exist",
				   detail="Path: #variables.settings.APILocationExpanded#/#arguments.name#",
				   type="Relax.InvalidDefaultAPI" )
		}

		// If we have a configure() then call it
		if( structKeyExists( dataCFC, "configure" ) ){
			processConfiguration( dataCFC );
		}

		// cleanup relax data
		if( NOT structKeyExists( dataCFC.relax, "validExtensions" ) ){
			dataCFC.relax.validExtensions = "";
		}
		if( NOT structKeyExists( dataCFC.relax, "throwOnInvalidExtension" ) ){
			dataCFC.relax.throwOnInvalidExtension = false;
		}

		// cleanup global headers
		if( NOT structKeyExists( dataCFC, "globalHeaders" ) ){
			dataCFC.globalHeaders = [];
		}
		// cleanup global parameters
		if( NOT structKeyExists( dataCFC, "globalParameters" ) ){
			dataCFC.globalParameters = [];
		}
		// cleanup of resources
		if( NOT structKeyExists( dataCFC, "resources" ) ){
			dataCFC.resources = [];
		}
		// cleanup entry point
		if( isSimpleValue( dataCFC.relax.entryPoint ) ){
			dataCFC.relax.entryPoint = { production = dataCFC.relax.entryPoint };
		}

		// Process resources
		for(var x=1; x lte arrayLen( dataCFC.resources ); x++){
			dataCFC.resources[ x ].resourceID = hash( dataCFC.resources[ x ].toString() );
			if( NOT structKeyExists( dataCFC.resources[ x ], "headers" ) ){
				dataCFC.resources[ x ].headers = [];
			}
			if( NOT structKeyExists( dataCFC.resources[ x ], "placeholders" ) ){
				dataCFC.resources[ x ].placeholders = [];
			}
			if( NOT structKeyExists( dataCFC.resources[ x ], "parameters" ) ){
				dataCFC.resources[ x ].parameters = [];
			}
			if( NOT structKeyExists( dataCFC.resources[ x ], "methods" ) ){
				dataCFC.resources[ x ].methods = "GET";
			}
			if( NOT structKeyExists( dataCFC.resources[ x ], "defaultMethod" ) ){
				dataCFC.resources[ x ].defaultMethod = "GET";
			}
			if( NOT structKeyExists( dataCFC.resources[ x ], "defaultFormat" ) ){
				dataCFC.resources[ x ].defaultFormat = "";
			}
			if( NOT structKeyExists( dataCFC.resources[ x ], "description" ) ){
				dataCFC.resources[ x ].description = "";
			}
			if( NOT structKeyExists( dataCFC.resources[ x ], "handler" ) ){
				dataCFC.resources[ x ].handler = "";
			}
			if( NOT structKeyExists( dataCFC.resources[ x ], "action" ) ){
				dataCFC.resources[ x ].action = "";
			}
			if( NOT structKeyExists( dataCFC.resources[ x ], "response" ) ){
				dataCFC.resources[ x ].response = {};
			}
		}
		// Store the definitions
		variables.APIDefinitions[ arguments.name ] = dataCFC;

		// Store user's selection
		session[ "relax-api" ] = arguments.name;

		return dataCFC;
	}

	/**
	* Process a relax configure method
	* @dataCFC The data CFC to process
	*/
	DSLService function processConfiguration( required dataCFC ){
		// create language object
		var dsl = new RelaxDSL();

		// decorate and mixin methods.
		dataCFC.injectMixin = variables.injectMixin;

		for(var key in dsl ){
			// only inject methods/properties that do not exist
			if( not structKeyExists( dataCFC, key ) ){

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
	* @name The name of the API to import
	* @json The JSON representation of the API
	*/
	DSLService function importAPI( required name, required json ){
		var targetDir = variables.settings.APILocationExpanded & "/" & arguments.name;
		var targetAPI = targetDir & "/Relax.json";

		// create the directory enclosure
		directoryCreate( variables.settings.APILocationExpanded & "/" & arguments.name );

		// create the relax.json file
		fileWrite(targetAPI, arguments.json );

		return this;
	}

	/**
	* Injection method
	*/
	private function injectMixin( required name, required UDF ){
		variables[ arguments.name ] = arguments.UDF;
		this[ arguments.name ] 		= arguments.UDF;

		return this;
	}

}