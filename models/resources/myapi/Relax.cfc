component {

	// I save the location of this CFC path to use resources located here
	variables.dirPath = getDirectoryFromPath( getMetadata( this ).path );

	function configure(){
		/************************************** SERVICE DEFINITION *********************************************/

		// This is where we define our RESTful service, this is usually
		// our first place before even building it, we spec it out.
		this.relax = {
			// Service Title
			title                   : "My RESTFul Service",
			// Service Description
			description             : "A very cool RESTFul Service",
			// Service entry point, can be a single string or name value pairs to denote tiers
			entryPoint              : { dev : "http://dev.myapi.com", production : "http://www.myapi.com" },
			// Does it have extension detection via ColdBox
			extensionDetection      : true,
			// Valid format extensions
			validExtensions         : "xml,json,jsont,wddx,html",
			// Does it throw exceptions when invalid extensions are detected
			throwOnInvalidExtension : false
		};

		/************************************** GLOBAL PARAMS +  HEADERS *********************************************/

		// Global API Headers
		globalHeader( name = "apikey", description = "The apikey needed for request authentication.", required = true );

		// Global API Parameters
		globalParam(
			name        = "paramKey",
			description = "The parameter key needed for request authentication.",
			required    = true
		);

		/************************************** RESOURCES *********************************************/

		// api users resource
		resource( pattern = "/api/users", handler = "rest.user", action = "list" )
			.description( "Returns all users" )
			.methods( "GET,PUT,POST" )
			.defaultMethod( "PUT" )
			.defaultFormat( "json" );

		// api my resource
		resource(
			pattern = "/api/myResource",
			handler = "rest.myUser",
			action  = { POST : "create", GET : "getResources" }
		).description( "Returns of my available resources" )
			.methods( "GET,POST" )
			.defaultMethod( "POST" );

		// api user username
		resource(
			pattern = "/api/user/:username",
			handler = "rest.user",
			action  = "{'get':'view','post':'create','put':'update','delete','remove'}"
		).description(
				"The representation for system users.  You can also interact with creation, updating and deletion via this resource"
			)
			.methods( "GET,POST,PUT,DELETE" )
			.header( name = "x-test", description = "Return test in a header", required = "true" )
			.param(
				name        = "firstName",
				description = "The user firstname. Only used on PUT and POST operations",
				required    = "true"
			)
			.param(
				name        = "lastName",
				description = "The user lastname. Only used on PUT and POST operations",
				required    = true
			)
			.param(
				name        = "email",
				description = "The user email. Only used on PUT and POST operations",
				required    = "false"
			)
			.placeholder( name = "username", description = "The resource username to interact with", required = true );

		// table actions resource
		resource( pattern = "/api/tables/:action", handler = "rest.table" )
			.description( "Returns table actions" )
			.methods( "GET" );

		// api user resource with response tags
		resource( pattern = "/api/user", handler = "rest.user" )
			.description( "User resource." )
			.methods( "GET,POST" )
			.param( name = "userID", description = "The userID of the User record.", required = false )
			.param( name = "username", description = "The username of the User record.", required = false )
			.schema(
				format      = "json",
				description = "The following will be returned when the format requested is JSON.",
				body        = fileRead( "#dirPath#schemas/user/user.json" )
			)
			.schema(
				format      = "xml",
				description = "The following will be returned when the format requested is XML.",
				body        = fileRead( "#dirPath#schemas/user/user.xsd" )
			)
			.sample(
				format      = "json",
				description = "The basic user information will be returned in a flat object.",
				body        = fileRead( "#dirPath#samples/user/user.json" )
			)
			.sample(
				format      = "json",
				description = "If the requested user is not found, or some other error has occurred, the resopnse will be like the following.",
				body        = fileRead( "#dirPath#samples/user/failure.json" )
			);
	}

}
