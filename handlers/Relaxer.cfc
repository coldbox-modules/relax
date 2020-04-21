/**
* Copyright Ortus Solutions, Corp, All rights reserved
* www.ortussolutions.com
* ---
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
		event.paramValue( "httpResource", "" )
			.paramValue( "httpFormat", "" )
			.paramValue( "httpMethod", "GET" )
			.paramValue( "headerNames", "" )
			.paramValue( "headerValues", "" )
			.paramValue( "parameterNames", "" )
			.paramValue( "parameterValues", "" )
			.paramValue( "sendRequest", false )
			.paramValue( "username", "" )
			.paramValue( "password", "" )
			.paramValue( "httpProxy", "" )
			.paramValue( "httpProxyPort", "" )
			.paramValue( "entryTier", "production" );

		// DSL Settings
		prc.dsl						= APIService.getLoadedAPI().getNormalizedDocument();
		prc.serviceEntryPoints		= [];
		prc.loadedAPIName 			= APIService.getLoadedAPIName();
		prc.loadedAPIs				= APIService.listAPIs();

		// exit handlers
		prc.xehPurgeHistory = "relax/relaxer/purgeHistory";
		prc.xehResourceDoc  = "relax/relaxer/resourceDoc";
		prc.xehLoadAPI		= "relax/Home/loadAPI";

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

		// display relaxer
		event.setView( "relaxer/index" );
	}

	any function send( event,rc,prc ){
		prc.results = {};

		try{

			var payload = event.getHTTPContent( json=true );

			/** Handle our interpolation of legacy client naming conventions **/
			if( structKeyExists( payload, "data" ) ){
				payload[ "params" ] = payload.data;
				structDelete( payload, "data" );
			}

			// deserialize our incoming json packet of request data
			prc.results = relaxerService.send( argumentCollection = payload );

		} catch( Any e ){
			prc.results[ 'mimeType' ] = "application/json";

			if( getSetting( "environment" ) != 'production' ){

				prc.results[ 'error' ] = "Error sending relaxed request! #e.message# #e.detail# #e.stackTrace#";
				prc.results[ 'message' ] = "Error sending relaxed request! #e.message# #e.detail# #e.tagContext.toString()#";

			} else {

				prc.results[ 'error' ] = "Invalid request. Please correct the URL and parameters of your endpoint and try again";

			}

			log.error( prc.results.error, e );

		}

		event.renderData( data=prc.results, type="json" );
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