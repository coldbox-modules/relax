<cfoutput>
	<!--- Sidebar --->
	<div class="col-md-3 mc-sidebar">
		<div class="panel panel-default api-selector">
	        <div class="panel-body">
	        	<p class="text-center">
	        		Loading Available APIs... <br>
	        		<i class="fa fa-spin fa-spinner"></i>
	        	</p>
	        </div>
	    </div>

	    <div class="panel panel-default">
	        <div class="panel-heading">
	            <h3 class="panel-title">API Export<cfif prc.settings.sessionsEnabled>/Import</cfif></h3>
	        </div>
	        <div class="panel-body">
	        	You can export your Relaxed Service API to JSON<cfif prc.settings.sessionsEnabled> and also import one</cfif>.<br/><br/>

				<p class="text-center">
					<!--- Export --->
					<a href="javascript:void(0)"
						data-link="#event.buildLink( prc.xehExportAPI )#"
						class="btn btn-primary btnExportJSON"
					   	title="Export API">
							<i class="fa fa-lg fa-cloud-download"></i> Export
					</a>

					<cfif prc.settings.sessionsEnabled>
						<!--- Import --->
						<a href="javascript:void(0)"
							data-toggle="tooltip"
							class="btn btn-primary btnImportAPI"
						   	title="Import API">
								<i class="fa fa-lg fa-cloud-upload"></i> Import
						</a>
					</cfif>
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
						data-link="#event.buildLink( prc.xehExportHTML )#"
						class="btn btn-primary btnExportFormat"
						data-toggle="tooltip"
					   	title="Export as HTML">
						<i class="fa fa-lg fa-html5"></i>
					</a>
					<!--- pdf --->
					<a 	href="javascript:void(0)"
						data-format="pdf"
						data-link="#event.buildLink( prc.xehExportPDF )#"
						class="btn btn-primary btnExportFormat"
						data-toggle="tooltip"
						title="Export as PDF">
						<i class="fa fa-lg fa-file-pdf"></i>
					</a>
					<!--- mediawiki --->
					<a 	href="javascript:void(0)"
						data-format="trac"
						data-link="#event.buildLink( prc.xehExportWiki )#"
						class="btn btn-primary btnExportFormat"
						data-toggle="tooltip"
					    title="Export as MediaWiki">
						<i class="fa fa-lg fa-file-code"></i>
					</a>
					<!--- trac --->
					<a 	href="javascript:void(0)"
						data-format="trac"
						data-link="#event.buildLink( prc.xehExportTrac )#"
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
						<img src="#prc.root#/includes/images/ortus-top-logo.png" alt="Ortus Solutions" border="0" class="img-thumbnail"/>
					</a>
				</div>

				<p>&nbsp;</p>

				<p><strong>Ortus Solutions</strong> is the company behind anything ColdBox. Need professional support, architecture analysis,
				code reviews, custom development or anything ColdFusion, ColdBox related?
				<a href="mailto:help@ortussolutions.com">Contact us</a>, we are here
				to help!</p>
	        </div>
	    </div>

	</div> <!--- end sidebar column --->

	<script type="text/template" id="api-selector-template">
		<cfinclude template="#prc.root#/views/apidoc/_template/api-selector.html"/>
	</script>
	<script type="text/template" id="api-import-form-template">
		<cfinclude template="#prc.root#/views/apidoc/_template/api-import-form.html"/>
	</script>
</cfoutput>