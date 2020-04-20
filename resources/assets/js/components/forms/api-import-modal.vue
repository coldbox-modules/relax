<template>
	<div class="modal fade" id="api-import-modal" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h4>Relax Import Console</h4>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				</div>

				<div class="modal-body">
					<p>
						Type the name of the API to import and paste the JSON description, in OpenAPI format:
					</p>

					<fieldset>
						<label for="apiName" class="inline">API Name:</label>
						<input class="form-control" @change="onValidateAPIName" name="apiName"/>
					</fieldset>

					<fieldset>
						<label for="apiJSON">API JSON:</label>
						<textarea name="apiJSON" class="form-control" rows="20" @blur="onInsertAPIDoc"></textarea>
					</fieldset>

				</div>

				<div class="modal-footer">
					<button class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="submit" class="btn btn-primary btnProcessImport" @click="onConfirmImportAPI">Start Import</button>
				</div>
			</div>
		</div>
	</div>
</template>
<script>
import { formatJSONRaw } from "@/util/udf";
export default{
	mixins : [
		require( "@/components/mixins/import-export" ).default
	],
	methods: {
		onInsertAPIDoc : ( e ) => {
			if( $( e.currentTarget ).val().length ){
				$( e.currentTarget ).val( formatJSONRaw( $( e.currentTarget ).val().trim() ) );
			}
		}
	}
}
</script>