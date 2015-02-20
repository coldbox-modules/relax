<cfoutput>
<div class="row">
	
	<div class="col-md-9">
		<!--- MessageBox --->
		<cfif flash.exists( "notice" )>
			<div class="alert alert-info"><i class="fa fa-bell"></i> #flash.get( "notice" )#</div>
		</cfif>

		<form name="relaxerForm" id="relaxerForm" action="#event.buildLink( prc.xehRelaxer)#" method="post" class="form-inline">
			<input type="hidden" name="sendrequest" value="true" />

			<div class="pull-right">
				<button type="button" class="btn btn-default" title="Advanced Settings" onClick="advancedSettings();return false;"> <img src="#prc.root#/includes/images/settings.png" alt="settings" height="16"/></button>
			</div>

			<fieldset>
			<legend>Method-Resource-Format</legend>

			<!--- Resource ID --->
			<input type="hidden" name="resourceID" 	 id="resourceID" 	value="null" />
			<input type="hidden" name="resourceTier" id="resourceTier" 	value="production" />

			<!--- HTTP Method --->
			<select name="httpMethod" id="httpMethod" title="Choose your HTTP Method" class="form-control">
				<option <cfif rc.httpMethod eq "GET">selected="selected"</cfif>>GET</option>
				<option <cfif rc.httpMethod eq "PUT">selected="selected"</cfif>>PUT</option>
				<option <cfif rc.httpMethod eq "POST">selected="selected"</cfif>>POST</option>
				<option <cfif rc.httpMethod eq "DELETE">selected="selected"</cfif>>DELETE</option>
				<option <cfif rc.httpMethod eq "HEAD">selected="selected"</cfif>>HEAD</option>
				<option <cfif rc.httpMethod eq "OPTIONS">selected="selected"</cfif>>OPTIONS</option>
			</select>

			<!--- Spacer --->
			<i class="fa fa-chevron-right"></i>

			<!--- Resource or URL --->
			<input title="The resource to hit" type="text" name="httpResource" id="httpResource" size="60" class="form-control" value="#rc.httpResource#" />

			<!--- Spacer --->
			<i class="fa fa-chevron-right"></i>

			<!--- Format --->
			<select name="httpFormat" id="httpFormat" title="The resource format extension (if available)" class="form-control">
				<option value="" <cfif rc.httpFormat eq "">selected="selected"</cfif>>none</option>
				<option <cfif rc.httpFormat eq "xml">selected="selected"</cfif>>xml</option>
				<option <cfif rc.httpFormat eq "json">selected="selected"</cfif>>json</option>
				<option <cfif rc.httpFormat eq "jsont">selected="selected"</cfif>>jsont</option>
				<option <cfif rc.httpFormat eq "rss">selected="selected"</cfif>>rss</option>
			</select>

			<!--- Button Bar --->
			<button type="button" class="btn btn-primary" title="Send Request" onclick="submitForm();return false;" style=""> Send </button>
			</fieldset>

			<!--- Advanced Settings --->
			<div id="advancedSettings" style="display:none" class="well">
				<!--- HTTP Basic Auth --->
				<fieldset>
					<legend>HTTP Basic Authentication</legend>
					Username:
					<input title="Username"  type="text" class="form-control" name="username" id="username" size="30" value="#rc.username#" />
					Password:
					<input title="Password"  type="text" class="form-control" name="password" id="password" size="30" value="#rc.password#" />

				</fieldset>

				<!--- HTTP Proxy --->
				<fieldset>
					<legend>HTTP Proxy</legend>
					Host:
					<input title="HTTP Proxy"  type="text" class="form-control" name="httpProxy" id="httpProxy"  size="30" value="#rc.httpProxy#" />
					Port:
					<input title="HTTP Proxy Port"  type="text" class="form-control" name="httpProxyPort" id="httpProxyPort" size="30" value="#rc.httpProxyPort#" />

				</fieldset>

				<!--- HTTP Headers --->
				<fieldset>
					<legend>API Headers</legend>

					<!--- Headers Holder --->
					<div id="httpHeaders">
						<cfloop from="1" to="#arrayLen( rc.headerNames )#" index="i">
						<p style="margin:0px">
							<input title="Header Name"  type="text" class="form-control" name="headerNames"  size="30" value="#rc.headerNames[ i ]#" />
							<input title="Header Value" type="text" class="form-control" name="headerValues" size="50"
								   value="<cfif arrayLen( rc.headerValues ) and arrayIsDefined( rc.headerValues, i )>#rc.headerValues[ i ]#</cfif>"/>
							<button class="btn btn-danger btn-sm dynamicRemove" onclick="return false;"><i class="fa fa-remove"></i></button>
						</p>
						</cfloop>
						<!--- Add Header --->
						<button class="btn btn-default btn-sm dynamicAdd" data-type="header" title="Add Header" id="addHeaderButton" onclick="return false;"><i class="fa fa-plus"></i></button>
					</div>
				</fieldset>

				<!--- Query Params --->
				<fieldset>
					<legend>API Parameters</legend>

					<!--- Parameters Holder --->
					<div id="httpParameters">
						<cfloop from="1" to="#arrayLen( rc.parameterNames )#" index="i">
						<p style="margin:0px">
							<input title="Parameter Name"  type="text" class="form-control" name="parameterNames"  size="30" value="#rc.parameterNames[ i ]#" />
							<input title="Parameter Value" type="text" class="form-control" name="parameterValues" size="50"
								   value="<cfif arrayLen( rc.parameterValues ) and arrayIsDefined( rc.parameterValues, i )>#rc.parameterValues[ i ]#</cfif>" />
							<button class="btn btn-danger btn-sm dynamicRemove" onclick="return false;"><i class="fa fa-remove"></i></button>
						</p>
						</cfloop>
						<!--- Add Header --->
						<button class="btn btn-default btn-sm dynamicAdd" data-type="parameter" title="Add Parameter" id="addParameterButton" onclick="return false;"><i class="fa fa-plus"></i></button>
					</div>
				</fieldset>

			</div>
		</form>

		<!--- Loader --->
		<div id="bottomCenteredLoader" style="display:none">
			<p class="text-center">
				Sending Request... <br/>
				<i class="fa fa-spinner fa-spin fa-4x"></i>
			</p>
		</div>

		<!--- results --->
		<cfif structKeyExists( prc, "results" )>
			<a name="results"></a>
			<div id="resultsBox">

				<div class="panel panel-default">
		            <div class="panel-body">
		                <div class="tab-wrapper tab-primary">
		                    <ul class="nav nav-tabs">
		                        <li class="active"><a href="##headers" data-toggle="tab">Response Headers</a></li>
								<li><a href="##results" data-toggle="tab">Raw Results</a></li>
								<li><a href="##pretty" data-toggle="tab">Pretty Results</a></li>
								<li><a href="##browser" onclick="showBrowserResults();return false">Browser Results</a></li>
		                    </ul>
		                    <div class="tab-content">
		                    	<!--- RAW HEADERS --->
		                        <div class="tab-pane active" id="headers">
		                        	<table class="table table-hover table-striped table-condensed" width="100%">
										<tr>
											<th width="200" class="text-right">Request Status</th>
											<td>
												#prc.results.statuscode#
											</td>
										</tr>
										<cfloop collection="#prc.results.responseHeader#" item="header">
										<tr>
											<th class="text-right">#header#</th>
											<td>
												#prc.results.responseHeader[ header ].toString()#
											</td>
										</tr>
										</cfloop>
									</table>
		                        </div>
		                        <!--- RAW CONTENT --->
		                        <div class="tab-pane" id="results">
		                        	<form>
									<textarea id="resultsRAW" class="textfield" rows="30" style="width:100%">#prc.results.fileContent.toString()#</textarea>
									</form>
		                        </div>
		                        <!--- PRETTY CONTENT --->
		                        <div class="tab-pane" id="pretty">
		                        	<pre id="resultsPretty" class="brush: #getBrush(prc.results.fileContent)#">
		                        		#getTreatedContent( prc.results.fileContent )#
									</pre>
		                        </div>
		                    </div>
		                </div>
		            </div> <!--- end panel body--->
		        </div> <!---- end panel --->
				
			</div>
		</cfif>
		<!--- end Results Box --->

	</div> <!--- end content column --->

	<!--- Sidebar --->
	<div class="col-md-3">
		<div class="panel panel-default">
            <div class="panel-heading">
                <h2 class="panel-title">#prc.loadedAPIName#</h2>
            </div>
            <div class="panel-body">
            	
            	<p>Choose a tier+resource to test:</p>

            	<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
            		<!-- Accordion Items-->
					<cfloop collection="#prc.dsl.relax.entryPoint#" item="entryPoint">
	            		<div class="panel panel-default">
            				<div class="panel-heading" role="tab" id="heading-#entryPoint#">
	            				<h4 class="panel-title">
							        <a data-toggle="collapse" data-parent="##accordion" href="##tab-#entryPoint#" aria-expanded="true" aria-controls="tab-#entryPoint#">
							        #entryPoint#
							        </a>
							    </h4>
	            			</div>
	            			<div id="tab-#entryPoint#" class="panel-collapse collapse <cfif rc.entryTier eq entryPoint>in</cfif>" role="tabpanel" aria-labelledby="tab-#entryPoint#">
	            				<div class="panel-body">
	            					<!--- My Resources --->
									<select name="myResource" id="myResource" title="Your defined RESTful resources" onchange="resourceSelect(this.value,'#JSStringFormat( entrypoint )#')" class="form-control">
										<option value="null" selected="selected">Pick One To Test</option>
										<cfloop array="#prc.dsl.resources#" index="thisResource">
											<option value="#thisResource.resourceID#;#prc.dsl.relax.entryPoint[entryPoint]##thisResource.pattern#">#thisResource.pattern#</option>
										</cfloop>
									</select>
	            				</div>
	            			</div>
	            		</div>
					</cfloop>
            	</div>

				<!--- Help button --->
				<p class="text-center">
					<br/>
					<button class="btn btn-primary" onclick="return showResourceHelp()" title="Selected Resource Help"> <i class="fa fa-question-circle"></i> Resource Doc</button>
				</p>

            </div>
        </div> <!--- panel resource --->

        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">Request History</h3>
            </div>
            <div class="panel-body">
            	
            	<!--- MessageHolder --->
				<div id="requestHistoryMessages" class="flickerMessages"></div>
				<p class="center">
					<!--- Selection Box --->
					<select name="requestHistory" id="requestHistory" <cfif arrayLen( prc.requestHistory ) EQ 0>disabled="disabled"</cfif> class="form-control">
						<cfif arrayLen( prc.requestHistory ) EQ 0>
							<option value="null">No History</option>
						<cfelse>
							<option value="null">Select History Item</option>
						</cfif>
						<cfloop from="1" to="#arrayLen( prc.requestHistory)#" index="x">
							<option value='#x-1#'>#printDate( prc.requestHistory[x].requestDate )#</option>
						</cfloop>
					</select>
					<br/>
				</p>

				<p class="text-center">
					<!--- Clear History Command --->
					<a href="javascript:clearHistory()" class="btn btn-danger confirmIt"
					   title="Clear the request history"
					   data-message="Do you really want to clear your request history?">
						<i class="fa fa-recycle" ></i>
					</a>

					<!--- Replay Command --->
					<a href="javascript:rebuildRequest()" class="btn btn-primary" title="Rebuild the request">
						<i class="fa fa-fast-backward" ></i>
					</a>
				</p>

				<!--- Loader --->
				<div id="historyLoader" class="text-center hidden">
					<p>
						<i class="fa fa-spinner fa-4x fa-spin"></i>
					</p>
				</div>

            </div>
        </div> <!--- panel history --->


    </div> <!--- end sidebar --->
</div> <!--- end row --->

<!--- Fields Template --->
<p id="fieldsTemplate" style="display:none;margin:3px">
	<input type="text" data-title="::fieldType:: name"  name="::fieldType::Names"  class="form-control" size="30" placeholder="name..." />
	<input type="text" data-title="::fieldType:: value" name="::fieldType::Values" class="form-control" size="50" placeholder="value..."/>
	<button class="btn btn-danger btn-sm dynamicRemove" onclick="return false;"><i class="fa fa-remove"></i></button>
</p>
</cfoutput>