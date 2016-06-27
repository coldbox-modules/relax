component extends="testbox.system.BaseSpec" name="BaseOpenAPISpec" {
	property name="TestJSONAPIDirectory";
	property name="TestYAMLAPIDirectory";
	property name="TestJSONFile";
	property name="TestYAMLFile";
	property name="Wirebox" inject="wirebox";

	this.loadColdbox = false;

	public function beforeAll(){
		VARIABLES.TestJSONAPIDIrectory = expandPath( "/modules/relax/models/resources/petstore" );
		VARIABLES.TestYAMLAPIDIrectory = expandPath( "/modules/relax/models/resources/petstore" );
		expect( APPLICATION ).toHaveKey( "wirebox", "Wirebox is required to perform this test spec.  Could not continue" );
		APPLICATION.wirebox.autowire( this );
		expect( isNull( Wirebox ) ).toBeFalse( "Autowiring failed.  Tests could not continue." );
		
		expect( directoryExists( TestJSONAPIDirectory ) ).toBeTrue( "The test JSON API directory does not exist. Could not continue." );
		expect( fileExists( TestJSONAPIDirectory & "/" & listLast(TestJSONAPIDirectory,"/") & ".json" ) ).toBeTrue( "A JSON API file named #listLast(TestJSONAPIDirectory,"/") & ".json"# does not exist in the #TestJSONAPIDirectory# directory.  Could not continue." );
		VARIABLES.TestJSONFile = TestJSONAPIDirectory & "/" & listLast(TestJSONAPIDirectory,"/") & ".json";

		expect( fileExists( TestYAMLAPIDirectory & "/" & listLast(TestYAMLAPIDirectory,"/") & ".yaml" ) ).toBeTrue( "A YML API file named #listLast(TestYAMLAPIDirectory,"/") & ".yaml"# does not exist in the #TestYAMLAPIDirectory# directory.  Could not continue." );
		VARIABLES.TestYAMLFile = TestYAMLAPIDirectory & "/" & listLast(TestYAMLAPIDirectory,"/") & ".yaml";

	};

	public function afterAll(){
		
	};

}