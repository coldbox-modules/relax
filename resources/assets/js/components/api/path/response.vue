<template>
	<div :id="resourceId + '-' + responseKey" class="method-card card card-gray">

		<div class="card-header d-flex p-0">
			<h3 class="card-title p-3 pathHeader">
				{{responseKey.toTitleCase()}}
			</h3>
			<ul class="nav nav-pills ml-auto p-2">
				<li class="nav-item">
					<a class="nav-link btToggleMethod" role="button" data-toggle="collapse" :href="`#card_${resourceId}-${responseKey}`" aria-expanded="false" :aria-controls="`card_${resourceId}-${responseKey}`">
						<i class="fa fa-chevron-down"></i>
					</a>
				</li>
			</ul>
		</div>

		<div :id="`card_${resourceId}-${responseKey}`" class="collapse card-body">
			<div class="col-xs-12" v-if="markedResponse.description">
				<h4 class="card-subtitle text-secondary">Description:</h4>
				<p v-html="markedResponse.description.HTMLBreakLines()"></p>
			</div>

			<!-- Swagger 2.x specification -->
			<div class="col-xs-12 schema-container" v-if="markedResponse.schema || markedResponse.examples">
				<h4 class="card-subtitle text-secondary">Schema and Examples:</h4>

				<div class="schema-tabs">
					<ul class="nav nav-tabs" role="tablist">
						<li v-if="markedResponse.schema" role="presentation" class="active">
							<a :href="`#${markedResponse.schema.tabId}`" data-toggle="tab" :aria-controls="markedResponse.schema.tabId">Schema Definition</a>
						</li>
						<li
							v-for="( example, mimetype, exampleIndex ) in ( markedResponse.examples || {} )"
							:key="`response_example_link_${exampleIndex}`"
							role="presentation" :class="{ 'active' : !markedResponse.schema && exampleIndex === 0}"
						>
							<a :href="`#${example.tabId}`" data-toggle="tab" :aria-controls="example.tabId">{{mimetype}}</a>
						</li>
					</ul>

					<div class="tab-content">
							<div v-if="markedResponse.schema" :id="`${markedResponse.schema.tabId}`" class="schema-definition">
								<schema-template :schema="response.schema"></schema-template>
							</div>
							<div
								v-for="( example, mimetype, exampleIndex ) in ( markedResponse.examples || {} )"
								:key="`response_example_link_${exampleIndex}`"
								:id="example.tabId"
								class="schema-example"
							>
								<div class="card card-solid-default">
									<prism :language="mimeLang( mimetype )" :code="formatAPIExample( example, mimetype )"></prism>
								</div>
							</div>
					</div><!-- /.tab-content -->
				</div><!-- /.schema-tabs -->
			</div><!-- /.schema-container -->

			<!-- Swagger 3.x specification -->
			<div class="col-xs-12 schema-container" v-if="markedResponse.content && Object.keys( markedResponse.content ).length">
				<h4 class="card-subtitle text-secondary">Content Types:</h4>
				<div class="box">
					<b-tabs :fill="true" class="container-fluid" nav-wrapper-class="text-secondary">
						<b-tab
							v-for="( content, mimetype ) in markedResponse.content"
							:key="resourceId + '-' + responseKey + '-content-' + mimetype"
							:title="mimetype"
							title-link-class="text-secondary box-title"
						>
							<div class="schema-definition">
								<schema-template :lang="mimeLang( mimetype )" :schema="content.schema"></schema-template>
							</div>

						</b-tab>
					</b-tabs>
				</div>
			</div><!-- /.schema-container -->
		</div><!-- /.card-body -->
	</div><!-- /.card -->
</template>
<script>
import { cloneDeep } from "lodash";
import SchemaTemplate from "@/components/api/path/schema";
import Prism from 'vue-prismjs';
import { formatAPIExample, getLangFromMimetype } from "@/util/udf";
export default {
	components: {
		SchemaTemplate,
		Prism
	},
	props : {
		resourceId : {
			type : String,
			default: String.prototype.uuid()
		},
		verb : {
			type : String,
			required : true
		},
		responseKey : {
			type : String,
			required : true
		},
		response : {
			type : Object,
			required: true
		}
	},
	computed : {
		markedResponse(){
			var self = this;
			var markedResponse = cloneDeep( this.response );
			if( markedResponse.schema ){
				markedResponse.schema[ "tabId" ] = String.prototype.uuid();

				if( markedResponse.schema.examples ){
					Object.keys( markedResponse.schema.examples ).forEach( ( exampleKey ) =>{
						markedResponse.schema.examples[ exampleKey ][ "tabId" ] = String.prototype.uuid();
					});
				}
			}
			return markedResponse;
		}
	},
	methods : {
		mimeLang : getLangFromMimetype,
		formatAPIExample : formatAPIExample
	}
}
</script>