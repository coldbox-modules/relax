<cfscript>
/**
* Mixin utility to handle the way older versions of ACF handle the init method when creating a java object
**/
function createLinkedHashMap(){

	if( !structKeyExists( VARIABLES, "moduleConfig" ) ) {
		throw( "The Relax module configuration is required to use this mixin. Please add the moduleConfig property, mapped to coldbox:setting:relax to your component." );	
	}
	
	if( structKeyExists( VARIABLES, "jLoader" ) ){
		var HashMap = VARIABLES.jLoader.create( "java", "java.util.LinkedHashMap" );
	} else {
		var HashMap = createObject( "java", "java.util.LinkedHashMap" );
	}

	switch( VARIABLES.moduleConfig.serverType ){
		case "coldfusion":
			return HashMap.init();
			break;
		default:
			return HashMap;
	}
}	
</cfscript>
