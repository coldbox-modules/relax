<cfscript>
	parameters = args.entity[ "parameters" ];
</cfscript>
<cfoutput>
	<table style="width: 100%" border="0" cellpadding="0px" cellspacing="0px">
		<tr class="col-xs-12 bg-default">
			<th class="parameter-column key col-sm-3 col-xs-8" style="text-align:left">
				Name
			</th>

			<th class="parameter column type col-sm-2 col-xs-4" style="text-align:left">
				Type
			</th>

			<th class="parameter column description col-sm-5 col-xs-8" style="text-align:left">
				Description
			</th>

			<th class="parameter column requirement col-sm-2 col-xs-4" style="text-align:left">
			  Required?
			</th>

		</tr>

		<cfloop array="#parameters#" index="param">
			<cfscript>
				paramUid = "param_" & createUUID();
			</cfscript>

				<tr class="list-group-item parameter optional col-xs-12" valign="top">

				    <td class="parameter-column key col-sm-3 col-xs-8" valign="top">
				    	<code>#param[ "name" ]#</code>
				    </td >

				    <td  class="parameter column type col-sm-2 col-xs-4" valign="top">
				    	<cfif structKeyExists( param, "type" ) and structKeyExists( param, "in" ) and param[ "in" ] neq 'body' >

				    		<code>#param[ "type" ]#</code>

				    	<cfelseif structKeyExists( param, "type" ) and structKeyExists( param, "schema" ) and structKeyExists( param[ "schema" ], "type" )>

				    		<code>#param[ "schema.type" ]# (body)</code>

				    	<cfelse>

				    		N/A

				    	</cfif>

				    </td>

				    <td  class="parameter column description col-sm-5 col-xs-8" valign="top">
				    	<p>#toParagraphFormat( param[ "description" ] )#</p>

				    	<cfif structKeyExists( param, "in" )>
					    	<p>Provided in the <code>#param[ "in" ]#</code> of the request</p>
				    	</cfif>

				    </td>

				    <td class="parameter column requirement col-sm-2 col-xs-4" valign="top">
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

					    <tr id="#paramUid#" class="panel panel-solid-default">
				    		<td colspan="4" valign="top">
				    		<cfif prc.pdf ?: false>
                                <code>#trim( serializeJSON( param[ "schema" ] ) )#</code>
                            <cfelse>
                                <pre class="language-json">#trim( serializeJSON( param[ "schema" ] ) )#</pre>
                            </cfif>
                            </td>
				    	</tr>

				    </cfif>


				</div>

		</cfloop>

	</div>
</cfoutput>