<cfoutput>
<!--- Service Title and Description --->
<h1>#prc.dsl.relax.title#</h1>
<blockquote>#prc.dsl.relax.description#</blockquote>

<!--- Entry Points --->
<h2>Service Entry Point(s)</h2>
<cfloop collection="#prc.dsl.relax.entryPoint#" item="entryPoint">
<p class="label label-info">#entryPoint#</p>
<pre class="brush: xml; ruler: false">#prc.dsl.relax.entryPoint[entryPoint]#</pre>
</cfloop>

<!--- API Return Formats --->
<h2>API Return Formats</h2>
<p>
	This service can detect the incoming resource extension in order to provide to you the resource represented
	according to the extension:
	<pre class="brush: html; auto-links:false">
	resource.{format}
	resource.json
	resource.xml</pre>

</p>
<table class="table table-striped table-hover" width="100%">
	<tr>
		<th width="250" class="textRight">Service Extension Detection:</th>
		<td>#yesNoFormat(prc.dsl.relax.extensionDetection)#</td>
	</tr>
	<tr>
		<th  class="textRight">Allowed Extensions:</th>
		<td>#prc.dsl.relax.validExtensions#</td>
	</tr>
	<tr>
		<th  class="textRight">Throw On Invalid Extension:</th>
		<td>#yesNoFormaT(prc.dsl.relax.throwOnInvalidExtension)#</td>
	</tr>
</table>

<!--- API Global Headers --->
<h2>API Global Headers</h2>
<cfif NOT arrayLen(prc.dsl.globalHeaders)>
	<em>No global headers</em>
</cfif>
<table class="table table-striped table-hover" width="100%">
	<tr>
		<th>Header</th>
		<th width="75">Type</th>
		<th width="40">Required</th>
		<th>Default</th>
		<th>Description</th>
	</tr>
	<cfloop array="#prc.dsl.globalHeaders#" index="thisHeader">
	<tr>
		<td><code>#thisHeader.name#</code></td>
		<td><cfif structKeyExists(thisHeader,"type")>#thisHeader.type#<cfelse>string</cfif></td>
		<td><cfif structKeyExists(thisHeader,"required")>#thisHeader.required#<cfelse>false</cfif></td>
		<td><cfif structKeyExists(thisHeader,"default")>#thisHeader.default#<cfelse>---</cfif></td>
		<td><cfif structKeyExists(thisHeader,"description")>#thisHeader.description#<cfelse>---</cfif></td>							
	</tr>
	</cfloop>
</table>

<!--- API Global Parameters --->
<h2>API Global Parameters</h2>
<cfif NOT arrayLen(prc.dsl.globalParameters)>
	<em>No global parameters</em>
</cfif>
<table class="table table-striped table-hover" width="100%">
	<tr>
		<th>Parameter</th>
		<th width="75">Type</th>
		<th width="40">Required</th>
		<th>Default</th>
		<th>Description</th>
	</tr>
	<cfloop array="#prc.dsl.globalParameters#" index="thisParam">
	<tr>
		<td><code>#thisParam.name#</code></td>
		<td><cfif structKeyExists(thisParam,"type")>#thisParam.type#<cfelse>string</cfif></td>
		<td><cfif structKeyExists(thisParam,"required")>#thisParam.required#<cfelse>false</cfif></td>
		<td><cfif structKeyExists(thisParam,"default")>#thisParam.default#<cfelse>---</cfif></td>
		<td><cfif structKeyExists(thisParam,"description")>#thisParam.description#<cfelse>---</cfif></td>							
	</tr>
	</cfloop>
</table>
</cfoutput>