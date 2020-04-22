<cfscript>
	requestBody = args.entity.requestBody;
</cfscript>

<cfloop array="#requestBody.content.keyArray()#" index="key">
	<cfoutput>
	<div id="#(entity["x-resourceId"] & '-requestBody-' & listLast( key, '/' ))#" class="method-card card card-info">
		<div class="card-header">
			<h3 class="card-title methodHeader">
				<strong>#key#</strong>
			</h3>
		</div>
		<div id="card_#(entity["x-resourceId"] & '-requestBody-' & listLast( key, '/' ))#" class="card-body">
			<cfif structKeyExists( requestBody.content[ key ], "schema" ) && structKeyExists( requestBody.content[ key ].schema, "properties" )>
			#renderView( view="apidoc/cfTemplate/schema", args={ "schema": requestBody.content[ key ].schema } )#
			</cfif>
		</div>
	</div>
	</cfoutput>
</cfloop>

