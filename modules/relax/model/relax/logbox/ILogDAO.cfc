<cfinterface hint="Log service DAO interface">

	<!--- getTotalLogs --->
    <cffunction name="getTotalLogs" output="false" access="public" returntype="numeric" hint="Get the total number of log entries">
    </cffunction>
	
	<!--- get logs --->
    <cffunction name="getLogs" output="false" access="public" returntype="query" hint="Get the log files">
    	<cfargument name="startRow" type="numeric" required="false" default="0" hint="The start row"/>
    	<cfargument name="maxRow" 	type="numeric" required="false" default="0" hint="The end row"/>
	</cffunction>
	
	<!--- getLog --->
	<cffunction name="getLog" output="false" access="public" returntype="query" hint="Get a log entry">
	 	<cfargument name="logid" type="string">
   	</cffunction>
	
	<!--- purgeLogs --->
    <cffunction name="purgeLogs" output="false" access="public" returntype="void" hint="Purge the log files">
   	</cffunction>

</cfinterface>