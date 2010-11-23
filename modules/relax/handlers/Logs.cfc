<cfcomponent output="false" extends="BaseHandler">

	<!--- Dependencies --->
	<cfproperty name="logService" inject="model:relax.logBox.logService" >

<cfscript>

	function index(event){
		var rc = event.getCollection();
		
		//paging
		event.paramValue("page",1);
		rc.pagingPlugin = getMyPlugin(plugin="Paging",module="relax");
		rc.paging = rc.pagingPlugin.getBoundaries();
		rc.pagingLink = event.buildLink('relax:logs.index.page.@page@');
		
		// Get Logs
		rc.qLogs = logService.getLogs(startRow=rc.paging.startRow,maxRow=rc.paging.maxRow);
		rc.totalLogCount = logService.getTotalLogs();
		
		// Exit handlers
		rc.xehPurge 	= "relax:logs.purgeLogs";
		rc.xehQuickView = "relax:logs.viewer";
		
		event.setView("logs/index");
	}
	
	function viewer(event){
		var rc = event.getCollection();
		rc.qLog = logService.getLog(rc.logid);
		event.setView(name="api/viewer",layout="Ajax");
	}
	
	function purgeLogs(event){
		logService.purgeLogs();
		getPlugin("MessageBox").setMessage(type="info", message="All Logs Purged");
		setNextEvent('relax:logs');
	}

</cfscript>
</cfcomponent>