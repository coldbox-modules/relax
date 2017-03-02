<cfscript>
    HTTPMethodKeys = [ 'get', 'put', 'post', 'patch', 'delete', 'options', 'head' ];
</cfscript>
<cfoutput>
    <div id="#args.path[ "x-resourceId" ]#" class="path-panel panel panel-primary">
        
        <!--- Path Title --->
        <div class="panel-heading">
            <h3 class="panel-title pathHeader">
                #args.key#
            </h3>
        </div>

        <!--- Div Content --->
        <div id="panel_#args.path[ "x-resourceId" ]#" class="panel-body">

            #renderView( 
                view = 'apidoc/cfTemplate/x-attributes', 
                args = { "entity" : args.path, "headerNode" : "h4" } 
            )#

            <h4 class="panel-subtitle text-muted">Methods:</h4>
            <div class="col-xs-12">

                <cfloop array="#HTTPMethodKeys#" index="httpMethod">
                    <cfif structKeyExists( args.path, httpMethod )>
                        #renderView( 
                            view = 'apidoc/cfTemplate/api-method', 
                            args = { 
                                key     : ucase( httpMethod ), 
                                api     : args.api, 
                                method  : args.path[ httpMethod ] 
                            } 
                        )#
                    </cfif>
                </cfloop>

            </div>

        </div>
    </div>
</cfoutput>