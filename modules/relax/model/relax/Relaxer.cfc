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

	<!--- Constructor --->
	<cffunction name="init" hint="Constructor" access="public" returntype="Relaxer" output="false">
		<cfargument name="logBox" 	  inject="logBox"/>
		<cfscript>
			// Logger
			instance.log = arguments.logBox.getLogger(this);
						
			return this;
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
		
		<cfscript>
			var results 	= structnew();
			var response 	= "";
			var i			= 1;
			
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
		</cfscript>
		
		<!--- Make cfhttp call --->
		<cfhttp method="#arguments.httpMethod#" 
				url="#arguments.httpResource#" 
				result="results"  
				timeout="20">
			
			<!--- Headers --->
			<cfloop from="1" to="#arrayLen(arguments.headerNames)#" index="i">
				<cfhttpparam type="header" name="#arguments.headerNames[i]#" value="#arguments.headerValues[i]#">
			</cfloop>
			
			<!--- Parameters --->
			<cfloop from="1" to="#arrayLen(arguments.parameterNames)#" index="i">
				<cfhttpparam type="url" name="#arguments.parameterNames[i]#" value="#arguments.parameterValues[i]#">
			</cfloop>		
			
		</cfhttp> 
				
	 	<cfreturn results>
	</cffunction>

</cfcomponent>