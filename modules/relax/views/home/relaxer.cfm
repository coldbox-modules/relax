<cfoutput>
<!--============================Sidebar============================-->
<div class="sidebar">
	<!--- Info Box --->
	<div class="small_box">
		<div class="header">
			<img src="#rc.root#/includes/images/iinfo_icon.png" alt="info" width="24" height="24" />RelaxURL
		</div>
		<div class="body">
			<strong>RelaxURL</strong>, pronounced "Relax-ER", is a utility to help you test against your Relaxed
			RESTful service definitions or any other RESTful web service.
		</div>
	</div>	
	<!--- Replay Button --->
	<div class="small_box" id="requestHistoryContainer">
		<div class="header">
			<img src="#rc.root#/includes/images/history.png" alt="History" width="24" height="24" />Request History
		</div>
		<!--- MessageHolder --->
		<div id="requestHistoryMessages" class="flickerMessages">Test</div>
		<div class="body">
			<p>
			Here are your latest <strong>#arrayLen(rc.requestHistory)#</strong> requests. You can select one so you 
			can replay the request.
			</p>
			
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
				<br/><br/>
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
					<legend>Method-Destination-Format</legend>
				
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
							<button class="button dynamicRemove"><img src="#rc.root#/includes/images/delete.png" alt="delete"/></button>
						</p>
						</cfloop>						
						<!--- Add Header --->
						<button class="button dynamicAdd" data-type="header" title="Add Header" id="addHeaderButton"><img src="#rc.root#/includes/images/add.png" /></button>
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
							<button class="button dynamicRemove"><img src="#rc.root#/includes/images/delete.png" alt="delete"/></button>
						</p>
						</cfloop>
						<!--- Add Header --->
						<button class="button dynamicAdd" data-type="parameter" title="Add Parameter" id="addParameterButton"><img src="#rc.root#/includes/images/add.png" /></button>
					</div>
				</fieldset>
				
				<hr />
			</form>
				
			<!--- Loader --->
			<div id="bottomCenteredLoader">
				<p>
					Sending Request... <br/>
					<img src="#rc.root#/includes/images/ajax-loader-blue.gif" alt="loader" />
				</p>
			</div>
			
			<!--- Button Bar --->
			<div id="bottomCenteredBar">
				<a href="#event.buildLink(event.getCurrentEvent())#" title="Reset RelaxURL">
					<button class="button">Reset</button>
				</a>
				<button class="buttonred" title="Send Request" onclick="submitForm()">Send Request</button>
			</div>
			
		</div>
	
	</div>
	<!--- end Box --->
	
	<!--- results --->
	<cfif structKeyExists(rc,"results")>
	<a name="results"></a> 
	<div class="box" id="resultsBox">
		<div class="header">
			<img src="#rc.root#/includes/images/web.png" alt="Database" width="30" height="30" title="Go Relax!" />
			RelaxURL Results
		</div>
		<br/>
		<div class="body">
			
			<!--- Tabs --->
			<ul class="tabs" id="tabs">
				<li><a href="##" onclick="showTab(0);return false">Response Headers</a></li>
				<li><a href="##" onclick="showTab(1);return false">Raw Results</a></li>
				<li><a href="##" onclick="showTab(2);return false">Pretty Results</a></li>
			</ul>
		
			<!--- Panes --->
			<div class="panes" id="tabPanes">
				<!--- headers --->
				<div class="pane">
					<table class="tablelisting" width="100%">
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
					<textarea class="textfield" rows="30" style="width:100%">#rc.results.fileContent.toString()#</textarea>
					</form>
				</div>
				<!--- Pretty Content --->
				<div class="pane">
					<pre class="brush: #getBrush(rc.results.fileContent)#">#getTreatedContent(rc.results.fileContent)#
					</pre>
				</div>
			
			</div>
			
			<p class="center">
				<button class="button" onclick="toTop()">^ Back To Top ^</button>
			</p>
								
		</div>
	</div>
	</cfif>
	<!--- end Results Box --->
</div>

<!--- Fields Template --->
<p id="fieldsTemplate" style="display:none;margin:0px">
	<input type="text" data-title="::fieldType:: name"  name="::fieldType::Names"  class="textfield" size="30" />
	<input type="text" data-title="::fieldType:: value" name="::fieldType::Values" class="textfield" size="50" />
	<button class="button dynamicRemove"><img src="#rc.root#/includes/images/delete.png" alt="delete"/></button>
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
	
	//json history
	reqHistory = [];
	<cfloop from="1" to="#arrayLen(rc.requestHistory)#" index="x">
	reqHistory[#x-1#] = #serializeJSON(rc.requestHistory[x])#;
	</cfloop>
});
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
		// main options
		selectOption("httpMethod",item.HTTPMETHOD);
		$("##httpResource").val(item.HTTPRESOURCE);
		selectOption("httpFormat",item.HTTPFORMAT);
		// headers
		if (item.HEADERNAMES.length) {
			var headerNames = item.HEADERNAMES.split(",");
			var headerValues = item.HEADERVALUES.split(",");
			$("##httpHeaders p").remove();
			$.each(headerNames, function(index, objValue){
				addDynamicItem($("##addHeaderButton"), [objValue, headerValues[index]]);
			})
		}
		// params
		if (item.PARAMETERNAMES.length) {
			var paramNames = item.PARAMETERNAMES.split(",");
			var paramValues = item.PARAMETERVALUES.split(",");
			$("##httpParameters p").remove();
			$.each(headerNames, function(index, objValue){
				addDynamicItem($("##addParameterButton"), [objValue, paramValues[index]]);
				
			})
		}
		
	}
}
function selectOption(itemID,data){
	$("##"+itemID+" option").each(function(index){
		var $this = $(this);
		if( $this.val() == data){ $this.attr("selected","selected"); }
	});
}
function toTop(){
	$.scrollTo($relaxerHeader, 800, {axis:'y'});
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
</script>
</cfoutput>