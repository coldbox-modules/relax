<cfoutput>
	<div id="#args.method[ "x-resourceId" ]#" class="method-panel panel panel-info">
			
		<div class="panel-heading">
			<h3 class="panel-title methodHeader">
				<strong>#args.key#</strong> 
			</h3>
		</div>

		<div class="panel-body">
			<div class="col-xs-12">
				
				<cfif structKeyExists( args.method, "description" ) && len( args.method[ "description" ] )>
					
					<h4 class="panel-subtitle text-primary">Description:</h4>

					#toParagraphFormat( args.method[ "description" ] )#

				</cfif>

				<cfif structKeyExists( args.method, "operationId" )>
					
					<h4 class="panel-subtitle text-primary">Internal Operation: <small class="text-muted">(e.g. Handler.Action)</small></h4>

					<code>#args.method[ "operationId" ]#</code>
					<hr>

				</cfif>

				<cfif structKeyExists( args.method, "parameters" ) and isArray( args.method[ "parameters" ] )>
					<h4 class="panel-subtitle text-primary">Parameters:</h4>
					#renderView( 
						view = "apidoc/cfTemplate/parameters", 
						args = { "entity" : args.method } 
					)#
					<hr>					
				</cfif>


            	#renderView( view='apidoc/cfTemplate/x-attributes', args={"entity":args.method,"headerNode":"h4"} )#
				
            	<cfif 
            		!structIsEmpty( args.method[ "responses" ] )
            		and
            		arrayLen( structKeyArray( args.method[ "responses" ] ) ) GT 1
            		and
            		(
            			!structKeyExists( prc, "pdf" )
            			or
            			!prc.pdf
            		)
            	>
	            	<h4 class="panel-subtitle text-primary">Responses:</h4>
	            	<cfloop array="#structKeyArray( args.method[ "responses" ] )#" index="responseKey">
		            	<cfif isNumeric( responseKey ) or responseKey eq 'default'>
			            	#renderView( 
			            		view="apidoc/cfTemplate/response", 
			            		args={
				            		"resourceId": args.method["x-resourceId"],
									"path":args.key,
									"key":responseKey,
									"response":args.method.responses[ responseKey ]
				            	} 
			            	)#
		            	</cfif>
	            	</cfloop>
					
            	</cfif>

				<!--- Hide Schema Examples in PDF --->
            	<cfif 
            		structKeyExists( args.method, "x-request-samples" )
            		and
            		arrayLen( structKeyArray( args.method[ "x-request-samples" ] ) ) GT 1
            		and
            		(
            			!structKeyExists( prc, "pdf" )
            			or
            			!prc.pdf
            		)
            	>
            		<cfscript>
	            		tabIds = {};
	            		tabActivated = false;
            		</cfscript>
	            	<div class="col-xs-12 schema-container">
						<h4 class="panel-subtitle text-primary">Sample Responses:</h4>
						<p>#args.method[ "x-request-samples" ][ "description" ]#</p>
						<div class="sample-tabs">
							<ul class="nav nav-tabs" role="tablist">
								<cfloop collection="#args.method[ "x-request-samples" ][ "examples" ]#" item="mimetype">
									<cfscript>
										typeRef = listLast( mimetype, "/" );
										if( typeRef EQ 'json' ) typeRef = 'javascript';
										tabIds[ typeRef ] = "sample" & createUUID();
									</cfscript>

									<li role="presentation">
										<a href="###tabIds[ typeRef ]#" data-toggle="tab">
											#mimetype#
										</a>
									</li>
									

								</cfloop>
								
							</ul>

							<div class="tab-content">
								<cfloop collection="#args.method[ "x-request-samples" ][ "examples" ]#" item="mimetype">
									<cfscript>
										typeRef = listLast( mimetype, "/" );
										if( typeRef EQ 'json' ) typeRef = 'javascript';
									</cfscript>
								</cfloop>
									
									<div id="#tabIds[typeRef]#" class="tab-pane fade sample-example">
										<div class="panel panel-solid-default">
											<pre class="language-#typeRef#">
												#args.method[ "x-request-samples" ][ "examples" ][ mimetype ][ "data" ]#
											</pre>
										</div>
									</div>

							</div><!-- /.tab-content -->
						</div><!-- /.schema-tabs -->
					</div><!-- /.schema-container -->

            	</cfif>

			</div>
		</div>

	</div>
</cfoutput>