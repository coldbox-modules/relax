<template>

	<div class="security-definitions">
		<table class="table table-striped table-condensed">
			<thead>
				<tr>
					<th class="text-secondary">Name</th>
					<th class="text-secondary">Type</th>
					<th class="text-secondary">Description</th>
					<th class="text-secondary">Delivery</th>
				</tr>
			</thead>
			<tbody
				v-for="( definition, definitionKey, index ) in definitions"
				:key="`param_${index}`"
			>
				<tr>
					<td style="vertical-align:top;">
						<code>{{ definition.name || definitionKey }}</code>
					</td>

					<td style="vertical-align:top;">
						<code v-if="definition.type">{{ definition.type }}</code>
						<span v-else >N/A</span>
					</td>

					<td style="vertical-align:top;">
						<p v-if="definition.description" v-html="definition.description.HTMLBreakLines()"></p>
						<p v-else>Definition description unavailable.</p>
					</td>

					<td style="vertical-align:top;">
						<p v-if="definition.in">Provided in the <code>{{definition.in}}</code> of the request</p>
						<p v-else>N/A</p>
					</td>
				</tr>
				<tr v-if="[ 'oauth', 'oauth2' ].indexOf( definition.type ) > -1" :id="`definition_${definition.type}`">
					<td colspan="4" style="vertical-align:top;">
						<ul class="list-unstyled">
							<li>
								<strong>Authorization URL:</strong>
								<a :href="definition.authorizationUrl">{{definition.authorizationUrl}}</a>
							</li>

							<li v-if="definition.tokenUrl">
								<strong>Token URL</strong> <a :href="definition.tokenUrl">{{definition.tokenUrl}}</a><br>
							</li>

							<li>
								<strong>OAuth Flow</strong> <code>{{definition.flow}}</code><br>
							</li>
							<li>
								<strong>Scopes:</strong><br>
								<prism language="json" :code="formatJSONRaw( JSON.stringify( definition.scopes ) ).trim()"></prism>
							</li>
						</ul>
					</td>
				</tr>
			</tbody>

		</table>
	</div>
	<!-- /.security definitions -->
</template>
<script>
import { formatJSONRaw } from "@/util/udf";
import Prism from 'vue-prismjs';
export default{
	components : {
		Prism
	},
	props : {
		definitions : {
			type : Object,
			required : true
		}
	},
	methods : {
		formatJSONRaw : formatJSONRaw
	}

}
</script>