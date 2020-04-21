<cfscript>
	parameters = args.entity[ "parameters" ];
</cfscript>
<cfoutput>
	<table style="width: 100%" border="0" cellpadding="0px" cellspacing="0px">
		<tr>
			<th class="parameter" style="text-align:left">
				Name
			</th>

			<th class="parameter" style="text-align:left">
				Type
			</th>

			<th class="parameter" style="text-align:left">
				Description
			</th>

			<th class="parameter" style="text-align:left">
				Delivery
			</th>

			<th class="parameter" style="text-align:left">
			  Required?
			</th>

		</tr>

		<cfloop array="#parameters#" index="param">
			<cfscript>
				paramUid = "param_" & createUUID();
			</cfscript>

				<tr valign="top">

				    <td class="parameter" valign="top">
				    	<code>#param[ "name" ]#</code>
				    </td >

				    <td  class="parameter" valign="top">
				    	<cfif structKeyExists( param, "type" ) and structKeyExists( param, "in" ) and param[ "in" ] neq 'body' >

				    		<code>#param[ "type" ]#</code>

				    	<cfelseif structKeyExists( param, "type" ) and structKeyExists( param, "schema" ) and structKeyExists( param[ "schema" ], "type" )>

				    		<code>#param[ "schema.type" ]# (body)</code>

				    	<cfelse>

				    		N/A

				    	</cfif>

				    </td>

				    <td  class="parameter" valign="top">
				    	<p>#toParagraphFormat( param[ "description" ] )#</p>
					</td>

					<td class="parameter">
						<cfif structKeyExists( param, "in" )>
							<p>Provided in the <code>#param[ "in" ]#</code> of the request</p>
						<cfelse>
							<p>Provided in either <code>form</code>, <code>query</code> or <code>body</code> of the request</p>
				    	</cfif>
					</td>

				    <td class="parameter" valign="top">
				      <i class="fa fa-#( param[ "required" ] ? 'check-circle text-danger' : 'circle-o text-muted' )#" data-toggle="tooltip" title="This parameter is #( param[ "required" ] ? 'required' : 'optional' )#"></i>
				       <cfif param[ "required" ] >
					       Yes
					   <cfelse>
					    	No
				       </cfif>
				    </td>

				    <cfif
				    	structKeyExists( param, "schema" )
				    	and
	            		(
	            			!structKeyExists( prc, "pdf" )
	            			or
	            			!prc.pdf
	            		)
				    >

					    <tr id="#paramUid#" class="box box-solid-default">
				    		<td colspan="4" valign="top">
				    		<cfif prc.pdf ?: false>
                                <code>#trim( serializeJSON( param[ "schema" ] ) )#</code>
                            <cfelse>
                                <pre class="language-json">#trim( serializeJSON( param[ "schema" ] ) )#</pre>
                            </cfif>
                            </td>
				    	</tr>

				    </cfif>


				</tr>

		</cfloop>
	</tbody>

</table>
</cfoutput>