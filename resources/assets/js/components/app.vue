<template>
	<div>
		<section class="content-wrapper">
			<section id="main-content" class="container-fluid">
				<div class="row">
					<div v-if="!availableAPIs" class="content-header container-fluid">
						<h4 class="text-muted">Get ready to kick back and... <em>Relax</em>!</h4>
						<p>
							<i class="fa fa-spin fa-spinner fa-2x text-muted"></i>
						</p>
					</div>
					<api-content v-else :api="api"></api-content>
				</div> <!-- end .row -->
			</section>
		</section>
		<!-- Control Sidebar -->
		<aside class="control-sidebar control-sidebar-dark" style="padding: 20px">
			<relax-sidebar></relax-sidebar>
		</aside>
	</div>
</template>
<script>
import ApiContent from "@/components/api/api-content";
import RelaxSidebar from "@/components/layout/relax-sidebar";
import { mapState, mapGetters } from "vuex";

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
				defaultAPI : state => state.defaultAPI,
				activeAPI : state => state.activeAPI
			}
		),
		...mapGetters([ 'requestedAPI' ] )
	},
	mounted(){
		this.$store.dispatch( "fetchAvailableAPIs" ).then( () => {
			if( !this.activeAPI ){
				this.$store.dispatch( "selectAPI", this.requestedAPI || this.defaultAPI )
			}
		} );
	}

}
</script>