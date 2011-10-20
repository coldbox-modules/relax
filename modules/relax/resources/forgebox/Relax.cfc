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
		title = "ForgeBox API",
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
	];
	
	// Global API Parameters
	this.globalParameters = [
		// Sample global parameter, Available keys: name,description,required,default,type
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
	
		// Types
		{ pattern="/:format/types",description="Returns a listing of all available ForgeBox code entry types",
		  placeholders=[ {name="format",type="xml,json",required=true,description="The return format for the resource"} ] },
		
		// Entries
		{ pattern="/:format/entries",description="Returns code entries according to passed in parameters or using default values.",
		  placeholders=[ {name="format",type="xml,json",required=true,description="The return format for the resource"} ],
		  paramters=[ 
		  	{name="orderby",	required=false, default="recent",	type="new,recent,popular", description="The ordering to impose in the results"},
		  	{name="maxrows",	required=false, default="0", 		type="numeric",	description="The max records to retrieve"},
			{name="startrow",	required=false, default="0", 		type="numeric",	description="The offset to use when paging records"},
			{name="type",		required=false, default="", 		type="string",	description="he type slug to filter the results with"}
		  ] }
	];
</cfscript>
</cfcomponent>