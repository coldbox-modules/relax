<cfoutput>
#html.startForm(action=prc.xehImport)#	
<h2>ColdBox Relax Import Console!</h2>

<!--- Export Console --->
<div>
	<p>
		Choose the name of the API to import and paste the JSON implementation of the API
	</p>
	<label for="apiName" class="inline">API Name:</label>
	#html.textfield(name="apiName",size="45")# <br/>
	<label for="apiJSON">API JSON:</label>
	#html.textarea(name="apiJSON",cols="100",rows="20")#
</div>
<hr/>

<!--- Button Bar --->
<div id="bottomCenteredBar" class="textRight">
	<button class="button" onclick="formatJSON('apiJSON');return false"> Format JSON </button>
	<input type="submit" class="button2" value="Start Import" onClick="formatJSON('apiJSON')" />
	<button class="buttonred" onclick="closeRemoteModal();return false"> Close </button>
</div>
#html.endForm()#

<script language="javascript">

</script>
</cfoutput>