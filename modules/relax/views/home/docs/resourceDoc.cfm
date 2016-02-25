<cfoutput>
<!--- Is resource coming from RC? Means direct view rendering and not collection rendering. --->
<cfif structKeyExists( prc, "thisResource")><cfset variables.thisResource = prc.thisResource></cfif>

<!--- Print Buttons --->
<cfif NOT structKeyExists( rc, "print" )>
<div id="exportBar" class="pull-right">
	<div class="btn-group">
		<a title="Print HTML Document"
		   target="_blank"
		   class="btn btn-info"
		   href="#event.buildlink(linkTo=prc.xehResourceDoc,queryString='resourceID='&thisResource.resourceID&"&print=html")#">
			<i class="fa fa-print"></i>
		</a>
		&nbsp;
		<a title="Print PDF"
		   target="_blank"
		   class="btn btn-info"
		   href="#event.buildlink(linkTo=prc.xehResourceDoc,queryString='resourceID='&thisResource.resourceID&"&print=pdf")#">
			<i class="fa fa-file-pdf-o"></i>
		</a>
		&nbsp;
 		<a title="View Details"
 			class="btn btn-info"
 			href="#event.buildlink(linkTo=prc.xehResourceDoc,queryString='resourceID='&thisResource.resourceID&"&print=relax")#">
 			<i class="fa fa-file-text-o"></i>
 		</a>
	</div>
</div>
</cfif>

<!--- Pattern Title --->
<h3>
<i class="fa fa-globe"></i>
<code>
<cfif prc.expandedResourceDivs>
	#thisResource.pattern#
<cfelse>
	<a href="javascript:toggleResource( '#thisResource.resourceID#' )">#thisResource.pattern#</a>
</cfif>
</code>
</h3>

<!--- Div Content --->
<div id="resource_#thisResource.resourceID#" <cfif prc.expandedResourceDivs>style="display:block"<cfelse>style="display:none"</cfif>>
	
	<!--- Description --->
	<fieldset>
		<legend>Description</legend>
		<p>#thisResource.description#</p>
	</fieldset>

	<!--- Entry Points --->
	<fieldset>
		<legend>Service Entry Point(s)</legend>
		<cfloop collection="#prc.dsl.relax.entryPoint#" item="entryPoint">
		<p class="label label-info">#entryPoint#</p>
		<pre class="brush: xml; ruler: false">#prc.dsl.relax.entryPoint[ entryPoint ]#</pre>
		</cfloop>
	</fieldset>

	<!--- URL --->
	<fieldset>
		<legend>Resource URL & Event Translations</legend>
		<pre class="brush: html; auto-links:false">#thisResource.pattern#<cfif prc.dsl.relax.extensionDetection>.{format}</cfif></pre>
		<p>
			<strong>Pattern</strong>: <code>#thisResource.pattern#</code><br/>
			<strong>Handler</strong>: <code><cfif structKeyExists(thisResource,"handler")>#thisResource.handler#<cfelse>---</cfif></code><br/>
			<strong>Action</strong>:  <code><cfif structKeyExists(thisResource,"action")>#thisResource.action.toString()#<cfelse>---</cfif></code><br/>
		</p>
	</fieldset>

	<!--- PlaceHolder Definitions --->
	<fieldset>
		<legend>URL Pattern Placeholders</legend>
		<p>The following patterns are part of the RESTful resource and must be passed in the exact
		position shown in the URL resource. Usually placeholders start with a <code>(:)</code> colon.</p>
		
		<pre class="brush: html; auto-links:false">#thisResource.pattern#<cfif prc.dsl.relax.extensionDetection>.{format}</cfif></pre>
		
		<cfif NOT structKeyExists(thisResource,"placeholders") or NOT arrayLen(thisResource.placeholders)>
			<div class="alert alert-warning">Route Pattern has no Placeholders</div>
		<cfelse>
			<table class="table table-hover table-striped" width="100%">
				<tr>
					<th>Placeholder</th>
					<th width="75">Type</th>
					<th width="40">Required</th>
					<th>Default</th>
					<th>Description</th>
				</tr>
				<cfloop array="#thisResource.placeholders#" index="thisHolder">
				<tr>
					<td><code>#thisHolder.name#</code></td>
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
			<strong>Supported: </strong> <code>#thisResource.methods#</code><br/>
			<strong>Default: </strong> <code>#thisResource.defaultMethod#</code><br/>
		</p>
	</fieldset>

	<!--- HTTP Headers --->
	<fieldset>
		<legend>HTTP Headers</legend>
		<cfif NOT structKeyExists(thisResource,"headers") or NOT arrayLen(thisResource.headers)>
			<div class="alert alert-warning">No Headers</div>
		<cfelse>
			<table class="table table-hover table-striped" width="100%">
				<tr>
					<th>Header</th>
					<th width="75">Type</th>
					<th width="40">Required</th>
					<th>Default</th>
					<th>Description</th>
				</tr>
				<cfloop array="#thisResource.headers#" index="thisHeader">
					<tr>
						<td><code>#thisHeader.name#</code></td>
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
			<div class="alert alert-warning">No Parameters</div>
		<cfelse>
			<table class="table table-hover table-striped" width="100%">
				<tr>
					<th>Header</th>
					<th width="75">Type</th>
					<th width="40">Required</th>
					<th>Default</th>
					<th>Description</th>
				</tr>
				<cfloop array="#thisResource.parameters#" index="thisParam">
					<tr>
						<td><code>#thisParam.name#</code></td>
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
			<p><strong>Default Response Format: </strong> <code>#thisresource.defaultFormat#</code></p>
		</cfif>
		
		<!--- Check if we have response definitions --->
		<cfif NOT structCount(thisResource.response)>
			<div class="alert alert-warning">No Response Definitions Defined</div>
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