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
	* Home
	*/
	function index( event, rc, prc ){
		// set view
		event.setView( "home/index" );
	}

	/**
	* Home
	*/
	function relax( event, rc, prc ){
		event.renderData( data=renderView( view="home/relax", module="relax" ) );
	}

	/**
	* Load a selected API
	*/
	function loadAPI( event, rc, prc ){
		event.paramValue( "apiName", "" )
			.paramValue( "returnEvent", "" );

		// load the api if it has length else ignored.
		if( len( rc.apiName ) ){
			APIService.loadAPI( rc.apiName );
			if( variables.settings.sessionsEnabled ) {
				flash.put( "notice", "API: #rc.apiName# loaded!" );
			}
		}

		setNextEvent( len( rc.returnEvent ) ? rc.returnEvent : prc.xehHome );
	}

	/**
	* Export Resource Doc
	*/
	function resourceDoc( event, rc, prc, resourceID, expandedDiv, boolean widget=false ){
		// DSL Settings
		prc.dsl					= APIService.getLoadedAPI();
		prc.loadedAPIName 		= APIService.getLoadedAPIName();
		// exit handlers
		prc.xehResourceDoc  	= "relax/home/resourceDoc";
		// expanded divs
		prc.expandedResourceDivs = true;

		// select layout
		event.paramValue( "print", "html" );

		// selected ID for resource display
		for(var x=1; x lte arrayLen( prc.dsl.resources ); x++ ){
			if( prc.dsl.resources[ x ].resourceID eq rc.resourceID ){
				prc.thisResource = prc.dsl.resources[x];
				break;
			}
		}

		// set view for Rendering
		if( arguments.widget ){
			return renderView( view="home/docs/resourceDoc", module="relax" );
		} else {
			event.setView( view="home/docs/resourceDoc", layout="#rc.print#" );
		}
	}

	/**
	* Home
	*/
	function clearUserData( event, rc, prc ){
		APIService.clearUserData();
		setNextEVent(rc.xehHome);
	}

}