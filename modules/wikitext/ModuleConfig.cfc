/**
* Module Config
*/
component {

	// Module Properties
	this.title 				= "WikiText";
	this.author 			= "Ortus Solutions";
	this.webURL 			= "https://www.ortussolutions.com";
	this.description 		= "A module to produce mediaki markup text to HTML";
	this.version			= "1.3.1+14";
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
		// parse parent settings
		parseParentSettings();
		// Startup Wiki Engine
		controller.getWireBox()
			.getInstance( "wikiText@WikiText" )
			.configure( controller.getConfigSettings().wikitext );
	}

	/**
	* Fired when the module is unregistered and unloaded
	*/
	function onUnload(){

	}

	/**
	* parse parent settings
	*/
	private function parseParentSettings(){
		var oConfig 		= controller.getSetting( "ColdBoxConfig" );
		var configStruct 	= controller.getConfigSettings();
		var settings 		= oConfig.getPropertyMixin( "wikitext", "variables", structnew() );

		//defaults
		configStruct.wikitext = {
			// The link pattern to translate internal links
			linkPattern = "${title}",
			// The base URL of the UI module
			linkBaseURL = "",
			// The image base URL
			imageBaseURL = "",
			// Allowed wiki attributed
			allowedAttributes = "style,url",
			// Ignored tags on conversion
			ignoreTagList = "img,iframe"
		};

		// incorporate settings
		structAppend( configStruct.wikitext, settings, true );

	}

}