<cfscript>
	parameters = args.entity[ "parameters" ];
</cfscript>
<cfoutput>
	<div class="parameter-list list-group">
		<div class="col-xs-12 bg-default">
			<div class="parameter-column key col-sm-3 col-xs-8">
				Name
			</div>

			<div class="parameter column type col-sm-2 col-xs-4">
				Type
			</div>

			<div class="parameter column description col-sm-5 col-xs-8">
				Description
			</div>

			<div class="parameter column requirement col-sm-2 col-xs-4">
			  Req?
			</div>

		</div>

		<cfloop array="#parameters#" index="param">
			<cfscript>
				paramUid = "param_" & createUUID();
			</cfscript>

				<div class="list-group-item parameter optional col-xs-12">

				    <div class="parameter-column key col-sm-3 col-xs-8">
				    	<code>#param[ "name" ]#</code>
				    </div>

				    <div class="parameter column type col-sm-2 col-xs-4">
				    	<cfif structKeyExists( param, "type" ) and structKeyExists( param, "in" ) and param[ "in" ] neq 'body' >
					    				    	
				    		<code>#param[ "type" ]#</code>

				    	<cfelseif structKeyExists( param, "type" ) and structKeyExists( param, "schema" ) and structKeyExists( param[ "schema" ], "type" )>
				    		
				    		<code>#param[ "schema.type" ]# (body)</code>

				    	<cfelse>

				    		N/A 	    	

				    	</cfif>
				    	
				    </div>

				    <div class="parameter column description col-sm-5 col-xs-8">
				    	<p>#toParagraphFormat( param[ "description" ] )#</p>

				    	<cfif structKeyExists( param, "in" )>
					    	<p>Provided in the <code>#param[ "in" ]#</code> of the request</p>	
				    	</cfif>
				    	
				    </div>

				    <div class="parameter column requirement col-sm-2 col-xs-4">
				      <i class="fa fa-#( param[ "required" ] ? 'check-circle text-danger' : 'circle-o text-muted' )#" data-toggle="tooltip" title="This parameter is #( param[ "required" ] ? 'required' : 'optional' )#"></i>
				    </div>

				    <cfif structKeyExists( param, "schema" )>
						<div class="clearfix"></div>
					    <div id="#paramUid#" class="panel panel-solid-default">
				    		<cfif prc.pdf ?: false>
                                <code>#trim( serializeJSON( param[ "schema" ] ) )#</code>
                            <cfelse>
                                <pre class="language-json">#trim( serializeJSON( param[ "schema" ] ) )#</pre>
                            </cfif>
				    	</div>
			    	    
				    </cfif>
				    

				</div>

		</cfloop>

	</div>
</cfoutput>