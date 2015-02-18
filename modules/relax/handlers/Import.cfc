/**
********************************************************************************
Copyright 2005-2007 by Luis Majano and Ortus Solutions, Corp
www.ortussolutions.com
********************************************************************************
* Import Handler
*/
component extends="BaseHandler"{

	/**
	* Show the importer
	*/
	function api( event, rc, prc ){
		// exit handlers
		prc.xehImport = "relax/import/start";

		event.renderData( data=renderView( view="import/api", module="relax" ) );
	}

	/**
	* Begin the import process
	*/
	function start( event, rc, prc ){
		event.paramValue( "apiName", "" )
			.paramValue( "apiJSON", "" );

		// validate data
		if( not len( rc.apiName ) OR not len( rc.apiJSON ) ){
			flash.put( "notice", "Please enter a valid API name and JSON content" );
			setNextEvent( prc.xehHome );
		}
		if( not isJSON( rc.apiJSON ) ){
			flash.put( "notice", "The JSON representation is not valid JSON,, please try again." );
			setNextEvent( prc.xehHome );
		}

		// slugify name
		rc.apiName = getInstance( "HTMLHelper@coldbox" ).slugify( rc.apiName );
		// Import API
		DSLService.importAPI( name=rc.apiName, json=rc.apiJSON );
		// Flash Notice
		flash.put( "notice" , "API imported successfully!" );

		// Relocate
		setNextEvent( prc.xehHome );
	}

}