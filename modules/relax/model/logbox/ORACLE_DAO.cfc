<!-----------------------------------------------------------------------
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldbox.org | www.luismajano.com | www.ortussolutions.com
********************************************************************************

Author     :	Luis Majano
Description :
	The DAO implementation for the logbox viewer for Oracle
----------------------------------------------------------------------->
<cfcomponent output="false" implements="ILogDAO" extends="AbstractDAO">

	<!--- Constructor --->
	<cffunction name="init" hint="Constructor" access="public" returntype="ORACLE_DAO" output="false">
		<cfargument name="configBean" inject="coldbox:configBean"/>
		<cfargument name="logBox" 	  inject="logBox"/>
		<cfscript>
			super.init(argumentCollection=arguments);
			return this;
		</cfscript>
	</cffunction>
	
	<!--- getLogStats --->
    <cffunction name="getLogStats" output="false" access="public" returntype="any" hint="Get some log statistics">
    	<cfset var q = "">
		
		<cfquery name="q" datasource="#getDatasource()#">
		SELECT 
			SUM(CASE lower(severity) WHEN 'fatal' THEN 1 ELSE 0 END) fatalCount,
			SUM(CASE lower(severity) WHEN 'error' THEN 1 ELSE 0 END) errorCount,
			SUM(CASE lower(severity) WHEN 'warn' THEN 1 ELSE 0 END) warnCount,
			SUM(CASE lower(severity) WHEN 'info' THEN 1 ELSE 0 END) infoCount,
			SUM(CASE lower(severity) WHEN 'debug' THEN 1 ELSE 0 END) debugCount
		FROM #getTable()#
		</cfquery>
		
		<cfreturn q>
    </cffunction>
	
	<!--- getTotalLogs --->
    <cffunction name="getTotalLogs" output="false" access="public" returntype="any" hint="Get the total number of log entries">
    	<cfargument name="search"   required="false" default=""  hint="A search criteria to filter on: message OR extrainfo fields">
		<cfset var q = "">
		
		<cfquery name="q" datasource="#getDatasource()#">
		SELECT count(id) as TotalCount
		  FROM #getTable()#
		<cfif len(arguments.search)>
			WHERE message like <cfqueryparam cfsqltype="cf_sql_longvarchar" value="%#arguments.search#%"> OR
			      extrainfo like <cfqueryparam cfsqltype="cf_sql_longvarchar" value="%#arguments.search#%">
		</cfif>
		</cfquery>
		
		<cfreturn q.TotalCount>
    </cffunction>
	
	<!--- get logs --->
    <cffunction name="getLogs" output="false" access="public" returntype="any" hint="Get the log files">
    	<cfargument name="startRow" required="false" default="0" hint="The start row"/>
    	<cfargument name="maxRow" 	required="false" default="0" hint="The end row"/>
		<cfargument name="search"   required="false" default=""  hint="A search criteria to filter on: message OR extrainfo fields">
		<cfset var q = "">
		
		<cfquery name="q" datasource="#getDatasource()#">
		SELECT * FROM(
			  SELECT a.*, rownum rnum FROM(
				SELECT * FROM #getTable()#
				<cfif len(arguments.search)>
				WHERE message like <cfqueryparam cfsqltype="cf_sql_longvarchar" value="%#arguments.search#%"> OR
			      	extrainfo like <cfqueryparam cfsqltype="cf_sql_longvarchar" value="%#arguments.search#%">
				</cfif>
				ORDER BY logdate desc
			  ) a
			  WHERE rownum <= (#arguments.maxrow#)
		)
		WHERE rnum >= (#arguments.startrow#)
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