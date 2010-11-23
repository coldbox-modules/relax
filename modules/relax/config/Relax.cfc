<cfcomponent output="false">
<cfscript>

	function configure(){
	
		// Global Headers
		relax.globalHeaders = [];
	
		// Valid Extensions
		relax.extensions = "xml,json,jsont";
		
		// Resources
		relax.resources = [
			// users
			{pattern="/api/users/:user",
			 handler="api.users",
			 action={GET="list", PUT="update", POST="create", DELETE="remove"},
			 methods="GET"
			 }		
		];
	}

</cfscript>
</cfcomponent>