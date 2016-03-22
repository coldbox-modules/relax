/**
* Copyright Ortus Solutions, Corp, All rights reserved
* www.ortussolutions.com
* ---
* Export handler
*/
component extends="BaseHandler"{
	
	// DI
	property name="wikitext"		inject="wikitext@wikitext";

	/**
	* pre handler
	*/
	function preHandler( event, rc, prc ){
		super.preHandler( argumentCollection=arguments );
		// Get the loaded API for the user
		prc.dsl				= APIService.getLoadedAPI().getNormalizedDocument();
		prc.loadedAPIName 	= APIService.getLoadedAPIName();

	}

	/**
	* API Export
	*/
	function api( event, rc, prc ){
		// exit handlers
		prc.xehExportAPI = "relax/export/api";
		// serialze the api
		prc.jsonAPI = serializeJSON( prc.dsl );

		if( event.valueExists( "download" ) ){
			event.setHTTPHeader( name="content-disposition", value='attachment; filename="#prc.loadedAPIName#.json"')
				.renderData( data=prc.dsl, type="json" );
		} else {
			event.renderData( data=renderView( view="export/api", module="relax" ) );
		}
	}

	/**
	* Export as HTML
	*/
	function html( event, rc, prc ){
		// args setup
		rc.print 				 = true;
		prc.expandedResourceDivs = true;
		// exit handlers
		prc.xehResourceDoc  = "relax/Home/resourceDoc";

		// View
		event.setView( name="export/html", layout="html" );
	}

	/**
	* Export as PDF
	*/
	function pdf( event, rc, prc ){
		
		var title = getInstance( "htmlhelper@coldbox" ).slugify( prc.dsl.info.title);
		
		if( !structKeyExists( rc, 'pagecontent' ) ){
			html( event, rc, prc );	
		}

		event.setLayout( "pdf" )
			.setHTTPHeader( name="Content-Disposition", value="inline; filename=#title#.pdf" );
	}

	/**
	* Export as media wiki
	*/
	function mediawiki( event, rc, prc ){
		toWikiMarkup( event, rc, prc, "WIKIPEDIA" );
	}

	/**
	* Export as Trac
	*/
	function trac( event, rc, prc ){
		toWikiMarkup( event, rc, prc, "TRAC" );
	}

	/**
	* Export as wiki markup
	*/
	private function toWikiMarkup( event, rc, prc, type ){
		html( event, rc, prc );
		if( !structKeyExists( rc, "content" ) ){
			rc.content = renderView( view="export/html", module="relax" );
		}
		var data = wikitext.toWiki( translator=arguments.type, html=rc.content );
		event.renderData( type="text", data=data );
	}

}