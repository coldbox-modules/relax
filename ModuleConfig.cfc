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
	this.dependencies		= [ "cbjavaloader", "cbswagger", "wikitext" ];
	// App Helpers
	this.applicationHelper = [
		"models/mixins/textFormat.cfm"
	];

	/**
	* Configure App
	*/
	function configure(){
		// Layout Settings
		layoutSettings = { defaultLayout = "relax.cfm" };

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
			{
				pattern = "export/:action/:apiname?",
				handler = "Export",
				action  = "index"
			},
			//Relaxer routes - explicit first, then our dynamic API selector
			{
				pattern = "relaxer/send",
				handler = "Relaxer",
				action  = "send"
			},
			{
				pattern = "relaxer/purgeHistory",
				handler = "Relaxer",
				action  = "purgeHistory"
			},
			{
				pattern = "relaxer/resourceDocd",
				handler = "Relaxer",
				action  = "resourceDoc"
			},
			{
				pattern = "relaxer/:apiname?",
				handler = "Relaxer",
				action  = "index"
			},
			{
				pattern = "api/:apiname?",
				handler = "Home",
				action  = "index"
			},
			// Module Entry Point
			{
				pattern = "",
				handler = "Home",
				action  = "index"
			},
			// Convention Route
			{ pattern 	= ":handler/:action?" }
		];

	}

	/**
	* Fired when the module is registered and activated.
	*/
	function onLoad(){
		// parse parent settings
		parseParentSettings();

		var configSettings = controller.getConfigSettings().relax;

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

		//RelaxDSL Translator
		binder.map( "DSLTranslator@relax" )
			.to( "#moduleMapping#.models.RelaxDSL.Translator" )
			.mixins( '/SwaggerSDK/models/mixins/hashMap.cfm' );


		// If caching is turned on, make our service a singleton ( in development, we would want it to remain a transient )
		if( configSettings.cache ){
			binder.map( "APIService@relax" )
				.to( "#moduleMapping#.models.APIService" )
				.asSingleton();
		}

	}

	/**
	* Fired when the module is unregistered and unloaded
	*/
	function onUnload(){
	}

	/**
	* Pre process for relax, makes sure an API is loaded
	*/
	function preProcess( event, interceptData ) eventPattern= "^relax.*"{
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
		// Read parent application config
		var oConfig 		= controller.getSetting( "ColdBoxConfig" );
		var relaxDSL		= oConfig.getPropertyMixin( "relax", "variables", structnew() );
		var configStruct 	= controller.getConfigSettings();

		// Default Config Structure
		configStruct.relax = {
			// The mapped location of the API definitions
			APILocation 	= "#moduleMapping#.models.resources",
			// The default API to load within the RELAX UI
			defaultAPI 		= "myapi",
			// Whether to enable session storage for history and preferences ( deprecated, as UI now uses JS localStorage )
			sessionsEnabled	= getApplicationMetadata().sessionManagement,
			// The number of history items in the session storage ( deprecated )
			maxHistory		= 10,
			// Whether to cache the API Service as a singleton, preventing each request from loading
			cache 			= false
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