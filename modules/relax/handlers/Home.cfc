<cfcomponent output="false" extends="BaseHandler">
<cfscript>

	function index(event){
		var rc = event.getCollection();
		event.setView("home/index");
	}

</cfscript>
</cfcomponent>