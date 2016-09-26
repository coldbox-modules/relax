<cfscript>
	entity = args.entity;
	headerNode =  !structKeyExsts( args, 'headerNode' ) ? 'h3' : args.headerNode;
	skippedAttributes = [ 'x-resourceId','x-entryPoint','x-extensionDetection','x-throwOnInvalidExtension', 'x-request-samples' ];
	xAttributes = [];
	for( nodeName in entity ){
		if( findNoCase( nodeName, 'x-' ) && !arrayContains( skippedAttributes, nodeName ) ){
			var attributeArray = listToArray( nodeName, '-' );
			arrayDeleteAt( attributeArray, 1 );
			var attributeName = titleCase( arrayToList( attributeArray, ' ' ) );
			arrayAppend( xAttributes, {
				"name": attributeName,
				"value": entity[ nodeName ]
			} );	
		}
	}
</cfscript>	
<cfif arrayLen( xAttributes ) >
	<#headerNode# class="text-primary">Extended Attributes:</#headerNode#>
	<table class="table-striped col-xs-12">
		<tr>
			<th width="40%">Name</th>
			<th width="60%">Value</th>
		</tr>
		<cfloop array="#xAttributes#" index="xAttribute">
			<tr>
				<td>
					<strong>#xAttribute.name#
				</td>
				<td>
					<cfscript>
						if( isStruct( xAttribute.value ) || isArray( xAttribute.value ) ){
							attributeValue = formatAPIExample( JSON.stringify( xAttribute.value ), "application/json" );
							useBrush=true;
							brushType = 'json';
						} else {
							useBrush=false;
							attributeValue =xAttribute.value;
						}
					</cfscript>
					<cfif useBrush>
						<pre><code class="language-#brushType#">#attributeValue#</code></pre>
					<cfelse>
						#attributeValue#
					</cfif>
				</td>
			</tr>
		</cfloop>
	</table>
</cfif>