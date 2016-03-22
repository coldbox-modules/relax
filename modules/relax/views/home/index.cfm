<cfoutput>
	<div id="main-content" class="row">
		<div class="col-md-9">
			<!-- MessageBox -->
			<div id="system-messages">
				<cfif flash.exists( "notice" )>
					<div class="alert alert-info"><i class="fa fa-bell"></i> #flash.get( "notice" )#</div>
				</cfif>
			</div>

			<div class="api-content">
				<div id="mc-loader" class="text-center">
					<h4 class="text-muted">Get ready to kick back and... <em>Relax</em>!</h4>
					<p>
						<i class="fa fa-spin fa-spinner fa-2x text-muted"></i>
					</p>
				</div>
			</div>
			
		</div> <!-- end .main-content -->

		#renderView( "includes/sidebar" )#

	</div> <!-- end .row -->

	<script type="text/template" id="api-content-template">
		<cfinclude template="#prc.root#/views/apidoc/_template/api-content.html"/>
	</script>
	<script type="text/template" id="path-template">
		<cfinclude template="#prc.root#/views/apidoc/_template/path.html"/>
	</script>
	<script type="text/template" id="method-template">
		<cfinclude template="#prc.root#/views/apidoc/_template/method.html"/>
	</script>
	<script type="text/template" id="response-template">
		<cfinclude template="#prc.root#/views/apidoc/_template/response.html"/>
	</script>
	<script type="text/template" id="httpcodes-template">
		<cfinclude template="#prc.root#/views/apidoc/_template/httpcodes.html"/>
	</script>
	<script type="text/template" id="response-code-template">
		<cfinclude template="#prc.root#/views/apidoc/_template/httpcodes.html"/>
	</script>
	<script type="text/template" id="parameter-template">
		<cfinclude template="#prc.root#/views/apidoc/_template/parameter.html"/>
	</script>
	<script type="text/template" id="example-template">
		<cfinclude template="#prc.root#/views/apidoc/_template/example.html"/>
	</script>
	<script type="text/template" id="schema-template">
		<cfinclude template="#prc.root#/views/apidoc/_template/schema.html"/>
	</script>
</cfoutput>
