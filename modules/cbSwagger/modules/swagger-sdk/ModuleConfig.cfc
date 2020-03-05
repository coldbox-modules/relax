/**
 * Copyright Ortus Solutions, Corp, All rights reserved
 * www.ortussolutions.com
 * ---
 */
component {

	// Module Properties
	this.title = "ColdBox Swagger SDK";
	this.author = "Ortus Solutions";
	this.webURL = "https://www.ortussolutions.com";
	this.description = "Swagger SDK Module";
	this.version = "2.0.0-snapshot";
	this.viewParentLookup = true;
	this.layoutParentLookup = true;
	// Module Entry Point
	this.entryPoint = "SwaggerSDK";
	// Model Namespace
	this.modelNamespace = "SwaggerSDK";
	// CF Mapping
	this.cfmapping = "SwaggerSDK";
	// Auto-map models
	this.autoMapModels = false;
	// Module Dependencies That Must Be Loaded First, use internal names or aliases
	this.dependencies = [ "cbjavaloader" ];

	/**
	 * Configure App
	 */
	function configure(){
	}

	/**
	 * Fired when the module is registered and activated.
	 */
	function onLoad(){
		// load jars
		wirebox.getInstance( "loader@cbjavaloader" )
			.appendPaths( variables.modulePath & "/lib" );


		/**
		* Utilities
		*
		*/

		// Open API Util
		binder
			.map( "OpenAPIUtil@SwaggerSDK" )
			.to( "#moduleMapping#.models.OpenAPI.Util" )
			.mixins( "/#this.cfmapping#/models/mixins/hashMap.cfm" )
			.asSingleton();


		/**
		* Manual Instantiation Instances
		*
		*/

		// models.OpenAPI.Document
		binder
			.map( "OpenAPIDocument@SwaggerSDK" )
			.to( "#moduleMapping#.models.OpenAPI.Document" )
			.noInit();


		// models.OpenAPI.Parser
		binder
			.map( "OpenAPIParser@SwaggerSDK" )
			.to( "#moduleMapping#.models.OpenAPI.Parser" )
			.mixins( "/#this.cfmapping#/models/mixins/hashMap.cfm" )
			.noInit();
	}

}
