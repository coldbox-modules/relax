<cfoutput>
<div class="modal-content">

	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		<h4>ColdBox Relax Import Console!</h4>
	</div>

	<div class="modal-body">
		<p>
		Choose the name of the API to import and paste the JSON implementation of the API
		</p>
		<label for="apiName" class="inline">API Name:</label>
		#html.textfield( name="apiName", size="45", class="form-control" )# <br/>
		<label for="apiJSON">API JSON:</label>
		#html.textarea( name="apiJSON", rows="20", class="form-control" )#

	</div>
	
	<div class="modal-footer">
		<button class="btn btn-default" data-dismiss="modal">Close</button>
		<button class="btn btn-info" onclick="formatJSON( 'apiJSON' );return false"> Format JSON </button>
		<button type="submit" class="btn btn-primary" onClick="formatJSON('apiJSON')">Start Import</button>
	</div>
</div>
</cfoutput>