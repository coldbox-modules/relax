<template>
	<div class="modal fade" id="api-export-modal" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h4>ColdBox Relax Export Console</h4>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				</div>

				<div class="modal-body">
					<p>
						Below you can see the JSON representation of your API.  Relax uses the <a href="https://openapis.org/">Swagger/OpenAPI Specification</a>, so this representation is compatible with any third party tools which accept that specification.
					</p>
					<textarea name="exportJSON" id="exportJSON" class="form-control" rows="20" v-model="formattedExport"></textarea>
					<hr/>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<a href="#" @click="downloadJSON" class="btn btn-primary">Download</a>
				</div>
			</div>
		</div>
	</div>
</template>
<script>
import { formatJSONRaw } from "@/util/udf";
import { mapState } from "vuex";
export default{
	mixins : [
		require( "@/components/mixins/import-export" ).default
	],
	computed : {
		...mapState({
			activeAPI : state => state.activeAPI,
			APIDoc : state => state.APIDoc,
			formattedExport : state => formatJSONRaw( JSON.stringify( state.APIDoc ) )
		})
	},
	methods: {
		onInsertAPIDoc : ( e ) => {
			if( $( e.currentTarget ).val().length ){
				$( e.currentTarget ).val( formatJSONRaw( $( e.currentTarget ).val().trim() ) );
			}
		},
		downloadJSON(){
			window.location.assign( this.globalData.url.exportAPI + '/' + this.activeAPI + '?download=true' );
		}
	}
}
</script>