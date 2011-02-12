<cfoutput>
<h2>ColdBox Relax ForgeBox Updates!</h2>

<div>
<p>
	Below you can see the latest forgebox relax version and your current version.
	To download an update click on the download button.
</p>
<table class="tablelisting" width="100%">
<tr>
	<th width="200" class="textRight">Your Relax Version:</th>
	<td><strong>#getModuleSettings('relax').version#</strong></td>
</tr>
<tr>
	<th  class="textRight">ForgeBox Relax Version:</th>
	<td>#rc.entry.version#</td>
</tr>
<tr>
	<th  class="textRight">ForgeBox Relax Last Update:</th>
	<td>#dateformat(rc.entry.updatedate,"full")# #Timeformat(rc.entry.updatedate,"full")#</td>
</tr>
</table>

<h3>Changelog</h3>
<p>
	#rc.entry.changelog#
</p>

<br/>

<div class="textCenter">
	<a href="#rc.entry.entryLink#" class="button" title="Visit ForgeBox Entry" target="_blank">
		<span>
			<img src="#rc.root#/includes/images/coldbox_icon.png" border="0" align="absmiddle" alt="entry" />
			 Visit ForgeBox
		</span>
	</a>
	
	<a href="#rc.entry.downloadURL#" class="button" title="Download Relax Version #rc.entry.version#" target="_blank">
		<span>
			<img src="#rc.root#/includes/images/download.png" border="0" align="absmiddle" alt="entry" />
			Download v.#rc.entry.version#
		</span>
	</a>
</div>
</div>

<hr/>

<!--- Button Bar --->
<div id="bottomCenteredBar" class="textRight">
	<button class="buttonred" onclick="closeRemoteModal()"> Close </button>
</div>

</cfoutput>