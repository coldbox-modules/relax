<cfoutput>
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
	<em>No global headers</em>
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
</cfoutput>