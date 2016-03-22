<!--- ============================ Remote Modal Window ============================ --->
    <div id="modal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog" id="modal-dialog">
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

    <!-- dynamic assets -->
    <cfoutput>

        <!-- Highlighter -->
        <link type="text/css" rel="stylesheet" href="#prc.root#/includes/plugins/highlighter/styles/shCoreMidnight.css">
        <script src="#prc.root#/includes/plugins/highlighter/scripts/shCore.js"></script>
        <script src="#prc.root#/includes/plugins/highlighter/scripts/shBrushColdFusion.js"></script>
        <script src="#prc.root#/includes/plugins/highlighter/scripts/shBrushXml.js"></script>
        <script src="#prc.root#/includes/plugins/highlighter/scripts/shBrushSql.js"></script>
        <script src="#prc.root#/includes/plugins/highlighter/scripts/shBrushJScript.js"></script>
        <script src="#prc.root#/includes/plugins/highlighter/scripts/shBrushJava.js"></script>
        <script src="#prc.root#/includes/plugins/highlighter/scripts/shBrushCss.js"></script>
        <!-- RJS Runtime -->
        <script src="#prc.root#/includes/js/require.js" type="application/javascript"></script>
        <script type="application/javascript">
            require(['#prc.root#/includes/js/es6-shim.js'],function(){
                require(['#prc.root#/includes/js/globals.js'],function(globals){
                    require(['#prc.root#/includes/js/app.js']);
                    require(['#prc.root#/includes/js/jsonlint.js'],function(){
                        require(['#prc.root#/includes/js/udf.js']);    
                    });
                    <!--- loop around the jsAppendList, to add page specific js --->
                    <cfloop array="#event.getPrivateValue("runtimeAssets",[]).js#" index="js">
                        require(['#js#']);
                    </cfloop>

                    $(document).ready(function() {
                        
                    });
            
                });
            });
        </script>

    </cfoutput>