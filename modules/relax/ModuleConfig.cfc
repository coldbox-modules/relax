<!-----------------------------------------------------------------------
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldbox.org | www.luismajano.com | www.ortussolutions.com
********************************************************************************

Author     :	Luis Majano
Description :
	Relax Module Configuration
----------------------------------------------------------------------->
<cfcomponent output="false" hint="Relaxed Configuration">
<cfscript>
	// Module Properties
	this.title 				= "Relax";
	this.author 			= "Luis Majano";
	this.webURL 			= "http://www.ortussolutions.com";
	this.description 		= "RESTful Tools For Lazy Experts";
	this.version			= "1.8.0";
	this.viewParentLookup 	= true;
	this.layoutParentLookup = true;
	this.entryPoint			= "relax:home.index";

	function configure(){

		// Relax Configuration Settings
		settings = {
			// Relax Version: DO NOT ALTER
			version = this.version,
			// The location of the relaxed APIs, in instantiation path
			apiLocationPath = "#moduleMapping#.resources",
			// Default API to load
			defaultAPI = "myapi",
			// History stack size, the number of history items to track in the RelaxURL
			maxHistory = 10,
			// logbox integration information needed for log viewer to work
			// this means that it can read tables that are written using the logbox's DB Appender.
			relaxLogs = {
				// THE CF DATASOURCE NAME
				datasource = "relax",
				// THE DB TO USE FOR LOGS, AVAILABLE ADAPTERS ARE: mysql, mssql, postgres, oracle
				adapter = "mysql",
				// THE TABLE WHERE THE LOGS ARE
				table 	= "api_logs",
				// PAGING MAX ROWS
				maxRows = 50,
				// PAGING CARROUSEL BANDGAP
				bandGap = 3
			}
		};

		// expand the location path
		settings.apiLocationExpandedPath = expandPath("/#replace(settings.apiLocationPath,".","/","all")#");

		// Layout Settings
		layoutSettings = { defaultLayout = "relax.cfm" };

		// SES Routes
		routes = [
			// Module Entry Point
			{pattern="/", handler="home",action="index"},
			// Convention Route
			{pattern="/:handler/:action?"}
		];

		// Model Bindings
		binder.map("DSLService@relax").to("#moduleMapping#.model.DSLService");
		binder.map("Relaxer@relax").to("#moduleMapping#.model.Relaxer");
		binder.map("DSLDoc@relax").to("#moduleMapping#.model.DSLDoc");
		// RelaxLogs Bindings
		binder.map("logService@relaxlogs").to("#moduleMapping#.model.logbox.LogService");
		binder.map("MSSQL_DAO@relaxlogs").to("#moduleMapping#.model.logbox.MSSQL_DAO");
		binder.map("MYSQL_DAO@relaxlogs").to("#moduleMapping#.model.logbox.MYSQL_DAO");
		binder.map("ORACLE_DAO@relaxlogs").to("#moduleMapping#.model.logbox.ORACLE_DAO");
		binder.map("POSTGRES_DAO@relaxlogs").to("#moduleMapping#.model.logbox.POSTGRES_DAO");

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

	/**
	* Pre process for relax, makes sure an API is loaded
	*/
	function preProcess(event,interceptData) eventPattern="^relax.*"{
		// load the default API
		loadDefaultAPI();
	}

	// Load default API Checks
	function loadDefaultAPI(){
		var DSLService = controller.getWireBox().getInstance("DSLService@relax");
		// check if the api is loaded or not, else, load the default one
		if( NOT DSLService.isLoadedAPI() ){
			DSLService.loadAPI( settings.defaultAPI );
		}
	}
</cfscript>
</cfcomponent>