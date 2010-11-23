<cfcomponent output="false">

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
		<cfargument name="httpMethod" 		type="string" required="false" default="GET" hint="HTTP Method"/>
		<cfargument name="httpResource" 	type="string" required="false" default="" hint="HTTP Resource to hit"/>
		<cfargument name="httpFormat" 		type="string" required="false" default="" hint="HTTP Format extension if used."/>
		<cfargument name="headerNames" 		type="string" required="false" default="" hint="HTTP header names (list)"/>
		<cfargument name="headerValues" 	type="string" required="false" default="" hint="HTTP header values (list)"/>
		<cfargument name="parameterNames" 	type="string" required="false" default="" hint="HTTP parameters names (list)"/>
		<cfargument name="parameterValues" 	type="string" required="false" default="" hint="HTTP parameters values (list)"/>
		
		<cfscript>
			var results 	= "";
			var response 	= "";
			var i			= 1;
			
			// infalte headers
			arguments.headerNames  = listToArray(arguments.headerNames);
			arguments.headerValues = listToArray(arguments.headerValues);
			
			// inflate parameters
			arguments.parameterNames  = listToArray(arguments.parameterNames);
			arguments.parameterValues = listToArray(arguments.parameterValues);
			
		</cfscript>
		
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