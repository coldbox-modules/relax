<template>
<div class="box box-default relaxer-history-box" :data-index="itemIndex">

	<div class="box-header">

		<h3 class="box-title" style="text-transform: lowercase">
			<a role="button" data-toggle="collapse" :href="`#history_box_${itemIndex}`" aria-expanded="false" :aria-controls="`history_box_${itemIndex}`">
				<small><i class="fa fa-chevron-down"></i></small>
			</a>

			<code>{{ historyItem.request.resource }}</code>

			<!--- Replay Command --->
			<a @click="onRemoveHistoryItem" class="btn btn-default text-muted pull-right" style="margin-left: 10px" v-b-tooltip.hover title="Remove this history item">
				<i class="fa fa-trash"></i>
			</a>
			<a @click="onReplayHistoryItem" class="btn btn-info pull-right" v-b-tooltip.hover title="Replay this request">
				<i v-if="isReplaying" class="fa fa-spin fa-spinner"></i>
				<i v-else class="fa fa-retweet"></i>
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
							v-for="( param, index ) in historyItem.request.data"
							:key="`request_data_${index}_${param.name}`"
						>
							<code>{{ param.name }}</code> : <code>{{ param.value }}</code>
						</li>
				</ul>

			</dd>

			<dt v-if="!isEmpty( historyItem.request.headers )">Request Headers</dt>
			<dd v-if="!isEmpty( historyItem.request.headers )">
				<ul class="list">
						<li
							v-for="(header, index ) in historyItem.request.headers"
							:key="`request_headers_${index}_${header.name}`"
						>
							<code>{{ header.name }}</code> : <code>{{ header.value }}</code>
						</li>
				</ul>

			</dd>

		</dl>

		<h4>Response</h4>

		<response-template :response="historyItem"></response-template>

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
		data(){
			return {
				isReplaying : false
			}
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
					"responseText": responseEcho.filecontent
				}
			}
		},
		methods : {
			isEmpty : isEmpty,
			onReplayHistoryItem(){
				var self = this;
				Vue.set( this, "isReplaying", true );
				this.$store.commit( "relaxer/updateState", { key : "currentRequest", value : this.historyItem.request } );
				this.$store.dispatch( "relaxer/sendRelaxerRequest" ).then( () => {
					Vue.set( self, "isReplaying", false );
					$( "#relaxer-last-response" )[0].scrollIntoView();
				} );
			},
			onRemoveHistoryItem(){
				this.$store.commit( "relaxer/removeHistoryItem", this.itemIndex );
			}
		}
	}
</script>