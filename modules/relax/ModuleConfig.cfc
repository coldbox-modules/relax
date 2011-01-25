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
	this.version			= "1.0";
	this.viewParentLookup 	= true;
	this.layoutParentLookup = true;
	this.entryPoint			= "relax:home.index";
	
	function configure(){
		
		// Relax Configuration Settings
		settings = {
			// Relax Version
			version = this.version,
			// History stack size, the number of history items to keep on requests
			maxHistory = 10,
			// logbox integration information needed for log viewer to work
			// this means that it can read tables that are written using the logbox's DB Appender.
			relaxLogs = {
				// THE CF DATASOURCE NAME
				datasource = "relax",
				// THE DB TO USE FOR LOGS, AVAILABLE ADAPTERS ARE: mysql, mssql, postgres
				adapter = "mysql",
				// THE TABLE WHERE THE LOGS ARE
				table 	= "api_logs",
				// PAGING MAX ROWS
				maxRows = 50,
				// PAGING CARROUSEL BANDGAP
				bandGap = 3
			}
		};
		
		// Layout Settings
		layoutSettings = { defaultLayout = "relax.cfm" };
		
		// SES Routes
		routes = [];				
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