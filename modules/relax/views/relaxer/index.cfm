<cfoutput>
<div class="row">
	
	<div class="col-md-9">
		<!--- MessageBox --->
		<cfif flash.exists( "notice" )>
			#flash.get( "notice" )#
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
				<!--- Tabs --->
				<ul class="tabs" id="tabs">
					<li><a href="##" onclick="showTab(0);return false">Response Headers</a></li>
					<li><a href="##" onclick="showTab(1);return false">Raw Results</a></li>
					<li><a href="##" onclick="showTab(2);return false">Pretty Results</a></li>
					<li><a href="##" onclick="showBrowserResults();return false">Browser Results</a></li>
				</ul>
				<!--- Panes --->
				<div class="panes" id="tabPanes">
					<!--- headers --->
					<div class="pane">
						<table class="tablelisting" width="100%">
							<tr>
								<th width="125" class="textRight">Request Status</th>
								<td>
									#prc.results.statuscode#
								</td>
							</tr>
							<cfloop collection="#prc.results.responseHeader#" item="header">
							<tr>
								<th width="125" class="textRight">#header#</th>
								<td>
									#prc.results.responseHeader[header].toString()#
								</td>
							</tr>
							</cfloop>
						</table>
					</div>
					<!--- Raw Content --->
					<div class="pane">
						<form>
						<textarea id="resultsRAW" class="textfield" rows="30" style="width:100%">#prc.results.fileContent.toString()#</textarea>
						</form>
					</div>
					<!--- Pretty Content --->
					<div class="pane">
						<pre id="resultsPretty" class="brush: #getBrush(prc.results.fileContent)#">#getTreatedContent(prc.results.fileContent)#
						</pre>
					</div>
				</div>
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
							<option value='#x-1#'>#printDate( prc.requestHistory[x].requestDate)#</option>
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
<script language="javascript">
$(document).ready(function() {
	$relaxerForm 	= $("##relaxerForm");
	$resultsBox  	= $("##resultsBox");
	$relaxerHeader 	= $("##relaxerHeader");

	<cfif structKeyExists( prc, "results" )>
	$tabPanes		= $("##tabPanes");
	$tabRoot		= $("##tabs");
	// syntax highlight
	SyntaxHighlighter.all();
	// tabs
	currentTabIndex = 0;
	// init tab
	showTab(currentTabIndex);
	// scroll to results
	$.scrollTo($resultsBox, 800, {axis:'y'});

	// some formatting
	<cfif( NOT isXML( prc.results.fileContent) )>
		$("##resultsPretty").html( formatJSONRaw('#JSStringFormat( prc.results.fileContent)#') );
	</cfif>

	</cfif>

	// Dynamic Add
	$(".dynamicAdd").click(function() {
		addDynamicItem($(this));
		return false;
	});
	// Removal Dynamic
	$(".dynamicRemove").click(function() {
		$container = $(this).parent().parent();
		$(this).parent().remove();
		return false;
	});

	// resource js models
	$resources = {};
	<cfloop array="#prc.dsl.resources#" index="thisResource">
		$resources['#thisResource.resourceID#'] = #serializeJSON( thisResource )#;
 	</cfloop>
	//json history
	reqHistory = [];
	<cfloop from="1" to="#arrayLen( prc.requestHistory)#" index="x">
	reqHistory[#x-1#] = #serializeJSON( prc.requestHistory[x] )#;
	</cfloop>
});
function showBrowserResults(){
	var w = 900, h = 750;
	var LeftPosition = (screen.width) ? (screen.width-w)/2 : 0;
	var TopPosition = (screen.height) ? (screen.height-h)/2 : 0;

	var c = window.open("","browserResults","height="+h+",width="+w+",left="+LeftPosition+",top="+TopPosition+",resizable=yes,scrollbars=yes");
	c.document.write( $("##resultsRAW").val() );
}
function resourceSelect(rData,tier){
	var resourceID = 0;
	// tier and URL selection
	if( rData != 'null' ){
		var values = rData.split(";");
		resourceID = values[0];
		$("##resourceID").val( resourceID );
		$("##httpResource").val( values[1] );
	}
	else{
		$("##httpResource").val('');
	}
	$("##entryTier").val(tier);

	// Select default HTTP Method
	selectOption("httpMethod", $resources[resourceID].DEFAULTMETHOD);
	// Select default Format
	selectOption("httpFormat", $resources[resourceID].DEFAULTFORMAT);

	// Check for required parameters
	var openAdvanced = false;
	// Clean header values and params
	cleanHeaders(); cleanParams();
	$("##httpParameters p").remove();

	// params required?
	if ($resources[resourceID].PARAMETERS != null) {
		$.each($resources[resourceID].PARAMETERS, function(index, objValue){
			if (objValue.REQUIRED == "true" || objValue.REQUIRED == true) {
				openAdvanced = true;
				addDynamicItem($("##addParameterButton"), [objValue.NAME, objValue.DEFAULT]);
			}
		});
	}
	// headers required?
	if ($resources[resourceID].HEADERS != null) {
		$.each($resources[resourceID].HEADERS, function(index, objValue){
			if (objValue.REQUIRED == "true") {
				openAdvanced = true;
				addDynamicItem($("##addHeaderButton"), [objValue.NAME, objValue.DEFAULT]);
			}
		});
	}
	// open advanced dialog
	if( openAdvanced ){ $("##advancedSettings").slideDown(); } else { $("##advancedSettings").slideUp(); }
}
function cleanHeaders(){
	$("##httpHeaders p").remove();
}
function cleanParams(){
	$("##httpParameters p").remove();
}
function showResourceHelp(){
	var val = $("##resourceID").val();
	if( val != "null"){
		var values = val.split(";");
		openRemoteModal( '#event.buildLink( prc.xehResourceDoc )#',{
			resourceID: values[0]
		});
	}

	return false;
}
function showTab(index){
	$tabRoot.find("li:eq("+currentTabIndex+")").removeClass("current");
	$tabRoot.find("li:eq("+index+")").addClass("current");
	$tabPanes.find("div:eq("+currentTabIndex+")").fadeOut('fast');
	$tabPanes.find("div:eq("+index+")").fadeIn('fast');
	currentTabIndex = index;
}
function addDynamicItem(_this, inData){
	var $trigger  = _this;
	var fieldType = $trigger.attr("data-type");
	// turn on the duplicate template on the requested trigger
	$("##fieldsTemplate").clone(true).attr("id","").insertBefore( $trigger ).toggle();

	$trigger.prev().find("input").each(function(index){
		var $this = $(this);
		var fieldTitle = $this.attr("data-title");
		var fieldName  = $this.attr("name");

		$this.attr("title", fieldTitle.replace(/::fieldType::/,fieldType) )
			.attr("name", fieldName.replace(/::fieldType::/,fieldType));
		if (inData != null) {
			$this.val(inData[index]);
		}
		$this.tooltip(toolTipSettings);
	});
}
function clearHistory(){
	//activate spinners
	$("##historyLoader").fadeIn();
	$("##requestHistoryContainer").css("opacity",".5");
	// clean history
	$.post( '#event.buildLink( prc.xehPurgeHistory )#',{},
		   function(response){
		   	// deactivate spinner
			$("##historyLoader").fadeOut();
			$("##requestHistoryContainer").css("opacity","1");
			// setup message
			$("##requestHistoryMessages").html(response.messages)
				.slideDown().delay(1500).slideUp();
			// Check if we can remove it
			if(!response.error){
				$('##requestHistory')
				    .empty()
				    .append('<option value="null">No History</option>');
			}
		   },
		   "json");
}
function rebuildRequest(){
	var index = $("##requestHistory").val();
	if( index != "null" ){
		var item = reqHistory[index].DATA;
		//console.log(item);

		$("##advancedSettings").slideDown();
		// main options
		selectOption("httpMethod",item.HTTPMETHOD);
		$("##httpResource").val(item.HTTPRESOURCE);
		selectOption("httpFormat",item.HTTPFORMAT);
		// HTTP Auth
		$("##username").val(item.USERNAME);
		$("##password").val(item.PASSWORD);
		// HTTP Proxy
		$("##httpProxy").val(item.HTTPPROXY);
		$("##httpProxyPort").val(item.HTTPPROXYPORT);
		// Clean header values and params
		cleanHeaders();cleanParams();

		// headers
		if (item.HEADERNAMES.toString().length) {
			var headerNames = item.HEADERNAMES.toString().split(",");
			var headerValues = item.HEADERVALUES.toString().split(",");
			$.each(headerNames, function(index, objValue){
				addDynamicItem($("##addHeaderButton"), [objValue, headerValues[index]]);
			})
		}
		// params
		if (item.PARAMETERNAMES.toString().length) {
			var paramNames = item.PARAMETERNAMES.toString().split(",");
			var paramValues = item.PARAMETERVALUES.toString().split(",");
			$.each(paramNames, function(index, objValue){
				addDynamicItem($("##addParameterButton"), [objValue, paramValues[index]]);
			})
		}
		$("##requestHistoryMessages").html("Request Rebuilt!")
				.slideDown().delay(250).slideUp();
	}
}
function selectOption(itemID,data){
	$("##"+itemID+" option").each(function(index){
		var $this = $(this);
		if( $this.val() == data){ $this.attr("selected","selected"); }
	});
}
function submitForm(){
	var $resource = $("##httpResource");
	// Verify the destination just in case:
	if( !$resource.val().length ){
		if( !$resource.hasClass("error") ){
			$resource.addClass("error");
		}
		$resource.focus();
		alert("The HTTP resource to hit cannot be empty! You are too relaxed!");
		return;
	}
	$('##bottomCenteredBar').slideUp("fast");
	$('##bottomCenteredLoader').fadeIn("slow");
	$relaxerForm.submit();
}
function advancedSettings(){
	$("##advancedSettings").slideToggle();
}
</script>
</cfoutput>