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
	
	function configure(){
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
		};
		
		// ForgeBox Types
		resource(pattern="/:format/types")
			.methods("GET")
			.description("Returns a listing of all available ForgeBox code entry types")
			.placeholder(name="format",type="xml,json",required=true,description="The return format for the resource");
		
		// ForgeBox Entries
		resource(pattern="/:format/entries")
			.methods("GET")
			.description("Returns code entries according to passed in parameters or using default values.")
			.placeholder(name="format",type="xml,json",required=true,description="The return format for the resource")
			.param(name="orderby",	required="false", default="recent",	type="new,recent,popular", description="The ordering to impose in the results")
			.param(name="maxrows",	required="false", default="0", 		type="numeric",	description="The max records to retrieve")
			.param(name="startrow",	required="false", default="0", 		type="numeric",	description="The offset to use when paging records")
			.param(name="type",		required="false", default="", 		type="string",	description="he type slug to filter the results with");
		
	}
	
</cfscript>
</cfcomponent>