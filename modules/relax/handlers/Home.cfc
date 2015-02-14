component extends="BaseHandler"{

	// DI
	property name="relaxerService" 	inject="Relaxer@relax";
	property name="DSLService"		inject="DSLService@relax";

	/**
	* Home
	*/
	function index( event, rc, prc ){
		// Get the loaded API for the user
		prc.dsl				= DSLService.getLoadedAPI();
		prc.loadedAPIName 	= DSLService.getLoadedAPIName();
		prc.loadedAPIs		= DSLService.listAPIs();
		// JS/CSS Append
		prc.jsAppendList  = "shCore,brushes/shBrushColdFusion,brushes/shBrushJScript,brushes/shBrushXml";
		prc.cssAppendList = "shCore,shThemeDefault";
		// Exit Handlers
		prc.xehResourceDoc  	= "relax/Home.resourceDoc";
		prc.xehResourceDocEvent = "relax:Home.resourceDoc";
		prc.xehExportHTML 		= "relax/Export.html";
		prc.xehExportPDF 		= "relax/Export.pdf";
		prc.xehExportwiki 		= "relax/Export.mediawiki";
		prc.xehExportTrac 		= "relax/Export.trac";
		prc.xehExportAPI		= "relax/Export.api";
		prc.xehImportAPI		= "relax/Import.api";
		prc.xehLoadAPI			= "relax/Home.loadAPI";

		// Expanded div for resource holders
		rc.expandedResourceDivs = false;

		event.setView( "home/index" );
	}

	/**
	* Home
	*/
	function relax( event, rc, prc ){
		event.setView(name="home/relax",layout="Ajax");
	}

	/**
	* Home
	*/
	function clearUserData( event, rc, prc ){
		DSLService.clearUserData();
		setNextEVent(rc.xehHome);
	}

	/**
	* Home
	*/
	function loadAPI( event, rc, prc ){
		event.paramValue("apiName","");
		// load the api if it has length else ignored.
		if( len(rc.apiName) ){
			test = DSLService.loadAPI( rc.apiName );
			flash.put( "notice", "API: #rc.apiName# loaded!" );
		}
		setNextEvent(rc.xehHome);
	}

	/**
	* Home
	*/
	function relaxer( event, rc, prc ){
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

	/**
	* Home
	*/
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

	/**
	* Home
	*/
	function purgeHistory( event, rc, prc ){
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

	/**
	* Home
	*/
	function dslDocs( event, rc, prc ){
		prc.docs = getModel("DSLDoc@relax").generate();
		event.setView(name="home/DSLDocs");
	}

	/**
	* Home
	*/
	function dslDocsCodex( event, rc, prc ){
		event.renderData(data=getModel("DSLDoc@relax").generateCodex(),type="text");
	}

}