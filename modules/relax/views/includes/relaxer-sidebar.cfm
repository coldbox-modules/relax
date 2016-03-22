<!--- Sidebar --->
<div class="col-md-3 mc-sidebar relaxer-sidebar">
	<div class="panel panel-default">

		<div class="panel panel-primary api-selector">
	        <div class="panel-body">
	        	<p class="text-center">
	        		Loading Available APIs... <br>
	        		<i class="fa fa-spin fa-spinner"></i>
	        	</p>
	        </div>
	    </div>

	    <div class="panel panel-default relaxer-resources"></div>

	    <div class="panel panel-default relaxer-history"></div>

</div> <!--- end sidebar --->


<script type="text/template" id="api-selector-template">
	<cfinclude template="#prc.root#/views/apidoc/_template/api-selector.html"/>
</script>
<script type="text/template" id="relaxer-resources-template">
    <cfinclude template="#prc.root#/views/apidoc/_template/relaxer-resources.html"/>
</script>
<script type="text/template" id="relaxer-history-template">
    <cfinclude template="#prc.root#/views/apidoc/_template/relaxer-history.html"/>
</script>