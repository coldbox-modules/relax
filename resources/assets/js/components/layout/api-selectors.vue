<template>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">Available Relax APIs</h3>
		</div>
		<div class="panel-body">
			Load another API:<br/>
			<p class="text-center">
				<b-form-select
					v-model="selected"
					:options="apiOptions"
					@change="onAPISelected"
				></b-form-select>
			</p>
		</div>
	</div>
</template>
<script>
import { mapState } from "vuex";
import { BFormSelect } from 'bootstrap-vue';
export default{
	components: {
		BFormSelect
	},
	data(){
		return {
			selected : null
		}
	},
	computed : {
		...mapState({
			availableAPIs : state => state.availableAPIs,
			APIDoc : state => state.APIDoc,
			defaultAPI : state => state.defaultAPI,
			apiOptions : state => Object.keys( state.availableAPIs ).map( ( key ) => {
				return {
					value : key,
					text : state.availableAPIs[key].title + '(' + key + ')'
				}
			} )
		})
	},
	methods : {
		onAPISelected( e ){
			console.log( e );
			this.$store.dispatch( "selectAPI", this.selected );
		}
	}
}
</script>