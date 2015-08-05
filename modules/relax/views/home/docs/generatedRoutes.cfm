<cfoutput>
<h1>Generated ColdBox Routes</h1>
<p>The following are the generated ColdBox URL Mapping routes that you can use to 
	copy and paste into your application or a specific module.
</p>

<h2>Parent App Routes</h2>
<p>Use the following when creating the routes for a parent application</p>
<pre class="brush: coldfusion;">
// AutoReload the routing table on each request? Great for dev, but no so great for modules.
// setAutoReload( false );

// Sets automatic route extension detection and places the extension in the rc.format variable
setExtensionDetection( #prc.dsl.relax.extensionDetection# );
<cfif prc.dsl.relax.extensionDetection and len(prc.dsl.relax.validExtensions)>
// Setup the list of valid extensions for this application
setValidExtensions( "#prc.dsl.relax.validExtensions#" );
</cfif>
<cfif prc.dsl.relax.extensionDetection>
// Throw exception 406 when an invalid extension is detected?
setThrowOnInvalidExtension( #prc.dsl.relax.throwOnInvalidExtension# );
</cfif>						
// Route Definitions
<cfloop array="#prc.dsl.resources#" index="thisResource">addRoute( pattern="#thisResource.pattern#"<cfif len(thisResource.handler)>, handler="#thisResource.handler#"</cfif>#flattenActions(thisResource.action)#);#chr( 10 )#</cfloop>
</pre>

<h2>Module Routes</h2>
<p>Use the following when creating the routes for a module inside the <code>ModuleConfig.cfc</code></p>
<cfset index = 1>
<pre class="brush: coldfusion;">
// Module Route Definitions
routes = [<cfloop array="#prc.dsl.resources#" index="thisResource">
	{ pattern="#thisResource.pattern#"<cfif len(thisResource.handler)>, handler="#thisResource.handler#"</cfif>#flattenActions(thisResource.action)# }<cfif index++ lt arrayLen(prc.dsl.resources)>,</cfif>
</cfloop>
];
</pre>

<p>You can also use the following for a standalone <code>Routes.cfm</code> in your module <code>config</code> directory</p>
<h3>ModuleConfig.cfc</h3>
<pre class="brush: coldfusion;">
// Module Route Definitions
routes = [
	"config/routes.cfm"
];
</pre>

<h3>routes.cfm</h3>
<pre class="brush: coldfusion;">
// Route Definitions
<cfloop array="#prc.dsl.resources#" index="thisResource">addRoute( pattern="#thisResource.pattern#"<cfif len(thisResource.handler)>, handler="#thisResource.handler#"</cfif>#flattenActions(thisResource.action)#);#chr( 10 )#</cfloop>
</pre>

</cfoutput>