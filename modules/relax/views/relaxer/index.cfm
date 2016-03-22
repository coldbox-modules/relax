<cfoutput>
<div class="row">
	
	<div class="col-md-9">
		<!--- MessageBox --->
		<cfif flash.exists( "notice" )>
			<div class="alert alert-info"><i class="fa fa-bell"></i> #flash.get( "notice" )#</div>
		</cfif>
		<h2>Relaxer API Test Tool</h2>
		<div class="relaxer">
			<div class="relaxer-form"></div>
			<div class="relaxer-results"></div>
		</div>

		<!--- Loader --->
		

		<!--- results --->
		<cfif structKeyExists( prc, "results" )>
			
		</cfif>
		<!--- end Results Box --->

	</div> <!-- /.main-content -->

		#renderView( "includes/relaxer-sidebar" )#

</div> <!--- end row --->

</cfoutput>

<!--- Fields Template --->
<script type="text/template" id="dynamicFieldsTemplate">
	<div class="dynamicField">
		<div class="col-xs-12 clearfix">
			<div class="col-xs-12 col-sm-1 col-xs-1 pull-right" style="vertical-align:middle">
				<button class="pull-right btn btn-danger btn-xs dynamicRemove" onclick="return false;"><i class="fa fa-remove"></i></button>
			</div>
			<div class="col-xs-12 col-sm-5 col-md-4 input-group pull-left">
				<span class="input-group-addon" id="sizing-addon1">Name:</span> 
				<input type="text" data-title="<%=fieldType%> name"  name="<%=fieldType%>Name"  class="form-control" size="30" placeholder="name..." value="<%=field.name%>" />
			</div>
			<div class="col-xs-12 col-sm-6 col-md-7 input-group pull-right">
				<span class="input-group-addon" id="sizing-addon1">Value:</span> 
				<input type="text" data-title="<%=fieldType%> value" name="<%=fieldType%>Value" class="form-control" size="50" placeholder="value..." value="<%=field.value%>"/>
			</div>
		</div>
	</div>
</script>