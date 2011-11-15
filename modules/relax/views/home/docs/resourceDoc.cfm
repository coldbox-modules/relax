<cfoutput>
<!--- Is resource coming from RC? Means direct view rendering and not collection rendering. --->
<cfif structKeyExists(rc,"thisResource")><cfset variables.thisResource = rc.thisResource></cfif>

<!--- Print Buttons --->
<cfif NOT structKeyExists(rc,"print")>
<div id="exportBar">
	<a title="Print HTML Document"
	   target="_blank"
	   href="#event.buildlink(linkTo=rc.xehResourceDoc,queryString='resourceID='&thisResource.resourceID&"&print=html")#">
		<img src="#rc.root#/includes/images/print.png" alt="print" />
	</a>
	&nbsp;
	<a title="Print PDF"
	   target="_blank"
	   href="#event.buildlink(linkTo=rc.xehResourceDoc,queryString='resourceID='&thisResource.resourceID&"&print=pdf")#">
		<img src="#rc.root#/includes/images/pdf.png" alt="print" />
	</a>
</div>
</cfif>

<!--- Pattern Title --->
<h3>
<img src="#rc.root#/includes/images/website.png" alt="resource"/> 
<cfif rc.expandedResourceDivs>
	#thisResource.pattern#
<cfelse>
	<a href="javascript:toggleResource('#thisResource.resourceID#')">#thisResource.pattern#</a>
</cfif>
</h3>

<!--- Div Content --->
<div id="resource_#thisResource.resourceID#" class="resourceDiv" <cfif rc.expandedResourceDivs>style="display:block"</cfif>>
	<!--- Description --->
	<fieldset>
		<legend>Description</legend>
		<p>#thisResource.description#</p>
	</fieldset>
	<!--- Entry Points --->
	<fieldset>
		<legend>Service Entry Point(s)</legend>
		<cfloop collection="#rc.dsl.relax.entryPoint#" item="entryPoint">
		<p>#entryPoint#</p>
		<pre class="brush: xml; ruler: false">#rc.dsl.relax.entryPoint[entryPoint]#</pre>
		</cfloop>
	</fieldset>
	<!--- URL --->
	<fieldset>
		<legend>Resource URL & Event Translations</legend>
		<pre class="brush: html; auto-links:false">#thisResource.pattern#<cfif rc.dsl.relax.extensionDetection>.{format}</cfif></pre>
		<p>
			<strong>Pattern</strong>: #thisResource.pattern#<br/>
			<strong>Handler</strong>: <cfif structKeyExists(thisResource,"handler")>#thisResource.handler#<cfelse>---</cfif><br/>
			<strong>Action</strong>:  <cfif structKeyExists(thisResource,"action")>#thisResource.action.toString()#<cfelse>---</cfif><br/>
		</p>
	</fieldset>
	<!--- PlaceHolder Definitions --->
	<fieldset>
		<legend>URL Pattern Placeholders</legend>
		<p>The following patterns are part of the RESTful resource and must be passed in the exact
		position shown in the URL resource. Usually placeholders start with a <strong>(:)</strong> colon.</p>
		
		<pre class="brush: html; auto-links:false">#thisResource.pattern#<cfif rc.dsl.relax.extensionDetection>.{format}</cfif></pre>
		
		<cfif NOT structKeyExists(thisResource,"placeholders") or NOT arrayLen(thisResource.placeholders)>
			<em>Route Pattern has no Placeholders</em>
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
		<legend>HTTP Request Methods</legend>
		<p>
			<strong>Supported: </strong> #thisResource.methods#<br/>
			<strong>Default: </strong> #thisResource.defaultMethod#<br/>
		</p>
	</fieldset>
	<!--- HTTP Headers --->
	<fieldset>
		<legend>HTTP Headers</legend>
		<cfif NOT structKeyExists(thisResource,"globalHeaders") or NOT arrayLen(thisResource.globalHeaders)>
			<em>No Headers</em>
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
		<p>HTTP Parameters are passed to the resource via the URL or via FORM posts depending on the HTTP verb used.</p>
		<cfif NOT structKeyExists(thisResource,"parameters") or NOT arrayLen(thisResource.parameters)>
			<em>No Parameters</em>
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
	<!--- Response & Samples --->
	<fieldset>
		<legend>Response</legend>
		
		<!--- Default Response --->
		<cfif structKeyExists(thisResource,"defaultFormat")>
			<strong>Default Response Format: </strong> #thisresource.defaultFormat# <br/>
		</cfif>
		
		<!--- Check if we have response definitions --->
		<cfif NOT structCount(thisResource.response)>
			<em>No Response Definitions Defined</em>
		<cfelse>
			<!--- Schemas --->
			<cfif structKeyExists(thisResource.response, "schemas") and arrayLen(thisResource.response.schemas)>
				<p><strong>Schemas</strong></p>
				<cfloop array="#thisResource.response.schemas#" index="thisSchema">
					<cfif structKeyExists(thisSchema, "description")>
						<p>#thisSchema.description#</p>
					</cfif>
					<pre class="brush: #getBrushByType(thisSchema.format)#; auto-links:false">#htmlEditFormat(thisSchema.body)#</pre>
				</cfloop>
			</cfif>
			<!--- Samples --->
			<cfif structKeyExists(thisResource.response, "samples") and arrayLen(thisResource.response.samples)>
				<p><strong>Samples</strong></p>
				<cfloop array="#thisResource.response.samples#" index="thisSample">
					<cfif structKeyExists(thisSample, "description")>
						<p>#thisSample.description#</p>
					</cfif>
					<pre class="brush: #getBrushByType(thisSample.format)#; auto-links:false">#htmlEditFormat(thisSample.body)#</pre>
				</cfloop>
			</cfif>
		</cfif>
	</fieldset>
</div>
</cfoutput>