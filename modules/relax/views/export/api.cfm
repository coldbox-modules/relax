<cfoutput>
<div class="modal-content">

	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		<h4>ColdBox Relax Export Console!</h4>
	</div>

	<div class="modal-body">
		<p>
			Below you can see the JSON representation of your API.  Relax uses the <a href="https://openapis.org/">Swagger/OpenAPI Specification</a>, so this representation is compatible with any third party tools which accept that specification.
		</p>	
		<textarea name="exportJSON" id="exportJSON" class="form-control" rows="20">#prc.jsonAPI#</textarea>
		<hr/>

	</div>
	
	<div class="modal-footer">
		<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		<a href="##" onclick="downloadJSON()" class="btn btn-primary">Download</a>
	</div>
</div>
<script language="javascript">
function downloadJSON(){
	window.location.assign( '#event.buildLink(prc.xehExportAPI)#/download/true' );
}

$(document).ready(function() {
	formatJSON('exportJSON');
});
</script>
</cfoutput>