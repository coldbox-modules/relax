component name="OpenAPIParser" accessors="true" {
	property name="jLoader" inject="loader@cbjavaloader";
	//the swagger parser
	property name="Parser";
	//the loaded swagger object
	property name="objAPI";

	public function init(){
		setParser(jLoader.create("io.swagger.parser.SwaggerParser"));

		return this;
	}

	public function read(required string APIDoc){
		if( isJSON( ARGUMENTS.APIDoc )){
			if(isStruct(ARGUMENTS.APIDoc)) ARGUMENTS.APIDoc = serializeJSON( ARGUMENTS.APIDoc )

			var jsonObj = jLoader.create("com.fasterxml.jackson.databind.JsonNode").init(ARGUMENTS.APIDoc);
			
			setObjAPI(Parser.read(jsonObj))

		} else if( fileExists( ARGUMENTS.APIDoc ) ) {
		
			setObjAPI( Parser.read() )
		
		} else {
			throw( "The APIDoc argument did not contain a file path or JSON string" )
		}

		return this;
	}

}