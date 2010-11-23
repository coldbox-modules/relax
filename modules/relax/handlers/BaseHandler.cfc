<cfcomponent output="false">
<cfscript>

	function preHandler(event){
		var rc 	= event.getCollection();
		var prc = event.getCollection(private=true);
		
		// module root
		rc.root = event.getModuleRoot();
		// exit handlers
		rc.xehHome 		= "relax:home";
		rc.xehRelaxer	= "relax:home.relaxer";
		rc.xehLogViewer = "relax:logs";
	}

</cfscript>
</cfcomponent>