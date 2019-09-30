component {

	// I save the location of this CFC path to use resources located here
	variables.dirPath = getDirectoryFromPath( getMetadata( this ).path );

	function configure(){
		/************************************** SERVICE DEFINITION *********************************************/

		// This is where we define our RESTful service, this is usually
		// our first place before even building it, we spec it out.
		this.relax = {
			// Service Title
			title       : "ForgeBox IO",
			// Service Description
			description : "This API powers ForgeBox",
			// Service entry point, can be a single string or name value pairs to denote tiers
			// entryPoint = "http://www.myapi.com",
			entryPoint  : {
				"production"  : "https://forgebox.io/api/v1",
				"staging"     : "http://forgebox.stg.ortussolutions.com/api/v1",
				"development" : "http://localhost:9095/api/v1"
			},
			// Does it have extension detection via ColdBox
			extensionDetection      : true,
			// Valid format extensions
			validExtensions         : "json",
			// Does it throw exceptions when invalid extensions are detected
			throwOnInvalidExtension : false
		};

		/************************************** GLOBAL PARAMS +  HEADERS *********************************************/

		// Global API Headers
		globalHeader(
			name        = "x-app-token",
			description = "The secret application token",
			required    = true,
			type        = "string"
		);

		/************************************** RESOURCES *********************************************/

		// ECHO
		resource( pattern = "/echo", handler = "Main", action = "echo" )
			.description( "Simple API echo command" )
			.defaultFormat( "json" )
			.methods( "GET" );

		// Types
		resource( pattern = "/types", handler = "Types", action = "list" )
			.description( "Retrieve all entry types in ForgeBox" )
			.defaultFormat( "json" )
			.methods( "GET" );

		// Type Display
		resource( pattern = "/types/:slug", handler = "Types", action = "show" )
			.description( "Retrieve a single type record" )
			.defaultFormat( "json" )
			.methods( "GET" )
			.placeholder(
				name        = "slug",
				description = "The slug to show",
				required    = true,
				type        = "string"
			);

		// Slug Check
		resource( pattern = "/slug-check/:slug", handler = "Entries", action = "slugCheck" )
			.description( "Verifies if a slug is available in ForgeBox" )
			.defaultFormat( "json" )
			.methods( "GET" )
			.placeholder(
				name        = "slug",
				description = "The slug to check",
				required    = true,
				type        = "string"
			);

		// Entries with ordering aliases
		resource(
			pattern = "/entries/:orderBy-regex:(popular|new|installs|recent)",
			handler = "Entries",
			action  = "list"
		).description( "Retrieve entries in Forgebox according to order" )
			.defaultFormat( "json" )
			.methods( "GET" )
			.placeholder(
				name        = "orderBy",
				description = "Retrieve entries with a given order",
				required    = false,
				default     = "popular",
				type        = "string"
			)
			.param(
				name        = "max",
				description = "The max records to return",
				required    = false,
				default     = "25",
				type        = "numeric"
			)
			.param(
				name        = "offset",
				description = "The slug to check",
				required    = false,
				default     = "0",
				type        = "numeric"
			)
			.param(
				name        = "isActive",
				description = "Active flag for entries",
				required    = false,
				default     = "true",
				type        = "boolean"
			)
			.param(
				name        = "searchTerm",
				description = "Narrow down and search",
				required    = false,
				default     = "",
				type        = "string"
			);

		// Entries representations
		resource( pattern = "/entries", handler = "Entries", action = "list" )
			.description( "Retrieve entries in F`orgebox" )
			.defaultFormat( "json" )
			.methods( "GET" )
			.param(
				name        = "orderBy",
				description = "Retrieve entries with a given order",
				required    = false,
				default     = "popular",
				type        = "string"
			)
			.param(
				name        = "max",
				description = "The max records to return",
				required    = false,
				default     = "25",
				type        = "numeric"
			)
			.param(
				name        = "offset",
				description = "The slug to check",
				required    = false,
				default     = "0",
				type        = "numeric"
			)
			.param(
				name        = "isActive",
				description = "Active flag for entries",
				required    = false,
				default     = "true",
				type        = "boolean"
			)
			.param(
				name        = "searchTerm",
				description = "Narrow down and search",
				required    = false,
				default     = "",
				type        = "string"
			);

		// Latest stable version for entry
		resource( pattern = "/entry/:slug/latest", handler = "Entries", action = "show" )
			.description( "Display the latest stable version of an Entry" )
			.defaultFormat( "json" )
			.methods( "GET" )
			.placeholder(
				name        = "slug",
				description = "The slug to retrieve",
				required    = true,
				type        = "string"
			);

		// Single entry representation
		resource( pattern = "/entry/:slug", handler = "Entries", action = "show" )
			.description( "Display a single ForgeBox entry" )
			.defaultFormat( "json" )
			.methods( "GET" )
			.placeholder(
				name        = "slug",
				description = "The slug to retrieve",
				required    = true,
				type        = "string"
			);

		// Global entries search
		resource( pattern = "/search/:searchTerm", handler = "Entries", action = "list" )
			.description( "Search entries in ForgeBox" )
			.defaultFormat( "json" )
			.methods( "GET" )
			.placeholder(
				name        = "searchTerm",
				description = "Narrow down and search",
				required    = true,
				type        = "string"
			)
			.param(
				name        = "orderBy",
				description = "Retrieve entries with a given order",
				required    = false,
				default     = "popular",
				type        = "string"
			)
			.param(
				name        = "max",
				description = "The max records to return",
				required    = false,
				default     = "25",
				type        = "numeric"
			)
			.param(
				name        = "offset",
				description = "The offset or start row of the search",
				required    = false,
				default     = "0",
				type        = "numeric"
			)
			.param(
				name        = "isActive",
				description = "Active flag for entries",
				required    = false,
				default     = "true",
				type        = "boolean"
			);

		// User Profiles
		resource( pattern = "/users/:username", handler = "Users", action = "show" )
			.description( "Display a user's public ForgeBox profile" )
			.defaultFormat( "json" )
			.methods( "GET" )
			.placeholder(
				name        = "username",
				description = "ForgeBox Username",
				required    = true,
				type        = "string"
			);

		// User Contributions
		resource( pattern = "/users/:username/contributions", handler = "Users", action = "show" )
			.description( "Display a user's entry contributions in ForgeBox" )
			.defaultFormat( "json" )
			.methods( "GET" )
			.placeholder(
				name        = "username",
				description = "ForgeBox Username",
				required    = true,
				type        = "string"
			);

		// User Authentication
		resource( pattern = "/authenticate", handler = "Users", action = "authenticate" )
			.description( "Authenticate against ForgeBox and get your user's API Key" )
			.defaultFormat( "json" )
			.methods( "POST" )
			.param(
				name        = "username",
				description = "ForgeBox Username",
				required    = true,
				type        = "string"
			)
			.param(
				name        = "password",
				description = "ForgeBox password",
				required    = true,
				type        = "string"
			);

		// User registration
		resource( pattern = "/register", handler = "Users", action = "register" )
			.description(
				"Register a new user in ForgeBox. Please note that you will still need to activate/confirm your account."
			)
			.defaultFormat( "json" )
			.defaultMethod( "POST" )
			.methods( "POST" )
			.param(
				name        = "fname",
				description = "First name",
				required    = true,
				type        = "string"
			)
			.param(
				name        = "lname",
				description = "Last name",
				required    = true,
				type        = "string"
			)
			.param(
				name        = "email",
				description = "Email",
				required    = true,
				type        = "string"
			)
			.param(
				name        = "username",
				description = "Username",
				required    = true,
				type        = "string"
			)
			.param(
				name        = "password",
				description = "Password",
				required    = true,
				type        = "string"
			)
			.param(
				name        = "facebookURL",
				description = "Facebook URL",
				required    = false,
				type        = "string"
			)
			.param(
				name        = "twitterURL",
				description = "Facebook URL",
				required    = false,
				type        = "string"
			)
			.param(
				name        = "blogURL",
				description = "Facebook URL",
				required    = false,
				type        = "string"
			)
			.param(
				name        = "otherURL",
				description = "Facebook URL",
				required    = false,
				type        = "string"
			)
			.param(
				name        = "linkedinURL",
				description = "Facebook URL",
				required    = false,
				type        = "string"
			);

		// Publish
		resource( pattern = "/publish", handler = "Entries", action = "publish" )
			.description(
				"Publish a new or update an existing package to ForgeBox.  Authentication tokens must be passed"
			)
			.defaultFormat( "json" )
			.defaultMethod( "POST" )
			.methods( "POST" )
			.header(
				name        = "x-api-token",
				description = "Valid APIToken for a confirmed ForgeBox account",
				required    = true,
				type        = "string"
			)
			.param(
				name        = "body",
				description = "JSON HTTP payload containing keys slug, version, boxJSON, isStable, description, installInstructions, and changeLog.",
				required    = true,
				type        = "body"
			);


		// Unpublish
		resource( pattern = "/unpublish", handler = "Entries", action = "unpublish" )
			.description(
				"Unpublish an existing package or package version from to ForgeBox.  If no version is given, the entire package and its versions are removed.  Authentication tokens must be passed"
			)
			.defaultFormat( "json" )
			.defaultMethod( "POST" )
			.methods( "POST" )
			.header(
				name        = "x-api-token",
				description = "Valid APIToken for a confirmed ForgeBox account",
				required    = true,
				type        = "string"
			)
			.param(
				name        = "slug",
				description = "Package Slug",
				required    = true,
				type        = "string"
			)
			.param(
				name        = "version",
				description = "Package Version.",
				required    = false,
				type        = "string"
			);

		// Installation counter
		resource( pattern = "/install", handler = "Entries", action = "recordInstall" )
			.description( "Increment install counter" )
			.defaultFormat( "json" )
			.defaultMethod( "POST" )
			.methods( "POST" )
			.param(
				name        = "slug",
				description = "The slug of the entry being installed",
				required    = true,
				type        = "string"
			)
			.param(
				name        = "version",
				description = "The version being installed",
				required    = false,
				type        = "string"
			);

		// download counter
		resource( pattern = "/download", handler = "Entries", action = "recordDownload" )
			.description( "Increment download counter" )
			.defaultFormat( "json" )
			.defaultMethod( "POST" )
			.methods( "POST" )
			.param(
				name        = "slug",
				description = "The slug of the entry being downloaded",
				required    = true,
				type        = "string"
			)
			.param(
				name        = "version",
				description = "The version being downloaded",
				required    = false,
				type        = "string"
			);

		// Slug search
		resource( pattern = "/slugs", handler = "Entries", action = "slugSearch" )
			.description( "Auto-complete partial slugs and versions" )
			.defaultFormat( "json" )
			.defaultMethod( "GET" )
			.methods( "GET" )
			.param(
				name        = "searchTerm",
				description = "The slug to be serached for",
				required    = true,
				type        = "string"
			);

		// Whoami
		resource( pattern = "/users/whoami", handler = "users", action = "whoami" )
			.description( "Look up a user based on API Token" )
			.defaultFormat( "json" )
			.defaultMethod( "GET" )
			.methods( "GET" )
			.param(
				name        = "APIToken",
				description = "The API Token to be serached for",
				required    = true,
				type        = "string"
			);
	}
	// end configure method

}
