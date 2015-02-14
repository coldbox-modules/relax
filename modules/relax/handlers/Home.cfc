component extends="BaseHandler"{

	property name="relaxerService" 	inject="Relaxer@relax";
	property name="DSLService"		inject="DSLService@relax";


	function index(event,rc,prc){
		// module settings
		rc.settings 		= getModuleSettings("relax");
		// Get the loaded API for the user
		rc.dsl				= DSLService.getLoadedAPI();
		rc.loadedAPIName 	= DSLService.getLoadedAPIName();
		rc.loadedAPIs		= DSLService.listAPIs();
		// JS/CSS Append
		rc.jsAppendList  = "shCore,brushes/shBrushColdFusion,brushes/shBrushJScript,brushes/shBrushXml";
		rc.cssAppendList = "shCore,shThemeDefault";
		// Exit Handlers
		rc.xehResourceDoc  		= "relax/Home.resourceDoc";
		rc.xehResourceDocEvent  = "relax:Home.resourceDoc";
		rc.xehExportHTML 		= "relax/Export.html";
		rc.xehExportPDF 		= "relax/Export.pdf";
		rc.xehExportwiki 		= "relax/Export.mediawiki";
		rc.xehExportTrac 		= "relax/Export.trac";
		rc.xehExportAPI			= "relax/Export.api";
		rc.xehImportAPI			= "relax/Import.api";
		rc.xehLoadAPI			= "relax/Home.loadAPI";

		// Expanded div for resource holders
		rc.expandedResourceDivs = false;

		event.setView("home/index");
	}

	function test(event,rc,prc){
		event.setView(name="test",layout="template");
	}

	function relax(event,rc,prc){
		event.setView(name="home/relax",layout="Ajax");
	}

	function clearUserData(event,rc,prc){
		DSLService.clearUserData();
		setNextEVent(rc.xehHome);
	}

	function loadAPI(event,rc,prc){
		event.paramValue("apiName","");
		// load the api if it has length else ignored.
		if( len(rc.apiName) ){
			test = DSLService.loadAPI( rc.apiName );
			flash.put( "notice", "API: #rc.apiName# loaded!" );
		}
		setNextEvent(rc.xehHome);
	}

	function relaxer(event,rc,prc){
		// some defaults
		event.paramValue("httpResource","");
		event.paramValue("httpFormat","");
		event.paramValue("httpMethod","GET");
		event.paramValue("headerNames","");
		event.paramValue("headerValues","");
		event.paramValue("parameterNames","");
		event.paramValue("parameterValues","");
		event.paramValue("sendRequest",false);
		event.paramValue("username","");
		event.paramValue("password","");
		event.paramValue("httpProxy","");
		event.paramValue("httpProxyPort","");
		event.paramValue("entryTier","production");

		// module settings
		rc.settings 		= getModuleSettings("relax");
		// DSL Settings
		rc.dsl				= DSLService.getLoadedAPI();
		rc.loadedAPIName 	= DSLService.getLoadedAPIName();

		// custom css/js
		rc.jsAppendList  = "jquery.scrollTo-min,shCore,brushes/shBrushJScript,brushes/shBrushColdFusion,brushes/shBrushXml";
		rc.cssAppendList = "shCore,shThemeDefault";

		// exit handlers
		rc.xehPurgeHistory 	= "relax/Home.purgeHistory";
		rc.xehResourceDoc  	= "relax/Home.resourceDoc";
		rc.xehLoadAPI		= "relax/Home.loadAPI";

		// send request
		if( rc.sendRequest ){
			try{
				rc.results = relaxerService.send(argumentCollection=rc);
			}
			catch(Any e){
				log.error("Error sending relaxed request! #e.message# #e.detail# #e.stackTrace#", e);
				flash.put( "notice", "Error sending relaxed request! #e.message# #e.detail# #e.tagContext.toString()#" );
			}
		}

		// Get request history
		rc.requestHistory = relaxerService.getHistory();

		// display relaxer
		event.setView("home/relaxer");
	}

	function resourceDoc(event,rc,prc,resourceID,expandedDiv){
		var layout = "Ajax";

		// event setup
		rc.settings 		= getModuleSettings("relax");
		// DSL Settings
		rc.dsl				= DSLService.getLoadedAPI();
		rc.loadedAPIName 	= DSLService.getLoadedAPIName();
		// exit handlers
		rc.xehResourceDoc  	= "relax/Home.resourceDoc";
		// expanded divs
		rc.expandedResourceDivs = true;

		// custom css/js
		rc.jsAppendList  = "shCore,brushes/shBrushJScript,brushes/shBrushColdFusion,brushes/shBrushXml";
		rc.cssAppendList = "shCore,shThemeDefault";

		// select layout
		if( structKeyExists(rc,"print") ){ layout = lcase(rc.print); }

		// selected ID for resource display
		for(x=1; x lte arrayLen(rc.dsl.resources);x++){
			if( rc.dsl.resources[x].resourceID eq rc.resourceID ){
				rc.thisResource = rc.dsl.resources[x];
				break;
			}
		}

		// set view for Rendering
		event.setView(name="home/docs/resourceDoc",layout="#layout#");
	}

	function purgeHistory(event,rc,prc){
		var results = {
			error = false,
			messages = "History cleaned!"
		};
		try{
			relaxerService.clearHistory();
		}
		catch(Any e){
			results.error = true;
			results.messages = "error clearing history: #e.detail# #e.message#";
			if( log.canError() ){
				log.error("Error clearing history: #e.message# #e.detail#",e);
			}
		}
		event.renderData(type="jsont",data=results);
	}

	function dslDocs(event,rc,prc){
		prc.docs = getModel("DSLDoc@relax").generate();
		event.setView(name="home/DSLDocs");
	}

	function dslDocsCodex(event,rc,prc){
		event.renderData(data=getModel("DSLDoc@relax").generateCodex(),type="text");
	}

}