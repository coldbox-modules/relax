<cfcomponent output="false" hint="Relaxed Configuration">
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
- modelMappings : structure of model mappings. Allowed keys are the alias and path, same as normal model mappings.

Available objects in variable scope
- controller
- appMapping (application mapping)
- moduleMapping (include,cf path)
- modulePath (absolute path)
- log (A pre-configured logBox logger object for this object)

Required Methods
- configure() : The method ColdBox calls to configure the module.

Optional Methods
- onLoad() 		: If found, it is fired once the module is fully loaded
- onUnload() 	: If found, it is fired once the module is unloaded

*/
	
	// Module Properties
	this.title 				= "Relax";
	this.author 			= "Luis Majano";
	this.webURL 			= "http://www.ortussolutions.com";
	this.description 		= "RESTful Tools For Lazy Experts";
	this.version			= "1.0";
	// If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
	this.viewParentLookup 	= true;
	// If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
	this.layoutParentLookup = true;
	// Module Entry Point
	this.entryPoint			= "relax:home.index";
	
	function configure(){
		
		// module settings - stored in modules.name.settings
		settings = {
			// module version reference
			version = this.version,
			// logbox integration information needed for log viewer to work
			relaxLogs = {
				// THE CF DATASOURCE NAME
				datasource = "relax",
				// THE DB ADAPTER TO USE FOR LOGS, AVAILABLE ADAPTERS: mysql, mssql
				adapter = "mysql",
				// THE TABLE THE LOGS THE LOGBOX DBAPPENDER CREATED
				table 	= "api_logs",
				// PAGING MAX ROWS
				maxRows = 50,
				// PAGING CARROUSEL BANDGAP
				bandGap = 3
			}
		};
		
		// Layout Settings
		layoutSettings = {
			defaultLayout = "relax.cfm"
		};
		
		// SES Routes
		routes = [
			//{pattern="/api-docs", handler="api",action="index"}		
		];				
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