<cfoutput>
<!--============================Sidebar============================-->
<div class="sidebar">
	<!--- Info Box --->
	<div class="small_box">
		<div class="header">
			<img src="#rc.root#/includes/images/iinfo_icon.png" alt="info" width="24" height="24" />#rc.loadedAPIName# API
		</div>
		<div class="body">
			<p>Choose a tier+resource to test:</p>
			<!--=== Accordion ===-->
			<div id="accordion" class="clearfix">
				<!-- Accordion Items-->
				<cfloop collection="#rc.dsl.relax.entryPoint#" item="entryPoint">
				<h2><img src="#rc.root#/includes/images/arrow_right.png" alt="" width="6" height="6" class="arrow_right" /> <img src="#rc.root#/includes/images/arrow_down.png" alt="" width="6" height="6" class="arrow_down" /> <strong>#entryPoint#</strong> </h2>
				<div class="pane" <cfif rc.entryTier eq entryPoint>style="display:block"</cfif>>
					<!--- My Resources --->
					<select name="myResource" id="myResource" title="Your defined RESTful resources" onchange="resourceSelect(this.value,'#entrypoint#')">
						<option value="null" selected="selected">Pick One To Test</option>
						<cfloop array="#rc.dsl.resources#" index="thisResource">
							<option value="#thisResource.resourceID#;#rc.dsl.relax.entryPoint[entryPoint]##thisResource.pattern#">#thisResource.pattern#</option>
						</cfloop>
					</select>
				</div>
				</cfloop>
			</div>
			<!--End Accordion-->
			
			<!--- Help button --->
			<p class="center">
				<br/>
				<button class="button" onclick="return showResourceHelp()" title="Selected Resource Help"> <img src="#rc.root#/includes/images/help_small.png" alt="help"/> Resource Doc</button>
			</p>
		</div>
	</div>	
	<!--- Replay Button --->
	<div class="small_box" id="requestHistoryContainer">
		<div class="header">
			<img src="#rc.root#/includes/images/history.png" alt="History" width="24" height="24" />Request History
		</div>
		<!--- MessageHolder --->
		<div id="requestHistoryMessages" class="flickerMessages"></div>
		<div class="body">
			<p class="center">
				<!--- Selection Box --->
				<select name="requestHistory" id="requestHistory" <cfif arrayLen(rc.requestHistory) EQ 0>disabled="disabled"</cfif>>
					<cfif arrayLen(rc.requestHistory) EQ 0>
						<option value="null">No History</option>
					<cfelse>
						<option value="null">Select History Item</option>
					</cfif>
					<cfloop from="1" to="#arrayLen(rc.requestHistory)#" index="x">
						<option value='#x-1#'>#printDate(rc.requestHistory[x].requestDate)#</option>
					</cfloop>					
				</select>
				<br/>
			</p>
			
			<p class="center">	
				<!--- Clear History Command --->
				<a href="javascript:clearHistory()" class="button confirmIt" 
				   title="Clear the request history"
				   data-message="Do you really want to clear your request history?">
					<span>
						<img src="#rc.root#/includes/images/edit-clear.png" border="0" align="absmiddle" alt="purge history" />
					</span>
				</a>
				
				<!--- Replay Command --->
				<a href="javascript:rebuildRequest()" class="button" title="Rebuild the request">
					<span>
						<img src="#rc.root#/includes/images/play.png" border="0" align="absmiddle" alt="replay request" />
					</span>
				</a>
			</p>
			
			<!--- Loader --->
			<div id="historyLoader" class="loaders">
				<p>
					<img src="#rc.root#/includes/images/ajax-loader-blue.gif" alt="loader" />
				</p>
			</div>
			
		</div>
	</div>	
</div>
<!--End sidebar-->

<!--============================Main Column============================-->
<div class="main_column">
	<div class="box">
		<div class="header" id="relaxerHeader">
			<img src="#rc.root#/includes/images/web.png" alt="Database" width="30" height="30" title="Go Relax!" />
			RelaxURL Console
		</div>
		
		<div class="body">
			<!--- MessageBox --->
			#getPlugin("messagebox").renderit()#	
			
			<form name="relaxerForm" id="relaxerForm" action="#event.buildLink(rc.xehRelaxer)#" method="post">
				<input type="hidden" name="sendrequest" value="true" />
				
				<fieldset>
					<legend>Method-Resource-Format</legend>
				
				<!--- Resource ID --->
				<input type="hidden" name="resourceID" 	 id="resourceID" 	value="null" />
				<input type="hidden" name="resourceTier" id="resourceTier" 	value="production" />
				
				<!--- HTTP Method --->
				<select name="httpMethod" id="httpMethod" title="Choose your HTTP Method">
					<option <cfif rc.httpMethod eq "GET">selected="selected"</cfif>>GET</option>
					<option <cfif rc.httpMethod eq "PUT">selected="selected"</cfif>>PUT</option>
					<option <cfif rc.httpMethod eq "POST">selected="selected"</cfif>>POST</option>
					<option <cfif rc.httpMethod eq "DELETE">selected="selected"</cfif>>DELETE</option>
					<option <cfif rc.httpMethod eq "HEAD">selected="selected"</cfif>>HEAD</option>
					<option <cfif rc.httpMethod eq "OPTIONS">selected="selected"</cfif>>OPTIONS</option>
				</select> 
				
				<!--- Spacer --->
				<img src="#rc.root#/includes/images/bullet_right.png" alt="right"/>
				
				<!--- Resource or URL --->
				<input title="The resource to hit" type="text" name="httpResource" id="httpResource" size="70" class="textfield" value="#rc.httpResource#" />
				
				<!--- Spacer --->
				<img src="#rc.root#/includes/images/bullet_right.png" alt="right"/>
				
				<!--- Format --->
				<select name="httpFormat" id="httpFormat" title="The resource format extension (if available)">
					<option value="" <cfif rc.httpFormat eq "">selected="selected"</cfif>>none</option>
					<option <cfif rc.httpFormat eq "xml">selected="selected"</cfif>>xml</option>
					<option <cfif rc.httpFormat eq "json">selected="selected"</cfif>>json</option>
					<option <cfif rc.httpFormat eq "jsont">selected="selected"</cfif>>jsont</option>
					<option <cfif rc.httpFormat eq "rss">selected="selected"</cfif>>rss</option>
				</select>
				
				<!--- Button Bar --->
				<button class="button" title="Advanced Settings" onClick="advancedSettings();return false;"> <img src="#rc.root#/includes/images/settings.png" alt="settings" height="16"/></button>
				<button class="button" title="Send Request" onclick="submitForm();return false;"> <img src="#rc.root#/includes/images/send-receive.png" alt="settings" height="16"/> </button>
				
				</fieldset>
				
				<!--- Advanced Settings --->
				<div id="advancedSettings">
					<fieldset style="background-color:##e5e5e5">
						<legend>Advanced Settings</legend>
					
					<!--- HTTP Basic Auth --->
					<fieldset>
						<legend>HTTP Basic Authentication</legend>
						Username:
						<input title="Username"  type="text" class="textfield" name="username" id="username" size="30" value="#rc.username#" />
						Password: 
						<input title="Password"  type="text" class="textfield" name="password" id="password" size="30" value="#rc.password#" />
						
					</fieldset>
					
					<!--- HTTP Proxy --->
					<fieldset>
						<legend>HTTP Proxy</legend>
						Host:
						<input title="HTTP Proxy"  type="text" class="textfield" name="httpProxy" id="httpProxy"  size="30" value="#rc.httpProxy#" />
						Port: 
						<input title="HTTP Proxy Port"  type="text" class="textfield" name="httpProxyPort" id="httpProxyPort" size="30" value="#rc.httpProxyPort#" />
						
					</fieldset>
									
					<!--- HTTP Headers --->
					<fieldset>
						<legend>API Headers</legend>
						
						<!--- Headers Holder --->
						<div id="httpHeaders">
							<cfloop from="1" to="#listLen(rc.headerNames)#" index="i">
							<p style="margin:0px">
								<input title="Header Name"  type="text" class="textfield" name="headerNames"  size="30" value="#listGetAt(rc.headerNames,i)#" />
								<input title="Header Value" type="text" class="textfield" name="headerValues" size="50" 
									   value="<cfif listLen(rc.headerValues)>#listGetAt(rc.headerValues,i)#</cfif>"/>
								<button class="button dynamicRemove" onclick="return false;"><img src="#rc.root#/includes/images/delete.png" alt="delete"/></button>
							</p>
							</cfloop>						
							<!--- Add Header --->
							<button class="button dynamicAdd" data-type="header" title="Add Header" id="addHeaderButton" onclick="return false;"><img src="#rc.root#/includes/images/add.png" /></button>
						</div>
					</fieldset>
					
					<!--- Query Params --->
					<fieldset>
						<legend>API Parameters</legend>
						
						<!--- Parameters Holder --->
						<div id="httpParameters">
							<cfloop from="1" to="#listLen(rc.parameterNames)#" index="i">
							<p style="margin:0px">
								<input title="Parameter Name"  type="text" class="textfield" name="parameterNames"  size="30" value="#listGetAt(rc.parameterNames,i)#" />
								<input title="Parameter Value" type="text" class="textfield" name="parameterValues" size="50" 
									   value="<cfif listLen(rc.parameterValues)>#listGetAt(rc.parameterValues,i)#</cfif>" />
								<button class="button dynamicRemove" onclick="return false;"><img src="#rc.root#/includes/images/delete.png" alt="delete"/></button>
							</p>
							</cfloop>
							<!--- Add Header --->
							<button class="button dynamicAdd" data-type="parameter" title="Add Parameter" id="addParameterButton" onclick="return false;"><img src="#rc.root#/includes/images/add.png" /></button>
						</div>
					</fieldset>
					
					</fieldset>
				</div>
			</form>
				
			<!--- Loader --->
			<div id="bottomCenteredLoader">
				<p>
					Sending Request... <br/>
					<img src="#rc.root#/includes/images/ajax-loader-blue.gif" alt="loader" />
				</p>
			</div>
			
			
			<!--- results --->
			<cfif structKeyExists(rc,"results")>
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
										#rc.results.statuscode#
									</td>
								</tr>
								<cfloop collection="#rc.results.responseHeader#" item="header">
								<tr>
									<th width="125" class="textRight">#header#</th>
									<td>
										#rc.results.responseHeader[header].toString()#
									</td>
								</tr>
								</cfloop>							
							</table>
						</div>
						<!--- Raw Content --->
						<div class="pane">
							<form>
							<textarea id="resultsRAW" class="textfield" rows="30" style="width:100%">#rc.results.fileContent.toString()#</textarea>
							</form>
						</div>
						<!--- Pretty Content --->
						<div class="pane">
							<pre id="resultsPretty" class="brush: #getBrush(rc.results.fileContent)#">#getTreatedContent(rc.results.fileContent)#
							</pre>
						</div>				
					</div>
				</div>
			</cfif>
			<!--- end Results Box --->
		</div>
	
	</div>
	<!--- end Box --->
	
</div>

<!--- Fields Template --->
<p id="fieldsTemplate" style="display:none;margin:0px">
	<input type="text" data-title="::fieldType:: name"  name="::fieldType::Names"  class="textfield" size="30" />
	<input type="text" data-title="::fieldType:: value" name="::fieldType::Values" class="textfield" size="50" />
	<button class="button dynamicRemove" onclick="return false;"><img src="#rc.root#/includes/images/delete.png" alt="delete"/></button>
</p>
<script language="javascript">
$(document).ready(function() {
	$relaxerForm 	= $("##relaxerForm");
	$resultsBox  	= $("##resultsBox");
	$relaxerHeader 	= $("##relaxerHeader");
	
	<cfif structKeyExists(rc,"results")>
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
	<cfif( NOT isXML(rc.results.fileContent) )>
		$("##resultsPretty").html( formatJSONRaw('#JSStringFormat(rc.results.fileContent)#') );	
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
	<cfloop array="#rc.dsl.resources#" index="thisResource">
		$resources['#thisResource.resourceID#'] = #serializeJSON( thisResource )#;
 	</cfloop>
	//json history
	reqHistory = [];
	<cfloop from="1" to="#arrayLen(rc.requestHistory)#" index="x">
	reqHistory[#x-1#] = #serializeJSON(rc.requestHistory[x])#;
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
		openRemoteModal('#event.buildLink(rc.xehResourceDoc)#',{
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
	$.post('#event.buildLink(rc.xehPurgeHistory)#',{},
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