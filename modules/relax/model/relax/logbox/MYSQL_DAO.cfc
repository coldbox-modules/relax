<!-----------------------------------------------------------------------
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldbox.org | www.luismajano.com | www.ortussolutions.com
********************************************************************************

Author     :	Luis Majano
Description :
	The DAO implementation for the logbox viewer for MySQL
----------------------------------------------------------------------->
<cfcomponent output="false" implements="ILogDAO" extends="AbstractDAO">

	<!--- Constructor --->
	<cffunction name="init" hint="Constructor" access="public" returntype="MYSQL_DAO" output="false">
		<cfargument name="configBean" inject="coldbox:configBean"/>
		<cfargument name="logBox" 	  inject="logBox"/>
		<cfscript>
			super.init(argumentCollection=arguments);
			return this;
		</cfscript>
	</cffunction>
	
	<!--- getTotalLogs --->
    <cffunction name="getTotalLogs" output="false" access="public" returntype="any" hint="Get the total number of log entries">
    	<cfset var q = "">
		
		<cfquery name="q" datasource="#getDatasource()#">
		SELECT count(id) as TotalCount
		  FROM #getTable()#
		</cfquery>
		
		<cfreturn q.TotalCount>
    </cffunction>
	
	<!--- get logs --->
    <cffunction name="getLogs" output="false" access="public" returntype="any" hint="Get the log files">
    	<cfargument name="startRow" required="false" default="0" hint="The start row"/>
    	<cfargument name="maxRow" 	required="false" default="0" hint="The end row"/>
		<cfset var q = "">
		
		<cfquery name="q" datasource="#getDatasource()#">
		SELECT *
		FROM #getTable()#
		ORDER BY logdate desc
		<cfif arguments.startRow AND arguments.maxRow>
		LIMIT #arguments.startRow-1#,#(arguments.startRow-1)+arguments.maxRow#
		</cfif>
		</cfquery>
		
		<cfreturn q>
    </cffunction>
	
	<!--- getLog --->
	<cffunction name="getLog" output="false" access="public" returntype="any" hint="Get a log entry">
	 	<cfargument name="logid">
   		<cfset var q = "">
		
		<cfquery name="q" datasource="#getDatasource()#">
		select * from #getTable()#
		where id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.logid#">
		</cfquery>
		
		<cfreturn q>
	</cffunction>
	
	<!--- purgeLogs --->
    <cffunction name="purgeLogs" output="false" access="public" returntype="void" hint="Purge the log files">
   		<cfset var q = "">
		
		<cfquery name="q" datasource="#getDatasource()#">
		truncate table #getTable()#
		</cfquery>
		
	</cffunction>
	
<!------------------------------------------- PRIVATE ------------------------------------------>


</cfcomponent>