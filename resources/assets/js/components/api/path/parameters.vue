<template>
	<div class="card-body">
		<table class="table table-striped table-condensed">
			<thead>
				<tr>
					<th class="text-secondary">Name</th>
					<th class="text-secondary">Type</th>
					<th class="text-secondary">Description</th>
					<th class="text-secondary">Delivery</th>
					<th class="text-secondary">Required?</th>
				</tr>
			</thead>
			<tbody
				v-for="( param, index ) in parameters"
				:key="`param_${index}`"
			>
				<tr>
					<td style="vertical-align:top;">
						<code>{{ param.name }}</code>
					</td>

					<td style="vertical-align:top;">
						<code v-if="param.type && ( !param.in || param.in !== 'body' )">{{ param.type }}</code>
						<code v-else-if="param.type && param.schema && param.schema.type">{{ param.schema.type }} (body)</code>
						<span v-else-if="!param.type">N/A</span>
					</td>

					<td style="vertical-align:top;">
						<p v-html="param.description.HTMLBreakLines()"></p>
					</td>

					<td style="vertical-align:top;">
						<p v-if="param.in">Provided in the <code>{{param.in}}</code> of the request</p>
						<p v-else>Provided in either <code>form</code>, <code>query</code> or <code>body</code> of the request</p>
					</td>

					<td style="vertical-align:top;">
					<i :class="`fa fa-${ param.required ? 'check-circle text-danger' : 'circle-o text-muted' }`" data-toggle="tooltip" :title="`This parameter is ${ param.required ? 'required' : 'optional' }`"></i>
						<a v-if="param.schema" :href="`#${parentResourceId}_${param.name}`" class="pull-right" data-toggle="collapse" aria-expanded="false" :aria-controls="`${parentResourceId}_${param.name}`">
							<small><i class="fa fa-chevron-down"></i></small>
						</a>
					</td>
				</tr>

				<tr v-if="param.schema" :id="parentResourceId">
					<td colspan="5" style="vertical-align:top;">
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