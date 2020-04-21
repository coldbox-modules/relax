<cfoutput>
	<!-- MessageBox -->
	<div id="system-messages">
		<cfif flash.exists( "notice" )>
			<div class="alert alert-info"><i class="fa fa-bell"></i> #flash.get( "notice" )#</div>
		</cfif>
	</div>

	<div id="app">
		<relaxer></relaxer>
	</div>
</cfoutput>
