/**
* Copyright Ortus Solutions, Corp, All rights reserved
* www.ortussolutions.com
* ---
*/
component{

	// Module Properties
	this.title 				= "ColdBox Relax";
	this.author 			= "Ortus Solutions";
	this.webURL 			= "https://www.ortussolutions.com";
	this.description 		= "RESTful Tools For Lazy Experts";
	this.version			= "@build.version@+@build.number@";
	this.viewParentLookup 	= true;
	this.layoutParentLookup = true;
	// Module Entry Point
	this.entryPoint			= "relax";
	// Model Namespace
	this.modelNamespace		= "relax";
	// CF Mapping
	this.cfmapping			= "relax";
	// Auto-map models
	this.autoMapModels		= true;
	// Module Dependencies That Must Be Loaded First, use internal names or aliases
	this.dependencies		= [ "cbjavaloader", "swagger-sdk", "wikitext" ];

	/**
	* Configure App
	*/
	function configure(){
		// Layout Settings
		layoutSettings = { defaultLayout = "relax.cfm" };

		// Add our mixins
		arrayAppend( controller.getSetting( "ApplicationHelper" ), "#moduleMapping#/models/mixins/textFormat.cfm" );

		// SES Routes
		routes = [
			// APIDoc API Routes
			{
				pattern = "apidoc/:api?",
				handler = "APIDoc",
				action 	= { 
					"GET" 		: "index",
					"POST" 		: "create",
					"PUT" 		: "update",
					"PATCH" 	: "update",
					"DELETE" 	: "delete"
				}
				
			},
			//Direct API requests
			{ pattern="export/:action/:apiname?", handler="Export", action="index" },
			{ pattern="api/:apiname?", handler="Home", action="index" },
			// Module Entry Point
			{ pattern="", handler="Home", action="index" },
			// Convention Route
			{ pattern=":handler/:action?" }
		];

	}

	/**
	* Fired when the module is registered and activated.
	*/
	function onLoad(){
		var configSettings = controller.getConfigSettings();
		// parse parent settings
		parseParentSettings();

		/**	
		* Utilities
		**/

		//models.Mongo.Util
		binder.map( "OpenAPIUtil@relax" )
			.toDSL( "OpenAPIUtil@SwaggerSDK" );

		/**
		* Manual Instantiation Instances
		**/

		//models.OpenAPI.Document
		binder.map( "OpenAPIDocument@relax" )
			.toDSL( "OpenAPIDocument@SwaggerSDK" );


		//models.OpenAPI.Parser
		binder.map( "OpenAPIParser@relax" )
			.toDSL( "OpenAPIParser@SwaggerSDK" );

		//RelaxDSL Parser
		binder.map( "RelaxDSL@relax" )
			.to( "#moduleMapping#.models.RelaxDSL.Document" );

		//RelaxDSL Document
		binder.map( "RelaxDoc@relax" )
			.to( "#moduleMapping#.models.RelaxDSL.Generator" );


		//RelaxDSL Translator
		binder.map( "DSLTranslator@relax" )
			.to( "#moduleMapping#.models.RelaxDSL.Translator" )
			.mixins( '/SwaggerSDK/models/mixins/hashMap.cfm' );

	}

	/**
	* Fired when the module is unregistered and unloaded
	*/
	function onUnload(){
	}

	/**
	* Pre process for relax, makes sure an API is loaded
	*/
	function preProcess( event, interceptData ) eventPattern="^relax.*"{
		var DSLService = wirebox.getInstance( "APIService@relax" );
		// load the default API if none loaded
		if( !DSLService.isLoadedAPI() ){
			DSLService.loadAPI( controller.getConfigSettings().relax.defaultAPI );
		}
	}

	/**
	* Prepare settings
	*/
	private function parseParentSettings(){
		/**
		Sample:
		relax = {
			// The location of the relaxed APIs, defaults to /models/resources
			APILocation = "#appMapping#.models.resources",
			// Default API to load
			defaultAPI = "myapi",
			// History stack size, the number of history items to track in the RelaxURL
			maxHistory = 10
		};
		**/
		// Read parent application config
		var oConfig 		= controller.getSetting( "ColdBoxConfig" );
		var relaxDSL		= oConfig.getPropertyMixin( "relax", "variables", structnew() );
		var configStruct 	= controller.getConfigSettings();

		// Default Config Structure
		configStruct.relax = {
			APILocation 	= "#moduleMapping#.models.resources",
			defaultAPI 		= "myapi",
			maxHistory		= 10,
			sessionsEnabled	= getApplicationMetadata().sessionManagement
		};

		// Append it
		structAppend( configStruct.relax, relaxDSL, true );

		/** 
		*  As a convenience, turn off flash auto-saves if sessions are disabled, 
		*  or requestEnd errors will be thrown
		**/
		if( !configStruct.relax.sessionsEnabled && controller.getSetting( "flash" ).scope == 'session' ){
			controller.getSetting( "flash" ).autoSave = false;
		}

		// expand the location path
		configStruct.relax.APILocationExpanded = expandPath( "/#replace( configStruct.relax.APILocation, ".", "/", "all" )#" );
	}

}