<template>
	<div :id="`route_${routeId}`" class="path-card card card-primary">
		<!--- Path Title --->
		<div class="card-header d-flex p-0">
			<h3 class="card-title p-3 pathHeader">
				{{route}}
			</h3>
			<ul class="nav nav-pills ml-auto p-2">
				<li class="nav-item">
					<a class="nav-link btnTogglePath" role="button" data-toggle="collapse" :href="`#card_${routeId}`" aria-expanded="false" :aria-controls="`card_${routeId}`">
						<i class="fa fa-chevron-down"></i>
					</a>
				</li>
			</ul>
		</div>

		<!--- Div Content --->
		<div :id="`card_${routeId}`" class="collapse card-body">
			<x-attributes :entity="path" header-type="h4" header-class="text-secondary"></x-attributes>
			<h4 class="card-subtitle text-muted">Methods:</h4>
			<div class="col-xs-12">
				<method
					v-for="verb in methodKeys"
					:key="`method_${verb}_${routeId}`"
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
		routeId(){
			return this.route.replace(/[\W_]+/g,"-");
		},
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