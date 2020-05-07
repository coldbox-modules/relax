<template>
	<div class="box">
		<!-- OpenAPI 3.x -->
		<div v-if="schema.items">
			<h4 class="card-subtitle text-secondary">Items:</h4>
			<schema-template :schema="schema.items" :showExample="!schema.example"></schema-template>
			<div v-if="schema.example" class="example box">
				<h4 class="box-header">Example:</h4>
				<div class="box-body">
					<prism :language="lang" :code="schema.example"></prism>
				</div>
			</div>
		</div>
		<div v-else-if="schema.type || schema.properties">
			<table class="table table-condensed col-xs-12">
				<thead v-if="detectedColumns.length > 2">
					<tr>
						<th class="text-secondary" v-for="column in detectedColumns" :key="`schema_column_${column.key}`">{{column.label}}</th>
					</tr>
				</thead>
				<tbody>
					<tr v-if="detectedColumns.length">
						<td v-for="column in detectedColumns" :key="`schema_column_row_${column.key}`" :colspan="detectedColumns.length <= 2 ? 2 : 1">
							<strong v-if="detectedColumns.length <= 2">{{column.label}}:</strong> <code>{{schema[ column.key ]}}</code>
						</td>
					</tr>
					<tr v-if="schema.properties" class="properties">
						<th class="text-secondary">Properties:</th>
						<td :colspan="detectedColumns.length ? detectedColumns.length - 1 : undefined">
							<schema-properties :properties="schema.properties"></schema-properties>
						</td>
					</tr>
					<tr v-if="showExample && propertiesExample && Object.keys( JSON.parse( propertiesExample ) ).length" class="example">
						<th class="text-secondary">Example:</th>
						<td :colspan="detectedColumns.length ? detectedColumns.length - 1 : 1">
							<prism :language="lang" :code="formatAPIExample( propertiesExample, lang )"></prism>
						</td>
					</tr>
					<tr v-if="Object.keys( unhandledSchema ).length">
						<th class="text-secondary"><strong><span v-if="detectedColumns.length">Additional </span>Constraints:</strong></th>
						<td :colspan="detectedColumns.length ? detectedColumns.length - 1 : 1">
							<prism language="json" :code="formatJSONRaw( JSON.stringify( unhandledSchema ) )"></prism>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- OpenAPI 2.x -->
		<div v-else class="card card-solid-default">
			<prism language="json" :code="formatJSONRaw( JSON.stringify( schema ) )"></prism>
		</div>
	</div>
</template>
<script>
import Prism from 'vue-prismjs';
import SchemaProperties from "@/components/api/path/schema-properties";
import { formatJSONRaw, formatAPIExample, objectToXML, formatXML, escapeHtml } from "@/util/udf";
export default{
	name : 'schema-template',
	data(){
		return {
			simpleValues : [ "title", "description", "summary", "required", "format"  ],
			availableColumns : [
				{
					"key" : "title",
					"label" : "Title"
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
					"key" : "default",
					"label" : "Default Value"
				},
				{
					"key" : "enum",
					"label" : "Accepted Values"
				},
				{
					"key" : "required",
					"label" : "Required"
				},
				{
					"key" : "description",
					"label" : "Description"
				}
			]
		}
	},
	components: {
		Prism,
		SchemaProperties
	},
	props : {
		schema : {
			required : true
		},
		showExample : {
			type : Boolean,
			default : true
		},
		lang : {
			type : String,
			default : 'json'
		}
	},
	computed : {
		condensedProperties(){
			var self = this;

			return !this.showExample || !this.schema.properties
					? undefined
					: Object.keys( this.schema.properties )
								.reduce( ( acc, key ) => {
									acc[ key ] = Object.assign( {}, this.schema.properties[ key ] );
									delete acc[ key ].example;
									return acc;
								}, {} )
		},
		itemsExample(){
			// default example
			if( this.schema.example ) return typeof( this.schema.example ) === 'string' ? this.schema.example : this.formatForLang( this.schema.example );
			// skip out if nothing to eval
			if( !this.schema.items || !this.schema.items.properties ) return undefined;

			var properties = this.schema.items.properties;
			return this.formatForLang( this.schemaPropertiesToExample( properties ) );
		},
		propertiesExample(){
			// default example
			if( this.schema.example ) return typeof( this.schema.example ) === 'string' ? this.schema.example : this.formatForLang( this.schema.example );
			// skip out if nothing to eval
			if( !this.schema.properties ) return undefined;
			var properties = this.schema.properties;
			return this.formatForLang( this.schemaPropertiesToExample( properties ) );
		},
		detectedColumns(){
			var self = this;
			return this.availableColumns.filter( col => Object.keys( self.schema ).indexOf( col.key ) > -1 );
		},
		unhandledSchema(){
			var self = this;
			var exclude = [ 'name', 'key', 'type', 'description', 'properties' ];
			let remainingKeys = Object.keys( this.schema ).reduce(
				( acc, key ) => {
					if( exclude.indexOf( key ) == -1 && acc.indexOf( key ) == -1 ){
						acc.push( key )
					}
					return acc;
				}
			, [] );
			if( !remainingKeys.length ) return {};
			return remainingKeys.reduce( ( acc, key ) => { if( remainingKeys.indexOf( key ) > -1 ) acc[ key ] = self.schema[ key ]; return acc; }, {} );
		}
	},
	methods : {
		formatJSONRaw : formatJSONRaw,
		formatAPIExample : formatAPIExample,
		schemaPropertiesToExample : ( properties ) => Object.keys( properties )
														.filter( key => !!properties[ key ].example )
														.reduce(
															(acc, key) => {
																acc[ key ] = properties[ key ].example;
																return acc;
															}, {}
														),
		formatForLang( obj ){
			switch( this.lang ){
				case "xml":
					return formatXML( objectToXML( obj ) )
					break;
				case "properties":
					return Object.keys( obj ).reduce( ( txt, key ) =>{
						txt += key + '=' + obj[key] + '\r\n';
						return txt;
					}, "" )
				default:
					return formatJSONRaw( JSON.stringify( obj ) );
			}
		}
	}
}
</script>