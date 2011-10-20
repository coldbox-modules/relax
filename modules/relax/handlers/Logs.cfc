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
	<cfproperty name="logService" 		inject="id:logService@relaxlogs" >
	<cfproperty name="sessionStorage" 	inject="coldbox:plugin:SessionStorage">

<cfscript>

	function preHandler(event){
		super.preHandler(event);
		if( NOT sessionStorage.exists("maxRows") ){
			sessionStorage.setVar("maxRows", getModuleSettings('relax').settings.relaxLogs.maxRows);
		}
	}

	function index(event,rc,prc){
		// search
		event.paramvalue("search","");
		rc.search = urlDecode( rc.search );
		
		//paging
		event.paramValue("page",1);
		event.paramValue("maxRows", sessionStorage.getVar("maxRows") );
		rc.pagingPlugin = getMyPlugin(plugin="Paging",module="relax");
		rc.paging 		= rc.pagingPlugin.getBoundaries(rc.maxRows);
		rc.pagingLink 	= event.buildLink('relax/logs.index.page.@page@');
		
		// alter paging for search
		if( len(rc.search) ){
			rc.pagingLink 	= event.buildLink('relax/logs.index.search.#urlEncodedFormat(rc.search)#.page.@page@');
		}
		
		// JS/CSS Append
		rc.jsAppendList  = "shCore,brushes/shBrushColdFusion";
		rc.cssAppendList = "shCore,shThemeDefault";
		
		
		// exit handlers
		rc.xehStoreMaxRows = "relax:logs.saveMaxRows";
		
		// Log Settings
		rc.logSettings = getModuleSettings("relax").settings.relaxLogs;
		
		// Get Logs
		rc.qLogs = logService.getLogs(startRow=rc.paging.startRow,maxRow=rc.paging.maxRow,search=rc.search);
		rc.totalLogCount = logService.getTotalLogs(search=rc.search);
		rc.qStats = logService.getLogStats();
		
		// Exit handlers
		rc.xehPurge 	= "relax:logs.purgeLogs";
		rc.xehQuickView = "relax:logs.viewer";
		
		event.setView("logs/index");
	}
	
	function help(event,rc,prc){
		// JS/CSS Append
		rc.jsAppendList  = "shCore,brushes/shBrushColdFusion";
		rc.cssAppendList = "shCore,shThemeDefault";
		event.setView("logs/help");
	}
	
	function saveMaxRows(event,rc,prc){
		sessionStorage.setVar("maxRows", rc.maxRows);
		getPlugin("MessageBox").setMessage(type="info", message="Max Rows Preference Saved!");
		setNextEvent('relax:logs');
	}
	
	function viewer(event,rc,prc){
		event.paramValue("print",false);
		// exit handlers
		rc.xehQuickView = "relax:logs.viewer";
		// get logs
		rc.qLog = logService.getLog(rc.logid);
		// print or normal
		if( rc.print ){
			event.setView(name="logs/viewer",layout="html");
		}
		else{
			event.setView(name="logs/viewer",layout="Ajax");
		}
	}
	
	function purgeLogs(event,rc,prc){
		logService.purgeLogs();
		getPlugin("MessageBox").setMessage(type="info", message="All Logs Purged");
		setNextEvent('relax:logs');
	}

</cfscript>
</cfcomponent>