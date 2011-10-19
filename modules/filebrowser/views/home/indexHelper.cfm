<cfscript>
	function $safe(str){ return urlEncodedFormat(arguments.str); }
	function $validIDName(str){return JSStringFormat( html.slugify( arguments.str )); }
	function $getBackPath(inPath){
		arguments.inPath = replace(arguments.inPath,"\","/","all");
		var lFolder = listLast( arguments.inPath,"/" );
		return URLEncodedFormat( left( arguments.inPath, len(arguments.inPath) - len(lFolder) ) );
	}
</cfscript>