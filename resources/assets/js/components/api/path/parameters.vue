<template>
	<div class="col-xs-12 parameter-list list-group">

		<div class="col-xs-12 bg-default">
			<div class="parameter-column key col-sm-3 col-xs-8">
				Name
			</div>

			<div class="parameter column type col-sm-2 col-xs-4">
				Type
			</div>

			<div class="parameter column description col-sm-5 col-xs-8">
				Description
			</div>

			<div class="parameter column requirement col-sm-2 col-xs-4">
			Required?
			</div>
		</div>
		<div
			v-for="( param, index ) in parameters"
			:key="`param_${index}`"
			class="list-group-item parameter optional col-xs-12"
		>

			<div class="parameter-column key col-sm-3 col-xs-8">
				<code>{{ param.name }}</code>
			</div>

			<div class="parameter column type col-sm-2 col-xs-4">
				<code v-if="param.type && ( !param.in || param.in !== 'body' )">{{ param.type }}</code>
				<code v-else-if="param.type && param.schema && param.schema.type">{{ param.schema.type }} (body)</code>
				<span v-else-if="!param.type">N/A</span>
			</div>

			<div class="parameter column description col-sm-5 col-xs-8">
				<p v-html="param.description.HTMLBreakLines()"></p>
				<p v-if="param.in">Provided in the <code>{{param.in}}</code> of the request</p>
			</div>

			<div class="parameter column requirement col-sm-2 col-xs-4">
			<i :class="`fa fa-${ param.required ? 'check-circle text-danger' : 'circle-o text-muted' }`" data-toggle="tooltip" :title="`This parameter is ${ param.required ? 'required' : 'optional' }`"></i>
				<a v-if="param.schema" :href="`#${parentResourceId}_${param.name}`" class="pull-right" data-toggle="collapse" aria-expanded="false" :aria-controls="`${parentResourceId}_${param.name}`">
					<small><i class="fa fa-chevron-down"></i></small>
				</a>
			</div>
			<div v-if="param.schema" class="clearfix"></div>
			<div v-if="param.schema" :id="parentResourceId" class="collapse panel panel-solid-default">
				<prism language="json" :code="formatJSONRaw( JSON.stringify( param.schema ) ).trim()"></prism>
			</div>
		</div>
	</div>
</template>
<script>
import { formatJSONRaw } from "@/util/udf";
import Prism from 'vue-prismjs';
export default{
	components: {
		Prism
	},
	props : {
		parameters : {
			type : Array,
			required: true
		},
		parentResourceId : {
			type : String,
			default : String.prototype.uuid()
		}
	},
	methods: {
		formatJSONRaw : formatJSONRaw
	}

}
</script>