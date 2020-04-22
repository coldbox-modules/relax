<template>
<div :id="method['x-resourceId']" class="method-card card card-lightblue">

	<div class="card-header d-flex p-0">
		<h3 class="card-title p-3 methodHeader">
			<strong>{{verb.toUpperCase()}}</strong>
		</h3>
		<ul class="nav nav-pills ml-auto p-2">
			<li class="nav-item">
				<a class="nav-link btToggleMethod" role="button" data-toggle="collapse" :href="`#card_${method['x-resourceId']}`" aria-expanded="false" :aria-controls="`card_${method['x-resourceId']}`">
					<i class="fa fa-chevron-down"></i>
				</a>
			</li>
		</ul>
	</div>

	<div :id="`card_${method['x-resourceId']}`" class="collapse card-body">
		<div class="col-xs-12">
			<h4 v-if="method.deprecated" class="card-subtitle text-secondary"><em>Deprecated</em></h4>
			<div v-if="method.summary">
				<h4 class="card-subtitle text-secondary">Summary:</h4>

				<p v-html="method.summary.HTMLBreakLines()"></p>

				<hr>
			</div>

			<div v-if="method.description">
				<h4 class="card-subtitle text-secondary">Description:</h4>

				<p v-html="method.description.HTMLBreakLines()"></p>

				<hr>
			</div>

			<div v-if="method.operationId">
				<h4 class="card-subtitle text-secondary">Internal Operation: <small class="text-muted">(e.g. Handler.Action)</small></h4>
				<code>{{ method.operationId }}</code>
				<hr>
			</div>
			<div v-if="method.parameters && method.parameters.length">
				<h4 class="card-subtitle text-secondary">Parameters:</h4>
				<parameters :parameters="method.parameters"></parameters>
				<hr>
			</div>

			<div v-if="method.requestBody">
				<h4 class="card-subtitle text-secondary">Request Body:</h4>
				<ul class="list-unstyled">
					<li><strong>Description:</strong> {{ method.requestBody.description }}</li>
					<li><strong>Required:</strong> <code>{{ method.requestBody.required ? 'true' : 'false' }}</code></li>
				</ul>
				<!-- Swagger 3.x specification -->
				<div class="col-xs-12 schema-container" v-if="method.requestBody.content && Object.keys( method.requestBody.content ).length">
					<h4 class="card-subtitle text-secondary">Content Types:</h4>
					<b-tabs :fill="true" class="container-fluid" nav-wrapper-class="text-secondary">
						<b-tab
							v-for="( content, mimetype ) in method.requestBody.content"
							:key="method['x-resourceId'] + '-requestBody-' + mimetype"
							:title="mimetype"
							title-link-class="text-secondary box-title"
						>
							<div class="schema-definition">
								<schema-template :lang="mimeLang( mimetype )" :schema="content.schema"></schema-template>
							</div>
							<div v-if="content.example" class="example box">
								<h5 class="box-header">Example</h5>
								<div class="box-body">
									<prism language="json" :code="formatJSONRaw( JSON.stringify( content.example ) )"></prism>
								</div>
							</div>
						</b-tab>
					</b-tabs>
				</div>
			</div>

			<x-attributes :entity="method" header-type="h4" header-class="text-secondary"></x-attributes>

			<div v-if="method.responses && Object.keys( method.responses ).length">
				<h4 class="card-subtitle text-secondary">Responses:</h4>
				<div
					v-for="responseKey in filteredResponseKeys"
					:key="`response_${method['x-resourceId']}_${responseKey}`"
				>
					<response-template
						:resourceId="method[ 'x-resourceId' ]"
						:verb="verb"
						:responseKey="responseKey"
						:response="filteredResponses[ responseKey ]"
					></response-template>
				</div>
			</div>

			<div v-if="method[ 'x-request-samples' ]">
				<div class="col-xs-12 schema-container">
					<h4 class="card-subtitle text-secondary">Sample Responses:</h4>
					<p>{{ method[ "x-request-samples" ].description }}</p>
					<div class="sample-tabs">
						<b-tabs class="tab-wrapper card card-default" content-class="card-body" nav-wrapper-class="card-header">
							<b-tab
								v-for="(example, mimetype, index) in method[ 'x-request-samples' ].examples"
								:key="`example_control_${mimetype}_${index}`"
								:title="mimetype"
							>
								<div class="card card-solid-default">
									<prism :language="mimeLang( mimetype )" :code="formatAPIExample( example, mimetype )"></prism>
								</div>
							</b-tab>
						</b-tabs>
					</div><!-- /.schema-tabs -->
				</div><!-- /.schema-container -->
			</div>
		</div>
	</div>

</div>

</template>
<script>
import Parameters from "@/components/api/path/parameters";
import ResponseTemplate from "@/components/api/path/response";
import XAttributes from "@/components/api/x-attributes";
import SchemaTemplate from "@/components/api/path/schema";
import Prism from 'vue-prismjs';
import { uniqueId } from "lodash";
import { formatAPIExample, getLangFromMimetype } from "@/util/udf";
export default{
	components : {
		Parameters,
		ResponseTemplate,
		SchemaTemplate,
		XAttributes,
		Prism
	},
	props : {
		method : {
			type : Object,
			required :true
		},
		verb : {
			type : String,
			required : true
		}
	},
	computed : {
		filteredResponses(){
			var self = this;
			return Object.keys( this.method.responses || {} ).reduce(
				function( acc, responseKey ){
					if( !isNaN( responseKey ) || responseKey === 'default' ){
						acc[ responseKey ] = self.method.responses[ responseKey ];
					}
					return acc;
				},
				{}
			);
		},
		filteredResponseKeys(){ return Object.keys( this.filteredResponses ) }
	},
	methods : {
		mimeLang : getLangFromMimetype,
		formatAPIExample : formatAPIExample
	}

}
</script>