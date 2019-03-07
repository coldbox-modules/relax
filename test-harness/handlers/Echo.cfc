component{
	public function index( event, rc, prc ){
		event.setHTTPHeader( name="Content-Type", value="application/json" );
		event.renderData( 
			data={
				"form":FORM,
				"url":URL,
				"body":event.getHTTPContent(),
				"headers":getHttpRequestData().headers
			},
			type="JSON" 
		);
	}
}