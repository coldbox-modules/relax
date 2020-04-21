<template>
<div class="box box-default relaxer-history-box" :data-index="itemIndex">

	<div class="box-header">

		<h3 class="box-title" style="text-transform: lowercase">
			<a role="button" data-toggle="collapse" :href="`#history_box_${itemIndex}`" aria-expanded="false" :aria-controls="`history_box_${itemIndex}`">
				<small><i class="fa fa-chevron-down"></i></small>
			</a>

			<code>{{ historyItem.request.resource }}</code>

			<!--- Replay Command --->
			<a href="javascript:void(0)" class="btnReplayHistoryIndex pull-right" data-toggle="tooltip" title="Replay this request">
				<i class="fa fa-retweet"></i>
			</a>

		</h3>

	</div>

	<div :id="`history_box_${itemIndex}`" class="collapse box-body">
		<h4>Request</h4>
		<dl>
			<dt>Entry Point URL</dt>
			<dd>{{ historyItem.request.resource }}</dd>

			<dt>HTTP Method</dt>
			<dd>{{ historyItem.request.method }}</dd>

			<dt v-if="!isEmpty( historyItem.request.data )">Request Parameters</dt>
			<dd v-if="!isEmpty( historyItem.request.data )">
				<ul class="list">
						<li
							v-for="( param, paramKey ) in historyItem.request.data"
							:key="`request_data_${itemIndex}_${paramKey}`"
						>
							<code>{{ key }}</code> : <code>{{ param }}</code>
						</li>
				</ul>

			</dd>

			<dt v-if="!isEmpty( historyItem.request.headers )">Request Headers</dt>
			<dd v-if="!isEmpty( historyItem.request.headers )">
				<ul class="list">
						<li
							v-for="( param, paramKey ) in historyItem.request.headers"
							:key="`request_headers_${itemIndex}_${paramKey}`"
						>
							<code>{{ paramKey }}</code> : <code>{{ param }}</code>
						</li>
				</ul>

			</dd>

		</dl>

		<h4>Response</h4>

		<response-template :response="responseObject"></response-template>

	</div>

</div>
</template>
<script>
	import ResponseTemplate from "@/components/relaxer/relaxer-response";
	import { isEmpty } from "lodash";
	export default{
		components: {
			ResponseTemplate
		},
		props : {
			historyItem : {
				type: Object,
				required: true
			},
			itemIndex : {
				type: Number,
				required: true
			}
		},
		computed : {
			responseObject(){
				var responseEcho = JSON.parse( this.historyItem.response.responseText );
				var responseObject = {
					"status": responseEcho.status_code,
					"statusText": responseEcho.status_text,
					"responseText": responseEcho.filecontent,
					getAllResponseHeaders: function(){
						return responseEcho.responseheader;
					},
					getResponseHeader: function( headerName ){
						return responseEcho.responseheader[ headerName ];
					}
				}
			}
		},
		methods : {
			isEmpty : isEmpty
		}
	}
</script>