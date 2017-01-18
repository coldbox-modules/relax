<cfscript>
	function toParagraphFormat(str) {
		//first make Windows style into Unix style
		str = replace(str,chr(13)&chr(10),chr(10),"ALL");
		//now make Macintosh style into Unix style
		str = replace(str,chr(13),chr(10),"ALL");
		//now fix tabs
		str = replace(str,chr(9),"&nbsp;&nbsp;&nbsp;","ALL");
		//now return the text formatted in HTML
		return replace(str,chr(10),"<br />","ALL");
	}

	function titleCase( str ){
		var hyphenatedArray = listToArray( str, '-' );
		for( var i=1; i<=arraylen( hyphenatedArray );i++ ){
			hyphenatedArray[ i ] = REReplace(str, "\b(\S)(\S*)\b", "\u\1\L\2", "all");
		}
		return arrayToList( hyphenatedArray, '-' );
	}
</cfscript>