<template>
	<div class="os-content" style="padding: 15px 10px 15px 10px;">
		<div class="mb-1 api-selector">
			<h5 v-if="!availableAPIs" class="mb-1">
				Loading Available APIs... <br>
				<i class="fa fa-spin fa-spinner"></i>
			</h5>
			<api-selectors v-else></api-selectors>
	    </div>
		<hr class="mb-2"/>
		<relaxer-resources v-if="APIDoc"></relaxer-resources>
	</div>
</template>
<script>
import ApiSelectors from "@/components/layout/api-selectors";
import RelaxerResources from "@/components/relaxer/relaxer-resources";
import { mapState } from "vuex";
export default {
	mixins : [
		require( "@/components/mixins/import-export" ).default
	],
	components : {
		ApiSelectors,
		RelaxerResources
	},
	computed : {
		...mapState({
			APIDoc : state => state.APIDoc,
			availableAPIs : state => state.availableAPIs
		})
	},
	methods : {

	}
}
</script>