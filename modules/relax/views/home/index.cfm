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
</div>
<!--End sidebar-->

<!--============================Main Column============================-->
<div class="main_column">
	<div class="box">
		<div class="header" id="relaxerHeader">
			<img src="#rc.root#/includes/images/sofa.png" alt="Database" width="30" height="30" title="Go Relax!" />
			Welcome To Relax
		</div>
		<!--- Body --->
		<div class="body">
			<p>Welcome to your Relax Console.  We have succesfully read the <em>Relax DSL CFC</em>
				you configured at <strong>#rc.settings.configCFC#.cfc</strong>.  Below is the RESTful 
				representation.  From here you can also tap into our <strong>RelaxURL</strong> console to test the resources or any web 
				RESTful service or view our awesome <strong>RelaxLogs</strong> log viewer.
			</p>			
		</div>
		<div class="body_vertical_nav clearfix">
			<!-- Vertical nav -->
			<ul class="vertical_nav">
				<li class="active"><a href="##overview">Service Overview</a></li>
				<li><a href="##resources">Defined Resources</a></li>
				<li><a href="##httpcodes">HTTP Codes</a></li>
			</ul>			
			<div class="main_column">
				<!-- Content area that wil show the form and stuff -->
				<div class="panes_vertical">
					<!--- OverView Panel --->
					<div>
						<h1>#rc.dsl.relax.title#</h1>
						<p>#rc.dsl.relax.description#</p>
						<h3>Main Entry Point</h3>
						<pre class="brush: xml; ruler: false">#rc.dsl.relax.entryPoint#</pre>
						<h3>API Return Formats</h3>
						<p>
							Below is the API information concerning return formats the service can return back.
							These are done via format extensions that are attached to the entry point resources:
							ex:
							<pre class="brush: html; auto-links:false">
							#rc.dsl.relax.entryPoint#/resource.{format}
							#rc.dsl.relax.entryPoint#/resource.json
							#rc.dsl.relax.entryPoint#/resource.xml</pre>
						
						</p>
						<table class="tablelisting" width="100%">
							<tr>
								<th width="200" class="textRight">Service Extension Detection:</th>
								<td>#yesNoFormat(rc.dsl.relax.extensionDetection)#</td>
							</tr>
							<tr>
								<th  class="textRight">Allowed Extensions:</th>
								<td>#rc.dsl.relax.validExtensions#</td>
							</tr>
							<tr>
								<th  class="textRight">Throw On Invalid Extension:</th>
								<td>#yesNoFormaT(rc.dsl.relax.throwOnInvalidExtension)#</td>
							</tr>
						</table>
						
						<h3>API Global Headers</h3>
						<cfif NOT arrayLen(rc.dsl.globalHeaders)>
							#getPlugin("messagebox").renderMessage("warning","No global headers")#
						</cfif>
						<table class="tablelisting" width="100%">
							<tr>
								<th>Header</th>
								<th width="75">Type</th>
								<th width="40">Required</th>
								<th>Default</th>
								<th>Description</th>
							</tr>
							<cfloop array="#rc.dsl.globalHeaders#" index="thisHeader">
							<tr>
								<td><strong>#thisHeader.name#</strong></td>
								<td><cfif structKeyExists(thisHeader,"type")>#thisHeader.type#<cfelse>string</cfif></td>
								<td><cfif structKeyExists(thisHeader,"required")>#thisHeader.required#<cfelse>false</cfif></td>
								<td><cfif structKeyExists(thisHeader,"default")>#thisHeader.default#<cfelse>---</cfif></td>
								<td><cfif structKeyExists(thisHeader,"description")>#thisHeader.description#<cfelse>---</cfif></td>							
							</tr>
							</cfloop>
						</table>
					</div>
					<!--- Resources Panel --->
					<div>
						<h1>Resource Definitions</h1>
						<p>The followin are all the resources defined in the #rc.dsl.relax.title# API</p>
						<cfloop array="#rc.dsl.resources#" index="thisResource">
							<h3><img src="#rc.root#/includes/images/website.png" alt="resource"/> <a href="javascript:toggleResource('#thisResource.id#')">#thisResource.pattern#</a></h3>
							<div id="resource_#thisResource.id#" class="resourceDiv">
								<!--- Description --->
								<fieldset>
									<legend>Description</legend>
									<p>#thisResource.description#</p>
								</fieldset>
								<!--- URL --->
								<fieldset>
									<legend>URL & Event Translations</legend>
									<p>#rc.dsl.relax.entryPoint#<strong>#thisResource.pattern#</strong><cfif rc.dsl.relax.extensionDetection>.<em>format</em></cfif></p>
									<p>
										<strong>Pattern</strong>: #thisResource.pattern#<br/>
										<strong>Handler</strong>: <cfif structKeyExists(thisResource,"handler")>#thisResource.handler#<cfelse>---</cfif><br/>
										<strong>Action</strong>: <cfif structKeyExists(thisResource,"action")>#thisResource.action#<cfelse>---</cfif><br/>
									</p>
								</fieldset>
								<!--- PlaceHolder Definitions --->
								<fieldset>
									<legend>URL Pattern Placeholders</legend>
									<cfif NOT structKeyExists(thisResource,"placeholders") or NOT arrayLen(thisResource.placeholders)>
										#getPlugin("MessageBox").renderMessage("warning","Route Pattern has no Placeholders")#
									<cfelse>
										<table class="tablelisting" width="100%">
											<tr>
												<th>Placeholder</th>
												<th width="75">Type</th>
												<th width="40">Required</th>
												<th>Default</th>
												<th>Description</th>
											</tr>
											<cfloop array="#thisResource.placeholders#" index="thisHolder">
											<tr>
												<td><strong>#thisHolder.name#</strong></td>
												<td><cfif structKeyExists(thisHolder,"type")>#thisHolder.type#<cfelse>string</cfif></td>
												<td><cfif structKeyExists(thisHolder,"required")>#thisHolder.required#<cfelse>false</cfif></td>
												<td><cfif structKeyExists(thisHolder,"default")>#thisHolder.default#<cfelse>---</cfif></td>
												<td><cfif structKeyExists(thisHolder,"description")>#thisHolder.description#<cfelse>---</cfif></td>							
											</tr>
											</cfloop>
										</table>
									</cfif>
								</fieldset>
								<!--- Methods --->
								<fieldset>
									<legend>Supported Request Methods</legend>
									<p>#thisResource.methods#</p>
								</fieldset>
								<!--- HTTP Headers --->
								<fieldset>
									<legend>HTTP Headers</legend>
									<cfif NOT structKeyExists(thisResource,"globalHeaders") or NOT arrayLen(thisResource.globalHeaders)>
										#getPlugin("MessageBox").renderMessage("warning","No Headers")#
									<cfelse>
										<table class="tablelisting" width="100%">
											<tr>
												<th>Header</th>
												<th width="75">Type</th>
												<th width="40">Required</th>
												<th>Default</th>
												<th>Description</th>
											</tr>
											<cfloop array="#thisResource.globalHeaders#" index="thisHeader">
												<tr>
													<td><strong>#thisHeader.name#</strong></td>
													<td><cfif structKeyExists(thisHeader,"type")>#thisHeader.type#<cfelse>string</cfif></td>
													<td><cfif structKeyExists(thisHeader,"required")>#thisHeader.required#<cfelse>false</cfif></td>
													<td><cfif structKeyExists(thisHeader,"default")>#thisHeader.default#<cfelse>---</cfif></td>
													<td><cfif structKeyExists(thisHeader,"description")>#thisHeader.description#<cfelse>---</cfif></td>							
												</tr>
											</cfloop>
										</table>
									</cfif>
								</fieldset>
								<!--- HTTP Paremters --->
								<fieldset>
									<legend>HTTP Parameters</legend>
									<cfif NOT structKeyExists(thisResource,"parameters") or NOT arrayLen(thisResource.parameters)>
										#getPlugin("MessageBox").renderMessage("warning","No Parameters")#
									<cfelse>
										<table class="tablelisting" width="100%">
											<tr>
												<th>Header</th>
												<th width="75">Type</th>
												<th width="40">Required</th>
												<th>Default</th>
												<th>Description</th>
											</tr>
											<cfloop array="#thisResource.parameters#" index="thisParam">
												<tr>
													<td><strong>#thisParam.name#</strong></td>
													<td><cfif structKeyExists(thisParam,"type")>#thisParam.type#<cfelse>string</cfif></td>
													<td><cfif structKeyExists(thisParam,"required")>#thisParam.required#<cfelse>false</cfif></td>
													<td><cfif structKeyExists(thisParam,"default")>#thisParam.default#<cfelse>---</cfif></td>
													<td><cfif structKeyExists(thisParam,"description")>#thisParam.description#<cfelse>---</cfif></td>							
												</tr>
											</cfloop>
										</table>
									</cfif>
								</fieldset>
							</div>
							
						</cfloop>						
					</div>
					<!--- HTTP Codes Panel --->
					<div>
						<h1>HTTP Response Codes</h1>
						<p> All RESTful service APIs should return appropriate <a href="http://en.wikipedia.org/wiki/List_of_HTTP_status_codes">HTTP Status Codes</a> for every request.</p>
						<table class="tablelisting" width="100%">
						  <tbody>
						    <tr>
						      <th width="30"><strong>Code</strong></th>
						      <th><strong>Description</strong></th>
						    </tr>
						    <tr>
						      <td><strong>200</strong></td>
						      <td> Success! </td>
						    </tr>
						    <tr>
						      <td><strong>201</strong></td>
						      <td> Created. A new   resource has been created successfully.  The response body is either   empty or contains a representation revealing the URI of the newly   created resource. </td>
						    </tr>
						    <tr>
						      <td><strong>202</strong></td>
						      <td> Accepted. The request   was valid and accepted but not yet processed.  The response body should   containe a URI to poll for status updates or a token assigned to this   request.  This allows for asynchronous REST requests. </td>
						    </tr>
						    <tr>
						      <td><strong>204</strong></td>
						      <td> No content.  The request was successfull but the server has no response for it. </td>
						    </tr>
						    <tr>
						      <td><strong>301</strong></td>
						      <td> Moved permanently </td>
						    </tr>
						    <tr>
						      <td><strong>302</strong></td>
						      <td> Moved temporarily. The   requested resource resides temporarily under a different URI. Since the   redirection might be altered on occasion, the client SHOULD continue to   use the Request-URI for future requests </td>
						    </tr>
						    <tr>
						      <td><strong>400</strong></td>
						      <td> Bad request. Look at the accompanying error messages to see why the request was invalid. </td>
						    </tr>
						    <tr>
						      <td><strong>401</strong></td>
						      <td> Unauthorized. Client not authorized to make the request. </td>
						    </tr>
						    <tr>
						      <td><strong>403</strong></td>
						      <td> Forbidden.  The   request is understood, but it has been refused.  Look at the   accompanying error messages to see why the request was invalid. </td>
						    </tr>
						    <tr>
						      <td><strong>404</strong></td>
						      <td> Not Found </td>
						    </tr>
						    <tr>
						      <td><strong>405</strong></td>
						      <td> Method Not Allowed.  The requested method is not allowed for that resource </td>
						    </tr>
						    <tr>
						      <td><strong>406</strong></td>
						      <td> Not Acceptable.  Cannot generate representation with given formats, headers or parameters. </td>
						    </tr>
						    <tr>
						      <td><strong>410</strong></td>
						      <td> Gone, the resource is no longer available. </td>
						    </tr>
						    <tr>
						      <td><strong>500</strong></td>
						      <td> Internal service error. </td>
						    </tr>
						    <tr>
						      <td><strong>503</strong></td>
						      <td> Service unavailable. Maybe too many requests. </td>
						    </tr>
						  </tbody>
						</table>

					</div>
				</div>
			</div>
			
		</div>
	
	</div>

</div>
<script language="javascript">
$(document).ready(function() {
	// syntax highlight
	SyntaxHighlighter.all();
});
function toggleResource(id){
	var $div = $("##resource_"+id);
	$div.slideToggle();	
}

</script>
</cfoutput>