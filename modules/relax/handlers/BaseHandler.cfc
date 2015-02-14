component{

	function preHandler( event, rc, prc ){

		// module root
		rc.root = event.getModuleRoot();
		// exit handlers
		rc.xehHome 			= "relax/home";
		rc.xehRelax			= "relax/home.relax";
		rc.xehRelaxer		= "relax/home.relaxer";
		rc.xehRelaxUpdates	= "relax/Home.checkUpdates";
		rc.xehDSLDocs		= "relax/home.DSLDocs";
	}

}