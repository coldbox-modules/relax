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
					<legend>Defined Resources</legend>
					<p>Here are your relaxed resources. Choose one in order to populate the RelaxURL console with the resource's defintion.</p>
					<select name="resource" id="resource">
						<option>None Defined</option>
					</select>
				</fieldset>
				
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
						<p style="margin:0px">
							<input title="Header Name"  type="text" class="textfield" name="headerNames"  size="30" />
							<input title="Header Value" type="text" class="textfield" name="headerValues" size="50" />
							<button class="button dynamicRemove"><img src="#rc.root#/includes/images/delete.png" alt="delete"/></button>
						</p>
						<!--- Add Header --->
						<button class="button dynamicAdd" title="Add Header" id="addHeaderButton"><img src="#rc.root#/includes/images/add.png" /></button>
					</div>
				</fieldset>
				
				<!--- Query Params --->
				<fieldset>
					<legend>API Parameters</legend>
					
					<!--- Parameters Holder --->
					<div id="httpParameters">
						<p style="margin:0px">
							<input title="Parameter Name"  type="text" class="textfield" name="parameterNames"  size="30" />
							<input title="Parameter Value" type="text" class="textfield" name="parameterValues" size="50" />
							<button class="button dynamicRemove"><img src="#rc.root#/includes/images/delete.png" alt="delete"/></button>
						</p>
						<!--- Add Header --->
						<button class="button dynamicAdd" title="Add Parameter" id="addHeaderButton"><img src="#rc.root#/includes/images/add.png" /></button>
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
			<h3>Response</h3>
			<!--- Results Table --->
			<table class="tablelisting" width="100%">
				<tr>
					<th width="100" class="textRight">URL:</th>
					<td><a href="#rc.httpResource#" target="_blank">#rc.httpResource#</a></td>
				</tr>
				<tr>
					<th class="textRight">Request Headers:</th>
					<td>
						<cfif len(rc.headerNames)>
							<cfloop from="1" to="#listLen(rc.headerNames)#" index="i">
							#listGetAt(rc.headerNames, i)#=#listGetAt(rc.headerValues,i)#;
							</cfloop>
						<cfelse>
						<em>None Sent</em>
						</cfif>
					</td>
				</tr>
				<tr>
					<th class="textRight">Request Params:</th>
					<td>
						<cfif len(rc.parameterNames)>
							<cfloop from="1" to="#listLen(rc.parameterNames)#" index="i">
							#listGetAt(rc.parameterNames, i)#=#listGetAt(rc.parameterValues,i)#;
							</cfloop>
						<cfelse>
						<em>None Sent</em>
						</cfif>
					</td>
				</tr>
				<tr>
					<th class="textRight">Status Code:</th>
					<td>#rc.results.statusCode#</td>
				</tr>
				<tr>
					<th class="textRight">Response Header</th>
					<td>#rc.results.header#</td>
				</tr>			
				
			</table>
			
			<h3>Raw Results:</h3>
			<form>
			<textarea class="textfield" rows="10" style="width:100%">#rc.results.fileContent#</textarea>
			</form>
			
			<h3>Semi-Pretty Results:</h3>
			
			<pre class="brush: #getBrush(rc.results.fileContent)#">#getTreatedContent(rc.results.fileContent)#
			</pre>
			
			
		</div>
	</div>
	</cfif>
	<!--- end Results Box --->
</div>

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
		var $trigger = $(this);
		$trigger.prev().clone(true).insertBefore( $trigger );
		$trigger.prev().find("button").fadeIn();
		return false;
	});
	// Removal Dynamic
	$(".dynamicRemove").click(function() {
		$container = $(this).parent().parent();
		if ($container.find("p").size() > 1) {
			$(this).parent().remove();
		}	
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