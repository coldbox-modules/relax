<cfscript>
function getBrushByType(type){
	switch(arguments.type){
		case "json" : case "jsont" : { return "javascript"; }
		case "xml"  : { return "xml"; }
		default : { return "html"; }
	}		
}
</cfscript>