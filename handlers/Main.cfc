<!-----------------------------------------------------------------------********************************************************************************Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corpwww.coldbox.org | www.luismajano.com | www.ortussolutions.com********************************************************************************Author     :	Luis MajanoDescription :	Main Handler-----------------------------------------------------------------------><cfcomponent output="false">		<!--- index --->	<cffunction name="index" returntype="void" output="false">		<cfargument name="event" required="true">		<cfset event.setView("home")>	</cffunction>		<!--- onRequestStart --->
    <cffunction name="onRequestStart" access="public" returntype="void" output="false" hint="">
    	<cfargument name="event" type="any" required="yes">
    	<cfset var rc = event.getCollection()>
    	<cfscript>    		// Sample logging so we can have data
    		if( log.canDebug() ){    			log.debug("Request initiated to #event.getCurrentEvent()#", getHTTPRequestData());    		}
    	</cfscript>
    </cffunction></cfcomponent>