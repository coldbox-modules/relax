/**
* Copyright Ortus Solutions, Corp, All rights reserved
* www.ortussolutions.com
* ---
* Open API Utilities
*/
component name="OpenAPIUtil" accessors="true" {

	/**
	 * Constructor
	 */
	function init(){
		return this;
	}

	/**
	 * Generate a new template for the Open API spec
	 */
	any function newTemplate(){
		// We need to use Linked Hashmaps to maintain struct order for serialization and deserialization
		var template = structNew( "ordered" );
		var templateDefaults  = [
			{ "openapi"			: "3.0.2" },
			{
			  "info"			: {
			      "version"       	: "",
			      "title"         	: "",
			      "description"   	: "",
			      "termsOfService"	: "",
			      "license"       	: structNew( "ordered" ),
			      "contact"       	: structNew( "ordered" )
			    }
			},
			{ "servers" 		: [] },
			{ "paths"           : structNew( "ordered" ) },
			{ "components"      : structNew( "ordered" ) },
			{ "security" 		: [] },
			{ "tags" 			: [] },
			{ "externalDocs" 	: {
				"description" 	: "",
				"url" 			: ""
			} }
		];

		for( var templateDefault  in  templateDefaults ){
			template.putAll( templateDefault );
		}

		return template;
	}

	/**
	 * Create a new method representation
	 */
	any function newMethod(){
		var method 	= structNew( "ordered" );
		var descMap = structNew( "ordered" );

		descMap.put( "description", "" );

		//Other supported options are requestBody and tag will be added runtime
		var methodDefaults   = [
			{ "summary"    	: "" },
			{ "tags" 		: [] },
			{ "description"	: "" },
			{ "operationId"	: "" },
			{ "parameters" 	: [] },
			{
				"responses"  : {
					"default": descMap
				}
			},
			{
				"externalDocs" : {
					"description" 	: "",
					"url" 			: ""
				}
			}
		];

		for( var methodDefault in methodDefaults ){
			method.putAll( methodDefault );
		}

		return method;
	}

	/**
	 * Get an array of default methods
	 */
	array function defaultMethods(){
		return [ "GET", "PUT", "POST" , "PATCH" , "DELETE" , "HEAD" ];
	}

	/**
	 * Get an array of default response codes
	 */
	array function defaultSuccessResponses(){
		return [ 200, 200, 201, 200, 204, 204 ];
	}

	/**
	 * Translate path from URL Path
	 *
	 * @URLPath
	 */
	string function translatePath( required string URLPath ){
		var pathArray = listToArray( arguments.URLPath, '/' );
		for( var i=1; i <= arrayLen( pathArray ); i++ ){
			if( left( pathArray[ i ], 1 ) == ':' ){
				pathArray[ i ] = "{" & replace( pathArray[ i ], ":", "" ) & "}";
			}
		}

		return "/" & arrayToList( pathArray, "/" );

	}

	/**
	 * Converts a Java object to native CFML structure
	 *
	 * @param Object Map  	The Java map object or array to be converted
	 */
	function toCF( map ){

		if( isNull( arguments.map ) ) return;

		//if we're in a loop iteration and the array item is simple, return it
		if( isSimpleValue( arguments.map ) ) return arguments.map;

		if( isArray( map ) ){
			var cfObj = [];

			for( var obj in arguments.map ){
				arrayAppend( cfObj, toCF( obj ) );
			}

		} else {

			var cfObj = {};

			try{
				cfObj.putAll( arguments.map );

			} catch ( any e ){

				return arguments.map;
			}

			// loop our keys to ensure first-level items with sub-documents objects are converted
			for( var key in cfObj ){

				if(
					!isNull( cfObj[ key ] ) &&
					( isArray( cfObj[ key ] ) || isStruct( cfObj[ key ] ) )
				){
					cfObj[ key ] = toCF( cfObj[ key ] );
				}
			}
		}

		return cfObj;
	}

}
