/**
* My BDD Test
*/
component extends="BaseOpenAPISpec"{
	
	this.loadColdbox=true;
/*********************************** LIFE CYCLE Methods ***********************************/

	function beforeAll(){
		super.beforeAll();
		
	};

	function afterAll(){
		super.afterAll();
	};

/*********************************** BDD SUITES ***********************************/

	function run(){
		// all your suites go here.
		describe( "Performs and tests general OpenAPIParser operations" ,function(){
			it( "Tests the ability instantiate the parser using a JSON file", function(){
				var JSONParser = Wirebox.getInstance( "OpenAPIParser@relax" ).init( VARIABLES.TestJSONFile );
				runParserTypeChecks( JSONParser );

				describe( "Performs recursion checks on parsed JSON document", function(){
					runParserRecursionTests( JSONParser, true );			
				});

				describe( "Performs cross-conversion tests on the the parsed JSON document",function(){
					runParserConversionTests( JSONParser );
				});

			});

			it( "Tests the ability instantiate the parser using a YAML file", function(){
				var YAMLParser = Wirebox.getInstance( "OpenAPIParser@relax" ).init( VARIABLES.TestYAMLFile );
				runParserTypeChecks( YAMLParser );

				describe( "Performs recursion checks on parsed YAML document", function(){
					runParserRecursionTests( YAMLParser );			
				});

			});

			xit( "Tests the ability instantiate the parser using a CFML file", function(){
				
			});
		});
	}

	function runParserTypeChecks( required Parser ){

		expect( ARGUMENTS.Parser ).toBeInstanceOf( "Parser" );
		expect( ARGUMENTS.Parser ).toHaveKey( "getDocumentObject" );
		expect( ARGUMENTS.Parser.getDocumentObject() ).toBeInstanceOf( "Document" );
		expect( ARGUMENTS.Parser ).toHaveKey( "getSchemaType" );
		expect( ARGUMENTS.Parser.getSchemaType() ).toBeString();
		expect( ARGUMENTS.Parser ).toHaveKey( "getBaseDocumentPath" );
		expect( ARGUMENTS.Parser.getBaseDocumentPath() ).toBeString();

	}


	function runParserRecursionTests( required Parser, required boolean testObjects=false ){
		if( ARGUMENTS.testObjects ){

			it( "Tests for the recursive presence of OpenAPIDocument objects within Parser #Parser.getSchemaType()# document object" , function(){
				var ParserDoc = Parser.getDocumentObject();
				expect( ParserDoc ).toBeInstanceOf( "Document" );
				expect( ParserDoc ).toHaveKey( "getDocument" );
				var APIDoc = ParserDoc.getDocument();
				expect( APIDoc ).toBeStruct();
				expect( APIDoc ).toHaveKey( "paths" );
				expect( APIDoc.paths ).toHaveKey( "/pets" );
				expect( APIDoc.paths[ "/pets" ] ).toBeInstanceOf( "Parser" );
				runParserTypeChecks( APIDoc.paths[ "/pets" ] );

			});
				
		}
		
		it( "Tests the ability to fully normalize the parsed #Parser.getSchemaType()# document" ,function(  ){
			var NormalizedDocument = Parser.getNormalizedDocument();

			expect( NormalizedDocument ).toBeStruct();
			expect( NormalizedDocument ).toHaveKey( "swagger" );
			expect( NormalizedDocument ).toHaveKey( "host" );
			expect( NormalizedDocument ).toHaveKey( "info" );
			expect( NormalizedDocument ).toHaveKey( "basePath" );
			expect( NormalizedDocument ).toHaveKey( "schemes" );
			expect( NormalizedDocument ).toHaveKey( "consumes" );
			expect( NormalizedDocument ).toHaveKey( "produces" );
			expect( NormalizedDocument ).toHaveKey( "paths" );

			expect( NormalizedDocument ).toHaveDeepKey( "/pets" );
			expect( NormalizedDocument.paths[ '/pets' ] ).toBeStruct();
			expect( NormalizedDocument.paths[ '/pets' ] ).toHaveDeepKey( "description" );
			expect( NormalizedDocument.paths[ '/pets' ] ).toHaveDeepKey( "parameters" );
			expect( NormalizedDocument.paths[ '/pets' ] ).toHaveDeepKey( "responses" );

			expect( NormalizedDocument ).toHaveDeepKey( "/pets/{id}" );
			expect( NormalizedDocument.paths[ '/pets/{id}' ] ).toBeStruct();
			expect( NormalizedDocument.paths[ '/pets/{id}' ] ).toHaveDeepKey( "description" );
			expect( NormalizedDocument.paths[ '/pets/{id}' ] ).toHaveDeepKey( "parameters" );
			expect( NormalizedDocument.paths[ '/pets/{id}' ] ).toHaveDeepKey( "responses" );

			expect( arrayLen( structFindKey( NormalizedDocument, "$ref" ) ) ).toBe( 0 );
			
		});

	}

	function runParserConversionTests(required Parser){
		it( "Tests the parsers ability to perform cross-MIME type conversions on the parsed #Parser.getSchemaType()# document.",function(){

		});
	}
	
}
