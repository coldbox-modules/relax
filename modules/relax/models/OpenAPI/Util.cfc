/**
* Copyright Ortus Solutions, Corp, All rights reserved
* www.ortussolutions.com
* ---
* Open API Utilities
*/
component name="OpenAPIUtil" accessors="true" {
	
	public function init(){
		return this;
	}


	/**
	* Converts a Java object to native CFML structure
	* @param Object Map  	The Java map object or array to be converted
	*/
	function toCF( Map ){

		if(isNull( Map )) return;
		
		//if we're in a loop iteration and the array item is simple, return it
		if(isSimpleValue( Map )) return Map;

		if(isArray( Map )){
			var cfObj = [];

			for(var obj in Map){
				arrayAppend(cfObj,toCF(obj));
			}
		
		} else {
		
			var cfObj = {};

			try{
				cfObj.putAll( Map );
			
			} catch (any e){
			
				return Map;
			}
			
			//loop our keys to ensure first-level items with sub-documents objects are converted
			for(var key in cfObj){
			
				if(!isNull(cfObj[key]) && ( isArray(cfObj[key]) || isStruct(cfObj[key]) ) ) cfObj[key] = toCF(cfObj[key]);
			
			}
		}

		return cfObj;
	}

}