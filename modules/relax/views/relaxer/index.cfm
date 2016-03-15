<cfoutput>
<div class="row">
	
	<div class="col-md-9">
		<!--- MessageBox --->
		<cfif flash.exists( "notice" )>
			<div class="alert alert-info"><i class="fa fa-bell"></i> #flash.get( "notice" )#</div>
		</cfif>

		<div class="relaxer col-xs-12">
			<div class="relaxer-form"></div>
			<div class="relaxer-results"></div>
		</div>

		<!--- Loader --->
		

		<!--- results --->
		<cfif structKeyExists( prc, "results" )>
			
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

            	<!--- My Apis --->
            	<h4>Loaded API:</h4>
            	<div class="form-group">
				<select name="myAPI" id="myAPI" title="You can switch the loaded API" onchange="window.location='#event.buildLink( prc.xehLoadAPI )#?returnEvent=#prc.xehRelaxer#&apiName=' + this.value" class="form-control input-sm">
					<cfloop query="prc.loadedAPIs">
						<cfif prc.loadedAPIs.type eq "Dir">
						<option value="#prc.loadedAPis.name#" <cfif prc.loadedAPIs.name eq prc.loadedAPIName>selected="selected"</cfif>>#prc.loadedAPis.name#</option>
						</cfif>
					</cfloop>
				</select>
				</div>
            	
            	<h4>Choose a tier+resource to test:</h4>

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
									<select name="myResource" id="myResource" title="Your defined RESTful resources" onchange="resourceSelect(this.value,'#JSStringFormat( entrypoint )#')" class="form-control input-sm">
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

        <!--- Request History --->
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">Request History</h3>
            </div>
            <div class="panel-body">
            	
            	<!--- MessageHolder --->
				<div id="requestHistoryMessages" class="alert alert-info" style="display:none"></div>
				<p class="center">
					<!--- Selection Box --->
					<select name="requestHistory" id="requestHistory" <cfif arrayLen( prc.requestHistory ) EQ 0>disabled="disabled"</cfif> class="form-control input-sm">
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
					<a href="javascript:clearHistory()" class="btn btn-danger confirmIt" onclick="confirm( 'Really wipe out the history' )"
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