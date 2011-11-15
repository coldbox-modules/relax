component singleton{

	function init(){
		return this;	
	}
	
	function generate(){
		var tab 	= chr(9);
		var br  	= chr(10);
		var dq      = chr(34);
		var fncExclude  = "init,onMissingMethod,appendResponse,appendData,verifyResourcePivot,$throw";
		var out   = createObject("java","java.lang.StringBuffer").init('');
		var md    = getComponentMetaData( "RelaxDSL" );
		var title = "Relax Programmatic Resource DSL Help";
	
		out.append('<h1>#title#</h1><p>#md.hint#</p>');
		
		// output functions
		for(x=1; x lte arrayLen(md.functions); x++){
			if( NOT structKeyExists(md.functions[x],"returntype") ){ md.functions[x].returntype = "any"; }
			if( NOT structKeyExists(md.functions[x],"hint") ){ md.functions[x].hint = ""; }
			if( NOT structKeyExists(md.functions[x],"access") ){ md.functions[x].access = "public"; }
			
			// Exclude certain functions
			if( listFindNoCase(fncExclude, md.functions[x].name) or listFindNoCase("private,package",md.functions[x].access) ){ continue; }
				
			out.append("
			<h2>#md.functions[x].name#()</h2>
			<p>#md.functions[x].hint#</p>");
			
			// Are arguments defined
			if( arrayLen(md.functions[x].parameters) ){
				
				out.append("
				<h3>Arguments</h3>
				
				<table class=#dq#tablelisting#dq# cellpadding=#dq#5#dq# width=#dq#98%#dq#>
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
				for( y=1; y lte arrayLen(md.functions[x].parameters); y++){
					if(NOT structKeyExists(md.functions[x].parameters[y],"required") ){	md.functions[x].parameters[y].required = false;	}
					if(NOT structKeyExists(md.functions[x].parameters[y],"hint") ){	md.functions[x].parameters[y].hint = "";	}
					if(NOT structKeyExists(md.functions[x].parameters[y],"type") ){	md.functions[x].parameters[y].type = "any";	}
					if(NOT structKeyExists(md.functions[x].parameters[y],"default") ){	md.functions[x].parameters[y]["default"] = "---"; }
					
					out.append('<tr>
					<td>#md.functions[x].parameters[y].name#</td>
					<td>#md.functions[x].parameters[y].type#</td>
					<td>#yesNoFormat(md.functions[x].parameters[y].required)#</td> 
					<td>#md.functions[x].parameters[y].default#</td>
					<td>#md.functions[x].parameters[y].hint#</td>
					</tr>');
				
				}// end for loop of params
				
				out.append('</tbody></table>');
				
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
if( NOT structKeyExists(md.functions[x],"returntype") ){ md.functions[x].returntype = "any"; }
if( NOT structKeyExists(md.functions[x],"hint") ){ md.functions[x].hint = ""; }
if( NOT structKeyExists(md.functions[x],"access") ){ md.functions[x].access = "public"; }

// Exclude certain functions
if( listFindNoCase(fncExclude, md.functions[x].name) or listFindNoCase("private,package",md.functions[x].access) ){ continue; }

out.append("
== #md.functions[x].name#() ==
<p>#md.functions[x].hint#</p>");

// Are arguments defined
if( arrayLen(md.functions[x].parameters) ){

out.append("
=== Arguments ===

{| cellpadding=#dq#5#dq#, class=#dq#tablelisting#dq#, width=#dq#98%#dq#
! '''Argument''' !! '''Type''' !! '''Required''' !! '''Default''' !! '''Description'''
|-
");

// Parameters
for( y=1; y lte arrayLen(md.functions[x].parameters); y++){
if(NOT structKeyExists(md.functions[x].parameters[y],"required") ){	md.functions[x].parameters[y].required = false;	}
if(NOT structKeyExists(md.functions[x].parameters[y],"hint") ){	md.functions[x].parameters[y].hint = "";	}
if(NOT structKeyExists(md.functions[x].parameters[y],"type") ){	md.functions[x].parameters[y].type = "any";	}
if(NOT structKeyExists(md.functions[x].parameters[y],"default") ){	md.functions[x].parameters[y]["default"] = "---"; }

out.append('|| #md.functions[x].parameters[y].name# || #md.functions[x].parameters[y].type# || #yesNoFormat(md.functions[x].parameters[y].required)# || #md.functions[x].parameters[y].default# || #md.functions[x].parameters[y].hint#');

if( y lt arrayLen(md.functions[x].parameters) ){ 
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