/**
********************************************************************************
Copyright 2005-2007 by Luis Majano and Ortus Solutions, Corp
www.ortussolutions.com
********************************************************************************
* Generate DSL docs
*/
component singleton{

	/**
	* Constructor
	*/
	function init(){
		return this;	
	}
	
	/**
	* Generate docs
	*/
	function generate(){
		var tab 		= chr( 9 );
		var br  		= chr( 10 );
		var dq      	= chr( 34 );
		var fncExclude  = "init,onMissingMethod,appendResponse,appendData,verifyResourcePivot";
		var out   		= createObject( "java", "java.lang.StringBuilder").init( '' );
		var md   		= getComponentMetaData( "RelaxDSL" );
		var title 		= "Relax Programmatic Resource DSL Help";
	
		out.append( '<h1>#title#</h1><p>#md.hint#</p>' );
		
		var aSortedNames = [];
		var mdLookup	 = {};
		for (var i=1; i LTE arrayLen(md.functions); i++ ){
			arrayAppend( aSortedNames, md.functions[i].name );
			mdLookup[ md.functions[i].name ] = md.functions[i];
		}
		arraySort( aSortedNames, "textnocase" );

		// output functions
		for(var thisFunction in aSortedNames ){
			var thisMD = mdLookup[ thisFunction ];
			
			if( NOT structKeyExists( thisMD, "returntype" ) ){ thisMD.returntype = "any"; }
			if( NOT structKeyExists( thisMD, "hint" ) ){ thisMD.hint = ""; }
			if( NOT structKeyExists( thisMD, "access" ) ){ thisMD.access = "public"; }
			
			// Exclude certain functions
			if( listFindNoCase( fncExclude, thisMD.name ) OR 
				listFindNoCase( "private,package", thisMD.access ) ){ continue; }
				
			out.append("
			<h2><code>#thisMD.name#()</code></h2>
			<p class='lead'>#thisMD.hint#</p>");
			
			// Are arguments defined
			if( arrayLen( thisMD.parameters ) ){
				
				out.append("
				<div class=#dq#panel panel-default#dq#>
					<div class=#dq#panel-heading#dq#>Arguments</div>

					<div class=#dq#panel-body#dq#>
					<table class=#dq#table table-striped table-hover#dq#>
						<thead>
							<tr>
								<th>Argument</th>
								<th>Type</th>
								<th>Required</th>
								<th>Default</th>
								<th>Description</th>
							</tr>
						</thead>
						<tbody>");
				
				// Parameters
				for( var y=1; y lte arrayLen( thisMD.parameters ); y++){
					if( NOT structKeyExists( thisMD.parameters[ y ],"required" ) ){	thisMD.parameters[ y ].required = false;	}
					if( NOT structKeyExists( thisMD.parameters[ y ],"hint" ) ){	thisMD.parameters[ y ].hint = "";	}
					if( NOT structKeyExists( thisMD.parameters[ y ],"type" ) ){	thisMD.parameters[ y ].type = "any";	}
					if( NOT structKeyExists( thisMD.parameters[ y ],"default" ) ){	thisMD.parameters[ y ]["default"] = "---"; }
					
					out.append('<tr>
					<td>#thisMD.parameters[ y ].name#</td>
					<td>#thisMD.parameters[ y ].type#</td>
					<td>#yesNoFormat(thisMD.parameters[ y ].required)#</td> 
					<td>#thisMD.parameters[ y ].default#</td>
					<td>#thisMD.parameters[ y ].hint#</td>
					</tr>');
				
				}// end for loop of params
				
				out.append('</tbody></table></div></div>');
				
			} // end if no params
		
		}// end functions
			
		return out.toString();
		
	}
	
	function generateCodex(){
var tab 	= chr(9);
var br  	= chr(10);
var dq      = chr(34);
var fncExclude  = "init,onMissingMethod,appendResponse,appendData,verifyResourcePivot,$throw";
var out   = createObject("java","java.lang.StringBuffer").init('');
var md    = getComponentMetaData( "RelaxDSL" );
var title = "Relax Programmatic Resource DSL Help";

out.append('= #title# = 
<p>#md.hint#</p>');

// output functions
for(x=1; x lte arrayLen(md.functions); x++){
if( NOT structKeyExists(md.functions[ x ],"returntype") ){ md.functions[ x ].returntype = "any"; }
if( NOT structKeyExists(md.functions[ x ],"hint") ){ md.functions[ x ].hint = ""; }
if( NOT structKeyExists(md.functions[ x ],"access") ){ md.functions[ x ].access = "public"; }

// Exclude certain functions
if( listFindNoCase(fncExclude, md.functions[ x ].name) or listFindNoCase("private,package",md.functions[ x ].access) ){ continue; }

out.append("
== #md.functions[ x ].name#() ==
<p>#md.functions[ x ].hint#</p>");

// Are arguments defined
if( arrayLen(md.functions[ x ].parameters) ){

out.append("
=== Arguments ===

{| cellpadding=#dq#5#dq#, class=#dq#tablelisting#dq#, width=#dq#98%#dq#
! '''Argument''' !! '''Type''' !! '''Required''' !! '''Default''' !! '''Description'''
|-
");

// Parameters
for( y=1; y lte arrayLen(md.functions[ x ].parameters); y++){
if(NOT structKeyExists(md.functions[ x ].parameters[ y ],"required") ){	md.functions[ x ].parameters[ y ].required = false;	}
if(NOT structKeyExists(md.functions[ x ].parameters[ y ],"hint") ){	md.functions[ x ].parameters[ y ].hint = "";	}
if(NOT structKeyExists(md.functions[ x ].parameters[ y ],"type") ){	md.functions[ x ].parameters[ y ].type = "any";	}
if(NOT structKeyExists(md.functions[ x ].parameters[ y ],"default") ){	md.functions[ x ].parameters[ y ]["default"] = "---"; }

out.append('|| #md.functions[ x ].parameters[ y ].name# || #md.functions[ x ].parameters[ y ].type# || #yesNoFormat(md.functions[ x ].parameters[ y ].required)# || #md.functions[ x ].parameters[ y ].default# || #md.functions[ x ].parameters[ y ].hint#');

if( y lt arrayLen(md.functions[ x ].parameters) ){ 
out.append('
|-
'); 
}

}// end for loop of params

out.append('
|}
');

} // end if no params

}// end functions

return out.toString();
		
	}
}