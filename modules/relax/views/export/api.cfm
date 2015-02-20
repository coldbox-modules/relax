<cfoutput>
<div class="modal-content">

	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		<h4>ColdBox Relax Export Console!</h4>
	</div>

	<div class="modal-body">
		<p>
			Below you can see the JSON representation of your ColdBox Relax Service DSL.  You can use it for safe keeping, versioning,
			or giving it to your friends! You can also click on the download button below. You can also format your JSON by going
			to <a href="http://jsonlint.com/" target="_blank">http://jsonlint.com/</a>
		</p>	
		<textarea name="exportJSON" id="exportJSON" class="form-control" rows="20">#prc.jsonAPI#</textarea>
		<hr/>

	</div>
	
	<div class="modal-footer">
		<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		<a href="#event.buildLink(prc.xehExportAPI)#/download/true" target="_blank" class="btn btn-primary">Download</a>
	</div>
</div>
<script language="javascript">
$(document).ready(function() {
	formatJSON('exportJSON');
});
</script>
</cfoutput>