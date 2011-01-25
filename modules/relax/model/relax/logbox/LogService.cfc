<!-----------------------------------------------------------------------
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldbox.org | www.luismajano.com | www.ortussolutions.com
********************************************************************************

Author     :	Luis Majano
Description :
	The logbox log viewer service
----------------------------------------------------------------------->
<cfcomponent output="false" singleton>

	<!--- Constructor --->
	<cffunction name="init" hint="Constructor" access="public" returntype="LogService" output="false">
		<cfargument name="configBean" inject="coldbox:configBean"/>
		<cfargument name="injector"	  inject="coldbox:plugin:BeanFactory"/>
		<cfargument name="logBox" 	  inject="logBox"/>
		<cfscript>
			// get module settings
			instance.logSettings = arguments.configBean.getKey("modules").relax.settings.relaxLogs;
			// retrieve DAO
			instance.dao = arguments.injector.getModel("relax.logbox.#ucase(instance.logSettings.adapter)#_DAO");
			// Logger
			instance.log = arguments.logBox.getLogger(this);
			
			return this;
		</cfscript>
	</cffunction>
	
	<!--- getTotalLogs --->
    <cffunction name="getTotalLogs" output="false" access="public" returntype="any" hint="Get the total number of log entries">
    	<cfscript>
    		return instance.dao.getTotalLogs();
    	</cfscript>
    </cffunction>
	
	<!--- getLogStats --->
    <cffunction name="getLogStats" output="false" access="public" returntype="any" hint="Get some log statistics">
    	<cfscript>
    		return instance.dao.getLogStats();
    	</cfscript>
    </cffunction>
	
	<!--- get logs --->
    <cffunction name="getLogs" output="false" access="public" returntype="any" hint="Get the log files">
    	<cfargument name="startRow" required="false" default="0" hint="The start row"/>
    	<cfargument name="maxRow" 	required="false" default="0" hint="The end row"/>
		<cfscript>
    		return instance.dao.getLogs(argumentCollection=arguments);
    	</cfscript>
    </cffunction>
	
	<!--- getLog --->
	<cffunction name="getLog" output="false" access="public" returntype="any" hint="Get a log entry">
	 	<cfargument name="logid">
   		<cfscript>
    		return instance.dao.getLog(argumentCollection=arguments);
    	</cfscript>
	</cffunction>
	
	<!--- purgeLogs --->
    <cffunction name="purgeLogs" output="false" access="public" returntype="void" hint="Purge the log files">
   		<cfscript>
    		instance.dao.purgeLogs();
    	</cfscript>
	</cffunction>	

</cfcomponent>