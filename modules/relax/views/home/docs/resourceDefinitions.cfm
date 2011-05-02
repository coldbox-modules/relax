<cfoutput>
<h1>Resource Definitions</h1>
<p>The following are all the resources defined in the #rc.dsl.relax.title# API</p>
<!--- Render Document Collection --->
#renderView(view="home/docs/resourceDoc",collection=rc.dsl.resources,collectionAs="thisResource")#
</cfoutput>