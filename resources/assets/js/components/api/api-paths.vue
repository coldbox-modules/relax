<template>
	<div class="paths-content">
		<h3>Available Paths:</h3>
		<api-path
			v-for="pathKey in pathKeys"
			:key="`path_node_${api.paths[ pathKey ][ 'x-resourceId' ]}`"
			:route="pathKey" :path="api.paths[ pathKey ]"
		></api-path>
	</div>
</template>
<script>
import ApiPath from "@/components/api/path/path";
export default{
	components : {
		ApiPath
	},
	computed : {
		pathKeys(){ return Object.keys( this.api.paths ) }
	},
	props : {
		api : {
			type : Object,
			required : true
		}
	},
	mounted(){
		if( window.location.hash ){
			var self = this;
			Vue.nextTick( function(){ self.$emit( "hash-present" ) } );
		}
	}
}
</script>