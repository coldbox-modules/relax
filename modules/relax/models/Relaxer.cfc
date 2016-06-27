/**
* Copyright Ortus Solutions, Corp, All rights reserved
* www.ortussolutions.com
* ---
* The Relaxer service
*/
component singleton accessors="true"{

	// DI
	property name="log" 		inject="logbox:logger:{this}";
	property name="DSLService"	inject="APIService@relax";

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
		return DSLService.getSettings().maxHistory;
	}

	/**
	* Clear the history stack
	* 
	* @return Relaxer
	*/
	function clearHistory(){
		if( DSLService.getSessionsEnabled() ){
			structDelete( session, "relax-history" );	
		}

		return this;
	}

	/**
	* Get the relaxer history array
	*/
	array function getHistory(){
		if( !DSLService.getSessionsEnabled() ) return [];

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
		if( DSLService.getSessionsEnabled() ){
			if( !structKeyExists( session, "relax-history" ) ){
				session[ "relax-history" ] = [];
			}
			stack = session[ "relax-history" ];
		} else {
			stack = [];
		}

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
		if( DSLService.getSessionsEnabled() ) session[ "relax-history" ] = stack;

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
		requestData
	){
		var results 	= structnew();
		var response 	= "";
		var i			= 1;
		var tmpValue	= "";
		var attribs		= structnew();
		var httpRequest	= {
			httpMethod 		= arguments.requestData.method,
			httpResource 	= arguments.requestData.url,
			httpHeaders 	= arguments.requestData.headers,
			httpParams 		= arguments.requestData.data
		};

		if( structKeyExists( arguments.requestData, "httpProxy" ) ){
			httpRequest[ 'httpProxy' ] = arguments.requestData.httpProxy;
			httpRequest[ 'httpProxyPort' ] = arguments.requestData.httpProxyPort;
		}

		if( structKeyExists( arguments.requestData, "authUsername" ) ){
			httpRequest[ "username" ] = arguments.requestData.username;
			httpPrequest[ "password" ] = arguments.requestData.password;
		}

		// Log what we are sending out
		if( variables.log.canDebug() ){
			variables.log.debug( "Relaxed URL Request to #httpRequest.httpMethod#:#httpRequest.httpResource#",
						   	     "RequestData: #serializeJSON( httpRequest )#" );
		}

		// optional attribs
		if( structKeyExists( httpRequest, "username" ) ){ attribs.username = httpRequest.username; }
		if( structKeyExists( httpRequest, "password" ) ){ attribs.password = httpRequest.password; }
		if( structKeyExists( httpRequest, "httpProxy" ) ){ attribs.proxyServer = httpRequest.httpProxy; }
		if( structKeyExists( httpRequest, "httpProxyPort" ) ){ attribs.proxyPort = httpRequest.httpProxyPort; }

		// Record History
		pushHistory( httpRequest );

		var httpService = new http(
			method				= "#httpRequest.httpMethod#",
			url					= "#httpRequest.httpResource#",
			timeout				= "20",
			resolveURL			= "true",
			userAgent			= "ColdBox Relaxer",
			attributecollection	= "#attribs#",
			charset				= "UTF-8"
		);

		// Add Headers
		for( var headerName in httpRequest.httpHeaders ){
			httpService.addParam( type="header", name=headerName, value=httpRequest.httpHeaders[ headerName ] );
		} 

		// Add Parameters
		for( var paramName in httpRequest.httpParams ){
			httpService.addParam( type="header", name=paramName, value=httpRequest.httpParams[ paramName ] );
		} 

		return httpService.send().getPrefix();

	}

}