<cfoutput>
<h2>Log Entry Viewer</h2>

<table class="tablelisting" id="logsTable" width="100%" cellspacing="1" cellpadding="0" border="0">
	<tr>
		<th class="center" width="100">Severity</th>
		<th class="center" width="150">Date</th>
		<th >Category</th>
	</tr>
	<tr>
		<td class="center">
		<img src="#rc.root#/includes/images/#severityLookup(rc.qlog.severity)#" alt="#rc.qlog.severity#" /> #rc.qLog.severity#
		</td>
		<td  class="center">#dateformat(rc.qlog.logdate,"medium")# at #timeFormat(rc.qLog.logdate,"medium")#</td>
		<td>#rc.qlog.category#</td>
	</tr>
	<tr>
		<th colspan="3">Message:</th>
	</tr>
	<tr>
		<td colspan="3">#rc.qlog.message#</td>
	</tr>
	<tr>
		<th colspan="3">Extra Info:</th>
	</tr>
	<tr>
		<td colspan="3">
			<cfif NOT len(rc.qLog.extraInfo)>
				<em>Null</em>
			<cfelse>
				<cfif isJSON(rc.qLog.extraInfo)>
				<cfdump var="#deserializeJSON(rc.qLog.extraInfo)#">
				<cfelse>
				#rc.qLog.extraInfo#
				</cfif>
			</cfif>
		</td>
	</tr>
</table>

<cfif not rc.print>

<hr/>

<!--- Button Bar --->
<div id="bottomCenteredBar" class="textRight">
	<a href="#event.buildLink(rc.xehQuickView)#?logID=#rc.logID#&print=true" target="_blank"><button class="button2"> Print Format </button></a>
	<button class="buttonred" onclick="closeRemoteModal()"> Close </button>
</div>
</cfif>

</cfoutput>