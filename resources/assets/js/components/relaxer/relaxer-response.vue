<template>
	<div class="container-fluid">
		<div class="box box-default">
			<div class="box-body">
				<div class="card card-secondary card-outline card-tabs">
					<div id="api-content-tabs" class="card-body row">
						<b-tabs :fill="true" class="container-fluid" nav-wrapper-class="text-secondary">
							<b-tab title="Response Result" title-link-class="text-secondary box-title" active>
								<div class="box box-solid-default">
									<prism :language="langRef" :code="formatAPIExample( response.responseText, mimetype )"></prism>
								</div>
							</b-tab>
							<b-tab title="Response Headers" title-link-class="text-secondary box-title" id="paths">
								<table class="table table-hover table-striped table-condensed" width="100%">
									<tr>
										<th width="200" class="text-right">Response Status</th>
										<td>
											Status Code: <code>{{response.status}}</code><br>
											<span v-if="response.statusText.length">
												Status Text: <code>{{ response.statusText }}</code>
											</span>
										</td>
									</tr>
									<tr
										v-for="( header, headerKey ) in allResponseHeaders"
										:key="`response_header_${headerKey}`"
									>
										<th class="text-right">{{headerKey}}</th>
										<td>
											{{getResponseHeader( headerKey )}}
										</td>
									</tr>
								</table>
							</b-tab>
							<b-tab title="Raw Response" title-link-class="text-secondary box-title" id="httpcodes">
								<div class="container-fluid">
									<textarea id="resultsRAW" class="textfield form-control" rows="30" style="width:100%" v-model="response.responseText"></textarea>
								</div>
							</b-tab>
						</b-tabs>
					</div>
				</div>
			</div>
		</div>
	</div>
</template>
<script>
import { uniqueId } from "lodash";
import { formatAPIExample, getLangFromMimetype, getResponseHeader, getAllResponseHeaders } from "@/util/udf";
import Prism from 'vue-prismjs';
export default{
	components : {
		Prism
	},
	props : {
		response : {
			type : Object,
			required : true
		}
	},
	data(){
		return {
			headersUID : uniqueId( "relaxResponseHeaders" ),
			rawUID : uniqueId( "relaxResponseRaw" ),
			prettyUID : uniqueId( "relaxResponsePretty" )
		}
	},
	computed : {
		contentType(){ return getResponseHeader( this.response, "Content-Type" ) },
		mimetype(){ return this.contentType ? getResponseHeader( this.response, "Content-Type" ).split( ";" )[ 0 ] : 'text/html' },
		langRef(){ return getLangFromMimetype( this.mimetype ) },
		allResponseHeaders(){ return getAllResponseHeaders( this.response ) }
	},
	methods : {
		formatAPIExample : formatAPIExample,
		getResponseHeader( headerName ){ return getResponseHeader( this.response, headerName ) }
	}
}
</script>