<cfoutput>
<!--- OverView Panel --->
<div>
	#renderView( view="home/docs/serviceOverview", module="relax" )#
</div>
<!--- Resources Panel --->
<div>
	#renderView( view="home/docs/resourceDefinitions", module="relax" )#						
</div>
<!--- HTTP Codes Panel --->
<div>
	#renderView( view="home/docs/httpcodes", module="relax" )#
</div>
</cfoutput>