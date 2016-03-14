<cfsetting showdebugoutput="false">
<!--- CFFDocument --->
<cfdocument pagetype="letter" format="pdf">

	<!--- Header --->
	<cfdocumentitem type="header">
	<cfoutput>
	<div style="font-size: 9px; text-align: right;">
	#prc.dsl.info.title#
	</div>
	</cfoutput>
	</cfdocumentitem>

	<!--- Footer --->
	<cfdocumentitem type="footer">
	<cfoutput>
	<div style="font-size: 9px; text-align: right;">
	Page #cfdocument.currentpagenumber# of #cfdocument.totalpagecount#
	</div>
	</cfoutput>
	</cfdocumentitem>

	<cfoutput>
	#event.getValue( "pagecontent" )#
	</cfoutput>
</cfdocument>
