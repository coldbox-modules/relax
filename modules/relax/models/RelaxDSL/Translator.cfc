/**
* Copyright Ortus Solutions, Corp, All rights reserved
* www.ortussolutions.com
* ---
* Translator for RelaxDSL APIs in to OpenAPI Format
*  
* @deprecate v3.0.0
*/
component name="RelaxDSLTranslator" singleton{
	
	VARIABLES.translationMap = {
		
	};

	public function translate( required any dataCFC ){
		return dataCFC;	
	}
}