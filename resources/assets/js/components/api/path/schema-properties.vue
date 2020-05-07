<template>
	<div class="card-body">
		<table class="table table-striped table-condensed">
			<thead>
				<tr>
					<th v-for="col in detectedColumns" :key="`th_${col.key}`" class="text-secondary">{{col.label}}</th>
				</tr>
			</thead>
			<tbody
				v-for="( param, index ) in normalizedProperties"
				:key="`param_${index}`"
			>
				<tr>
					<td v-for="col in detectedColumns" :key="`td_${col.key}`" class="text-secondary">
						<span v-if="col.key == 'type'" style="vertical-align:top">
							<code v-if="param.type && ( !param.in || param.in !== 'body' )">{{ param.type }}</code>
							<code v-else-if="param.type && param.schema && param.schema.type">{{ param.schema.type }} (body)</code>
							<span v-else-if="!param.type">N/A</span>
						</span>
						<span v-else-if="col.key == 'description'" style="vertical-align:top">
							<p v-html="param.description ? param.description.HTMLBreakLines() : 'N/A'"></p>
						</span>
						<span v-else-if="col.key == 'in'" style="vertical-align:top">
							<p v-if="param.in">Provided in the <code>{{param.in}}</code> of the request</p>
							<p v-else>Provided in either <code>form</code>, <code>query</code> or <code>body</code> of the request</p>
						</span>
						<span v-else-if="col.key == 'required'" style="vertical-align:top">
							<i :class="`fa fa-${ param.required ? 'check-circle text-danger' : 'circle-o text-muted' }`" v-b-tooltip.hover :title="`This parameter is ${ param.required ? 'required' : 'optional' }`"></i>
						</span>
						<span v-else style="vertical-align:top"><code v-if="param[ col.key ]">{{ param[ col.key ] }}</code></span>
					</td>
				</tr>

				<tr v-if="param.schema">
					<td colspan="5" style="vertical-align:top;" :id="`${parentResourceId}_${param.name}`">
						<h6 class="text-secondary">Constraints:</h6>
						<schema-template :schema="param.schema"></schema-template>
					</td>
				</tr>

			</tbody>

		</table>
	</div>
</template>
<script>
import { formatJSONRaw } from "@/util/udf";
import Prism from 'vue-prismjs';
import SchemaTemplate from "@/components/api/path/schema";
export default{
	components: {
		Prism,
		SchemaTemplate
	},
	props : {
		properties : {
			type : Object,
			required: true
		},
		parentResourceId : {
			type : String,
			default : String.prototype.uuid()
		}
	},
	data(){
		return {
			columnDefinitions : [
				{
					"key" : "name",
					"label" : "Name"
				},
				{
					"key" : "type",
					"label" : "Type"
				},
				{
					"key" : "format",
					"label" : "Format"
				},
				{
					"key" : "description",
					"label" : "Description"
				},
				{
					"key" : "in",
					"label" : "Delivery"
				},
				{
					"key" : "required",
					"label" : "Required?"
				}
			]
		}
	},
	computed : {
		detectedColumns(){
			var self = this;
			return this.columnDefinitions.filter(
				def => self.normalizedProperties.reduce( ( acc, param ) => {
					Object.keys( param ).forEach( key => { if( acc.indexOf( key ) == -1 ) acc.push( key ) } );
					return acc;
				}, [] ).indexOf( def.key ) > -1
			)
		},
		normalizedProperties(){
			var self = this;
			return Object.keys( this.properties ).reduce( ( acc, propKey ) => {
				let normalized = Object.assign( {}, self.properties[ propKey ] );
				normalized[ "name" ] = propKey;
				if( normalized.schema ){
					Object.keys( normalized.schema ).forEach( key => normalized[ key ] = normalized.schema[ key ] );
				}
				delete normalized.schema;
				acc.push( normalized );
				return acc;
			}, [] );

		}
	},
	methods: {
		formatJSONRaw : formatJSONRaw
	}

}
</script>