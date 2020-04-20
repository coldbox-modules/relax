<!--- ============================ Remote Modal Window ============================ --->
<div id="modal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" id="modal-dialog">
        <div class="modal-content" id="remoteModelContent">
            <div class="modal-header">
                <h3>Loading...</h3>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
                <i class="fa fa-spinner fa-spin fa-lg fa-4x"></i>
            </div>
        </div>
    </div>
</div>
<!--- Modal Template --->
<script type="text/html" id="modal-template">
    <div class="modal-content" id="remoteModelContent">
        <div class="modal-header">
            <h3>Loading...</h3>
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        </div>
        <div class="modal-body">
            <i class="fa fa-spinner fa-spin fa-lg fa-4x"></i>
        </div>
    </div>
</script>

<!-- dynamic assets -->
<cfoutput>
	<script>
		window.relaxGlobalData = #serializeJSON( prc.relaxGlobalData, false, listFindNoCase( "Lucee", server.coldfusion.productname ) ? "utf-8" : false )#
	</script>
	<script type="application/javascript" src="#relaxElixirPath( "js/runtime.js" )#"></script>
	<script type="application/javascript" src="#relaxElixirPath( "js/vendor.js" )#"></script>
	<script type="application/javascript" src="#relaxElixirPath( "js/app.js" )#"></script>
</cfoutput>

<!-- Fonts -->
<link href='//fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,900,300italic,400italic,600italic,700italic,900italic' rel='stylesheet' type='text/css'>
<link href='//fonts.googleapis.com/css?family=Open+Sans:400,700' rel='stylesheet' type='text/css'>