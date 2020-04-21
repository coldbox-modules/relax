<template>
	<div>
		<section class="content-wrapper">
			<section id="main-content" class="container-fluid">
				<div class="row">
					<div v-if="!availableAPIs || !api" class="content-header container-fluid">
						<h4 class="text-muted">Loading available APIs...</h4>
						<p>
							<i class="fa fa-spin fa-spinner fa-2x text-muted"></i>
						</p>
					</div>
					<div v-else class="api-content container-fluid">
						<div class="content-header container-fluid">
							<div class="container-fluid">
								<h1 class="m-0 text-dark">Relax API Test Tool: {{api.info.title}}</h1>
							</div>
						</div>
						<section class="content container-fluid">
							<div class="container-fluid">
								<div class="card card-secondary card-outline">
									<div class="card-body row container-fluid">
										<relaxer-form></relaxer-form>
										<relaxer-response v-if="lastResponse" :response="lastResponse"></relaxer-response>
										<relaxer-history></relaxer-history>
									</div>
								</div>
							</div>
						</section>
					</div>
				</div> <!-- end .row -->
			</section>
		</section>
		<!-- Control Sidebar -->
		<aside class="control-sidebar control-sidebar-dark" style="padding: 20px">
			<relaxer-sidebar></relaxer-sidebar>
		</aside>
	</div>
</template>
<script>
import RelaxerSidebar from "@/components/relaxer/relaxer-sidebar";
import RelaxerForm from "@/components/relaxer/relaxer-form";
import RelaxerHistory from "@/components/relaxer/relaxer-history";
import RelaxerResponse from "@/components/relaxer/relaxer-response";
import RelaxerStore from "@/store/relaxer";
import { mapState, mapGetters } from "vuex";
export default{
	components : {
		RelaxerSidebar,
		RelaxerForm,
		RelaxerHistory,
		RelaxerResponse
	},
	computed : {
		...mapState({
			api : state => state.APIDoc,
			availableAPIs : state => state.availableAPIs,
			defaultAPI : state => state.defaultAPI,
			lastResponse : state => state.relaxer.lastResponse
		}),
		...mapGetters([ 'requestedAPI' ] )
	},
	mounted(){
		this.$store.registerModule( "relaxer", RelaxerStore );
		this.$store.dispatch( "fetchAvailableAPIs" ).then( () => {
			if( !this.activeAPI ){
				this.$store.dispatch( "selectAPI", this.requestedAPI || this.defaultAPI )
			}
		} );
	}
}
</script>