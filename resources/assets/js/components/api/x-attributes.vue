<template>
	<div class="x-attributes" v-if="xAttributes.length">
		<component :is="headerClass" class="text-primary">Extended Attributes:</component>
		<table class="table-striped col-xs-12">
			<tr>
				<th width="40%">Name</th>
				<th width="60%">Value</th>
			</tr>
				<tr v-for="( xAttribute, index ) in xAttributes" :key="`x_attribute_${index}`">
					<td>
						<strong>{{ xAttribute.name }}</strong>
					</td>
					<td>
						<prism v-if="getBrushType( xAttribute )" :language="getBrushType( xAttribute )" :code="getAttributeValue( xAttribute )"></prism>
						<span v-else>{{getAttributeValue( xAttribute )}}</span>
					</td>
				</tr>
		</table>
	</div>
</template>
<script>
import { formatAPIExample } from "@/util/udf";
import Prism from 'vue-prismjs'
export default{
	components: {
		Prism
	},
	props : {
		entity : {
			type : Object
		},
		headerClass : {
			type : String,
			default : 'h3'
		}
	},
	data(){
		return {
			omitted : [ 'x-resourceId','x-entryPoint','x-extensionDetection','x-throwOnInvalidExtension', 'x-request-samples' ]
		}
	},
	computed : {
		xAttributes(){
			var self = this;
			return Object.keys( self.entity )
						.filter( key => self.omitted.indexOf( key ) == -1 && key.indexOf( "x-" ) > -1 )
						.reduce( ( acc, key ) => {
							let attributeArray = key.split( '-' );
							attributeArray.shift();
							let attributeName = attributeArray.join( ' ' ).toTitleCase();
							acc.push(
								{
									name : attributeName,
									value : self.entity[ key ]
								}
							);
							return acc;
						}, [] );
		}
	},
	methods : {
		getAttributeValue( xAttribute ){
			switch ( typeof( xAttribute.value ) ) {
				case 'object':
				case 'array':
					return formatAPIExample( JSON.stringify( xAttribute.value ), "application/json" );
				default:
					return xAttribute.value;
			}
		},
		getBrushType( xAttribute ){
			switch ( typeof( xAttribute.value ) ) {
				case 'object':
				case 'array':
					return 'json';
				default:
					return;
			}
		}
	}
}
</script>