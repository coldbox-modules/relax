<cfoutput>
<h1>Resource Definitions</h1>
<p>The following are all the resources defined in the #rc.dsl.relax.title# API</p>
<cfloop array="#rc.dsl.resources#" index="rc.thisResource">
	<cfset structAppend(rc.eventArguments,rc.thisResource)>
	<!--- resource viewlet  --->
	#runEvent(event=rc.xehResourceDocEvent,eventArguments=rc.eventArguments)#					
</cfloop>
</cfoutput>