<!-----------------------------------------------------------------------
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldbox.org | www.luismajano.com | www.ortussolutions.com
********************************************************************************

Author     :	Luis Majano
Description :
	LogBox integration
----------------------------------------------------------------------->
<cfcomponent output="false" extends="BaseHandler">

	<!--- Dependencies --->
	<cfproperty name="logService" 		inject="model:relax.logBox.logService" >
	<cfproperty name="sessionStorage" 	inject="coldbox:plugin:SessionStorage">

<cfscript>

	function preHandler(event){
		super.preHandler(event);
		if( NOT sessionStorage.exists("maxRows") ){
			sessionStorage.setVar("maxRows", getModuleSettings('relax').settings.relaxLogs.maxRows);
		}
	}

	function index(event){
		var rc = event.getCollection();
		
		//paging
		event.paramValue("page",1);
		event.paramValue("maxRows", sessionStorage.getVar("maxRows") );
		rc.pagingPlugin = getMyPlugin(plugin="Paging",module="relax");
		rc.paging 		= rc.pagingPlugin.getBoundaries(rc.maxRows);
		rc.pagingLink 	= event.buildLink('relax:logs.index.page.@page@');
		
		// JS/CSS Append
		rc.jsAppendList  = "shCore,brushes/shBrushColdFusion";
		rc.cssAppendList = "shCore,shThemeDefault";
		
		
		// exit handlers
		rc.xehStoreMaxRows = "relax:logs.saveMaxRows";
		
		// Log Settings
		rc.logSettings = getModuleSettings("relax").settings.relaxLogs;
		
		// Get Logs
		rc.qLogs = logService.getLogs(startRow=rc.paging.startRow,maxRow=rc.paging.maxRow);
		rc.totalLogCount = logService.getTotalLogs();
		rc.qStats = logService.getLogStats();
		
		// Exit handlers
		rc.xehPurge 	= "relax:logs.purgeLogs";
		rc.xehQuickView = "relax:logs.viewer";
		
		event.setView("logs/index");
	}
	
	function help(event){
		var rc = event.getCollection();
		// JS/CSS Append
		rc.jsAppendList  = "shCore,brushes/shBrushColdFusion";
		rc.cssAppendList = "shCore,shThemeDefault";
		event.setView("logs/help");
	}
	
	function saveMaxRows(event){
		var rc = event.getCollection();
		sessionStorage.setVar("maxRows", rc.maxRows);
		getPlugin("MessageBox").setMessage(type="info", message="Max Rows Preference Saved!");
		setNextEvent('relax:logs');
	}
	
	function viewer(event){
		var rc = event.getCollection();
		rc.qLog = logService.getLog(rc.logid);
		event.setView(name="logs/viewer",layout="Ajax");
	}
	
	function purgeLogs(event){
		logService.purgeLogs();
		getPlugin("MessageBox").setMessage(type="info", message="All Logs Purged");
		setNextEvent('relax:logs');
	}

</cfscript>
</cfcomponent>