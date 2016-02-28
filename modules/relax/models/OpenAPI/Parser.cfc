component name="OpenAPIParser" accessors="true" {
	//the base path of the APIDoc
	property name="DocumentObject";
	property name="baseDocumentPath";
	property name="schemaType";
	property name="Wirebox" inject="wirebox";
	property name="jLoader" inject="loader@cbjavaloader";
	property name="Utils" inject="OpenAPIUtil@relax";


	public function init(string APIDocPath){
		var refArray = listToArray( ARGUMENTS.APIDocPath, chr( 35 ) );

		var DocPath = refArray[ 1 ];
		if( arrayLen( refArray ) > 1 ) {
			var XPath = refArray[ 2 ];
		} else {
			XPath="";
		}

		if( !fileExists( DocPath ) ) throw(  type="Relax.ParserException", message="The APIDoc file #ARGUMENTS.APIDocPath# does not exist." )

		setBaseDocumentPath( DocPath );
		setSchemaType( ucase( listLast( DocPath, '.' ) ) );
		
		var documentContent = "";
		
		switch( getSchemaType() ){
			case "cfm":
				savecontent variable="documentContent" {
					include APath;
				}
				if( !isJSON( trim( documentContent ) ) ) throwInvalidJSONException( documentContent );
				
				documentContent = serializeJSON( trim( documentContent ) );

				break;

			case "yaml":
			case "yml":

				var YAMLLoader = jLoader.create( "org.yaml.snakeyaml.Yaml" );
				var IOFile = jLoader.create( "java.io.File" ).init( DocPath );
				var InputStream = jLoader.create( "java.io.FileInputStream" ).init( IOFile );

				documentContent = getUtils().toCF( YAMLLoader.load( InputStream ) );
		
				break;

			case "json":
				documentContent = fileRead( DocPath );
				
				if( !isJSON( documentContent ) ) throwInvalidJSONException( documentContent );
				
				documentContent = deSerializeJSON( documentContent );
				break;

			default:
				throw( type="Relax.ParserException", message="Relax does not support schema using the .#lcase(getSchemaType())# file extension." );
		}


		return parse( documentContent , XPath );
	}


	public function parse( required struct APIDoc, required string XPath="" ){
		
		for( var key in ARGUMENTS.APIDoc ){
			ARGUMENTS.APIDoc[ key ] = parseDocumentReferences( ARGUMENTS.APIDoc[ key ] );
		}

		setDocumentObject( getWirebox().getInstance( "OpenAPIDocument@relax" ).init( ARGUMENTS.APIDoc, ARGUMENTS.XPath) );

		return this;
	}

	public function parseDocumentReferences(required any DocItem ){

		if( isArray( DocItem ) ) {
			for( var i = 1; i <= arrayLen( DocItem ); i++){
				DocItem[ i ] = parseDocumentReferences( DocItem[ i ] );
			}
		} else if( isStruct( DocItem ) ) {
			for( var key in DocItem){
				if( 
					isStruct( DocItem[ key ] ) 
					&& 
					structKeyExists( DocItem[ key ], "$ref" ) 
				) {
					DocItem[ key ] = fetchDocumentReference( DocItem[ key ][ "$ref" ] );
				} else if( isArray( DocItem[ key ] ) ){
					DocItem[ key ] = parseDocumentReferences( DocItem[ key ] );
				}
			}
		}

		return DocItem;

	}

	public function getDocumentInstance( required string XPath = "" ){
		
		if( len( XPath ) ){
			return getDocumentObject().locate( replace( XPath, "/", "." , "ALL") );
		} else {
			return getDocumentObject();
		}

	}

	/**
	* Convenience method to return the fully normalize document
	**/
	public function getNormalizedDocument(){
		return getDocumentObject().getNormalizedDocument();
	}

	private function fetchDocumentReference( required string $ref ){
		var refArray = listToArray( $ref, chr( 35 ) );

		var FilePath = refArray[ 1 ];
		if( arrayLen( refArray ) > 1 ) {
			var XPath = refArray[ 2 ]
		}

		var ReferenceDocument = {};
		
		if( len( FilePath ) && fileExists( getDirectoryFromPath( getBaseDocumentPath() ) &  FilePath )){

			var ReferenceDocument = Wirebox.getInstance( "OpenAPIParser@relax" ).init(  getDirectoryFromPath( getBaseDocumentPath() ) & $ref );
		
		} else if( !isNull( XPath ) ) {
			var ReferenceDocument = Wirebox.getInstance( "OpenAPIParser@relax" ).init(  getBaseDocumentPath()  & $ref );
		}

		return ReferenceDocument;
	}

	private function throwInvalidJSONException( required string InvalidContent ){

		throw( type="Relax.ParserException", message="The API Document Provided: #getBaseDocumentPath()# could not be converted to valid JSON" );
	
	}

}