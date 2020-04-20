<template>
	<div>
		<h5 class="mb-1">Available Relax APIs</h5>
		<div class="mb-1">
			Load another API:<br/>
			<p class="text-center">
				<b-form-select
					:value="selected"
					:options="apiOptions"
					@change="onAPISelected"
				></b-form-select>
			</p>
		</div>
	</div>
</template>
<script>
import { BFormSelect } from 'bootstrap-vue';
import { mapGetters, mapState } from "vuex";
export default{
	components: {
		BFormSelect
	},
	computed : {
		...mapState({
			selected : state => state.activeAPI,
			availableAPIs : state => state.availableAPIs,
			APIDoc : state => state.APIDoc,
			defaultAPI : state => state.defaultAPI,
			apiOptions : state => Object.keys( state.availableAPIs ).map( ( key ) => {
				return {
					value : key,
					text : state.availableAPIs[key].title + '(' + key + ')'
				}
			} )
		}),
		...mapGetters( [ 'requestedAPI' ] )
	},
	methods : {
		onAPISelected( api ){
			this.$store.dispatch( "selectAPI", api );
		}
	}
}
</script>