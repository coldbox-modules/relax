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

		prc.exportTitle 			= getInstance( "htmlhelper@coldbox" )
			.slugify( prc.dsl[ "info" ][ "title" ] ) & " v" & prc.dsl[ "info" ][ "version" ];

		// View
		event.setView(
			view 	= "apidoc/cfTemplate/api-content",
			layout 	= "html",
			args 	= { "api" : prc.dsl }
		);
	}

	/**
	* Export as PDF
	*/
	function pdf( event, rc, prc ){
		return this.html( argumentCollection=arguments );
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
			rc.content = renderView( view="apidoc/cfTemplate/api-content", args={"api":prc.dsl}, module="relax" );
		}
		var data = wikitext.toWiki( translator=arguments.type, html=rc.content );
		event.setHTTPHeader( name="content-disposition", value='attachment; filename="#prc.loadedAPIName#.#lcase( arguments.type )#.txt"');
		event.renderData( type="text", data=data );
	}

}