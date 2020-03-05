<cfscript>
/**
* Mixin utility to handle the way older versions of ACF handle the init method when creating a java object
**/
function createLinkedHashMap(){
	// Left for backwards compat
	return structNew( "ordered" );
}
</cfscript>
