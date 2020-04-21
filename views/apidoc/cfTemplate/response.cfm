<cfoutput>
	<div id="#args.resourceId#-#args.key#" class="method-box box box-primary">

		<div class="box-header">
			<h3 class="box-title methodHeader">
				<strong>#args.key#</strong>
			</h3>
		</div>

		<div class="box-body">
			<cfif structKeyExists( args.response, "description" ) and len( args.response[ "description" ] )>
				<div class="col-xs-12">

						<h4 class="box-subtitle text-primary">Description:</h4>
						<p>#toParagraphFormat( args.response[ "description" ] )#</p>
						<hr>
				</div>

			</cfif>
			<!--- Hide Schema Examples in PDF --->
			<cfif
				(
					structKeyExists( args.response, "schema" )
					or structKeyExists( args.response, "examples" )
				)
				and
				( !structKeyExists( prc, "pdf" )
            		or
            	  !prc.pdf
            	)
			>
				<cfset tabIds = {} >
				<div class="col-xs-12 schema-container">
					<h4 class="box-subtitle text-primary">Schema and Examples:</h4>
					<cfif structKeyExists( args.response, "schema" )>
						<cfset tabIds[ "schemaUID" ] = "schema" & createUUID()>
						<div class="box-header">
							<h3 class="box-title schemaHeader">
								<strong>Schema Definition</strong>
							</h3>
						</div>

						<div class="box-body schema-definition">
							#renderView( view="apidoc/cfTemplate/schema", args={ "entity": args.response } )#
						</div>

					</cfif>

					<cfif structKeyExists( args.response, "examples" )>
						<cfloop collection="#args.response.examples#" item="mimetype">
							<cfscript>
								typeRef = listLast( mimetype, "/" );
								if( typeRef EQ "json" ) typeRef = "javascript";
								tabIds[ typeRef ] = "example" & createUUID();
							</cfscript>

							<div class="box-header">
								<h3 class="box-title schemaHeader">
									<strong>#mimetype#</strong>
								</h3>
							</div>

							<div class="box-body schema-example">
								<div class="box box-solid-default">
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
		</div><!-- /.box-body -->

	</div><!-- /.box -->
</cfoutput>