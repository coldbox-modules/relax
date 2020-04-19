<template>
	<div :id="path['x-resourceId']" class="path-panel panel panel-primary">
		<!--- Path Title --->
		<div class="panel-heading">
			<h3 class="panel-title pathHeader">
				{{route}}
				<a class="pull-right btTogglePath" role="button" data-toggle="collapse" :href="`#panel_${path['x-resourceId']}`" aria-expanded="false" :aria-controls="`panel_${path['x-resourceId']}`">
					<i class="fa fa-chevron-down"></i>
				</a>
			</h3>
		</div>

		<!--- Div Content --->
		<div :id="`panel_${path['x-resourceId']}`" class="collapse panel-body">
			<x-attributes :entity="path" header-type="h4"></x-attributes>
			<h4 class="panel-subtitle text-muted">Methods:</h4>
			<div class="col-xs-12">
				<method
					v-for="verb in methodKeys"
					:key="`method_${verb}_${path['x-resourceId']}`"
					:verb="verb"
					:method="path[ verb ]"
				></method>
			</div>

		</div>
	</div>
</template>
<script>
import XAttributes from "@/components/api/x-attributes";
import Method from "@/components/api/path/method";
export default {
	components: {
		XAttributes,
		Method
	},
	props : {
		route : {
			type : String,
			required : true
		},
		path : {
			type : Object,
			required: true
		}
	},
	data(){
		return {
			httpMethodKeys : [ 'get','put','post','patch','delete','options','head' ]
		}
	},
	computed : {
		pathMethods(){
			return this.httpMethodKeys.reduce( ( acc, key ) => {
				if( this.path[ key ] ){
					acc[ key ] = this.path[ key ];
				}
				return acc;
			}, {} )
		},
		methodKeys(){ return Object.keys( this.pathMethods ) }
	}
}
</script>