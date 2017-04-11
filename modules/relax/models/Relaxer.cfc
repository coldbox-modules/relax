/**
* Copyright Ortus Solutions, Corp, All rights reserved
* www.ortussolutions.com
* ---
* The Relaxer service
*/
component 
	accessors="true"
	singleton 
{

	// DI
	property 
		name="log" 		
		inject="logbox:logger:{this}";

	property 
		name="DSLService"	
		inject="APIService@relax";

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
	* Send a Relaxer Request according to data
	* @method 			HTTP Method
	* @resource 		HTTP Resource to hit
	* @headers 			HTTP headers (struct)
	* @params 			HTTP FORM Data (struct)
	* @authUsername 	HTTP Basic Auth Username
	* @authPassword 	HTTP Basic Auth password
	* @httpProxy 		HTTP Proxy server host
	* @httpProxyPort 	HTTP Proxy server host port
	* @timeout 			HTTP Timeout defaults to 20
	*/
	function send(
		string method = "GET",
		required string resource,
		struct headers = {},
		struct params = {},
		string authUsername,
		string authPassword,
		string HTTPProxy,
		numeric HTTPProxyPort=80,
		numeric timeout=20
	){
		// Log what we are sending out
		if( variables.log.canDebug() ){
			variables.log.debug( 
				"Relaxed URL Request to #arguments.method#:#arguments.resource#",
				"RequestData: #serializeJSON( arguments )#" 
			);
		}

		// optional attributes
		var attribs = {};
		if( structKeyExists( arguments, "authUsername" ) ){ attribs.username = arguments.authUsername; }
		if( structKeyExists( arguments, "authPassword" ) ){ attribs.password = arguments.authPassword; }
		if( structKeyExists( arguments, "HTTPProxy" ) ){ attribs.proxyServer = arguments.HTTPProxy; }
		attribs.proxyPort 	= arguments.HTTPProxyPort;

		// Record History
		pushHistory( arguments );

		// Prepare HTTP Request
		var HTTPService = new http(
			method				= arguments.method,
			url					= arguments.resource,
			timeout				= arguments.timeout,
			resolveURL			= "true",
			userAgent			= "ColdBox Relaxer",
			charset				= "UTF-8",
			attributecollection	= "#attribs#"
		);

		// Add Headers
		for( var thisHeader in arguments.headers ){
			HTTPService.addParam( type="header", name=thisHeader, value=arguments.headers[ thisHeader ] );
		} 

		// Add Form Parameters
		for( var thisParam in arguments.params ){
			HTTPService.addParam( type="formfield", name=thisParam, value=arguments.params[ thisParam ] );
		} 

		return HTTPService.send().getPrefix();
	}

}