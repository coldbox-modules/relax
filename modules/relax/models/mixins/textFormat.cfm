<cfscript>
	function toParagraphFormat( required str ){
		//first make Windows style into Unix style
		arguments.str = replace( arguments.str, chr( 13 ) & chr( 10 ), chr( 10 ), "ALL" );
		//now make Macintosh style into Unix style
		arguments.str = replace( arguments.str, chr( 13 ), chr( 10 ), "ALL" );
		//now fix tabs
		arguments.str = replace( arguments.str, chr( 9 ), "&nbsp;&nbsp;&nbsp;", "ALL" );
		//now return the text formatted in HTML
		return replace( arguments.str, chr( 10 ), "<br />", "ALL" );
	}

	function titleCase( required str ){
		var hyphenatedArray = listToArray( arguments.str, '-' );
		for( var i = 1; i <= arraylen( hyphenatedArray ); i++ ){
			hyphenatedArray[ i ] = REReplace( arguments.str, "\b(\S)(\S*)\b", "\u\1\L\2", "all" );
		}
		return arrayToList( hyphenatedArray, '-' );
	}
</cfscript>