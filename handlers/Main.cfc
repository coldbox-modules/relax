<cfcomponent output="false"><!------------------------------------------- GLOBAL IMPLICIT EVENTS ONLY ------------------------------------------>
<!--- In order for these events to fire, you must declare them in the coldbox.xml.cfm --->		<cffunction name="index" returntype="void" output="false">		<cfargument name="event" required="true">		<cfset event.setView("home")>	</cffunction>		<!--- onRequestStart --->
    <cffunction name="onRequestStart" access="public" returntype="void" output="false" hint="">
    	<cfargument name="Event" type="any" required="yes">
    	<cfset var rc = event.getCollection()>
    	<cfscript>    		// Sample data
    		log.debug("Request initiated to #event.getCurrentEvent()#", getHTTPRequestData());
    	</cfscript>
    </cffunction>
</cfcomponent>