<!--- ============================ Remote Modal Window ============================ --->
<div id="modal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" id="modal-dialog">
        <div class="modal-content" id="remoteModelContent">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h3>Loading...</h3>
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
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h3>Loading...</h3>
        </div>
        <div class="modal-body">
            <i class="fa fa-spinner fa-spin fa-lg fa-4x"></i>
        </div>
    </div>
</script>

<!-- Underscore Template Objects -->
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
<script type="text/template" id="security-definitions-template">
    <cfinclude template="#prc.root#/views/apidoc/_template/security-definitions.html"/>
</script>
<script type="text/template" id="relaxer-form-template">
    <cfinclude template="#prc.root#/views/apidoc/_template/relaxer-form.html"/>
</script>
<script type="text/template" id="relaxer-response-template">
    <cfinclude template="#prc.root#/views/apidoc/_template/relaxer-response.html"/>
</script>
<script type="text/template" id="x-attributes-template">
    <cfinclude template="#prc.root#/views/apidoc/_template/x-attributes.html"/>
</script>

<!-- dynamic assets -->
<cfoutput>
    <!-- RJS Runtime -->
    <script src="#prc.root#/includes/js/require.js" type="application/javascript"></script>
    <script type="application/javascript">
        require(['#prc.root#/includes/js/es6-shim.js'],function(){
            require(['#prc.root#/includes/js/globals.js'],function(globals){
                require.config( {
                   baseUrl : '#prc.root#/includes/js/',
                } );
                window[ "_" ] = _;
                window[ "relax" ] = {
                    baseUrl:"#prc.root#/",
                    apiDocBaseUrl:"#prc.root#/apidoc"
                }
                require(
                    [
                        '#prc.root#/includes/js/jsonlint.js',
                        '#prc.root#/includes/js/app.js',
                        '#prc.root#/includes/js/prism.js',
                        '#prc.root#/includes/js/udf.js'
                    ]
                ,function(){
                    <!--- loop around the jsAppendList, to add page specific js --->
                    <cfloop array="#event.getPrivateValue("runtimeAssets",arrayNew( 1 )).js#" index="js">
                        require(['#js#']);
                    </cfloop>    
                });
            });
        });
    </script>

</cfoutput>


<!-- Fonts -->
<link href='//fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,900,300italic,400italic,600italic,700italic,900italic' rel='stylesheet' type='text/css'>
<link href='//fonts.googleapis.com/css?family=Open+Sans:400,700' rel='stylesheet' type='text/css'>

