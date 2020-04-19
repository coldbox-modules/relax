<template>
<div :id="method['x-resourceId']" class="method-panel panel panel-info">

	<div class="panel-heading">
		<h3 class="panel-title methodHeader">
			<strong>{{verb}}</strong>
			<a class="pull-right btToggleMethod" role="button" data-toggle="collapse" :href="`#panel_${method['x-resourceId']}`" aria-expanded="false" :aria-controls="`panel_${method['x-resourceId']}`">
				<i class="fa fa-chevron-down"></i>
			</a>
		</h3>
	</div>

	<div :id="`panel_${method['x-resourceId']}`" class="collapse panel-body">
		<div class="col-xs-12">

			<div v-if="method.description">
				<h4 class="panel-subtitle text-primary">Description:</h4>

				<p v-html="method.description.HTMLBreakLines()"></p>

				<hr>
			</div>

			<div v-if="method.operationId">
				<h4 class="panel-subtitle text-primary">Internal Operation: <small class="text-muted">(e.g. Handler.Action)</small></h4>
				<code>{{ method.operationId }}</code>
				<hr>
			</div>
			<div v-if="method.parameters && method.parameters.length">
				<h4 class="panel-subtitle text-primary">Parameters:</h4>
				<parameters :parameters="method.parameters"></parameters>
				<hr>
			</div>

			<div v-if="method.requestBody">
				<h4 class="panel-subtitle text-primary">Request Body:</h4>
				<ul class="list-unstyled">
					<li><strong>Description:</strong> {{ method.requestBody.description }}</li>
					<li><strong>Required:</strong> <code>{{ method.requestBody.required ? 'true' : 'false' }}</code></li>
				</ul>
				<request-body :entity="method"></request-body>
				<hr>
			</div>

			<x-attributes :entity="method" header-type="h4"></x-attributes>

			<div v-if="Object.keys( method.responses ).length">
				<h4 class="panel-subtitle text-primary">Responses:</h4>
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
					<h4 class="panel-subtitle text-primary">Sample Responses:</h4>
					<p>{{ method[ "x-request-samples" ].description }}</p>
					<div class="sample-tabs">
						<b-tabs content-class="tab-wrapper">
							<b-tab
								v-for="(example, mimetype, index) in method[ 'x-request-samples' ].examples"
								:key="`example_control_${mimetype}_${index}`"
								:title="mimetype"
							>
								<div class="panel panel-solid-default">
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
import RequestBody from "@/components/api/path/request-body";
import XAttributes from "@/components/api/x-attributes";
import Prism from 'vue-prismjs';
import { uniqueId } from "lodash";
import { formatAPIExample } from "@/util/udf";
export default{
	components : {
		Parameters,
		ResponseTemplate,
		RequestBody,
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
		mimeLang : ( mimetype ) => {
			typeRef = mimetype.split('/')[ mimetype.split( '/' ).length-1 ];
			if( typeRef === 'json' ) typeRef = 'javascript';
			return typeRef;
		}
	}

}
</script>