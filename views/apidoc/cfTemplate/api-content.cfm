<cfscript>
    api = args.api;
</cfscript>
<cfoutput>
    <div>
        <div id="overview" class="active service-summary">
            <!--- Service Title and Description --->
            <h2>#api[ "info" ][ "title" ]#</h2>
            <cfif structKeyExists( api[ "info" ], "version") && len(api[ "info" ][ "version" ])>
                <h4>Version: <span class="label label-primary">#api[ "info" ][ "version" ]#</span></h4>
            </cfif>
            <dl>
                <dt class="text-info">Introduction:</dt>
                <dd>#toParagraphFormat( api[ "info" ][ "description" ] )#</dd>
                <cfif structKeyExists( api[ "info" ], "contact" ) && !structIsEmpty( api[ "info" ][ "contact" ] )>
                        <dt class="text-info">Contact:</dt>
                        <dd class="address">
                            <ul>
                            <cfloop collection="#api[ "info" ][ "contact" ]#" item="contactKey">
                                <li class="list-unstyled">
                                    <strong>#titleCase( contactKey )#:</strong>

                                    <cfif findNoCase( "http", api[ "info" ][ "contact" ][ contactKey ] )>
                                        <a href="#api[ "info" ][ "contact" ][ contactKey ]#" target="_blank">
                                    </cfif>

                                        #api[ "info" ][ "contact" ][ contactKey ]#

                                    <cfif findNoCase( "http", api[ "info" ][ "contact" ][ contactKey ] )>
                                        </a>
                                    </cfif>
                                </li>

                            </cfloop>

                            </ul>
                        </dd>
                </cfif>
                <cfif structKeyExists( api[ "info" ], 'license' ) && structKeyExists( api[ "info" ][ "license" ], "url" )>
                    <dt class="text-info">License:
                        <a href="#api[ "info" ][ "license" ].url#">
                            <cfif structKeyExists( api[ "info" ][ "license" ], "name" ) && len( api[ "info" ][ "license" ].name )>
                                #api[ "info" ][ "license" ].name#
                            <cfelse>
                                #api[ "info" ][ "license" ].url#
                            </cfif>
                            <i class="fa fa-link"></i>
                        </a>
                    </dt>
                </cfif>
                <cfif structKeyExists( api[ "info" ],"termsOfService" ) && len( api[ "info" ][ "termsOfService" ] ) >
                    <cfif findNoCase( "http", api[ "info" ][ "termsOfService" ] )>
                        <dt class="text-info">
                            Terms of Service: <a href="#api[ "info" ][ "termsOfService" ]#">#api[ "info" ][ "termsOfService" ]#</a>
                        </dt>
                    <cfelse>
                        <dd>
                            #toParagraphFormat( api[ "info" ][ "termsOfService" ] )#
                        </dd>
                    </cfif>
                </cfif>

                <cfif structKeyExists( api, "externalDocs" ) && structKeyExists( api[ "externalDocs" ], "url" )>
                    <dt class="text-info">External Docs:
                        <a href="#api[ "externalDocs" ][ "url" ]#">
                            #( ( structKeyExists( api[ "externalDocs" ], "description" ) && len( api[ "externalDocs" ][ "description" ] ) ) ? api[ "externalDocs" ][ "description" ] : api[ "externalDocs" ][ "url" ] )#
                            <i class="fa fa-globe"></i>
                        </a>
                    </dt>
                </cfif>

            </dl>

			<cfdump var="#api#"><cfabort>
            <h3>Service Entry Points</h3>
            <ul class="list-unstyled">
                <li>
                    <em>Default:</em>
                    <a href="#( structKeyExists( api, "scheme" ) ? api[ "scheme" ]  & '://' : '//' )##api[ "host" ]#">
                        #( structKeyExists( api, "scheme" ) ? api[ "scheme" ] & '://' : "//" )##api[ "host" ]#
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

           <ul>

            <cfloop collection="#api[ "paths" ]#" item="key">
                <li><code><a class="path-nav" href="###api[ "paths" ][ key ][ "x-resourceId" ]#">#key#</a></code></li>
            </cfloop>

            </ul>

            <h3>MIME Types Consumed</h3>

            <ul>
                <cfloop array="#api[ "consumes" ]#" index="type">
                    <li>
                        <code><span class="consumes-nav" data-mimetype="type">#type#</span></code>
                    </li>
                </cfloop>
            </ul>

            <!--- API Return Formats --->
            <h3>MIME Types Returned</h3>
            <ul>
                <cfloop array="#api[ "produces" ]#" index="type">
                    <li>
                        <code><span class="consumes-nav" data-mimetype="type">#type#</span></code>
                    </li>
                </cfloop>
            </ul>

            <cfif structKeyExists( api, "x-extensionDetection" )>
                <h3>Extension Detection:  <code>#api[ "x-extensionDetection" ]#</code></h3>
            </cfif>

            <cfif structKeyExists( api, "x-throwOnInvalidExtension" )>
                <h3>Throws on Invalid Extension:  <code>#api[ "x-throwOnInvalidExtension" ]#</code></h3>
            </cfif>

            <cfif structKeyExists( api, "securityDefinitions" )>
                <!-- Security Definitions -->
                <h3>Security Definitions</h3>
                <table class="definition-list table table-striped">
                    <tr class="text-muted">
                        <th class="definition-column key" style="text-align:left">
                            Name
                        </th>

                        <th class="definition column type" style="text-align:left">
                            Type
                        </th>

                        <th class="definition column description" style="text-align:left">
                            Description
                        </th>
                    </tr>
                    <cfloop collection="#api['securityDefinitions']#" item="definitionKey">
                        <cfset definition = api[ 'securityDefinitions' ][ definitionKey ]>
                        <cfset definitionUid = createUUID()>
                        <tr class="definition optional">

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
                                <cfif definition.type EQ 'oauth2'>
                                    <a href="###definitionUid#" class="pull-right" data-toggle="collapse" aria-expanded="false">
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
                            </td>

                        </tr>
                        <cfif definition.type EQ 'oauth2'>
                            <tr class="definition optional" id="#definitionUid#">
                                <td colspan="3">
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

                                    <cfif prc.pdf ?: false>
                                        <code>#serializeJSON( definition.scopes )#</code>
                                    <cfelse>
                                        <pre class="language-json">#serializeJSON( definition.scopes )#</pre>
                                    </cfif>
                                </td>
                            </tr>
                        </cfif>
                    </cfloop>
                </table>
            </cfif>

            <cfif structKeyExists( api, 'parameter' )>
                <!--- API Global Parameters --->
                <h3>Global Parameters</h3>
                #paramTemplate( { "entity":api } )#
            </cfif>

            #renderView(
                view='apidoc/cfTemplate/x-attributes',
                args={"entity":api}
            )#

            <div class="clearfix"></div>

        </div>

        <h2>API Path Reference:</h2>

        <cfloop array="#structKeyArray( api[ "paths" ] )#" index="pathKey">
            <!--- ACF Compatibility Fix for a null pointer exception --->
            <cfscript>
                writeOutput( renderView(
                    view    = 'apidoc/cfTemplate/api-path',
                    args    = {
                        "api" : api,
                        "key" : pathKey,
                        "path": api[ "paths" ][ pathKey ]
                    }
                ) );
            </cfscript>
        </cfloop>

    </div>
</cfoutput>