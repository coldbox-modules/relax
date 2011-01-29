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
<cfscript>

	function preHandler(event){
		var rc = event.getCollection();
		super.preHandler(argumentCollection=arguments);
		// module settings
		rc.settings = getModuleSettings("relax").settings;
		rc.dsl		= rc.settings.dsl;
		// custom css/js
		rc.jsAppendList  = "jquery.scrollTo-min,shCore,brushes/shBrushJScript,brushes/shBrushColdFusion,brushes/shBrushXml";
		rc.cssAppendList = "shCore,shThemeDefault";
		// Exit Handlers
		rc.xehResourceDocEvent  = "relax:Home.resourceDoc";
	}

	function html(event){
		var rc = event.getCollection();
		rc.print = "true";
		rc.eventArguments = {
			expandedDiv = true
		};
		event.setView(name="export/html",layout="html");
	}
	
	function pdf(event){
		var rc = event.getCollection();
		html(event);
		event.setLayout("pdf");
	}
	
	function mediawiki(event){
		wikiMarkup(event,"MEDIAWIKI");
	}

	function trac(event){
		wikiMarkup(event,"TRAC");	
	}

	function wikiMarkup(event,type){
		var rc = event.getCollection();
		var converter = getPlugin(plugin="WikiText",module="relax");
		var data = "";
		
		html(event);
		data = converter.toWiki(wikiTranslator=arguments.type,htmlString=renderView("export/html"));
		event.renderData(type="text",data=data);
	}

</cfscript>
</cfcomponent>