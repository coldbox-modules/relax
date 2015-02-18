<cfoutput>
<div class="row">
	<div class="col-md-9">
		<div class="header" id="relaxerHeader">
			<img src="#prc.root#/includes/images/sofa.png" alt="Database" width="30" height="30" title="Go Relax!" />
			Welcome To Relax
		</div>
		<!--- Body --->
		<div class="body">
			<!--- MessageBox --->
			<cfif flash.exists( "notice" )>
				<div>#flash.get( "notice" )#</div>
			</cfif>
			<!--- Body --->
			<p>Welcome to your Relax Console.  We have succesfully read the <em>Relax DSL</em>
				for your loaded API: <strong>#prc.loadedAPIName#</strong>.  Below is the RESTful
				documentation.  From here you can also tap into our <strong>RelaxURL</strong> console to test the resources or any web
				RESTful service or view our awesome <strong>RelaxLogs</strong> log viewer.
			</p>
		</div>
		<div class="body_vertical_nav clearfix">
			<!--- Documentation Navigation Bar --->
			<ul class="vertical_nav">
				<li class="active"><a href="##overview">Service Overview</a></li>
				<li><a href="##resources">Defined Resources</a></li>
				<li><a href="##httpcodes">HTTP Codes</a></li>
				<li><a href="##routes">Generated Routes</a></li>
			</ul>
			<!--- Documentation Panes --->
			<div class="main_column">
				<!-- Content area that wil show the form and stuff -->
				<div class="panes_vertical">
					<!--- OverView Panel --->
					<div>
						#renderView(view="home/docs/serviceOverview",prePostExempt=true)#
					</div>
					<!--- Resources Panel --->
					<div>
						#renderView(view="home/docs/resourceDefinitions",prePostExempt=true)#
					</div>
					<!--- HTTP Codes Panel --->
					<div>
						#renderView(view="home/docs/httpcodes",prePostExempt=true)#
					</div>
					<!--- Generated Routes --->
					<div>
						#renderView(view="home/docs/generatedRoutes",prePostExempt=true)#
					</div>
				</div>
			</div>

		</div>
	</div>

	<!--- Sidebar --->
	<div class="col-md-3">
		<div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">Loaded Relaxed APIs</h3>
            </div>
            <div class="panel-body">
            	From here you can switch to another Relaxed API in your <strong>resources</strong> folder:<br/>

				<p class="center">
					<!--- My Apis --->
					<select name="myAPI" id="myAPI" title="Your defined Relaxed APIs" onchange="window.location='#event.buildLink( prc.xehLoadAPI )#?apiName=' + this.value">
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

				<p class="center">
					<!--- Export --->
					<a href="javascript:openRemoteModal('#event.buildLink( prc.xehExportAPI)#')"
						class="button"
					   	title="Export API">
						<span>
							<img src="#prc.root#/includes/images/export_16.png" alt="export"/> Export
						</span>
					</a>
					<!--- Import --->
					<a href="javascript:openRemoteModal('#event.buildLink( prc.xehImportAPI)#')"
						class="button"
					   	title="Import API">
						<span>
							<img src="#prc.root#/includes/images/import_16.png" alt="import"/> Import
						</span>
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
				<p class="center">
					<!--- html --->
					<a href="#event.buildLink( prc.xehExportHTML)#"
						target="_blank"
						class="button"
					   	title="Export as HTML">
						<span>
							<img src="#prc.root#/includes/images/html.png" border="0" align="absmiddle" alt="html" />
						</span>
					</a>
					<!--- pdf --->
					<a href="#event.buildLink( prc.xehExportPDF)#" class="button"
					    target="_blank"
						title="Export as PDF">
						<span>
							<img src="#prc.root#/includes/images/pdf.png" border="0" align="absmiddle" alt="html" />
						</span>
					</a>
					<!--- mediawiki --->
					<a href="#event.buildLink( prc.xehExportwiki)#" class="button"
					    target="_blank"
						title="Export as MediaWiki">
						<span>
							<img src="#prc.root#/includes/images/wikipedia.png" border="0" align="absmiddle" alt="html" />
						</span>
					</a>
					<!--- trac --->
					<a href="#event.buildLink( prc.xehExporttrac)#" class="button"
					    target="_blank"
						title="Export as TracMarkup">
						<span>
							<img src="#prc.root#/includes/images/trac.png" border="0" align="absmiddle" alt="html" />
						</span>
					</a>
				</p>
            </div>
        </div>

        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">Need Help?</h3>
            </div>
            <div class="panel-body">
            	<a href="http://www.ortussolutions.com" target="_blank" title="The Gurus behind ColdBox">
				<img src="#prc.root#/includes/images/ortus-top-logo.png" alt="Ortus Solutions" border="0" /></a><br/>

				<p><strong>Ortus Solutions</strong> is the company behind anything ColdBox. Need professional support, architecture analysis,
				code reviews, custom development or anything ColdFusion, ColdBox related?
				<a href="mailto:help@ortussolutions.com">Contact us</a>, we are here
				to help!</p>
            </div>
        </div>

	</div> <!--- end sidebar column --->
</div> <!--- end row --->
</cfoutput>