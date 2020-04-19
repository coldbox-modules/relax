<template>
	<section class="api-content">
		<p class="hidden-print">
			The <em>Relax DSL</em> is loaded for your API: <code>{{ api.id }}</code>.
		</p>

		<div class="panel panel-default">
			<div id="api-content-tabs" class="panel-body">
				<b-tabs class="tab-wrapper panel panel-primary" content-class="panel-body" nav-wrapper-class="panel-heading">
					<b-tab title="Service Overview" active>
						<api-info :api="api"></api-info>
					</b-tab>
					<b-tab title="API Path Reference" id="paths">
						<api-paths :api="api"></api-paths>
					</b-tab>
					<b-tab v-if="!isPrintStyled" title="HTTP Response Reference" id="httpcodes">
						<http-codes></http-codes>
					</b-tab>
				</b-tabs>
			</div>
		</div>
	</section>

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
			api : state => state.APIDoc
		}),
		isPrintStyled(){ return $( "body" ).hasClass( "print" ) }
	}

}
</script>