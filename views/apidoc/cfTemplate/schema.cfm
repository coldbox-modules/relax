<cfscript>
	if( ! structKeyExists( args, "schema" ) ){
		args.schema = args.entity[ "schema" ];
	}
	param args.showExample = true;

	args.schemaPropertiesToExample = function( properties ){
		return structKeyArray( arguments.properties )
						.filter( function( key ){
							return structKeyExists( properties[ key ], "example" )
						} )
						.reduce( function( acc, key ){
							acc[ key ] = properties[ key ][ "example" ]
							return acc;
						}, {} );
	};
	args.getExampleAsString = function( example ){
		return isSimpleValue( arguments.example )
					? arguments.example
					: serializeJSON( arguments.example, false, listFindNoCase( "Lucee", server.coldfusion.productname ) ? "utf-8" : false );
	};

	args.createPropertyExample = function(){
		if( structKeyExists( args.schema, "example" ) ) return args.schema[ "example" ];
		// skip out if nothing to eval
		if( !structKeyExists( args.schema, "properties" ) ) return javacast( "null", 0 );
		var properties = args.schema[ "properties" ];
		return args.schemaPropertiesToExample( properties );
	};

	args.propertiesExample = args.createPropertyExample();
</cfscript>
<cfoutput>
<div class="box box-solid-default">
	<div class="box">
		<!-- OpenAPI 3.x -->
		<cfif structKeyExists( args.schema, "items" )>
			<div>
				<cfif structKeyExists( args.schema, "example" )>
					<div class="example box">
						<h5 class="box-header">Example:</h5>
						<div class="box-body">
							<pre class="language-json">#args.getExampleAsString( args.schema[ "example" ] )#</pre>
						</div>
					</div>
				</cfif>
				<h4 class="card-subtitle text-secondary">Items:</h4>
				#renderView( view="apidoc/cfTemplate/schema", args={ "schema": args.schema[ "items" ], "showExample" : !structKeyExists( args.schema, "example" ) } )#
			</div>
		<cfelseif structKeyExists( args.schema, "type" ) OR structKeyExists( args.schema, "properties")>
			<div>
				<cfif structKeyExists( args.schema, "title" )>
					<h5 class="box-header">#args.schema[ 'title' ]#</h5>
				</cfif>
				<cfif structKeyExists( args.schema, "type" )>
					<h5 class="box-header">Type: <code>#args.schema[ "type" ]#</code></h5>
				</cfif>
				<cfif structKeyExists( args.schema, "required" )>
					<h5 class="box-header">Required: <code>#( isSimpleValue( args.schema[ "required" ] ) ? args.schema[ "required" ] : arrayToList( args.schema[ "required" ], "</code>, <code>" ) )#</code></h5>
				</cfif>

				<cfif structKeyExists( args.schema, "description" )>
					<h5 class="box-header">Description:</h5>
					<p>#args.schema["description"]#</p>
				</cfif>

				<cfif args.showExample && !isNull( args.propertiesExample ) >
					<div class="example box">
						<h5 class="box-header">Example:</h5>
						<div class="box-body">
							<pre class="language-json">#args.getExampleAsString( args.propertiesExample )#</pre>
						</div>
					</div>
				</cfif>

				<cfif structKeyExists( args.schema, "properties" )>
					<div class="box">
						<h5 class="box-header">Properties:</h5>
						<pre class="language-json">#serializeJSON( args.schema.properties, false, listFindNoCase( "Lucee", server.coldfusion.productname ) ? "utf-8" : false )#</pre>
					</div>
				</cfif>

			</div>
		<cfelse>
			<!-- OpenAPI 2.x -->
			<div class="card card-solid-default">
				<pre class="language-json">#serializeJSON( args.schema, false, listFindNoCase( "Lucee", server.coldfusion.productname ) ? "utf-8" : false  )#</pre>
			</div>
		</cfif>
	</div>
</div>
</cfoutput>