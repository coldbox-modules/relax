<cfsetting showdebugoutput="false">
<cfset event.showDebugPanel(false)>
<!--- Content Disposition --->
<cfheader name="Content-Disposition" value="inline; filename=ColdBoxRelaxDocument.pdf">
<!--- CFFDocument --->
<cfdocument pagetype="letter" format="pdf">
	
	<!--- Header --->
	<cfdocumentitem type="header">
	<cfoutput>
	<div style="font-size: 9px; text-align: left;">
	ColdBoxRelax Docs - #dateformat(now(),"MMM DD, YYYY")# at #timeFormat(now(),"full")#
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
#renderLayout("html")#
</cfoutput>
</cfdocument>
