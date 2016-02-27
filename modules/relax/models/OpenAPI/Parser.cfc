component name="OpenAPIParser" accessors="true" {
	//the base path of the APIDoc
	property name="document";
	property name="baseDocumentPath";


	public function init(string APIDocPath){
		setBaseDocumentPath( APIDocPath );
		var documentContent;
		switch( listLast( APIDocPath, ',' ) ){
			case "cfm":
				savecontent variable="documentContent" {
					include APIDocPath;
				}
				break;
			case "yml":
				throw( "YAML support is not yet implemented" );
				break;
			default:
				documentContent = fileRead( APIDocPath );
		}

		if( !isJSON( documentContent ) ) throw( "The API Document Provided: #APIDocPath# is not valid JSON" );

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