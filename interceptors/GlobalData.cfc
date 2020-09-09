/**
 * Copyright Ortus Solutions, Corp, All rights reserved
 * www.ortussolutions.com
 * ---
 * Global interception to setup request data
 */
component {
	function preProcess( event, rc, prc ){
		// module root
		prc.root 			= event.getModuleRoot();
		// Exit Handlers
		prc.xehResourceDoc  = "relax/Home/resourceDoc";
		prc.xehLoadAPI		= "relax/Home/loadAPI";
		prc.xehExportHTML 	= "relax/Export/html";
		prc.xehExportPDF 	= "relax/Export/pdf";
		prc.xehExportWiki 	= "relax/Export/mediawiki";
		prc.xehExportTrac 	= "relax/Export/trac";
		prc.xehExportAPI	= "relax/Export/api";
		prc.xehImportAPI	= "relax/Import/api";

		// Expanded div for resource holders
		prc.expandedResourceDivs = false;

		prc[ "relaxGlobalData" ] = {
			"rootPath" : prc.root,
			"expandAll" : prc.expandedResourceDivs,
			"sessionEnabled" : getInstance( "APIService@relax" ).getSessionsEnabled(),
			"url" : {
				"moduleRoot" : replacenocase( event.buildLink( 'relax' ), "/index.cfm", "" ),
				"resourceDoc" : event.buildLink( prc.xehResourceDoc ),
				"loadAPI" : event.buildLink( prc.xehLoadAPI ),
				"exportHTML" : event.buildLink( prc.xehExportHTML ),
				"exportPDF" : event.buildLink( prc.xehExportPDF ),
				"exportAPI" : event.buildLink( prc.xehExportAPI ),
				"exportWiki" : event.buildLink( prc.xehExportWiki ),
				"exportTrac" : event.buildLink( prc.xehExportTrac ),
				"importAPI" : event.buildLink( prc.xehImportAPI )
			}
		};

	}
}
