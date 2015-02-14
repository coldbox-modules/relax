/**
* Module Config
*/
component {

	// Module Properties
	this.title 				= "WikiText";
	this.author 			= "Luis Majano";
	this.webURL 			= "http://www.ortussolutions.com";
	this.description 		= "A module to produce mediaki markup text to HTML";
	this.version			= "1.0.0";
	// If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
	this.viewParentLookup 	= true;
	// If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
	this.layoutParentLookup = true;
	// Module Entry Point
	this.entryPoint			= "WikiText";
	// Model Namespace
	this.modelNamespace		= "WikiText";
	// CF Mapping
	this.cfmapping			= "WikiText";
	// Dependencies
	this.dependencies		= [ "cbjavaloader" ];

	/**
	* Configure
	*/
	function configure(){

	}

	/**
	* Fired when the module is registered and activated.
	*/
	function onLoad(){
		// setup load paths
		controller.getWireBox().getInstance( "loader@cbjavaloader" )
			.appendPaths( expandPath( '#moduleMapping#/models/lib' ) );
		// startup the engines
		controller.getWireBox().getInstance( "WikiText@WikiText" ).configure();
	}

	/**
	* Fired when the module is unregistered and unloaded
	*/
	function onUnload(){

	}

}