/**
* Copyright Ortus Solutions, Corp, All rights reserved
* www.ortussolutions.com
* ---
* Generate DSL docs
*  
* @deprecate v3.0.0
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
		var md   		= getComponentMetaData( "Document" );
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
	
}