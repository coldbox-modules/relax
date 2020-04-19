<template>
	<div :id="resourceId + '-' + responseKey" class="method-panel panel panel-primary">

		<div class="panel-heading">
			<h3 class="panel-title methodHeader">
				<strong>{{responseKey}}</strong>
				<a class="pull-right btToggleMethod" role="button" data-toggle="collapse" :href="`#panel_${resourceId}-${responseKey}`" aria-expanded="false" :aria-controls="`panel_${resourceId}-${responseKey}`">
					<i class="fa fa-chevron-down"></i>
				</a>
			</h3>
		</div>

		<div :id="`panel_${resourceId}-${responseKey}`" class="collapse panel-body">
			<div class="col-xs-12" v-if="markedResponse.description">
					<h4 class="panel-subtitle text-primary">Description:</h4>
					<p v-html="markedResponse.description.HTMLBreakLines()"></p>
					<hr>
			</div>

			<div class="col-xs-12 schema-container" v-if="markedResponse.schema || markedResponse.examples">
				<h4 class="panel-subtitle text-primary">Schema and Examples:</h4>

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
							<div v-if="markedResponse.schema" :id="`${markedResponse.schema.tabId}`" class="tab-pane fade in active schema-definition">
								<schema-template :schema="markedResponse.schema"></schema-template>
							</div>
							<div
								v-for="( example, mimetype, exampleIndex ) in ( markedResponse.examples || {} )"
								:key="`response_example_link_${exampleIndex}`"
								:id="example.tabId"
								:class="{ 'tab-pane' : true, 'fade' : true, 'schema-example' : true, 'in active' : !markedResponse.schema && exampleIndex === 0 }"
							>
								<div class="panel panel-solid-default">
									<prism :language="mimeLang( mimetype )" :code="formatAPIExample( example, mimetype )"></prism>
								</div>
							</div>
					</div><!-- /.tab-content -->
				</div><!-- /.schema-tabs -->
			</div><!-- /.schema-container -->
		</div><!-- /.panel-body -->
	</div><!-- /.panel -->
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
			required : true
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