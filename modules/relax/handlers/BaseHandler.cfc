/**
* Copyright Ortus Solutions, Corp, All rights reserved
* www.ortussolutions.com
* ---
*/
component{

	// DI
	property name="settings" 		inject="wirebox:property:relax";
	property name="DSLService"		inject="id:DSLService@relax";

	/**
	* Pre handler
	*/
	function preHandler( event, rc, prc ){
		// module root
		prc.root 			= event.getModuleRoot();
		// settings
		prc.settings 		= variables.settings;
		// exit handlers
		prc.xehHome 		= "relax";
		prc.xehRelax		= "relax/home/relax";
		prc.xehRelaxer		= "relax/relaxer";
		prc.xehDSLDocs		= "relax/home/DSLDocs";
	}

}