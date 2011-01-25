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
		event.setView("home/index");
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
		
		// custom css/js
		rc.jsAppendList  = "jquery.scrollTo-min,shCore,brushes/shBrushJScript,brushes/shBrushColdFusion,brushes/shBrushXml";
		rc.cssAppendList = "shCore,shThemeDefault";
		
		// exit handlers
		rc.xehPurgeHistory = "relax/Home.purgeHistory";
		
		// send request
		if( rc.sendRequest ){
			try{
				rc.results = relaxerService.send(argumentCollection=rc);
			}
			catch(Any e){
				log.error("Error sending relaxed request! #e.message# #e.detail# #e.stackTrace#", e);
				getPlugin("MessageBox").error("Error sending relaxed request! #e.message# #e.detail#");
			}
		}
		
		// Get request history
		rc.requestHistory = relaxerService.getHistory();
		
		// display relaxer
		event.setView("home/relaxer");
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

</cfscript>
</cfcomponent>