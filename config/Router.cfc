component{

	function configure(){
		// Module Entry Point
		route( "/", "home.index" );

		// APIDoc API Routes
		route( "/apidoc/:api?" )
			.withAction( {
				"GET" 		: "index",
				"POST" 		: "create",
				"PUT" 		: "update",
				"PATCH" 	: "update",
				"DELETE" 	: "delete"
			} )
			.toHandler( "APIDoc" );

		//Direct API requests
		route( "export/:action/:apiname?" ).toHandler( "export" );

		//Relaxer routes - explicit first
		route( "relaxer/send" ).to( "relaxer.send" );
		route( "relaxer/purgeHistory" ).to( "relaxer.purgeHistory" );
		route( "relaxer/resourceDoc" ).to( "relaxer.resourceDoc" );
		route( "relaxer/:apiname?" ).to( "relaxer.index" );

		// then our dynamic API selector
		route( "api/:apiname?" ).to( "home.index" );

	}

}