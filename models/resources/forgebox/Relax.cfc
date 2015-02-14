<!-----------------------------------------------------------------------
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldbox.org | www.luismajano.com | www.ortussolutions.com
********************************************************************************

Author     :	Luis Majano
Description :
	Relax Resources Definition.  For documentation on how to build this CFC
	look at our documenation here: http://wiki.coldbox.org/wiki/Projects:Relax.cfm
	
	The methods you can use for defining your RESTful service are:
	
	// Service is used to define the service
	- service(title:string,
		      description:string,
			  entryPoint:string or struct
			  extensionDetection:boolean,
			  validExtensions:list,
			  throwOnInvalidExtensions:boolean);
	
	// GlobalHeader() is used to define global headers which can be concatenated
	- globalHeader(name:string, description:string, required:boolean, default:any, type:string);
	
	// globalParam() is used to define global params which can be concatenated
	- globalParam(name:string, description:string, required:boolean, default:any, type:string);
	
	// Resources are defined by concatenating the following methods
	// The resource() takes in all arguments that match the SES addRoutes() method
	resource(pattern:string, handler:string, action:string or struct)
		.description(string)
		.methods(string or list)
		.header(name:string, description:string, required:boolean, default:any, type:string)
		.param(name:string, description:string, required:boolean, default:any, type:string)
		.placeholder(name:string, description:string, required:boolean, default:any, type:string)
		.schema(format:string, description:string, body:string)
		.sample(format:string, description:string, body:string);
		
----------------------------------------------------------------------->
<cfcomponent output="false">
<cfscript>
	
	function configure(){
		
		// Service Setup
		service(title = "ForgeBox API",
				description = "ForgeBox is a source directory for anything ColdBox.",
				entryPoint={dev="http://coldbox.jfetmac/api/forgebox",production="http://www.coldbox.org/api/forgebox"},
				extensionDetection = false);
		
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