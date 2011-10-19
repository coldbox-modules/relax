<!-----------------------------------------------------------------------
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldbox.org | www.luismajano.com | www.ortussolutions.com
********************************************************************************

Author     :	Luis Majano
Description :
	Relax Resources Definition.  For documentation on how to build this CFC
	look at our documenation here: http://wiki.coldbox.org/wiki/Projects:Relax.cfm
----------------------------------------------------------------------->
<cfcomponent output="false">
<cfscript>
	
	// This is where we define our RESTful service, this is usually
	// our first place before even building it, we spec it out.
	this.relax = {
		// Service Title
		title = "ForgeBox APII",
		// Service Description
		description = "ForgeBox is a source directory for anything ColdBox.",
		// Service entry point, can be a single string or name value pairs to denote tiers
		//entryPoint = "http://www.myapi.com",
		entryPoint = {
			dev  = "http://coldbox.jfetmac/api/forgebox",
			production = "http://www.coldbox.org/api/forgebox"
		},
		// Does it have extension detection via ColdBox
		extensionDetection = false
		// Valid format extensions
		//validExtensions = "xml,json,jsont,wddx,html",
		// Does it throw exceptions when invalid extensions are detected
		//throwOnInvalidExtension = false		
	};
		
	// Global API Headers
	this.globalHeaders = [
		// Sample global header, Available keys: name,description,required,default,type
		{name="apikey",description="The apikey needed for request authentication.",required=true}
	];
	
	// Global API Parameters
	this.globalParameters = [
		// Sample global parameter, Available keys: name,description,required,default,type
		{name="paramKey",description="The parameter key needed for request authentication.",required=true}
	];
		
	/** Define our Relaxed RESTful resources in order just like you are defining routes
	 Each resource has the following keys that are used for documentation and testing.
	 {
	 	pattern="", handler="", action="", description="", methods="", headers=[], parameters=[], placeholders[],
	 	response={ schemas=[{format="",description="",body=""}], samples=[{format="",description="",body=""}] }
	 }
	 
	 Each header, parameter or placeholder is a structure with the following keys:
	 {name="",type="",required="",default="",description=""}
	**/
	this.resources = [
	
		// api users resource
		{pattern="/api/users",handler="rest.user",action="list",description="Returns all users",methods="GET",headers=[],parameters=[],placeholders=[]},
		
		// api my resource
		{pattern="/api/myResource",handler="rest.myUser",action={POST = 'create', GET = 'getResources'},description="Returns of my available resources",
		 methods="GET,POST",headers=[],parameters=[],placeholders=[]},
		  
		  // api user username
		 {pattern="/api/user/:username",handler="rest.user",action="{'get':'view','post':'create','put':'update','delete','remove'}",
		  description="The representation for system users.  You can also interact with creation, updating and deletion via this resource",
		  methods="GET,POST,PUT,DELETE",
		  headers=[
		  	{name="x-test",description="Return test in a header",required="true"}
		  ],
		  parameters=[
		  	{name="firstName",description="The user firstname. Only used on PUT and POST operations",required="true"},
			{name="lastName",description="The user lastname. Only used on PUT and POST operations",required="true"},
			{name="email",description="The user email. Only used on PUT and POST operations",required="false"}
		  ],
		  placeholders=[{name="username",description="The resource username to interact with",required=true}]
		 },
		  
		  // table actions resource
		 {pattern="/api/tables/:action",handler="rest.table",
		 description="Returns table actions",
		 methods="GET",headers=[],parameters=[],placeholders=[]},
		 
		 // api user resource with response tags
		 {
 			pattern="/api/user", handler="rest.user", description="User resource.",
 			methods="GET,POST",
 			parameters=[
 				{name="userID", description="The userID of the User record.", required=false},
 				{name="username", description="The username of the User record.", required=false}
 			],
 			response={
 				schemas=[
 					{format="json", description="The following will be returned when the format requested is JSON.", body=fileRead("#dirPath#schemas/user/user.json") },
 					{format="xml", description="The following will be returned when the format requested is XML.", body=fileRead("#dirPath#schemas/user/user.xsd") }
 				],
 				samples=[
 					{format="json", description="The basic user information will be returned in a flat object.", body=fileRead("#dirPath#samples/user/user.json")},
 					{format="json", description="If the requested user is not found, or some other error has occurred, the resopnse will be like the following.", body=fileRead("#dirPath#samples/user/failure.json")}
 				]
 			}
 		}
	];
</cfscript>
</cfcomponent>