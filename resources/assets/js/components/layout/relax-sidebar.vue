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
		<h5 class="mb-1">API Export<span v-if="globalData.sessionEnabled">/Import</span></h5>
		<div class="mb-1">
			You can export your Relaxed Service API to JSON<span v-if="globalData.sessionEnabled"> and also import one</span>.<br/><br/>

			<p class="text-center">
				<!--- Export --->
				<a href="javascript:;"
					@click="onExportAPIJSON"
					:data-link="globalData.url.exportAPI"
					class="btn btn-primary btnExportJSON"
					title="Export API">
						<i class="fa fa-lg fa-cloud-download"></i> Export
				</a>

				<!--- Import --->
				<a
					v-if="globalData.sessionEnabled"
					href="javascript:;"
					@click="onShowImportAPI"
					data-toggle="tooltip"
					class="btn btn-primary btnImportAPI"
					title="Import API">
						<i class="fa fa-lg fa-cloud-upload"></i> Import
				</a>
			</p>
		</div>

		<hr class="mb-2"/>

		<h5 class="mb-1">Docs Export Lounge</h5>
		<div class="mb-1">
			<p>You can export your Relaxed Service Documentation in several formats: <br/></p>
			<!--- Export Commands --->
			<p class="text-center">
				<!--- html --->
				<a 	href="javascript:;"
					@click="onExportFormat"
					data-format="html"
					:data-link="globalData.url.exportHTML"
					class="btn btn-primary btnExportFormat"
					data-toggle="tooltip"
					title="Export as HTML">
					<i class="fa fa-lg fa-html5"></i>
				</a>
				<!--- pdf --->
				<a 	href="javascript:;"
					@click="onExportFormat"
					data-format="pdf"
					:data-link="globalData.url.exportPDF"
					class="btn btn-primary btnExportFormat"
					data-toggle="tooltip"
					title="Export as PDF">
					<i class="fa fa-lg fa-file-pdf-o"></i>
				</a>
				<!--- mediawiki --->
				<a 	href="javascript:;"
					@click="onExportFormat"
					data-format="trac"
					:data-link="globalData.url.exportWiki"
					class="btn btn-primary btnExportFormat"
					data-toggle="tooltip"
					title="Export as MediaWiki">
					<i class="fa fa-lg fa-file-code-o"></i>
				</a>
				<!--- trac --->
				<a 	href="javascript:;"
					@click="onExportFormat"
					data-format="trac"
					:data-link="globalData.url.exportTrac"
					class="btn btn-primary btnExportFormat"
					data-toggle="tooltip"
					title="Export as TracMarkup">
					<i class="fa fa-lg fa-paw"></i>
				</a>
			</p>
		</div>

		<hr class="mb-2"/>

		<h5 class="mb-1">Need Help?</h5>
		<div class="mb-1">
			<div>
				<a href="http://www.ortussolutions.com" target="_blank" title="The Gurus behind ColdBox">
					<img :src="`${globalData.rootPath}/includes/static/images/ortus-top-logo.png`" alt="Ortus Solutions" border="0" class="img-thumbnail"/>
				</a>
			</div>

			<p>&nbsp;</p>

			<p><strong>Ortus Solutions</strong> is the company behind anything ColdBox. Need professional support, architecture analysis,
			code reviews, custom development or anything ColdFusion, ColdBox related?
			<a href="mailto:help@ortussolutions.com">Contact us</a>, we are here
			to help!</p>
		</div>
	</div>
</template>
<script>
import ApiSelectors from "@/components/layout/api-selectors";
import { mapState } from "vuex";
export default {
	mixins : [
		require( "@/components/mixins/import-export" ).default
	],
	components : {
		ApiSelectors
	},
	computed : {
		...mapState({
			availableAPIs : state => state.availableAPIs
		})
	},
	methods : {

	}
}
</script>