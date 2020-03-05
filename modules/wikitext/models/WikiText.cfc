/**
* Copyright 2015 Ortus Solutions, Corp
* www.ortussolutions.com
* Manage the wikitext library
*/
component accessors="true" singleton{

	// DI
	property name="javaloader" inject="loader@cbjavaloader";

	/**
	* The location of the parser's library
	*/
	property name="parserLibPath";
	/**
	* Available Translators array
	*/
	property name="translators";
	/**
	* Wiki Configuration object
	*/
	property name="wikiConfig";

	// Converter static references
	this.WIKIPEDIA 	= "info.bliki.html.wikipedia.ToWikipedia";
	this.GOOGLECODE = "info.bliki.html.googlecode.ToGoogleCode";
	this.MOINMOIN 	= "info.bliki.html.googlecode.ToMoinMoin";
	this.JSPWIKI 	= "info.bliki.html.jspwiki.ToJSPWiki";	
	this.TRAC 		= "info.bliki.html.googlecode.ToTrac";

	/**
	* Constructor
	*/
	function init(){
		// WikiParser Lib Path */
		parserLibPath = getDirectoryFromPath( getMetadata( this ).path ) & "lib";
		// Setup available translators
		translators = [ "WIKIPEDIA" , "GOOGLECODE", "JSPWIKI", "MOINMOIN", "TRAC" ];
		
		return this;
	}

	/**
	* Configure the Wiki Converter Driver, usually called after construction when a system is ready to startup the engine
	*/
	function configure( struct settings={} ){
		// if got passed settings, then override
		variables.settings = arguments.settings;

		// Setup JavaLoader
		javaLoader.appendPaths( parserLibPath );

		// Create Wiki Config object and store it
		wikiConfig = getJavaLoader().create( "info.bliki.wiki.model.Configuration" ).init();
		var tagNode = getJavaLoader().create( "info.bliki.wiki.tags.HTMLTag" );
		
		// Add CF Source Highlighting Configuration
		wikiConfig.addCodeFormatter( "coldfusion", javaloader.create( "com.codexwiki.bliki.codeFilter.ColdFusionCodeFilter" ).init() );
		
		// Add Allowed attribute registrations
		var allowedAttributes = listToArray( settings.allowedAttributes );
		for( var thisAttrib in allowedAttributes ){
			tagNode.addAllowedAttribute( thisAttrib );
		}
		
		// Add Ignored Tag Lists into configuration
		var ignoreTagList = listToArray( settings.ignoreTagList );
		for( var thisTag in ignoreTagList ){
			wikiConfig.addTokenTag( thisTag, javaLoader.create( "org.htmlcleaner.TagNode" ).init( thisTag ) );
		}
	}

	/************************************** PUBLIC *********************************************/

	/**
	* Convert an HTML string to wiki syntax
	* translator.hint The wiki syntax to use. It must be using a valid translator. [WIKIPEDIA,GOOGLECODE,JSPWIKI,MOINMOIN,TRAC]
	* html.hint The html string to convert
	*/
	function toWiki(required translator, required html){
		var translatorRegex = replace( arrayToList( getTranslators() ), ",", "|", "all" );
		
		// Validate incoming translator syntax
		if( NOT reFindNoCase("^(#translatorRegex#)$", arguments.translator ) ){
			throw(message="Invalid Wiki Translator",
				  detail="The translator you sent in #arguments.translator# is not valid.  Valid translators are #arrayToList( getTranslators() )#",
				  type="WikiText.HTML2WikiConverter.InvalidTranslatorException");
		}
		
		// create HTML2Wiki converter
		var oConverter = javaLoader.create("info.bliki.html.HTML2WikiConverter").init( arguments.html );
		// Create Syntax Translator
		var oTranslator = javaLoader.create( this[ arguments.translator ] ).init();
		
		return oConverter.toWiki( oTranslator );
	}

	/**
	* Convert wiki text and return a structure with two keys: [wikiModel=The java wiki model object, html=the converted html string]
	*/
	function toHTML(required markup){
		var results = { wikiModel = 0, html = ""};
		// Create Wiki Model
		results.wikiModel = javaLoader
			.create( "com.codexwiki.bliki.model.WikiModel" )
			.init( wikiConfig, settings.imageBaseURL, settings.linkPattern, settings.linkBaseURL ); 
		// render data
		results.html = trim( results.wikiModel.render( arguments.markup ) );
		// return results
		return results;
	}

}