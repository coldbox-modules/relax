<template>
	<div class="box">
		<!-- OpenAPI 3.x -->
		<div v-if="schema.items">
			<div v-if="schema.example" class="example box">
				<h5 class="box-header">Example:</h5>
				<div class="box-body">
					<prism :language="lang" :code="schema.example"></prism>
				</div>
			</div>
			<h4 class="card-subtitle text-secondary">Items:</h4>
			<schema-template :schema="schema.items" :showExample="!schema.example"></schema-template>
		</div>
		<div v-else-if="schema.type || schema.properties">
			<h5 class="box-header">{{schema.title}}</h5>
			<h5 v-if="schema.type" class="box-header">Type: <code>{{schema.type}}</code></h5>
			<h5 v-if="schema.required" class="box-header">Required: <code>{{schema.required}}</code></h5>
			<h5 v-if="schema.description" class="box-header">Description:</h5>
			<p v-if="schema.description" v-html="schema.description.HTMLBreakLines()"></p>

			<div v-if="showExample && propertiesExample && Object.keys( propertiesExample ).length" class="example box">
				<h5 class="box-header">Example:</h5>
				<div class="box-body">
					<prism :language="lang" :code="propertiesExample"></prism>
				</div>
			</div>

			<div v-if="schema.properties" class="box">
				<h5 class="box-header">Properties:</h5>
				<prism language="json" :code="formatJSONRaw( JSON.stringify( condensedProperties ) )"></prism>
			</div>

		</div>
		<!-- OpenAPI 2.x -->
		<div v-else class="card card-solid-default">
			<prism language="json" :code="formatJSONRaw( JSON.stringify( schema ) )"></prism>
		</div>
	</div>
</template>
<script>
import Prism from 'vue-prismjs';
import { formatJSONRaw, objectToXML, formatXML, escapeHtml } from "@/util/udf";
export default{
	name : 'schema-template',
	data(){
		return {
			simpleValues : [ "title", "description", "summary", "required", "format"  ]
		}
	},
	components: {
		Prism
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
		}
	},
	methods : {
		formatJSONRaw : formatJSONRaw,
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