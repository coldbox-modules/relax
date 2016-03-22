component output="false"{
/**
*	*******************************************************************************
*	Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
*	www.coldbox.org | www.luismajano.com | www.ortussolutions.com
*	********************************************************************************
*	
*	Author     :	Luis Majano
*	Description :
*		Relax Resources Definition using the Open API Specification
**/
	function configure(){
		// I save the location of this CFC path to use resources located here
	variables.dirPath = getDirectoryFromPath( getMetadata(this).path ); 
	
	function configure(){
		
		/************************************** SERVICE DEFINITION *********************************************/
		
		// This is where we define our RESTful service, this is usually
		// our first place before even building it, we spec it out.
		this.relax = {
			// Service Title
			title = "Relax OpenAPI Example",
			// Service Description
			description = "A Relax API which which is modeled using the OpenAPI (Swagger) specification",
			// Service entry point, can be a single string or name value pairs to denote tiers
			entryPoint = {
				dev  = "http://dev.myapi.com",
				production = "http://www.myapi.com"
			},
			// This resource is modeled using SES and always returns JSON so no additional extensions are required
			extensionDetection = false,
			// Our relative link to the definition representation file for this resource - JSON or YAML
			definition = "petstore.json"	
			//definition = "petstore.yaml"	
		};
	}

}