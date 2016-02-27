component extends="testbox.system.BaseSpec" name="BaseOpenAPISpec" {
	property name="TestJSONAPIDirectory" default="#expandPath( "/modules/relax/models/resources/petstore" )#";
	property name="TestYAMLAPIDirectory" default="#expandPath( "/modules/relax/models/resources/petstore" )#";
	property name="TestJSONFile";
	property name="TestYAMLFile";
	property name="Wirebox" inject="wirebox";

	this.loadColdbox = true;

	public function beforeAll(){
		expect( APPLICATION ).toHaveKey( "wirebox", "Wirebox is required to perform this test spec.  Could not continue" );
		APPLICATION.wirebox.autowire( this );
		expect( isNull( Wirebox ) ).toBeFalse( "Autowiring failed.  Tests could not continue." );
		
		expect( directoryExists( TestJSONAPIDirectory ) ).toBeTrue( "The test JSON API directory does not exist. Could not continue." );
		expect( fileExists( TestJSONAPIDirectory & "/ " & listLast(TestJSONAPIDirectory,"/") & ".json" ) ).toBeTrue( "A JSON API representation does not exist in the #TestJSONAPIDirectory# directory.  Could not continue." );
		VARIABLES.TestJSONFile = TestJSONAPIDirectory & "/ " & listLast(TestJSONAPIDirectory,"/") & ".json";

		expect( fileExists( TestYAMLAPIDirectory & "/ " & listLast(TestYAMLAPIDirectory,"/") & ".yaml" ) ).toBeTrue( "A YML API representation does not exist in the #TestYAMLAPIDirectory# directory.  Could not continue." );
		VARIABLES.TestYAMLFile = TestYAMLAPIDirectory & "/ " & listLast(TestYAMLAPIDirectory,"/") & ".yaml";

	};

	public function afterAll(){
		
	};

}