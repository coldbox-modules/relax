<cfoutput>
	<div id="#args.resourceId#-#args.key#" class="method-card card card-primary">

		<div class="card-header">
			<h3 class="card-title methodHeader">
				<strong>#args.key#</strong>
			</h3>
		</div>

		<div class="card-body">
			<cfif structKeyExists( args.response, "description" ) and len( args.response[ "description" ] )>
				<div class="col-xs-12">

						<h4 class="card-subtitle text-primary">Description:</h4>
						<p>#toParagraphFormat( args.response[ "description" ] )#</p>
				</div>
			</cfif>

			<cfif
				(
					structKeyExists( args.response, "schema" )
					or structKeyExists( args.response, "content" )
					or structKeyExists( args.response, "examples" )
				)
			>
				<cfset tabIds = {} >
				<div class="col-xs-12 schema-container">
					<h4 class="card-subtitle text-primary">Schema and Examples:</h4>
					<cfif structKeyExists( args.response, "schema" )>
						<div class="card-header">
							<h3 class="card-title schemaHeader">
								<strong>Schema Definition</strong>
							</h3>
						</div>

						#renderView( view="apidoc/cfTemplate/schema", args={ "schema": args.response.schema } )#

					</cfif>

					<cfif structKeyExists( args.response, "content" )>
						<cfloop array="#structKeyArray( args.response.content )#" item="mimetype">
							<div class="method-card card card-info">
								<div class="card-header">
									<h3 class="card-title methodHeader">
										<strong>#mimetype#</strong>
									</h3>
								</div>
								<div class="card-body">
									<cfif structKeyExists( args.response.content[ mimetype ], "schema" ) && structKeyExists( args.response.content[ mimetype ].schema, "properties" )>
									#renderView( view="apidoc/cfTemplate/schema", args={ "schema": args.response.content[ mimetype ].schema } )#
									</cfif>
								</div>
							</div>
						</cfloop>

					</cfif>

					<cfif structKeyExists( args.response, "examples" )>
						<cfloop collection="#args.response.examples#" item="mimetype">
							<cfscript>
								typeRef = listLast( mimetype, "/" );
								if( typeRef EQ "json" ) typeRef = "javascript";
								tabIds[ typeRef ] = "example" & createUUID();
							</cfscript>

							<div class="card-header">
								<h3 class="card-title schemaHeader">
									<strong>#mimetype#</strong>
								</h3>
							</div>

							<div class="card-body schema-example">
								<div class="card card-solid-default">
									<cfscript>
										switch( typeRef ){
											case "xml":
												schemaExample = encodeForHTML( isSimpleValue( args.response.examples[ mimetype ] ) ? args.response.examples[ mimetype ] :  serializeXML( args.response.examples[ mimetype ] ) );
												break;
											default:
												schemaExample = isSimpleValue( args.response.examples[ mimetype ] ) ? args.response.examples[ mimetype ] : encodeForHTML( serializeJSON( args.response.examples[ mimetype ] ) );

										}
									</cfscript>


									<cfif prc.pdf ?: false>
		                                <code>#schemaExample#</code>
		                            <cfelse>
		                                <pre class="language-#typeRef#">#schemaExample#</pre>
		                            </cfif>

								</div>
							</div>

						</cfloop>
					</cfif>
				</div><!-- /.schema-container -->
			</cfif>
		</div><!-- /.card-body -->

	</div><!-- /.card -->
</cfoutput>