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

	<!--- Dependencies --->
	<cfproperty name="DSLService" inject="id:DSLService@relax" >

<cfscript>

	function api(event,rc,prc){
		// exit handlers
		prc.xehImport = "relax/import/start";

		event.setView(name="import/api",layout="ajax");
	}

	function start(event,rc,prc){
		event.paramValue("apiName","")
			.paramValue("apiJSON","");

		// validate data
		if( not len(rc.apiName) OR not len(rc.apiJSON) ){
			flash.put( "notice", "Please enter a valid API name and JSON content" );
			//setNextEvent(rc.xehHome);
		}
		if( not isJSON(rc.apiJSON) ){
			flash.put( "notice", "The JSON representation is not valid JSON,, please try again." );
			//setNextEvent(rc.xehHome);
		}

		// slugify name
		rc.apiName = getInstance("HTMLHelper@coldbox").slugify( rc.apiName );

		// Import API
		DSLService.import(name=rc.apiName,json=rc.apiJSON);

		// relocate
		flash.put( "notice" , "API imported successfully!" );

		setNextEvent(rc.xehHome);
	}
</cfscript>
</cfcomponent>