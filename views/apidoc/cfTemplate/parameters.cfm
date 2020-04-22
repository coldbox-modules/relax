<cfscript>
	parameters = args.entity[ "parameters" ];
</cfscript>
<cfoutput>
	<div class="card-body">
		<table class="table table-striped table-condensed">
			<thead>
				<tr>
					<th class="text-secondary">Name</th>
					<th class="text-secondary">Type</th>
					<th class="text-secondary">Description</th>
					<th class="text-secondary">Delivery</th>
					<th class="text-secondary">Required?</th>
				</tr>
			</thead>
			<cfloop array="#parameters#" index="param">
				<tbody>
					<tr>
						<td style="vertical-align:top;">
							<code>#param["name"]#</code>
						</td>

						<td style="vertical-align:top;">
							<cfif structKeyExists( param, "type" ) and ( structKeyExists( param, "in" ) or param[ "in" ] eq 'body' )>
								<code>#param.type#</code>
							<cfelseif structKeyExists( param, "type" ) and structKeyExists( param, "schema" ) && structKeyExists( param[ "schema" ], "type" )>
								<code>#param[ "schema" ][ "type" ]# (body)</code>
							<cfelse>
								<span>N/A</span>
							</cfif>
						</td>

						<td style="vertical-align:top;">
							<cfif structKeyExists( param, "description" )>
								<p>#param[ "description" ]#</p>
							</cfif>
						</td>

						<td style="vertical-align:top;">
							<cfif structKeyExists( param, "in" )>
								<p>Provided in the <code>#param[ "in" ]#</code> of the request</p>
							<cfelse>
								<p>Provided in either <code>form</code>, <code>query</code> or <code>body</code> of the request</p>
							</cfif>
						</td>

						<cfset paramRequired = structKeyExists( param, "required" ) && param[ "required" ] />
						<td style="vertical-align:top;">
							<i class="fa fa-#(paramRequired ? 'check-circle text-danger' : 'circle-o text-muted')#"></i>
						</td>
					</tr>

					<cfif structKeyExists( param, "schema" )>
						<td colspan="5" style="vertical-align:top;">
							#renderView( view="apidoc/cfTemplate/schema", args={ "schema": param[ "schema" ] } )#
						</td>
					</cfif>

				</tbody>
			</cfloop>
		</table>
	</div>
</cfoutput>