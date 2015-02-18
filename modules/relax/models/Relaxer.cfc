/**
********************************************************************************
Copyright 2005-2007 by Luis Majano and Ortus Solutions, Corp
www.ortussolutions.com
********************************************************************************
* The Relaxer service
*/
component singleton accessors="true"{

	// DI
	property name="log" 		inject="logbox:logger:{this}";
	property name="settings"	inject="coldbox:setting:relax";

	/**
	* Constructor
	*/
	function init(){
		return this;
	}

	/**
	* Get the max history stack, this comes from the relax settings
	*/
	numeric function getMaxHistory(){
		return variables.settings.maxHistory;
	}

	/**
	* Clear the history stack
	* 
	* @return Relaxer
	*/
	function clearHistory(){
		structDelete( session, "relax-history" );
		return this;
	}

	/**
	* Get the relaxer history array
	*/
	array function getHistory(){
		return ( structKeyExists( session, "relax-history" ) ? session[ "relax-history" ] : [] );
	}

	/**
	* Clear the history stack
	* 
	* @return Relaxer
	*/
	function pushHistory( required values ){
		var stack = "";
		var history = {};

		// check if history exists?
		if( NOT structKeyExists( session, "relax-history" ) ){
			session[ "relax-history" ] = [];
		}
		stack = session[ "relax-history" ];
		// Check limit on it
		if( ( arrayLen( stack ) + 1 ) GT getMaxHistory() ){
			// pop one
			arrayDeleteAt( stack, arrayLen( stack ) );
		}
		// Push new history
		history.requestDate = now();
		history.data 		= arguments.values;
		// append it
		arrayPrepend( stack, history );
		// save it
		session[ "relax-history" ] = stack;

		return this;
	}
	
	/**
	* Send a Relaxer Request
	* @httpMethod 		HTTP Method
	* @httpResource 	HTTP Resource to hit
	* @httpFormat 		HTTP Format extension if used.
	* @headerNames 		HTTP header names (list)
	* @headerValues 	HTTP header values (list)
	* @parameterNames 	HTTP parameters names (list)
	* @parameterValues	HTTP parameters values (list)
	* @username 		HTTP Basic Auth Username
	* @password 		HTTP Basic Auth password
	* @httpProxy 		HTTP Proxy server host
	* @httpProxyPort 	HTTP Proxy server host port
	*/
	function send(
		httpMethod = "GET",
		httpResource = "",
		httpFormat = "",
		headerNames = "",
		headerValues = "",
		parameterNames = "",
		parameterValues = "",
		username = "",
		password = "",
		httpProxy = "",
		httpProxyPort = ""
	){
		var results 	= structnew();
		var response 	= "";
		var i			= 1;
		var tmpValue	= "";
		var attribs		= structnew();
		var history		= {
			httpMethod 		= arguments.httpMethod,
			httpResource 	= arguments.httpResource,
			httpFormat 		= arguments.httpFormat,
			headerNames 	= arguments.headerNames,
			headerValues 	= arguments.headerValues,
			parameterNames 	= arguments.parameterNames,
			parameterValues = arguments.parameterValues,
			username		= arguments.username,
			password		= arguments.password,
			httpProxy		= arguments.httpProxy,
			httpProxyPort	= arguments.httpProxyPort
		};

		// Record History
		pushHistory( history );

		// Format Extension detected? If so, add it to resource.
		if( len( arguments.httpFormat ) ){
			arguments.httpResource = arguments.httpResource & "." & arguments.httpFormat;
		}

		// Log what we are sending out
		if( variables.log.canDebug() ){
			variables.log.debug( "Relaxed URL Request to #arguments.httpMethod#:#arguments.httpResource#:#arguments.httpFormat#",
						   	     "Headers: #arguments.headerNames#->#arguments.headerValues#; Parameters: #arguments.parameterNames#->#arguments.parameterValues#" );
		}

		// inflate headers
		arguments.headerNames  = listToArray( arguments.headerNames );
		arguments.headerValues = listToArray( arguments.headerValues );

		// inflate parameters
		arguments.parameterNames  = listToArray( arguments.parameterNames );
		arguments.parameterValues = listToArray( arguments.parameterValues );

		// optional attribs
		if( len( arguments.username ) ){ attribs.username = arguments.username; }
		if( len( arguments.password ) ){ attribs.password = arguments.password; }
		if( len( arguments.httpProxy ) ){ attribs.proxyServer = arguments.httpProxy; }
		if( len( arguments.httpProxyPort ) ){ attribs.proxyPort = arguments.httpProxyPort; }

		var httpService = new http(
			method				= "#arguments.httpMethod#",
			url					= "#arguments.httpResource#",
			timeout				= "20",
			resolveURL			= "true",
			userAgent			= "ColdBox Relaxer",
			attributecollection	= "#attribs#",
			charset				= "UTF-8"
		);

		// Add Headers
		for( var x=1; x lte arrayLen( arguments.headerNames ); x++ ){
			var thisValue = ( arrayIsDefined( arguments.headerValues, x ) ? arguments.headerValues[ x ] : "" );
			httpService.addParam( type="header", name=arguments.headerNames[ x ], value=thisValue );
		} 

		// Add Parameters
		for( var x=1; x lte arrayLen( arguments.parameterNames ); x++ ){
			var thisValue = ( arrayIsDefined( arguments.parameterValues, x ) ? arguments.parameterValues[ x ] : "" );
			httpService.addParam( type="url", name=arguments.parameterNames[ x ], value=thisValue );
		}

		return httpService.send().getPrefix();

	}

}