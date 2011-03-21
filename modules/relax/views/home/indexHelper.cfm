<cfscript>
function flattenActions(action){
	var key = "";
	var r = "";
	var i = 1;
	var a = arguments.action;
	
	if( isStruct(a) ){
		r = ",action={";
		for(key in a){
			r &= key & '="#action[key]#"';
			if( i lt structCount(a) ){ r &= ","; }
			i++;	
		}
		return r & "}";
	}
	
	if( len(action) ){
		return ',action="#action#"';
	}
	
	return '';
}
</cfscript>