<cfcomponent output="false" extends="BaseHandler">

	<!--- dependencies --->
	<cfproperty name="relaxerService" inject="model:relax.Relaxer" >
	
<cfscript>

	function index(event){
		var rc = event.getCollection();
		event.setView("home/index");
	}
	
	function relaxer(event){
		var rc = event.getCollection();
		event.paramValue("format","json");
		event.paramValue("sendRequest",false);
		
		
		if( rc.sendRequest ){
			rc.results = relaxerService.send(argumentCollection=rc);
		}
		
		// display relaxer
		event.setView("home/relaxer");
	}

</cfscript>
</cfcomponent>