/**
********************************************************************************
Copyright 2005-2007 by Luis Majano and Ortus Solutions, Corp
www.ortussolutions.com
********************************************************************************
* Main Handler
*/
component extends="BaseHandler"{

	// DI
	property name="relaxerService" 	inject="Relaxer@relax";

	/**
	* The Awesome Relaxer
	*/
	function index( event, rc, prc ){
		// some defaults
		event.paramValue( "httpResource", "" );
		event.paramValue( "httpFormat", "" );
		event.paramValue( "httpMethod", "GET" );
		event.paramValue( "headerNames", "" );
		event.paramValue( "headerValues", "" );
		event.paramValue( "parameterNames", "" );
		event.paramValue( "parameterValues", "" );
		event.paramValue( "sendRequest", false );
		event.paramValue( "username", "" );
		event.paramValue( "password", "" );
		event.paramValue( "httpProxy", "" );
		event.paramValue( "httpProxyPort", "" );
		event.paramValue( "entryTier", "production" );

		// DSL Settings
		prc.dsl				= DSLService.getLoadedAPI();
		prc.loadedAPIName 	= DSLService.getLoadedAPIName();

		// exit handlers
		prc.xehPurgeHistory = "relax/relaxer/purgeHistory";
		prc.xehResourceDoc  = "relax/relaxer/resourceDoc";

		// send request
		if( rc.sendRequest ){
			try{
				prc.results = relaxerService.send( argumentCollection=rc );
			} catch( Any e ){
				log.error( "Error sending relaxed request! #e.message# #e.detail# #e.stackTrace#", e );
				flash.put( "notice", "Error sending relaxed request! #e.message# #e.detail# #e.tagContext.toString()#" );
			}
		}

		// Inflate lists
		rc.headerNames 		= listToArray( rc.headerNames );
		rc.headerValues 	= listToArray( rc.headerValues );
		rc.parameterNames 	= listToArray( rc.parameterNames );
		rc.parameterValues 	= listToArray( rc.parameterValues );

		// Get request history
		prc.requestHistory = relaxerService.getHistory();

		// display relaxer
		event.setView( "relaxer/index" );
	}

	/**
	* resourceDoc, called via Ajax
	*/
	any function resourceDoc( event, rc, prc ){
		prc.body = runEvent( event="relax:home.resourceDoc", eventArguments={ widget=true } );
		event.renderData( data=renderView( view="relaxer/resourceDoc", module="relax" ) );
	}

	/**
	* Purge relaxer history
	*/
	function purgeHistory( event, rc, prc ){
		var results = {
			"error" 	= false,
			"messages" 	= "History cleaned!"
		};
		try{
			relaxerService.clearHistory();
		} catch( Any e ){
			results.error 	 = true;
			results.messages = "error clearing history: #e.detail# #e.message#";
			if( log.canError() ){
				log.error( "Error clearing history: #e.message# #e.detail#", e );
			}
		}
		event.renderData( type="json", data=results );
	}

}