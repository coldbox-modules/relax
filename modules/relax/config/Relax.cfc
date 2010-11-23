<cfcomponent output="false">
<cfscript>

	function configure(){
		
		// This is where we define our RESTful service, this is usually
		// our first place before even building it, we spec it out.
		
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