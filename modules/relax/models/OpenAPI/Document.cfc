/**
* Copyright Ortus Solutions, Corp, All rights reserved
* www.ortussolutions.com
* ---
* Open API Document Object
*/
component name="OpenAPIDocument" accessors="true" {
	property name="Document";
	property name="XPath";
	property name="Wirebox" inject="wirebox";
	property name="jLoader" inject="loader@cbjavaloader";
	
	/**
	* Constructor
	* 
	* @param Doc	The document representation
	* @param XPath	The XPath of the document to zoom this Document object to
	**/
	public function init( required struct Doc, required string XPath="" ){
		
		setDocument( ARGUMENTS.Doc );

		if( len( ARGUMENTS.XPath ) ){
			this.setXPath( ARGUMENTS.XPath );
			zoomToXPath();
		}

		setResourceIds( getDocument() );
		
		return this;
	}

	/**
	* Convenience methot for setting the XPath of the Document
	* 
	* @param XPath	The XPath to zoom the parsed document to during recursion
	**/
	public function xPath( required string XPath ){
		this.setXPath( ARGUMENTS.XPath );
	}

	/**
	* Zooms this Document instance to the XPath
	**/
	public function zoomToXPath(){
		if( isNull( getXPath() ) ) return;

		setDocument( locate( getXPath() ) );

	}

	/**
	* Sets the resourceId extension of a document path
	* 
	* @param resourceDoc	The document to parse for x-resourceId nodes
	* @param hashPrefix		The prefix to use when hashing the x-resourceId value
	**/
	private void function setResourceIds(required struct resourceDoc, string hashPrefix="" ){
		var appendableNodes = [ "paths","get","post","put","patch","delete","head","option" ];

		for ( var resourceKey in appendableNodes ){
			
			if(  structKeyExists( resourceDoc, resourceKey ) && isStruct( resourceDoc[ resourceKey ] ) ){
				for( var pathKey in resourceDoc[ resourceKey ] ){
					if( !isStruct( resourceDoc[ resourceKey ][ pathKey ] ) ) continue;

					resourceDoc[ resourceKey ][ pathKey ].put( "x-resourceId", lcase( hashPrefix & hash( pathKey ) ) );
					
					//recurse, if necessary
					for( var subKey in resourceDoc[ resourceKey ][ pathKey ] ){
						if( 
							arrayFindNoCase( appendableNodes, subKey ) 
							&& 
							isStruct( resourceDoc[ resourceKey ][ pathKey ][ subKey ] )
						) {
							resourceDoc[ resourceKey ][ pathKey ][ subKey ].put( "x-resourceId", lcase( hashPrefix & hash( pathKey & subkey ) ) );
						}
					}
				}
			}	
		}

	}

	/**
	* Convenience method to return a flattened struct of the Document instance
	**/
	public function asStruct(){	
		return getNormalizedDocument();
	}

	/**
	* Convenience method to return a YAML string of the normalized document
	**/
	public function asYAML(){
		return convertToYAML( getNormalizedDocument );
	}

	/**
	* Converts the entity doc to a YAML string
	**/
	private string function convertToYAML(){
		throw( "Method not yet implemented" );
	}

	/**
	* Convenience method to return a JSON representation of the normalized document
	**/
	public function asJSON(){
		return serializeJSON( getNormalizedDocument() );
	}

	/**
	* Normalizes the document recursively to provide a flattened representation
	* @param APIDoc 	The document to normalized.  Defaults to the entity document
	**/
	public function getNormalizedDocument(struct APIDoc=this.getDocument()){
		
		var NormalizedDoc = structCopy( ARGUMENTS.APIDoc );

		for ( var key in NormalizedDoc ){

			if( isObject( NormalizedDoc[ key ] ) && findNoCase( "Parser", getMetaData( NormalizedDoc[ key ] ).name ) ){

				if( !structKeyExists( NormalizedDoc[ key ], "getDocumentObject" )  ){
					throwForeignObjectTypeException( NormalizedDoc[ key ] );
					throw( type="Relax.NormalizationException" ,message="Relax doesn't know what do with an object of type #getMetaData( NormalizedDoc[ key ] ).name#." );
				}					
			
				NormalizedDoc[ key ]=NormalizedDoc[ key ].getDocumentObject().getNormalizedDocument();	
			
			} else if( isStruct( normalizedDoc[ key ] ) ){

				NormalizedDoc[ key ] = getNormalizedDocument( NormalizedDoc[ key ] );
				
			} else if( isArray( NormalizedDoc[ key ] ) ){

				for( var i = 1; i <= arrayLen( NormalizedDoc[ key ] ); i++ ){

					if( isStruct( NormalizedDoc[ key ][ i ] ) ) NormalizedDoc[ key ][ i ] = getNormalizedDocument( NormalizedDoc[ key ][ i ] );
					
					if( isObject( NormalizedDoc[ key ][ i ] ) ) {

						if( !structKeyExists( NormalizedDoc[ key ][ i ], "getDocumentObject" )  ){
							throwForeignObjectTypeException( NormalizedDoc[ key ][ i ] );
						}
						
						NormalizedDoc[ key ][ i ] = NormalizedDoc[ key ][ i ].getDocumentObject().getNormalizedDocument();
					
					}

				}
			
			}
		}

		setResourceIds(normalizedDoc);

		return NormalizedDoc;
	}

	/**
	 * Helper function to locate deeply nested document items
	 *
	 * @param key the key to locate
	 * @return any the value of the key or null if the key is not found
	 * @usage locate('key.subkey.subsubkey.waydowndeepsubkey')
	 **/
	public any function locate( string key ){
		var document=this.getDocument();
		if( structKeyExists( document, ARGUMENTS.key ) ){
			return document[ ARGUMENTS.key ];
		} else {
			if( isDefined( 'document.#ARGUMENTS.key#' ) ){
				return evaluate( 'document.#ARGUMENTS.key#' );
			}
		}
		
		return document;
	}


	/**
	* Throws a foreign object type exception if detected when normalizing a document
	* @param UnKnownObject 		The foreign object detected
	**/
	private function throwForeignObjectTypeException( required any UnKnownObject ){
		throw( type="Relax.ForeignObjectException" ,message="Relax doesn't know what do with an object of type #getMetaData( UnKnownObject ).name#." );
	}

}