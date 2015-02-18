<cfoutput>
<h1>Resource Definitions</h1>
<p>The following are all the resources defined in the <code>#prc.dsl.relax.title#</code> API</p>
<!--- Render Document Collection --->
#renderView( view="home/docs/resourceDoc", collection=prc.dsl.resources, collectionAs="thisResource", module="relax" )#
</cfoutput>