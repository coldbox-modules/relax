<cfscript>
function severityLookup(severity){
	switch(arguments.severity){
		case "FATAL" : { return "fatal.png"; }
		case "ERROR" : { return "error.gif"; }
		case "WARN"  : { return "warning.png"; }
		case "INFO"  : { return "information.png"; }
		case "DEBUG" : { return "debug.gif"; }		
	}
}
</cfscript>