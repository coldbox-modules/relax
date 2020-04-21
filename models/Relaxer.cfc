/**
 * Copyright Ortus Solutions, Corp, All rights reserved
 * www.ortussolutions.com
 * ---
 * The Relaxer service
 */
component accessors="true" singleton {

	// DI
	property name="log" 		inject="logbox:logger:{this}";
	property name="DSLService" 	inject="APIService@relax";

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
	 * Send a Relaxer Request according to data
	 * @method 			HTTP Method
	 * @resource 		HTTP Resource to hit
	 * @headers 		HTTP headers (struct)
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
		array headers = [],
		array params  = [],
		string body    = "",
		string authUsername,
		string authPassword,
		string HTTPProxy,
		numeric HTTPProxyPort = 80,
		numeric timeout       = 20
	){
		// Log what we are sending out
		if ( variables.log.canDebug() ) {
			variables.log.debug(
				"Relaxed URL Request to #arguments.method#:#arguments.resource#",
				"RequestData: #serializeJSON( arguments )#"
			);
		}

		// optional attributes
		var attribs = {};
		if ( structKeyExists( arguments, "authUsername" ) ) {
			attribs.username = arguments.authUsername;
		}
		if ( structKeyExists( arguments, "authPassword" ) ) {
			attribs.password = arguments.authPassword;
		}
		if ( structKeyExists( arguments, "HTTPProxy" ) ) {
			attribs.proxyServer = arguments.HTTPProxy;
		}
		attribs.proxyPort = arguments.HTTPProxyPort;

		// Prepare HTTP Request
		var HTTPService = new http(
			method              = arguments.method,
			url                 = arguments.resource,
			timeout             = arguments.timeout,
			resolveURL          = "true",
			userAgent           = "ColdBox Relaxer",
			charset             = "UTF-8",
			attributecollection = "#attribs#"
		);

		// Add Headers
		for ( var header in arguments.headers ) {
			if( header.keyExists( "name" ) && len( header.name ) ){
				HTTPService.addParam( type = "header", name = header.name, value = header.value );
			}
		}

		// Add Form Parameters
		for ( var param in arguments.params ) {
			if( param.keyExists( "name" ) && len( param.name ) ){
				var paramType = arguments.method == "GET" ? "URL" : "formField";
				HTTPService.addParam( type = paramType, name = param.name, value = param.value );
			}
		}

		if ( len( arguments.body ) ) {
			HTTPService.addParam( type = "body", value = arguments.body );
		}

		return HTTPService.send().getPrefix();
	}

}
