<cfcomponent output="false" hint="My Module Configuration">
<cfscript>
/**
Module Directives as public properties
this.title 				= "Title of the module";
this.author 			= "Author of the module";
this.webURL 			= "Web URL for docs purposes";
this.description 		= "Module description";
this.version 			= "Module Version"

Optional Properties
this.viewParentLookup   = (true) [boolean] (Optional) // If true, checks for views in the parent first, then it the module.If false, then modules first, then parent.
this.layoutParentLookup = (true) [boolean] (Optional) // If true, checks for layouts in the parent first, then it the module.If false, then modules first, then parent.
this.entryPoint  		= "" (Optional) // If set, this is the default event (ex:forgebox:manager.index) or default route (/forgebox) the framework
									       will use to create an entry link to the module. Similar to a default event.

structures to create for configuration
- parentSettings : struct (will append and override parent)
- settings : struct
- datasources : struct (will append and override parent)
- webservices : struct (will append and override parent)
- interceptorSettings : struct of the following keys ATM
	- customInterceptionPoints : string list of custom interception points
- interceptors : array
- layoutSettings : struct (will allow to define a defaultLayout for the module)
- routes : array Allowed keys are same as the addRoute() method of the SES interceptor.
- wirebox : The wirebox DSL to load and use

Available objects in variable scope
- controller
- appMapping (application mapping)
- moduleMapping (include,cf path)
- modulePath (absolute path)
- log (A pre-configured logBox logger object for this object)
- binder (The wirebox configuration binder)

Required Methods
- configure() : The method ColdBox calls to configure the module.

Optional Methods
- onLoad() 		: If found, it is fired once the module is fully loaded
- onUnload() 	: If found, it is fired once the module is unloaded

*/
	
	// Module Properties
	this.title 				= "filebrowser";
	this.author 			= "Ortus Solutions";
	this.webURL 			= "http://www.ortussolutions.com";
	this.description 		= "A file and directory browser and selector";
	this.version			= "1.0";
	// If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
	this.viewParentLookup 	= true;
	// If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
	this.layoutParentLookup = true;
	// Module Entry Point
	this.entryPoint			= "filebrowser";
	
	function configure(){
		
		// module settings - stored in modules.name.settings
		settings = {
			// The title name
			title = "ColdBox FileBrowser v#this.version#",
			// the directory root path to start the visualizer on
			directoryRoot = expandPath("/#appMapping#"),
			// Secure the visualization or creation of stuff above the root
			traversalSecurity = true,
			// Show files on the visualizer or not
			showFiles = true,
			// Ability to create folders
			createFolders = true,
			// Name filtering applies to both files and directories. This is also a regex
			nameFilter = ".*",
			// Extension filtering that applies to file extensions to display, matches the filter argument to directoryList()
			extensionFilter = "",
			// Volume Chooser, display the volume navigator
			volumeChooser = true
		};
		
		// Layout Settings
		layoutSettings = {
			defaultLayout = "filebrowser.cfm"
		};
		
		// SES Routes
		routes = [
			// create folder
			{pattern="/createFolder", handler="home",action="createfolder"},
			// traversal paths
			{pattern="/d/:path", handler="home",action="index"},
			// Module Entry Point
			{pattern="/", handler="home",action="index"},
			// Convention Route
			{pattern="/:handler/:action?"}		
		];		
		
		// Custom Declared Points
		interceptorSettings = {
			customInterceptionPoints = ""
		};
		
		// Custom Declared Interceptors
		interceptors = [
		];
		
		// Binder Mappings
		// binder.map("Alias").to("#moduleMapping#.model.MyService");
		
	}
	
	/**
	* Fired when the module is registered and activated.
	*/
	function onLoad(){
		
	}
	
	/**
	* Fired when the module is unregistered and unloaded
	*/
	function onUnload(){
		
	}
	
</cfscript>
</cfcomponent>