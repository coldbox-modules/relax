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
			// Relax DSL component that has the resource definitions, this is an instanatiation path
			configCFC = "Relax",
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
		var dataCFC = createObject("component",settings.configCFC);
		var x	= 1;
		
		// Cleanup of data
		if( NOT structKeyExists(dataCFC,"globalHeaders") ){
			dataCFC.globalHeaders = [];
		}
		if( NOT structKeyExists(dataCFC,"resources") ){
			dataCFC.resources = [];
		}
		// Process resources
		for(x=1; x lte arrayLen(dataCFC.resources); x++){
			dataCFC.resources[x].resourceID = createUUID();
			if( NOT structKeyExists(dataCFC.resources[x],"headers") ){
				dataCFC.resources[x].headers = [];
			}
			if( NOT structKeyExists(dataCFC.resources[x],"placeholders") ){
				dataCFC.resources[x].placeholders = [];
			}
			if( NOT structKeyExists(dataCFC.resources[x],"parameters") ){
				dataCFC.resources[x].parameters = [];
			}
			if( NOT structKeyExists(dataCFC.resources[x],"methods") ){
				dataCFC.resources[x].methods = "GET";
			}
			if( NOT structKeyExists(dataCFC.resources[x],"description") ){
				dataCFC.resources[x].description = "";
			}
			if( NOT structKeyExists(dataCFC.resources[x],"handler") ){
				dataCFC.resources[x].handler = "";
			}
			if( NOT structKeyExists(dataCFC.resources[x],"action") ){
				dataCFC.resources[x].action = "index";
			}
		}		
		// Create the Relax.cfc configuration object and load it as a module setting.
		controller.getSetting('modules').relax.settings.dsl = dataCFC;
	}
	
	/**
	* Fired when the module is unregistered and unloaded
	*/
	function onUnload(){
		
	}	
</cfscript>
</cfcomponent>