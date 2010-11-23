<cfoutput>
<!--============================Sidebar============================-->
<div class="sidebar">
	<!--=========Users Box=========-->
	<div class="small_box">
		<div class="header">
			<img src="#rc.root#/includes/images/iinfo_icon.png" alt="History" width="24" height="24" />RelaxURL
		</div>
		<div class="body">
			<strong>RelaxURL</strong>, pronounced "Relax-ER", is a utility to help you test against your Relaxed
			RESTful service definition.
		</div>
	</div>
	<!--End Users Box-->	
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
					<option>GET</option>
					<option>PUT</option>
					<option>POST</option>
					<option>DELETE</option>
					<option>HEAD</option>
					<option>OPTIONS</option>
				</select> 
				
				<!--- Spacer --->
				<img src="#rc.root#/includes/images/bullet_right.png" alt="right"/>
				
				<!--- Resource or URL --->
				<input title="Enter your full resource URL" type="text" name="httpResource" id="httpResource" size="70" class="textfield" />
				
				<!--- Spacer --->
				<img src="#rc.root#/includes/images/bullet_right.png" alt="right"/>
				
				<!--- Format --->
				<select name="httpFormat" id="httpFormat" title="Choose the resource format extension">
					<option <cfif rc.format eq "xml">selected="selected"</cfif>>xml</option>
					<option <cfif rc.format eq "json">selected="selected"</cfif>>json</option>
					<option <cfif rc.format eq "jsont">selected="selected"</cfif>>jsont</option>
				</select>
				
				</fieldset>
				
				<!--- HTTP Headers --->
				<fieldset>
					<legend>API Headers</legend>
					
					<!--- Headers Holder --->
					<div id="httpHeaders">
						<p style="margin:0px">
							<input title="Header Name"  type="text" class="textfield" name="headerNames"  size="30" />
							<input title="Header Value" type="text" class="textfield" name="headerValues" size="65" />
							<button class="button dynamicRemove" title="Remove"><img src="#rc.root#/includes/images/delete.png" alt="delete"/></button>
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
							<input title="Parameter Value" type="text" class="textfield" name="parameterValues" size="65" />
							<button class="button dynamicRemove" title="Remove"><img src="#rc.root#/includes/images/delete.png" alt="delete"/></button>
						</p>
						<!--- Add Header --->
						<button class="button dynamicAdd" title="Add Header" id="addHeaderButton"><img src="#rc.root#/includes/images/add.png" /></button>
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
	<div class="box">
		<div class="header">
			<img src="#rc.root#/includes/images/web.png" alt="Database" width="30" height="30" title="Go Relax!" />
			RelaxURL Results
		</div>
		
		<div class="body">
			<div id="apiresults">
				<!---<label class="inline">URL:</label> <a href="#rc.resourceURL#" target="_blank">#rc.resourceURL#</a> <br/>
				--->
				<label class="inline">Status Code:</label> #rc.results.statusCode# <br/>
				<label class="inline">Mime Type:</label> #rc.results.mimetype#
				<label>Content:</label>
				<pre>
				#htmlCodeFormat(xmlHumanReadable(rc.results.fileContent))#
				</pre>
			</div>
		</div>
	</div>
	</cfif>
	<!--- end Results Box --->
</div>

<script language="javascript">
$(document).ready(function() {
	$relaxerForm = $("##relaxerForm");
	// Dynamic Add
	$(".dynamicAdd").click(function() {
		var $trigger = $(this);
		$trigger.prev().clone(true).insertBefore( $trigger );
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