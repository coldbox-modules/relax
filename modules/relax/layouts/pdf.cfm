<cfsetting showdebugoutput="false">
<!--- CFFDocument --->
<cfdocument pagetype="letter" format="pdf">

	<!--- Header --->
	<cfdocumentitem type="header">
	<cfoutput>
	<div style="font-size: 9px; text-align: right;">
	#prc.dsl.relax.title#
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
	#renderLayout( layout="relax", args={ sidebar=false, header=false, print=true } )#
	</cfoutput>
</cfdocument>
