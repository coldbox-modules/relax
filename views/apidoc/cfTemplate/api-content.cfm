<cfscript>
	api = args.api;
	pathKeys = api[ "paths" ].keyArray();
	pathKeys.sort( function(a, b){ return compare( ucase( a ), ucase( b ) );} );
</cfscript>
<cfoutput>
    <div>
        <div id="overview" class="active service-summary">
            <!--- Service Title and Description --->
            <h1>#api[ "info" ][ "title" ]#</h1>
            <cfif structKeyExists( api[ "info" ], "version") && len(api[ "info" ][ "version" ])>
                <h3>Version: <span class="label label-primary">#api[ "info" ][ "version" ]#</span></h3>
            </cfif>
            <dl>
                <dt class="text-info"><strong>Introduction:</strong></dt>
                <dd>#toParagraphFormat( api[ "info" ][ "description" ] )#</dd>
                <cfif structKeyExists( api[ "info" ], "contact" ) && !structIsEmpty( api[ "info" ][ "contact" ] )>
                        <dt class="text-info"><strong>Contact:</strong></dt>
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
                    <dt class="text-info"><strong>License:</strong>
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

			<cfif structKeyExists( api, "servers" )>
				<h2>Servers</h2>
				<ul class="list-unstyled">
					<cfloop array="#api.servers#" index="apiServer">
						<li><strong><a href="#apiServer.url#">#apiServer.url#</a></strong><cfif structKeyExists( server, "description" )> - #apiServer.description# </cfif></li>
					</cfloop>
				</ul>
			</cfif>

			<cfif structkeyExists( api, "x-entryPoint" )>
				<h2>Service Entry Points</h2>
				<ul class="list-unstyled">
					<cfloop collection="#api['x-entryPoint']#" item="tierName">
						<li><em>#titleCase( tierName )#:</em> <a href="#api[ "x-entryPoint" ][ tierName ]#">#api[ "x-entryPoint" ][ tierName ]#</a></li>
					</cfloop>
				</ul>
			<cfelseif structKeyExists( api, "host" )>
				<h2>Service Entry Points</h2>
				<ul class="list-unstyled">
					<li><em>Host:</em> <code>#api[ "host" ]#</code></li>
				</ul>
			</cfif>

            <!--- Paths --->
            <h2>Service Available Paths</h2>

           <ul>

            <cfloop array="#pathKeys#" index="key">
                <li><code><a class="path-nav" href="###api[ "paths" ][ key ][ "x-resourceId" ]#">#key#</a></code></li>
            </cfloop>

            </ul>

            <!--- API Return Formats --->
			<cfif structKeyExists( api, "x-validExtensions" )>
                <h2>Valid Format Extensions:  <code>#api[ "x-validExtensions" ]#</code></h2>
            </cfif>

            <cfif structKeyExists( api, "x-extensionDetection" )>
                <h2>Extension Detection:  <code>#api[ "x-extensionDetection" ]#</code></h2>
            </cfif>

            <cfif structKeyExists( api, "x-throwOnInvalidExtension" )>
                <h2>Throws on Invalid Extension:  <code>#api[ "x-throwOnInvalidExtension" ]#</code></h2>
            </cfif>

            <cfif structKeyExists( api, "securityDefinitions" )>
                <!-- Security Definitions -->
                <h2>Security Definitions</h2>
                <table class="definition-list table table-striped" cellpadding="10">
                    <tr class="text-muted">
                        <th class="definition-column key" style="text-align:left" valign="top">
                            Name
                        </th>

                        <th class="definition column type" style="text-align:left" valign="top">
                            Type
                        </th>

                        <th class="definition column description" style="text-align:left" valign="top">
                            Description
                        </th>
                    </tr>
                    <cfloop collection="#api['securityDefinitions']#" item="definitionKey">
                        <cfset definition = api[ 'securityDefinitions' ][ definitionKey ]>
                        <cfset definitionUid = createUUID()>
                        <tr class="definition optional">

                            <td class="definition-column key" valign="top">
                                <code>#definitionKey#</code>
                            </td>

                            <td class="definition column type" valign="top">
                                <cfif structKeyExists( definition, "type" )>
                                    <code># definition.type #</code>
                                <cfelse>
                                    N/A
                                </cfif>
                            </td>

                            <td class="definition column description" valign="top">
                                <cfif definition.type EQ 'oauth1'>
                                    <a href="###definitionUid#" class="pull-right" data-toggle="collapse" aria-expanded="false">
                                        <small><i class="fa fa-chevron-down"></i></small>
                                    </a>
                                </cfif>

                                <cfif structKeyExists( definition, "in" )>
                                    <em>Provided in the <code>#definition.in#</code> of the request</em><br>
                                </cfif>
                                <cfif structKeyExists( definition, 'description' )>
                                    #toParagraphFormat( definition.description )#
                                <cfelse>
                                    Definition description unavailable.
                                </cfif>
                            </td>

                        </tr>
                        <cfif definition.type EQ 'oauth1'>
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
                <h2>Global Parameters</h2>
                #paramTemplate( { "entity":api } )#
            </cfif>

            #renderView(
                view='apidoc/cfTemplate/x-attributes',
                args={"entity":api}
            )#

            <div class="clearfix"></div>

        </div>

        <h1>API Path Reference:</h1>

        <cfloop array="#pathKeys#" index="pathKey">
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