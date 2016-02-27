component name="OpenAPIParser" accessors="true" {
	//the base path of the APIDoc
	property name="document";
	property name="baseDocumentPath";
	property name="schemaType";


	public function init(string APIDocPath){
		setBaseDocumentPath( APIDocPath );
		setSchemaType( ucase( listLast( APIDocpath, ',' ) ) );
		var documentContent;
		switch( getSchemaType() ){
			case "cfm":
				savecontent variable="documentContent" {
					include APath;
				}
				break;
			case "yml":
				throw( "YAML support is not yet implemented" );
				break;

			case "json":
				documentContent = fileRead( APIDocPath );

			default:
				throw( "Relax does not support schema using the .#lcase(getSchemaType())# file extension." )
		}

		if( !isJSON( documentContent ) ) throw( "The API Document Provided: #APIDocPath# could not be parsed converted to valid JSON" );

		return parse( deSerializeJSON( documentContent ) );
	}


	public function parse( required struct APIDoc ){
		


	}

	public function normalizeSchema( required struct APIDoc ){
		for ( var key in APIDoc ){
			if( structKeyExists( APIDoc[key], "$ref" ) ){
				
			}
		}

	}

}