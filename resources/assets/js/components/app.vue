<template>
	<div id="main-content" class="row">
			<div class="col-md-9 pull-left">
				<div class="api-content">
					<div v-if="!availableAPIs" id="mc-loader" class="text-center">
						<h4 class="text-muted">Get ready to kick back and... <em>Relax</em>!</h4>
						<p>
							<i class="fa fa-spin fa-spinner fa-2x text-muted"></i>
						</p>
					</div>
					<div v-else-if="!api">

					</div>
					<api-content v-else :api="api"></api-content>
				</div>

			</div> <!-- /.main-content -->

			<div class="col-md-3 pull-right">
				<relax-sidebar></relax-sidebar>
			</div>

	</div> <!-- end .row -->

</template>
<script>
import ApiContent from "@/components/api/api-content";
import RelaxSidebar from "@/components/layout/relax-sidebar";
import { parseRequestParams } from "@/util/udf";
import { mapState } from "vuex";

export default {
	components : {
		ApiContent,
		RelaxSidebar
	},
	computed : {
		...mapState(
			{
				api : state => state.APIDoc,
				availableAPIs : state => state.availableAPIs,
				activeAPI : state => state.activeAPI
			}
		)
	},
	mounted(){
		this.$store.dispatch( "fetchAvailableAPIs" ).then( () => {
			if( this.activeAPI ){
				this.$store.dispatch( "selectAPI", this.activeAPI )
			}
		} );
	}

}
</script>