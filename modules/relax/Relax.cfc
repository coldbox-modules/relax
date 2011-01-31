<!-----------------------------------------------------------------------
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldbox.org | www.luismajano.com | www.ortussolutions.com
********************************************************************************

Author     :	Luis Majano
Description :
	Relax Resources Definition
----------------------------------------------------------------------->
<cfcomponent output="false">
<cfscript>

	// This is where we define our RESTful service, this is usually
	// our first place before even building it, we spec it out.
	this.relax = {
		// Service Title
		title = "My RESTFul Service",
		// Service Description
		description = "A very cool RESTFul Service",
		// Service entry point
		entryPoint = "http://www.myapi.com",
		// Does it have extension detection via ColdBox
		extensionDetection = true,
		// Valid format extensions
		validExtensions = "xml,json,jsont,wddx",
		// Does it throw exceptions when invalid extensions are detected
		throwOnInvalidExtension = false		
	};
		
	// Global API Headers
	this.globalHeaders = [
		// Sample global header, Available keys: name,description,required,default,type
		{name="apikey",description="The apikey needed for request authentication.",required=true}
	];
		
	// Define our Relaxed RESTful resources in order just like you are defining routes
	// Each header, parameter or placeholder is a structure with the following keys:
	// {name="",type="",required="",default="",description=""}
	this.resources = [
		{pattern="/api/users",handler="rest.user",action="list",
		 description="Returns all users",
		 methods="GET",headers=[],parameters=[],placeholders=[]},
		 
		 {pattern="/api/user/:username",handler="rest.user",action="{'get':'view','post':'create','put':'update','delete','remove'}",
		  description="The representation for system users.  You can also interact with creation, updating and deletion via this resource",
		  methods="GET,POST,PUT,DELETE",
		  headers=[],
		  parameters=[
		  	{name="firstName",description="The user firstname. Only used on PUT and POST operations",required="false"},
			{name="lastName",description="The user lastname. Only used on PUT and POST operations",required="false"},
			{name="email",description="The user email. Only used on PUT and POST operations",required="false"}
		  ],
		  placeholders=[{name="username",description="The resource username to interact with",required=true}]}
	];
</cfscript>
</cfcomponent>