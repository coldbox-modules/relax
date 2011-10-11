<!-----------------------------------------------------------------------
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldbox.org | www.luismajano.com | www.ortussolutions.com
********************************************************************************

Author     :	Luis Majano
Description :
	The DAO interface for logbox integration
----------------------------------------------------------------------->
<cfinterface hint="Log service DAO interface">

	<!--- getTotalLogs --->
    <cffunction name="getTotalLogs" output="false" access="public" returntype="any" hint="Get the total number of log entries" colddoc:generic="numeric">
    	<cfargument name="search"   required="false" default=""  hint="A search criteria to filter on: message OR extrainfo fields">
    </cffunction>
	
	<!--- get logs --->
    <cffunction name="getLogs" output="false" access="public" returntype="any" hint="Get the log files found as a query">
    	<cfargument name="startRow" required="false" default="0" hint="The start row"/>
    	<cfargument name="maxRow" 	required="false" default="0" hint="The end row"/>
		<cfargument name="search"   required="false" default=""  hint="A search criteria to filter on: message OR extrainfo fields">
	</cffunction>
	
	<!--- getLog --->
	<cffunction name="getLog" output="false" access="public" returntype="any" hint="Get a log entry as a query">
	 	<cfargument name="logid">
   	</cffunction>
	
	<!--- purgeLogs --->
    <cffunction name="purgeLogs" output="false" access="public" returntype="void" hint="Purge the log files">
   	</cffunction>

</cfinterface>