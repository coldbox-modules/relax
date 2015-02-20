<cfoutput>
<div class="row">
	<div class="col-md-9">
		<h1>
			<i class="fa fa-beer"></i>
			Welcome To Relax
		</h1>

		<!--- MessageBox --->
		<cfif flash.exists( "notice" )>
			<div>#flash.get( "notice" )#</div>
		</cfif>

		<!--- Body --->
		<p>We have succesfully loaded the <em>Relax DSL</em> for your loaded API: <code>#prc.loadedAPIName#</code>.
		</p>

		<div class="panel panel-default">
            <div class="panel-body">
                <div class="tab-wrapper tab-primary">
                    <ul class="nav nav-tabs">
                        <li class="active"><a href="##overview" data-toggle="tab">Service Overview</a></li>
						<li><a href="##httpcodes" data-toggle="tab">HTTP Codes</a></li>
						<li><a href="##routes" data-toggle="tab">Generated Routes</a></li>
                    </ul>
                    <div class="tab-content">
                        <div class="tab-pane active" id="overview">
                        	#renderView( view="home/docs/serviceOverview" , module="relax", prePostExempt=true )#
                        	#renderView( view="home/docs/resourceDefinitions" , module="relax", prePostExempt=true )#
                        </div>
                        <div class="tab-pane" id="httpcodes">#renderView( view="home/docs/httpcodes" , module="relax", prePostExempt=true )#</div>
                        <div class="tab-pane" id="routes">#renderView( view="home/docs/generatedRoutes" , module="relax", prePostExempt=true )#</div>
                    </div>
                </div>
            </div>
        </div>
		
	</div> <!--- end main content column --->

	<!--- Sidebar --->
	<div class="col-md-3">
		<div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">Loaded Relaxed APIs</h3>
            </div>
            <div class="panel-body">
            	From here you can switch to another Relaxed API in your <strong>resources</strong> folder:<br/>

				<p class="text-center">
					<br>
					<!--- My Apis --->
					<select name="myAPI" id="myAPI" title="Your defined Relaxed APIs" onchange="window.location='#event.buildLink( prc.xehLoadAPI )#?apiName=' + this.value" class="form-control">
						<cfloop query="prc.loadedAPIs">
							<cfif prc.loadedAPIs.type eq "Dir">
							<option value="#prc.loadedAPis.name#" <cfif prc.loadedAPIs.name eq prc.loadedAPIName>selected="selected"</cfif>>#prc.loadedAPis.name#</option>
							</cfif>
						</cfloop>
					</select>
				</p>
            </div>
        </div>

        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">API Export/Import</h3>
            </div>
            <div class="panel-body">
            	You can export your Relaxed Service API to JSON and also import one.<br/><br/>

				<p class="text-center">
					<!--- Export --->
					<a href="#event.buildLink( prc.xehExportAPI )#"
						data-toggle="modal" 
						data-target="##modal"
						class="btn btn-primary"
					   	title="Export API">
							<i class="fa fa-lg fa-cloud-download"></i> Export
					</a>
					<!--- Import --->
					<a href="#event.buildLink( prc.xehImportAPI)#"
						data-toggle="modal" 
						data-target="##modal"
						class="btn btn-primary"
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
				<!--- Export COmmands --->
				<p class="text-center">
					<!--- html --->
					<a href="#event.buildLink( prc.xehExportHTML)#"
						target="_blank"
						class="btn btn-primary"
					   	title="Export as HTML">
						<i class="fa fa-lg fa-html5"></i>
					</a>
					<!--- pdf --->
					<a href="#event.buildLink( prc.xehExportPDF)#" class="btn btn-primary"
					    target="_blank"
						title="Export as PDF">
						<i class="fa fa-lg fa-file-pdf-o"></i>
					</a>
					<!--- mediawiki --->
					<a href="#event.buildLink( prc.xehExportwiki)#" class="btn btn-primary"
					    target="_blank"
						title="Export as MediaWiki">
						<i class="fa fa-lg fa-file-code-o"></i>
					</a>
					<!--- trac --->
					<a href="#event.buildLink( prc.xehExporttrac)#" class="btn btn-primary"
					    target="_blank"
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
</div> <!--- end row --->
</cfoutput>