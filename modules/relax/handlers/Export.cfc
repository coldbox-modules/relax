/**
********************************************************************************
Copyright 2005-2007 by Luis Majano and Ortus Solutions, Corp
www.ortussolutions.com
********************************************************************************
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
		prc.dsl				= DSLService.getLoadedAPI();
		prc.loadedAPIName 	= DSLService.getLoadedAPIName();
		// custom css/js
		prc.jsAppendList 	= "jquery.scrollTo-min,shCore,brushes/shBrushJScript,brushes/shBrushColdFusion,brushes/shBrushXml";
		prc.cssAppendList 	= "shCore,shThemeDefault";
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
			var title = getInstance( "htmlhelper@coldbox" ).slugify( prc.dsl.relax.title );
			event.setHTTPHeader( name="content-disposition", value='attachment; filename="#title#.json"')
				.renderData( data=prc.jsonAPI, type="json" );
		} else {
			event.renderData( data=renderView( view="export/api", module="relax" ) );
		}
	}

	/**
	* Export as HTML
	*/
	function html( event, rc, prc ){
		prc.print 				 = "true";
		prc.expandedResourceDivs = true;

		// custom css/js
		prc.jsAppendList  = "shCore,brushes/shBrushJScript,brushes/shBrushColdFusion,brushes/shBrushXml";
		prc.cssAppendList = "shCore,shThemeDefault";

		// View
		event.setView( name="export/html", layout="html" );
	}

	/**
	* Export as PDF
	*/
	function pdf( event, rc, prc ){
		var title = getInstance( "htmlhelper@coldbox" ).slugify( prc.dsl.relax.title );
		html( event, rc, prc );
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
		var data = wikitext.toWiki( wikiTranslator=arguments.type, htmlString=renderView( view="export/html", module="relax" ) );
		event.renderData( type="text", data=data );
	}

}