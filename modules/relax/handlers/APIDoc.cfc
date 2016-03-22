 /**
********************************************************************************
Copyright 2005-2007 by Luis Majano and Ortus Solutions, Corp
www.ortussolutions.com
********************************************************************************
*/
component extends="BaseHandler"{
	//HTTP STATUS CODES
	STATUS = {
		"CREATED":201,
		"SUCCESS":200,
		"NO_CONTENT":204,
		"BAD_REQUEST":400,
		"NOT_AUTHORIZED":401,
		"NOT_FOUND":404,
		"NOT_ALLOWED":405,
		"NOT_ACCEPTABLE":406,
		"EXPECTATION_FAILED":417,
		"INTERNAL_ERROR":500,
		"NOT_IMPLEMENTED":501
	};


	function preHandler( event, action, eventArguments, rc, prc ){

		event.noLayout();
		rc.format = "JSON";
		super.preHandler(argumentCollection=arguments);
		rc.data = {};
		rc.statusCode = STATUS.NOT_FOUND;
		
	}

	function postHandler( event, action, eventArguments, rc, prc){
		event.renderData( type=rc.format, data=rc.data, statusCode=rc.statusCode, statusMessage=structKeyExists(rc,'statusMessage')?rc.statusMessage:"Success");  
	}

	/**
	* Main API Doc function
	**/
	function index( event, rc, prc ){
		switch(event.getHTTPMethod()){
			case "POST":
				this.createDocument( argumentCollection = ARGUMENTS);
				break;
			case "PUT":
			case "PATCH":
				this.updateDocument( argumentCollection = ARGUMENTS );

				break;
			case "DELETE":
				this.deleteDocument( argumentCollection = ARGUMENTS);
				break;
			default:
				this.getDocument( argumentCollection = ARGUMENTS );
		}

	}

	/**
	* Renders the API Document
	* (GET) /relax/apidoc/:id?
	**/
	function getDocument( event, rc, prc ){

	}

	/**
	* Updates an API Document
	* (PUT|PATCH) /relax/apidoc/:id?
	**/
	function updateDocument( event, rc, prc ){

	}

	/**
	* Deletes an API Document
	* (DELETE) /relax/apidoc/:id?
	**/
	function deleteDocument( event, rc, prc ){

	}
	
	/**
	* Marshall an API Document Response
	**/
	private function marshallDocument( event, rc, prc, struct APIDoc){
	
	}

	/**
	* Creates the view-specific document keys within an API doc
	**/
	private function prepareDocumentForView( required struct APIDoc){

	}

	/**
	* Sanitizes the view-specific keys from an APIDoc
	**/
	private function santizeDocument( required struct APIDoc ){

	}

}