 /**
********************************************************************************
Copyright 2005-2007 by Luis Majano and Ortus Solutions, Corp
www.ortussolutions.com
********************************************************************************
*/
component extends="BaseHandler"{

	//HTTP STATUS CODES
	STATUS = {
		"CREATED"           : 201,
		"SUCCESS"           : 200,
		"NO_CONTENT"        : 204,
		"BAD_REQUEST"       : 400,
		"NOT_AUTHORIZED"    : 401,
		"NOT_FOUND"         : 404,
		"NOT_ALLOWED"       : 405,
		"NOT_ACCEPTABLE"    : 406,
		"EXPECTATION_FAILED": 417,
		"INTERNAL_ERROR"    : 500,
		"NOT_IMPLEMENTED"   : 501
	};


	function preHandler( event, action, eventarguments, rc, prc ){
		event.noLayout();
		rc.format = "JSON";
		super.preHandler( argumentCollection=arguments );
		rc.data = {};
		rc.statusCode = STATUS.NOT_FOUND;
	}

	function postHandler( event, action, eventarguments, rc, prc){

		event.renderData(
			type=rc.format,
			data=rc.data,
			statusCode=rc.statusCode,
			statusMessage=structKeyExists(rc,'statusMessage')?rc.statusMessage:"Success"
		);

	}

	/**
	* Main API Doc function
	**/
	function index( event, rc, prc ){

		if( structKeyExists( rc, "api" ) ){

			if( rc.api != 'cbswagger' ){
				marshallAPIDocument( argumentCollection=arguments );
			} else {
				rc.data = getInstance( "RoutesParser@cbswagger" ).createDocFromRoutes().getNormalizedDocument();
				rc.statusCode = STATUS.SUCCESS;
			}

		} else {
			marshallAPIs( argumentCollection=arguments );
		}

	}
	/**
	* Creates a new Relax API
	* (POST) /relax/apidoc
	**/
	function create( event, rc, prc ){

		var serviceResponse = APIService.processAPIImport( arguments.rc );

		if( serviceResponse.success ){

			rc.data = serviceResponse.data;
			rc.statusCode = STATUS.CREATED;

		} else {

			rc.data = {
				"message": serviceResponse.message,
				"errors" : serviceResponse.errors,
				"api"    : {
					"name"    : event.getValue( "apiName", "" ),
					"document": event.getValue( "apiJSON", {} )
				}
			};

			rc.statusCode = status.EXPECTATION_FAILED;
		}
	}

	/**
	* Updates an API Document
	* (PUT|PATCH) /relax/apidoc/:id?
	**/
	function update( event, rc, prc ){
		rc.data={
			"message" : "Method not yet implemented"
		};
		rc.statusCode = STATUS.NOT_IMPLEMENTED;
	}

	/**
	* Deletes an API Document
	* (DELETE) /relax/apidoc/:id?
	**/
	function delete( event, rc, prc ){
		rc.data={
			"message" : "Method not yet implemented"
		};
		rc.statusCode = STATUS.NOT_IMPLEMENTED;
	}

	private function marshallAPIs( event, rc, prc ){
		var availableAPIs = APIService.listAPIs();

		rc.data = {
			"apis"   : {},
			"default": APIService.getDefaultAPIName()
		};
		rc.statusCode = STATUS.SUCCESS;

		for( var API in availableAPIs ){
			if( API.type == 'cbswagger' ){
				rc.data.apis[ API.name ] = deserializeJSON( API.attributes );
			} else {
				rc.data.apis[ API.name ] = APIService.loadAPI( API.name ).getDocumentObject().getDocument()[ "info" ];
			}
			rc.data.apis[ API.name ][ "href" ] = '/relax/apidoc/' & API.name;
		}

	}

	/**
	* Marshall an API Document Response
	**/
	private function marshallAPIDocument( event, rc, prc, struct APIDoc ){
		try {

			if( !isNull( arguments.APIDoc ) ){

				rc.data = arguments.APIDoc;

			} else{

				rc.data = APIService.loadAPI( rc.api ).getNormalizedDocument();

			}

			if( !structKeyExists( rc.data, "basePath" ) ){
				rc.data[ "basePath" ] = '/';
			}

			rc.statusCode = STATUS.SUCCESS;

		} catch ( any e ) {
			rc.statusCode = STATUS.INTERNAL_ERROR;
			rc.data[ "message" ] = "The API Request could not be parsed";
			rc.data[ "errors" ] = [ {
				"type"       : e.type,
				"message"    : e.message,
				"description": e.detail
			} ];
		}
	}

}
