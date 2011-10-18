<cfoutput>
<h2>ColdBox Relax Exported Console!</h2>

<!--- Export Console --->
<div>
	<p>
		Below you can see the JSON representation of your ColdBox Relax Service DSL.  You can use it for safe keeping, versioning,
		or giving it to your friends! You can also click on the download button below.
	</p>
	
	<textarea cols="100" rows="20">#prc.jsonAPI#</textarea>
</div>
<hr/>

<!--- Button Bar --->
<div id="bottomCenteredBar" class="textRight">
	<a href="#event.buildLink(prc.xehExportAPI)#/download/true" target="_blank"><button class="button2"> Download </button></a>
	<button class="buttonred" onclick="closeRemoteModal()"> Close </button>
</div>
</cfoutput>