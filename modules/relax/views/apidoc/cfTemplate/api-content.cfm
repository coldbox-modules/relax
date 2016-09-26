<div class="panel panel-default">
    <div id="api-content-tabs" class="panel-body">
        <div class="tab-wrapper tab-primary">
            <ul class="nav nav-tabs">
                <li class="active"><a href="#overview" data-toggle="tab" aria-controls="overview">Service Overview</a></li>
                <li><a href="#paths" data-toggle="tab" aria-controls="paths">API Path Reference</a></li>
                <li><a href="#httpcodes" data-toggle="tab" aria-controls="httpcodes">HTTP Response Reference</a></li>
            </ul>
            <h2 class="text-primary">API Service Overview:</h2>
            <div class="tab-content">
                <div id="overview" class="tab-pane active service-summary">
                    <!--- Service Title and Description --->
                    <h2>#api.info.title#</h2>
                    
                    <cfif structKeyExists( api.info, "version") && len(api.version.info)>
                        <h4>Version: <span class="label label-primary">#api.info.version#</span></h4>
                    </cfif>
                    <dl>
                        <dt class="text-info">Introduction:</dt>
                        <dd>#toParagraphFormat( api.info.description )#</dd>
                        <cfif structKeyExists( api.info, "contact" ) && !structIsEmpty( api.info.contact )>
                                <dt class="text-info">Contact:</dt>
                                <dd class="address">
                                    <ul>
                                    <cfloop collection="#api.info.contact#" item="contactKey">
                                        
                                        <li class="list-unstyled">
                                            <strong>#contactKey.toProperCase()#:</strong> 
                                            
                                            <cfif findNoCase( "http", api.info.contact[ contactKey ] )>    
                                                <a href="#api.info.contact[ contactKey ]#" target="_blank">
                                            </cfif>

                                                #api.info.contact[ contactKey ]#
                                            
                                            <cfif findNoCase( "http", api.info.contact[ contactKey ] )>
                                                </a>
                                            </cfif>
                                        </li>

                                    </cfloop>
                                    
                                    </ul>
                                </dd>
                        </cfif>
                        <cfif structKeyExists( api.info, 'license' ) && structKeyExists( api.info.license, "url" )>
                            <dt class="text-info">License: 
                                <a href="#api.info.license.url#">
                                    <cfif structKeyExists( api.info.license, "name" ) && len( api.info.license.name )>
                                        #api.info.license.name#
                                    <cfelse>
                                        #api.info.license.url#
                                    </cfif>
                                    <i class="fa fa-link"></i>
                                </a>
                            </dt>
                        </cfif>
                        <cfif structKeyExists( api.info,"termsOfService" ) && len( api.info.termsOfService ) >
                            <cfif findNoCase( "http", api.info.termsOfService )>
                                <dt class="text-info">
                                    Terms of Service: <a href="#api.info.termsOfService#">#api.info.termsOfService#</a>
                                </dt>
                            <cfelse>
                                <dd>
                                    #toParagraphFormat( api.info.termsOfService )#
                                </dd>
                            </cfif>
                        </cfif>

                        <cfif structKeyExists( api, "externalDocs" ) && structKeyExists( api.externalDocs, "url" )>
                            <dt class="text-info">External Docs: 
                                <a href="#api.externalDocs.url#">
                                    #( ( structKeyExists( api.externalDocs, "description" ) && len( api.externalDocs.description ) ) ? api.externalDocs.description : api.externalDocs.url )#
                                    <i class="fa fa-globe"></i>
                                </a>
                            </dt>
                        </cfif>

                    </dl>

                    <h3>Service Entry Points</h3>
                    <ul class="list-unstyled">
                        <li>
                            <em>Default:</em> 
                            <a href="#( structKeyExists( api, "scheme" ) ? api.scheme  & '://' : '//' )#api.host#">
                                #( structKeyExists( api, "scheme" ) ? api.scheme & '://' : "//" )##api.host#
                            </a>
                        </li>
                        <cfif structkeyExists( api, "x-entryPoint" )>
                            <cfloop collection="#api['x-entryPoint']#" item="tierName">
                                <li><em>#titleCase( tierName )#:</em> <a href="#api[ "x-entryPoint" ][ tierName ]#">#api[ "x-entryPoint" ][ tierName ]#</a></li>
                            </cfloop>
                        </cfif>
                        
                    </ul>

                    <!--- Paths --->
                    <h3>Service Available Paths</h3>

                   <p>

                    <cfloop collection="#api.paths#" item="key">
                        <a class="btn btn-xs btn-primary path-nav" href="###api.paths[ key ][ "x-resourceId" ]#">
                            #key#
                        </a>
                    </cfloop>
                    
                    </p>

                    <h3>MIME Types Consumed</h3>
                    
                    <p>
                        <cfloop array="#api.consumes#" index="type">
                            <span class="label label-primary consumes-nav" data-mimetype="type">#type#</span>
                        </cfloop>
                    </p>

                    <!--- API Return Formats --->
                    <h3>MIME Types Returned</h3>
                    <p>
                        <cfloop array="#api.produces#" index="type">
                            <span class="label label-primary consumes-nav" data-mimetype="type">#type#</span>
                        </cfloop>
                    </p>

                    <cfif structKeyExists( api, "x-extensionDetection" )>
                        <h3>Extension Detection:  <code>#api[ "x-extensionDetection"]#</code></h3>
                    </cfif> 

                    <cfif structKeyExists( api, "x-throwOnInvalidExtension" )>
                        <h3>Throws on Invalid Extension:  <code>#api[ "x-throwOnInvalidExtension"]#</code></h3>
                    </cfif>

                    <cfif structKeyExists( api, "securityDefinitions" )>
                        <!-- Security Definitions -->
                        <h3>Security Definitions</h3>
                        <table class="definition-list list-group">
                            <tr class="bg-primary">
                                <th class="definition-column key">
                                    Name
                                </th>

                                <th class="definition column type">
                                    Type
                                </th>

                                <th class="definition column description">
                                    Description
                                </th>
                            </tr>
                                <cfloop collection="#api['securityDefinitions']#" item="definitionKey">
                                    <cfset definition = api[ 'securityDefinitions' ][ definitionKey ]>
                                    <cfset definitionUid = createUUID()>
                                    <tr class="list-group-item definition optional">

                                        <td class="definition-column key">
                                            <code>#structKeyExists( definition, "name" ) ? definition.name : definitionKey#</code>
                                        </td>

                                        <td class="definition column type">
                                            <cfif structKeyExists( definition, "type" )>
                                                <code># definition.type #</code>
                                            <cfelse>
                                                N/A
                                            </cfif>
                                        </td>

                                        <td class="definition column description">
                                            <cfif definition.type == 'oauth2'>
                                                <a href="###definitionUid#" class="pull-right" data-toggle="collapse" aria-expanded="false" aria-controls="#definitionUid#">
                                                    <small><i class="fa fa-chevron-down"></i></small>
                                                </a>
                                            </cfif>

                                            <cfif structKeyExists( definition, "in" )>
                                                <p>Provided in the <code>#definition.in#</code> of the request</p>
                                            </cfif>
                                            <cfif structKeyExists( definition, 'description' )>
                                                <p>#toParagraphFormat( definition.description )#</p>
                                            <cfelse>
                                                <p>Definition description unavailable.</p>
                                            </cfif>                                            
                                        </div>

                                        <cfif definition.type == 'oauth2'>
                                            <div class="clearfix"></div>
                                            <div id="#definitionUid#" class="collapse panel panel-solid-default">
                                                <p>
                                                    
                                                    <strong>Authorization URL:</strong> 
                                                    <a href="#definition.authorizationUrl#">#definition.authorizationUrl#</a>
                                                    <br>
                                                    
                                                    <cfif structKeyExists( definition, 'tokenUrl' )>
                                                        strong>Token URL</strong> <a href="#definition.tokenUrl#">#definition.tokenUrl#</a><br>
                                                    </cfif>
                                                    
                                                    <strong>OAuth Flow</strong> <code>#definition.flow#</code><br>

                                                </p>
                                                <strong>Scopes:</strong><br>
                                                <pre class="language-json">#serializeJSON(definition.scopes)#</pre>
                                            </div>
                                            
                                        </cfif>

                                    </div>
                                </cfloop>
                            </div>                    
                    </cfif>

                    <cfif structKeyExists( api, 'parameter' )>
                        <!--- API Global Parameters --->
                        <h3>Global Parameters</h3>
                        #paramTemplate( { "entity":api } )#
                    </cfif>

                    #renderView( view='apidoc/cfTemplate/x-attributes', args=api )#
                    
                    <div class="clearfix"></div>

                </div>
                <div class="tab-pane hidden-print" id="httpcodes">
                    #responseCodeTemplate()#
                </div>

                <% if( $( "body" ).hasClass( "print" ) ){#
                    <h2 class="text-primary">API Path Reference:</h2>
                <% }#

                <div id="paths" class="tab-pane paths-content">
                    <h3>Available Paths:</h3>
                </div>

            </div>
        </div>
    </div>
</div>