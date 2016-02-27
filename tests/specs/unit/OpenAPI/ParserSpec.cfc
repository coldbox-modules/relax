/**
* My BDD Test
*/
component extends="BaseOpenAPISpec"{
	
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

				describe( "Performs recursion checks on parsed JSON document", function(){
					runParserRecursionTests( JSONParser );			
				});

				describe( "Performs cross-conversion tests on the the parsed JSON document",function(){
					runParserConversionTests( JSONParser );
				});

			});

			xit( "Tests the ability instantiate the parser using a CFML file", function(){
				
			});

			xit( "Tests the ability instantiate the parser using a YAML file", function(){
				var YAMLParser = Wirebox.getInstance( "OpenAPIParser@relax" ).init( VARIABLES.TestYAMLFile );

				describe( "Performs recursion checks on parsed YAML document", function(){
					runParserRecursionTests( YAMLParser );			
				});

			});
		});
	}


	function runParserRecursionTests( required Parser ){
		it( "Tests for the recursive presence of OpenAPIDocument objects within Parser #Parser.getSchemaType()# document object" ,functioN(){
			
		});
		
		it( "Tests the ability to fully normalize the parsed #Parser.getSchemaType()# document" ,function(  ){
			
		});

	}

	function runParserConversionTests(required Parser){
		it( "Tests the parsers ability to perform cross-MIME type conversions on the parsed #Parser.getSchemaType()# document.",function(){

		});
	}
	
}
