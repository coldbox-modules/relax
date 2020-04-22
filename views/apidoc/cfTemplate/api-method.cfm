<cfoutput>
	<cfif !structKeyExists( args.method, "x-resourceId" )>
		<cfset args.method[ "x-resourceId" ] = createUUID()/>
	</cfif>
	<div id="#args.method[ "x-resourceId" ]#" class="method-card card card-gray">

		<div class="card-header">
			<h3 class="card-title methodHeader">
				<strong>#args.key#</strong>
			</h3>
		</div>

		<div class="card-body">
			<div class="col-xs-12">
				<cfif structKeyExists( args.method, "deprecated" ) && args.method[ "deprecated" ]>
					<h4 class="card-subtitle text-primary"><em>Deprecated</em></h4>
				</cfif>

				<cfif structKeyExists( args.method, "summary" ) && len( args.method[ "summary" ] )>

					<h4 class="card-subtitle text-primary">Summary:</h4>

					#toParagraphFormat( args.method[ "summary" ] )#

				</cfif>

				<cfif structKeyExists( args.method, "description" ) && len( args.method[ "description" ] )>

					<h4 class="card-subtitle text-primary">Description:</h4>

					#toParagraphFormat( args.method[ "description" ] )#

				</cfif>

				<cfif structKeyExists( args.method, "operationId" )>

					<h4 class="card-subtitle text-primary">Internal Operation: <small class="text-muted">(e.g. Handler.Action)</small></h4>

					<code>#args.method[ "operationId" ]#</code>
					<hr>

				</cfif>

				<cfif structKeyExists( args.method, "parameters" ) and isArray( args.method[ "parameters" ] ) and args.method[ "parameters" ].len() >
					<div class="card card-default">
						<div class="card-header">
							<h4 class="card-subtitle text-primary">Parameters:</h4>
						</div>
						<div class="card-body">
							#renderView(
								view = "apidoc/cfTemplate/parameters",
								args = { "entity" : args.method }
							)#
						</div>
					</div>
					<hr>
				</cfif>

				<cfif structKeyExists( args.method, "requestBody" )>
					<h4 class="card-subtitle text-primary">Request Body:</h4>
					<cfif structKeyExists( args.method.requestBody, "description" )>
						<h5>Description: #args.method.requestBody.description#</h5>
					</cfif>

					<cfparam name="args.method.requestBody.required" default="true"/>
					<h5>Required: <pre>#(args.method.requestBody.required ? 'true' : 'false')#</pre></h5>
					#renderView(
						view = "apidoc/cfTemplate/request-body",
						args = { "entity" : args.method }
					)#
					<hr>
				</cfif>

            	#renderView( view='apidoc/cfTemplate/x-attributes', args={"entity":args.method,"headerNode":"h4"} )#

            	<cfif
            		!structIsEmpty( args.method[ "responses" ] )
            		and
            		arrayLen( structKeyArray( args.method[ "responses" ] ) ) GT 1
            	>
	            	<h4 class="card-subtitle text-primary">Responses:</h4>
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
            	>
            		<cfscript>
	            		tabIds = {};
	            		tabActivated = false;
            		</cfscript>
	            	<div class="col-xs-12 schema-container">
						<h4 class="card-subtitle text-primary">Sample Responses:</h4>
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
										<div class="card card-solid-default">
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