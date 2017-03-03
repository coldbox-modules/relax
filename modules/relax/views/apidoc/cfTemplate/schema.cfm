<cfoutput>
<div class="panel panel-solid-default">
	<cfif prc.pdf ?: false>
		<code>#serializeJSON( args.entity[ "schema" ] )#</code>
	<cfelse>
		<pre class="language-javascript">#serializeJSON( args.entity[ "schema" ] )#</pre>
	</cfif>
</div>
</cfoutput>