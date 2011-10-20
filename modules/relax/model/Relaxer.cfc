<!-----------------------------------------------------------------------
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldbox.org | www.luismajano.com | www.ortussolutions.com
********************************************************************************

Author     :	Luis Majano
Description :
	The Relaxer service
----------------------------------------------------------------------->
<cfcomponent output="false" hint="The Relaxer service">

	<!--- Dependencies --->
	<cfproperty name="sessionStorage" 	inject="coldbox:plugin:SessionStorage">
	<cfproperty name="configBean" 		inject="coldbox:configBean">
		
	<!--- Constructor --->
	<cffunction name="init" hint="Constructor" access="public" returntype="Relaxer" output="false">
		<cfargument name="logBox" 	  inject="logBox"/>
		<cfscript>
			// Logger
			instance.log = arguments.logBox.getLogger(this);
						
			return this;
		</cfscript>
	</cffunction>
	
	<!--- getMaxHistory --->
    <cffunction name="getMaxHistory" output="false" access="public" returntype="any" hint="Get the maximum history stack">
    	<cfreturn configBean.getKey("modules").relax.settings.maxHistory>
    </cffunction>
	
	<!--- clearHistory --->
    <cffunction name="clearHistory" output="false" access="public" returntype="void" hint="Clear relaxer history">
    	<cfset sessionStorage.deleteVar("relaxHistory")>
    </cffunction>
	
	<!--- getHistory --->
    <cffunction name="getHistory" output="false" access="public" returntype="any" hint="Get the relaxer history array">
    	<cfreturn sessionStorage.getVar("relaxHistory",[])>
    </cffunction>
	
	<!--- pushHistory --->
    <cffunction name="pushHistory" output="false" access="public" returntype="any" hint="Push a restful history item">
    	<cfargument name="values" required="true" hint="The structure values for the push"/>
		<cfscript>
			var stack = "";
			var history = {};
			
			// check if history exists?
			if( NOT sessionStorage.exists('relaxHistory') ){
				sessionStorage.setVar("relaxHistory",[]);
			}
			stack = sessionStorage.getVar("relaxHistory");
			// Check limit on it
			if( (arrayLen(stack) + 1) GT getMaxHistory() ){
				// pop one
				arrayDeleteAt(stack, arrayLen(stack) );
			}
			// Push new history
			history.requestDate = now();
			history.data = arguments.values;
			// append it
			arrayPrepend(stack, history);
			// save it
			sessionStorage.setVar("relaxHistory",stack);
		</cfscript>
    </cffunction>
	
	<!--- Send Request --->
	<cffunction name="send" output="false" access="public" returntype="any" hint="Send a Relaxer Request">
		<cfargument name="httpMethod" 		required="false" default="GET" hint="HTTP Method"/>
		<cfargument name="httpResource" 	required="false" default="" hint="HTTP Resource to hit"/>
		<cfargument name="httpFormat" 		required="false" default="" hint="HTTP Format extension if used."/>
		<cfargument name="headerNames" 		required="false" default="" hint="HTTP header names (list)"/>
		<cfargument name="headerValues" 	required="false" default="" hint="HTTP header values (list)"/>
		<cfargument name="parameterNames" 	required="false" default="" hint="HTTP parameters names (list)"/>
		<cfargument name="parameterValues" 	required="false" default="" hint="HTTP parameters values (list)"/>
		<cfargument name="username" 		required="false" default="" hint="HTTP Basic Auth Username"/>
		<cfargument name="password" 		required="false" default="" hint="HTTP Basic Auth password"/>
		<cfargument name="httpProxy" 		required="false" default="" hint="HTTP Proxy server host"/>
		<cfargument name="httpProxyPort" 	required="false" default="" hint="HTTP Proxy server host port"/>
		<cfscript>
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
			pushHistory(history);
			
			// Format Extension detected? If so, add it to resource.
			if( len(arguments.httpFormat) ){
				arguments.httpResource = arguments.httpResource & "." & arguments.httpFormat;
			}
			
			// Log what we are sending out
			if( instance.log.canDebug() ){
				instance.log.debug("Relaxed URL Request to #arguments.httpMethod#:#arguments.httpResource#:#arguments.httpFormat#",
							   	   "Headers: #arguments.headerNames#->#arguments.headerValues#; Parameters: #arguments.parameterNames#->#arguments.parameterValues#");
			}
			
			// inflate headers
			arguments.headerNames  = listToArray(arguments.headerNames);
			arguments.headerValues = listToArray(arguments.headerValues);
			
			// inflate parameters
			arguments.parameterNames  = listToArray(arguments.parameterNames);
			arguments.parameterValues = listToArray(arguments.parameterValues);
			
			// optional attribs
			if( len(arguments.username) ){ attribs.username = arguments.username; }
			if( len(arguments.password) ){ attribs.password = arguments.password; }
			if( len(arguments.httpProxy) ){ attribs.proxyServer = arguments.httpProxy; }
			if( len(arguments.httpProxyPort) ){ attribs.proxyPort = arguments.httpProxyPort; }
			
		</cfscript>
		
		<!--- Make cfhttp call --->
		<cfhttp method="#arguments.httpMethod#" 
				url="#arguments.httpResource#" 
				result="results"  
				timeout="20" 
				resolveURL="true"
				userAgent="ColdBox Relax"
				attributecollection="#attribs#">
			
			<!--- Headers --->
			<cfloop from="1" to="#arrayLen(arguments.headerNames)#" index="i">
				<cfset tmpValue = "">
				<cfif arrayIsDefined(arguments.headerValues,i)>
					<cfset tmpValue = arguments.headerValues[i]>
				</cfif>
				<cfhttpparam type="header" name="#arguments.headerNames[i]#" value="#tmpValue#">							 
			</cfloop>
			
			<!--- Parameters --->
			<cfloop from="1" to="#arrayLen(arguments.parameterNames)#" index="i">
				<cfset tmpValue = "">
				<cfif arrayIsDefined(arguments.parameterValues,i)>
					<cfset tmpValue = arguments.parameterValues[i]>
				</cfif>
				<cfhttpparam type="url" name="#arguments.parameterNames[i]#" value="#tmpValue#">
			</cfloop>		
			
		</cfhttp> 
				
	 	<cfreturn results>
	</cffunction>

</cfcomponent>