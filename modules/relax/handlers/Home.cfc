<!-----------------------------------------------------------------------
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldbox.org | www.luismajano.com | www.ortussolutions.com
********************************************************************************

Author     :	Luis Majano
Description :
	Home Handler Section
----------------------------------------------------------------------->
<cfcomponent output="false" extends="BaseHandler">

	<!--- dependencies --->
	<cfproperty name="relaxerService" inject="model:relax.Relaxer" >
	
<cfscript>

	function index(event){
		var rc = event.getCollection();
		
		// module settings
		rc.settings = getModuleSettings("relax").settings;
		rc.dsl		= rc.settings.dsl;
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
		
		// viewlet argument passholder
		rc.eventArguments 	= {
			expandedDiv = false
		};
		// View
		event.setView("home/index");
	}
	
	function test(event){
		event.setView(name="test",layout="template");
	}
	
	function relax(event){
		event.setView(name="home/relax",layout="Ajax");
	}
	
	function relaxer(event){
		var rc = event.getCollection();
		
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
		rc.settings = getModuleSettings("relax").settings;
		rc.dsl		= rc.settings.dsl;
		
		// custom css/js
		rc.jsAppendList  = "jquery.scrollTo-min,shCore,brushes/shBrushJScript,brushes/shBrushColdFusion,brushes/shBrushXml";
		rc.cssAppendList = "shCore,shThemeDefault";
		
		// exit handlers
		rc.xehPurgeHistory = "relax/Home.purgeHistory";
		rc.xehResourceDoc  = "relax/Home.resourceDoc";
		
		// send request
		if( rc.sendRequest ){
			try{
				rc.results = relaxerService.send(argumentCollection=rc);
			}
			catch(Any e){
				log.error("Error sending relaxed request! #e.message# #e.detail# #e.stackTrace#", e);
				getPlugin("MessageBox").error("Error sending relaxed request! #e.message# #e.detail# #e.tagContext.toString()#");
			}
		}
		
		// Get request history
		rc.requestHistory = relaxerService.getHistory();
		
		// display relaxer
		event.setView("home/relaxer");
	}
		
	function resourceDoc(event,resourceID,expandedDiv){
		var rc = event.getCollection();
		var layout = "Ajax";
		
		// module settings
		rc.settings 		= getModuleSettings("relax").settings;
		rc.dsl				= rc.settings.dsl;
		rc.xehResourceDoc  	= "relax/Home.resourceDoc";
		rc.expandedDiv 		= true;
		
		// custom css/js
		rc.jsAppendList  = "shCore,brushes/shBrushJScript,brushes/shBrushColdFusion,brushes/shBrushXml";
		rc.cssAppendList = "shCore,shThemeDefault";
		
		// select layout
		if( structKeyExists(rc,"print") ){ layout = lcase(rc.print); }
		
		// Resource ID Override?
		if( structKeyExists(arguments,"resourceID") ){ 
			rc.resourceID = arguments.resourceID;
		}
		
		// Expanded Div Override?
		if( structKeyExists(arguments, "expandedDiv") ){ rc.expandedDiv = arguments.expandedDiv; }
		else{ rc.expandedDiv = true; }
		
		// selected ID for resource display
		for(x=1; x lte arrayLen(rc.dsl.resources);x++){
			if( rc.dsl.resources[x].resourceID eq rc.resourceID ){
				rc.thisResource = rc.dsl.resources[x];
				break;
			}
		}
		
		// viewlet or not?
		if( structKeyExists(arguments,"resourceID") ){ 
			return renderView("home/docs/resourceDoc");
		}
		else{
			event.setView(name="home/docs/resourceDoc",layout="#layout#");
		}
	}
	
	function purgeHistory(event){
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
	
	function checkUpdates(event){
		var rc = event.getCollection();
		
		// check updates
		rc.entry = getMyPlugin(plugin="ForgeBox",module="Relax").getEntry('coldbox-relax');
		
		event.setView(name="home/checkUpdates",layout="Ajax");
	}

</cfscript>
</cfcomponent>