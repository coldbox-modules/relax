/**
* Copyright Ortus Solutions, Corp, All rights reserved
* www.ortussolutions.com
* ---
* Open API Parser
*/
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

		setDocumentObject( getWirebox().getInstance( "OpenAPIDocument@relax" ).init( ARGUMENTS.APIDoc, ARGUMENTS.XPath) );

		var Document = getDocumentObject().getDocument();

		for( var key in Document ){
			Document[ key ] = parseDocumentReferences( Document[ key ] );
		}

		return this;
	}

	public function parseDocumentReferences(required any DocItem ){
		
		if( isArray( DocItem ) ) {
			for( var i = 1; i <= arrayLen( DocItem ); i++){
				DocItem[ i ] = parseDocumentReferences( DocItem[ i ] );
			}
		} else if( isStruct( DocItem ) ) {
			//handle top-level values, if they exist
			if( structKeyExists( DocItem, "$ref" ) ) return fetchDocumentReference(DocItem[ "$ref" ]);

			for( var key in DocItem){
				if( 
					isStruct( DocItem[ key ] ) 
					&& 
					structKeyExists( DocItem[ key ], "$ref" ) 
				) {
					DocItem[ key ] = fetchDocumentReference( DocItem[ key ][ "$ref" ] );
				} else if( isStruct( DocItem[ key ] ) ||  isArray( DocItem[ key ] ) ){
					DocItem[ key ] = parseDocumentReferences( DocItem[ key ] );
				} 
			}
		}

		return DocItem;

	}

	public function getInternalXPath( required string XPath ){
		var PathArray = listToArray( XPath, "/" );
		return getDocumentObject().locate( arrayToList( PathArray, "." ) );
	}

	/**
	* Convenience method to return the fully normalize document
	**/
	public function getNormalizedDocument(){
		return getDocumentObject().getNormalizedDocument();
	}

	private function fetchDocumentReference( required string $ref ){
		
		//resolve internal refrences before looking for externals
		if( left( $ref, 1 ) == chr( 35 )){
			var FilePath = "";
			var XPath = listLast( " " & $ref, chr( 35 ) );

		} else {
			var refArray = listToArray( $ref, chr( 35 ) );
			var FilePath = refArray[ 1 ];
			if( arrayLen( refArray ) > 1 ) {
				var XPath = refArray[ 2 ];
			}	
		}

		var ReferenceDocument = {};
		
		//Files receive a parser reference
		if( len( FilePath ) && fileExists( getDirectoryFromPath( getBaseDocumentPath() ) &  FilePath )){

			var ReferenceDocument = Wirebox.getInstance( "OpenAPIParser@relax" ).init(  getDirectoryFromPath( getBaseDocumentPath() ) & $ref );
		
		} else if( len( FilePath ) && !fileExists( getDirectoryFromPath( getBaseDocumentPath() ) &  FilePath )) {

			throw( type="Relax.ParserException", message="File #( getDirectoryFromPath( getBaseDocumentPath() ) &  FilePath )# does not exist" );

		} else if( !isNull( XPath )  && len( XPath ) ) {

			var ReferenceDocument = getInternalXPath( XPath );	

		} else {

			throw( type="Relax.ParserException", message="The $ref #$ref# could not be resolved as either an internal or external reference");

		}

		return ReferenceDocument;
	}

	private function throwInvalidJSONException( required string InvalidContent ){

		throw( type="Relax.ParserException", message="The API Document Provided: #getBaseDocumentPath()# could not be converted to valid JSON" );
	
	}

}