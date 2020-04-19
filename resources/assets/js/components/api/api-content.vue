<template>
	<div class="api-content container-fluid">
		<div v-if="api" class="content-header container-fluid">
			<div class="container-fluid">
				<h1 class="m-0 text-dark">API Documentation: {{ api.info.title }}</h1>
			</div>
		</div>
		<section v-if="api" class="content container-fluid">
			<div class="container-fluid">
				<div class="card card-secondary card-outline card-tabs">
					<div id="api-content-tabs" class="card-body row">
						<b-tabs :fill="true" class="container-fluid" nav-wrapper-class="text-secondary">
							<b-tab title="Service Overview" title-link-class="text-secondary box-title" active>
								<api-info :api="api"></api-info>
							</b-tab>
							<b-tab title="API Path Reference" title-link-class="text-secondary box-title" id="paths">
								<api-paths :api="api"></api-paths>
							</b-tab>
							<b-tab v-if="!isPrintStyled" title="HTTP Response Reference" title-link-class="text-secondary box-title" id="httpcodes">
								<http-codes></http-codes>
							</b-tab>
						</b-tabs>
					</div>
				</div>
			</div>
		</section>
	</div>
</template>
<script>
import ApiInfo from "@/components/api/api-info";
import HttpCodes from "@/components/api/httpcodes";
import ApiPaths from "@/components/api/api-paths";
import { mapState } from "vuex";
export default{
	components : {
		ApiInfo,
		HttpCodes,
		ApiPaths
	},
	computed : {
		...mapState({
			api : state => state.APIDoc,
			activeAPI : state => state.activeAPI
		}),
		isPrintStyled(){ return $( "body" ).hasClass( "print" ) }
	}

}
</script>