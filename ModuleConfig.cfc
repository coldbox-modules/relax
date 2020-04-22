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
		"models/mixins/textFormat.cfm",
		"models/mixins/elixirPath.cfm"
	];

	/**
	* Configure App
	*/
	function configure(){
		// Settings
		settings = {
			// The mapped location of the API definitions
			APILocation 	= "#moduleMapping#.models.resources",
			// The default API to load within the RELAX UI
			defaultAPI 		= "petstore",
			// APIs to be excluded from display - may be a list or an array and items may include Regex
			exclude         = "",
			// The number of history items in the session storage ( deprecated )
			maxHistory		= 10,
			// Whether to cache the API Service as a singleton, preventing each request from reloading changes
			cache 			= false,
			// Whether to enable session storage for history and preferences ( deprecated, as UI now uses JS localStorage )
			sessionsEnabled	= getApplicationMetadata().sessionManagement
		};

		// Layout Settings
		layoutSettings = {
			defaultLayout = "relax.cfm"
		};

		interceptors = [
			{ class="relax.interceptors.GlobalData" }
		];
	}

	/**
	* Fired when the module is registered and activated.
	*/
	function onLoad(){
		/**
		*  As a convenience, turn off flash auto-saves if sessions are disabled,
		*  or requestEnd errors will be thrown
		**/
		if( !variables.settings.sessionsEnabled && controller.getSetting( "flash" ).scope == 'session' ){
			controller.getSetting( "flash" ).autoSave = false;
		}

		// expand the location path
		variables.settings.APILocationExpanded = expandPath( "/#replace( variables.settings.APILocation, ".", "/", "all" )#" );


		binder.map( "OpenAPIUtil@relax" )
			.toDSL( "OpenAPIUtil@SwaggerSDK" );

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
			.to( "#moduleMapping#.models.RelaxDSL.Translator" );

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
			DSLService.loadAPI( settings.defaultAPI );
		}
	}

}