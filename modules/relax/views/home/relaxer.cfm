<cfoutput>
<!--============================Sidebar============================-->
<div class="sidebar">
	<div class="small_box">
		<div class="header">
			<img src="#rc.root#/includes/images/iinfo_icon.png" alt="History" width="24" height="24" />RelaxURL
		</div>
		<div class="body">
			<strong>RelaxURL</strong>, pronounced "Relax-ER", is a utility to help you test against your Relaxed
			RESTful service definitions.
		</div>
	</div>	
</div>
<!--End sidebar-->

<!--============================Main Column============================-->
<div class="main_column">
	<div class="box">
		<div class="header">
			<img src="#rc.root#/includes/images/web.png" alt="Database" width="30" height="30" title="Go Relax!" />
			RelaxURL Console
		</div>
		
		<div class="body">
			<!--- MessageBox --->
			#getPlugin("messagebox").renderit()#	
			
			<form name="relaxerForm" id="relaxerForm" action="#event.buildLink(event.getCurrentEvent())#" method="post">
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
					<option <cfif rc.httpFormat eq "">selected="selected"</cfif>>none</option>
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
							<input title="Header Value" type="text" class="textfield" name="headerValues" size="50" value="#listGetAt(rc.headerValues,i)#"/>
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
							<input title="Parameter Value" type="text" class="textfield" name="parameterValues" size="50" value="#listGetAt(rc.parameterValues,i)#" />
							<button class="button dynamicRemove"><img src="#rc.root#/includes/images/delete.png" alt="delete"/></button>
						</p>
						</cfloop>
						<!--- Add Header --->
						<button class="button dynamicAdd" data-type="parameter" title="Add Parameter" id="addHeaderButton"><img src="#rc.root#/includes/images/add.png" /></button>
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
	<div class="box" id="resultsBox">
		<div class="header">
			<img src="#rc.root#/includes/images/web.png" alt="Database" width="30" height="30" title="Go Relax!" />
			RelaxURL Results
		</div>
		
		<div class="body">
			<h3>Raw Results:</h3>
			<form>
			<textarea class="textfield" rows="10" style="width:100%">#rc.results.fileContent.toString()#</textarea>
			</form>
			
			<h3>Semi-Pretty Results:</h3>
			<pre class="brush: #getBrush(rc.results.fileContent)#">#getTreatedContent(rc.results.fileContent)#
			</pre>
			
			<h3>Response Header</h3>
			<table class="tablelisting" width="100%">
				<cfloop collection="#rc.results.responseHeader#" item="header">
				<tr>
					<th width="125" class="textRight">#header#</th>
					<td>
						<cfif isSimpleValue(rc.results.responseHeader[header])>
						#rc.results.responseHeader[header]#
						<cfelse>
						<cfdump var="#rc.results.responseHeader[header]#">
						</cfif>
					</td>
				</tr>
				</cfloop>							
			</table>
			
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
	$relaxerForm = $("##relaxerForm");
	$resultsBox  = $("##resultsBox");
	// syntax highlight
	SyntaxHighlighter.all();
	
	<cfif structKeyExists(rc,"results")>
	// scroll to results
	$.scrollTo($resultsBox, 800, {axis:'y'});
	</cfif>
	
	// Dynamic Add
	$(".dynamicAdd").click(function() {
		var $trigger  = $(this);
		var fieldType = $trigger.attr("data-type");
		
		$("##fieldsTemplate").clone(true).attr("id","").insertBefore( $trigger ).toggle();
		
		$trigger.prev().find("input").each(function(index){
			var $this = $(this);
			var fieldTitle = $this.attr("data-title");
			var fieldName  = $this.attr("name");
			
			$this.attr("title", fieldTitle.replace(/::fieldType::/,fieldType) )
				.attr("name", fieldName.replace(/::fieldType::/,fieldType));
			
			$this.tooltip(toolTipSettings);
		});
		
		return false;
	});
	// Removal Dynamic
	$(".dynamicRemove").click(function() {
		$container = $(this).parent().parent();
		$(this).parent().remove();
		return false;
	});
});
function submitForm(){
	$('##bottomCenteredBar').slideUp("fast");
	$('##bottomCenteredLoader').fadeIn("slow");		
	$relaxerForm.submit();
}
</script>
</cfoutput>