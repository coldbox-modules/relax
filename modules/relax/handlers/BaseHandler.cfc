/**
* Copyright Ortus Solutions, Corp, All rights reserved
* www.ortussolutions.com
* ---
*/
component accessors=true{

	// DI
	property name="settings" 		inject="coldbox:setting:relax";
	property name="moduleConfig" 	inject="coldbox:moduleconfig:relax";
	property name="APIService"		inject="id:APIService@relax";

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
		prc.xehOpenAPIDocs	= "relax/home/OpenAPIDocs";

		prepareRuntimeAssets( argumentCollection=arguments );
	}

	/**
	 * Prepare runtime css/js
	 */
	private function prepareRuntimeAssets( event, rc, prc ){
		var handler 	= listLast( event.getCurrentHandler(), ":" );
		var action 		= event.getCurrentAction();
		var cssViewPath = prc.root & '/includes/css/views/';
		var jsViewPath 	= prc.root & '/includes/js/views/';

		prc.runtimeAssets = {
			"js" 	: [],
			"css" 	: []
		};

		// Naming convention is: {handler}.css
		var cssPathCheck = cssViewPath & "#lcase( handler )#.css";
		if( fileExists( expandPath( cssPathCheck )) ){ addCSS( cssPathCheck ); }

		// Naming convention is: {handler}-{action}.css
		var cssPathCheck = cssViewPath & "#lcase( handler )#-#action#.css";
		if( fileExists( expandPath( cssPathCheck )) ){ addCSS( cssPathCheck ); }

		// Naming convention is: {handler}.js
		var jsPathCheck = jsViewPath & "#lcase( handler )#.js";
		if( fileExists( expandPath(jsPathCheck) ) ){ addJS( jsPathCheck ); }

		// Naming convention is: {handler}.{action}.js
		var jsPathCheck = jsViewPath & "#lcase( handler )#.#action#.js";
		if( fileExists( expandPath(jsPathCheck) ) ){ addJS( jsPathCheck ); }
	}

	/**
	 * Add CSS paths to conventions		
	 */
	private function addCSS( required path, required struct assets ){
		arrayAppend( arguments.assets.css, arguments.path );
	};

	/**
	 * Add JS paths to conventions
	 */
	private function addJS( required path, required struct assets ){
		arrayAppend( arguments.assets.js, arguments.path );
	}

}