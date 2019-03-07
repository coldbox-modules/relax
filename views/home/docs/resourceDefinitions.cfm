<cfoutput>
<h1>Resource Definitions</h1>
<p>The following are all the resources defined in the <code>#prc.dsl.info.title#</code> API</p>
<!--- Render Document Collection --->
#renderView( view="home/docs/resourcePath", collection=prc.dsl.paths, collectionAs="thisResource", module="relax" )#
</cfoutput>