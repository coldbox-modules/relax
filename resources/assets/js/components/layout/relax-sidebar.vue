<template>
	<div class="mc-sidebar">
		<div class="panel panel-default api-selector">
	        <div v-if="!availableAPIs" class="panel-body">
	        	<p class="text-center">
	        		Loading Available APIs... <br>
	        		<i class="fa fa-spin fa-spinner"></i>
	        	</p>
	        </div>
			<api-selectors v-else></api-selectors>
	    </div>

	    <div class="panel panel-default">
	        <div class="panel-heading">
	            <h3 class="panel-title">API Export<span v-if="globalData.sessionEnabled">/Import</span></h3>
	        </div>
	        <div class="panel-body">
	        	You can export your Relaxed Service API to JSON<span v-if="globalData.sessionEnabled"> and also import one</span>.<br/><br/>

				<p class="text-center">
					<!--- Export --->
					<a href="javascript:void(0)"
						:data-link="globalData.url.exportAPI"
						class="btn btn-primary btnExportJSON"
					   	title="Export API">
							<i class="fa fa-lg fa-cloud-download"></i> Export
					</a>

					<!--- Import --->
					<a
						v-if="globalData.sessionEnabled"
						href="javascript:void(0)"
						data-toggle="tooltip"
						class="btn btn-primary btnImportAPI"
						title="Import API">
							<i class="fa fa-lg fa-cloud-upload"></i> Import
					</a>
				</p>
	        </div>
	    </div>

	    <div class="panel panel-default">
	        <div class="panel-heading">
	            <h3 class="panel-title">Docs Export Lounge</h3>
	        </div>
	        <div class="panel-body">
	        	<p>You can export your Relaxed Service Documentation in several formats: <br/></p>
				<!--- Export Commands --->
				<p class="text-center">
					<!--- html --->
					<a 	href="javascript:void(0)"
						data-format="html"
						:data-link="globalData.url.exportHTML"
						class="btn btn-primary btnExportFormat"
						data-toggle="tooltip"
					   	title="Export as HTML">
						<i class="fa fa-lg fa-html5"></i>
					</a>
					<!--- pdf --->
					<a 	href="javascript:void(0)"
						data-format="pdf"
						:data-link="globalData.url.exportPDF"
						class="btn btn-primary btnExportFormat"
						data-toggle="tooltip"
						title="Export as PDF">
						<i class="fa fa-lg fa-file-pdf-o"></i>
					</a>
					<!--- mediawiki --->
					<a 	href="javascript:void(0)"
						data-format="trac"
						:data-link="globalData.url.exportWiki"
						class="btn btn-primary btnExportFormat"
						data-toggle="tooltip"
					    title="Export as MediaWiki">
						<i class="fa fa-lg fa-file-code-o"></i>
					</a>
					<!--- trac --->
					<a 	href="javascript:void(0)"
						data-format="trac"
						:data-link="globalData.url.exportTrac"
						class="btn btn-primary btnExportFormat"
						data-toggle="tooltip"
					    title="Export as TracMarkup">
						<i class="fa fa-lg fa-paw"></i>
					</a>
				</p>
	        </div>
	    </div>

	    <div class="panel panel-default">
	        <div class="panel-heading">
	            <h3 class="panel-title">Need Help?</h3>
	        </div>
	        <div class="panel-body">
	        	<div class="text-center">
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
	</div>
</template>
<script>
import ApiSelectors from "@/components/layout/api-selectors";
import { mapState } from "vuex";
export default {
	components : {
		ApiSelectors
	},
	computed : {
		...mapState({
			availableAPIs : state => state.availableAPIs
		})
	}
}
</script>