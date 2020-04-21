<cfscript>
	requestBody = args.entity.requestBody;
</cfscript>

<cfloop array="#requestBody.content.keyArray()#" index="key">
	<cfoutput>
	<div id="#(entity["x-resourceId"] & '-requestBody-' & listLast( key, '/' ))#" class="method-box box box-info">
		<div class="box-header">
			<h3 class="box-title methodHeader">
				<strong>#key#</strong>
				<a class="pull-right btToggleMethod" role="button" data-toggle="collapse" href="##box_#(entity["x-resourceId"] & '-requestBody-' & listLast( key, '/' ))#" aria-expanded="false" aria-controls="box_#(entity["x-resourceId"] & '-requestBody-' & listLast( key, '/' ))#">
					<i class="fa fa-chevron-down"></i>
				</a>
			</h3>
		</div>
		<div id="box_#(entity["x-resourceId"] & '-requestBody-' & listLast( key, '/' ))#" class="box-body">
			<ul class="col-xs-12 list-unstyled">
				<cfif structKeyExists( requestBody.content[ key ], "schema" ) && structKeyExists( requestBody.content[ key ].schema, "properties" )>
					<cfscript>
						bodyProperties = requestBody.content[ key ].schema.properties.keyArray();
						bodyProperties.sort( function( a, b ){ return compare( ucase( a ), ucase( b ) ); } );
					</cfscript>
					<cfloop array="#bodyProperties#" index="param">
						<cfscript>
							definition = requestBody.content[ key ].schema.properties[ param ];
						</cfscript>
						<li>
							<strong><code>#param#</code></strong>
							<ul class="list-unstyled" padding-left="20px">
								<li><strong>Type:</strong></storng>#(definition.keyExists( 'type' ) ? definition.type : 'N/A')#</li>
								<cfif definition.keyExists( 'description' )>
									<li>
										<strong>Description:</strong><br>
										<p>#definition.description#</p>
									</li>
								</cfif>
							</ul>
						</li>
					</cfloop>
				</cfif>
			</ul>
		</div>
	</div>
	</cfoutput>
</cfloop>

