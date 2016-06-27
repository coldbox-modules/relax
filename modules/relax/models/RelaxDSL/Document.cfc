/**
* Copyright Ortus Solutions, Corp, All rights reserved
* www.ortussolutions.com
* ---
* Relax offers you a nice programmatic DSL to define RESTFul web services.  All functions defined in this DSL can be concatenated with each other to 
* create expressive and human readable representations of your API Definitions.
* 
* @deprecate v3.0.0
*/
component accessors="true"{

	// setup defaults
	this.relax 				= {};
	this.globalHeaders 		= [];
	this.globalParameters	= [];
	this.resources			= [];	
	// Internal pivots
	this._currentResource	= "";	
	this._definedResources	= {};
	
	/**
	* Constructor
	*/
	function init(){
		return this;
	}

	/**
	* The relaxed service information. From here you will define the RESTful service endpoints, extension detection, valid formats, and more.
	* @title The title of the RESTful service
	* @description The description of the RESTful service
	* @entryPoint A simple URL or a structure of entry points for different tiers: { dev="http://localhost/api", prd="http://www.mysite.com/api" }
	* @extensionDetection Will this API do extension detection
	* @validExtensions The valid extensions to detect
	* @throwOnInvalidExtensions Throw on invalid extensions or not
	* 
	* @return RelaxDSL
	*/
	function service(
		required string title,
		required string description,
		required any entryPoint,
		boolean extensionDetection=false,
		string validExtensions="json,jsont,xml,html,htm,rss",
		boolean throwOnInvalidExtensions=false
	){
		for(var key in arguments){
			if( structKeyExists( arguments, key ) ){
				this.relax[ key ] = arguments[ key ];
			}
		}
		return this;
	}

	/**
	* Add a global header to the relax definition
	* @name The name of the header
	* @description The description of the header
	* @required Is the header required or not
	* @defaultValue The default value of this header
	* @type The type of the incoming header
	* 
	* @return RelaxDSL
	*/
	function globalHeader(
		required string name,
		string description="",
		boolean required=false,
		string defaultValue="",
		string type="string"
	){
		var thisHeader 	= {};
		
		for(var key in arguments){
			if( structKeyExists( arguments, key ) ){
				thisHeader[ key ] = arguments[ key ];
			}
		}
		
		arrayAppend( this.globalHeaders, thisHeader );
		
		return this;
	}

	/**
	* Add a global parameter to the relax definition
	* @name The name of the parameter
	* @description The description of the parameter
	* @required Is the parameter required or not
	* @defaultValue The default value of this parameter
	* @type The type of the incoming parameter
	* 
	* @return RelaxDSL
	*/
	function globalParam(
		required string name,
		string description="",
		boolean required=false,
		string defaultValue="",
		string type="string"
	){
		var thisParam 	= {};
		
		for(var key in arguments){
			if( structKeyExists( arguments, key ) ){
				thisParam[ key ] = arguments[ key ];
			}
		}
		
		arrayAppend( this.globalParameters, thisParam );
		
		return this;
	}
    

    /**
	* Add a new resource to the API definition, you can then concatenate more methods to the same resource: methods(),description(),header(),parameter(),placeholder(),schema(),sample()
	* @pattern The SES pattern to register for the resource
	* @handler The handler this pattern directs to
	* @action The action this pattern directs to, it can be simple or a complex HTTP-Action struct: { "get" : "list", "delete", "doRemove" }
	* @defaultValueMethod The default HTTP Method: GET
	* 
	* @return RelaxDSL
	*/
	function resource(
		required string pattern,
		string handler,
		any action,
		string defaultMethod="GET"
	){
		var data	= {};
		
		for( var key in arguments ){
			if( structKeyExists( arguments, key ) ){
				data[ key ] = arguments[ key ];
			}
		}
		
		// store resource definition and current pivot point
		this._definedResources[ arguments.pattern ] = data;
		this._currentResource = arguments.pattern;
		
		// add reference to resources
		arrayAppend( this.resources, this._definedResources[ arguments.pattern ] );
		
		// setup default method
		this.defaultMethod( arguments.defaultMethod );
		
		return this;
	}
    
	/**
	* Add valid HTTP methods to a resource
	* @methods A list of HTTP methods a resource allows
	* 
	* @return RelaxDSL
	*/
    function methods( required methods ){
    	verifyResourcePivot();
		this._definedResources[ this._currentResource ].methods = arguments.methods;
		
		return this;
    }

    /**
	* Define a default HTTP method for a resource
	* @method The HTTP method that will be the default
	* 
	* @return RelaxDSL
	*/
    function defaultMethod( required string method ){
    	verifyResourcePivot();
		this._definedResources[ this._currentResource ].defaultMethod = arguments.method;
			
		return this;
    }
  	
  	/**
	* Define a default return format for a resource
	* @format The format. Ex: json, xml, html
	* 
	* @return RelaxDSL
	*/
    function defaultFormat( required string format ){
    	verifyResourcePivot();
		this._definedResources[ this._currentResource ].defaultFormat = arguments.format;
		
		return this;
    }

    /**
	* Add a description to a resource
	* @description The long description of a resource
	* 
	* @return RelaxDSL
	*/
    function description( required string description ){
    	verifyResourcePivot();
		this._definedResources[ this._currentResource ].description = arguments.description;
		
		return this;
    }
    
    /**
	* Add a header to a resource
	* @name The name of the header
	* @description The description of the header
	* @required Is the header required or not
	* @defaultValue The default value of this header
	* @type The type of the incoming header
	* 
	* @return RelaxDSL
	*/
	function header(
		required string name,
		string description="",
		boolean required=false,
		string defaultValue="",
		string type="string"
	){
		appendData( arguments, "headers" );
		return this;
	}
   
    /**
	* Add a parameter to a resource
	* @name The name of the parameter
	* @description The description of the parameter
	* @required Is the parameter required or not
	* @defaultValue The default value of this parameter
	* @type The type of the incoming parameter
	* 
	* @return RelaxDSL
	*/
	function param(
		required string name,
		string description="",
		boolean required=false,
		string defaultValue="",
		string type="string"
	){
		appendData( arguments, "parameters" );
		return this;
	}

	/**
	* Add a placeholder to a resource
	* @name The name of the placeholder
	* @description The description of the placeholder
	* @required Is the placeholder required or not
	* @defaultValue The default value of this placeholder
	* @type The type of the incoming placeholder
	* 
	* @return RelaxDSL
	*/
	function placeholder(
		required string name,
		string description="",
		boolean required=false,
		string defaultValue="",
		string type="string"
	){
		appendData( arguments, "placeholders" );
		return this;
	}
    
    /**
	* Append a schema to a resource
	* @format The format of the schema
	* @description The description of the schema
	* @body The body contents of the schema
	* 
	* @return RelaxDSL
	*/
	function schema(
		required string format,
		string description="",
		string body=""
	){
		appendResponse( arguments, "schemas" );
		return this;
	}

	/**
	* Append a sample to a resource
	* @format The format of the sample
	* @description The description of the sample
	* @body The body contents of the sample
	* 
	* @return RelaxDSL
	*/
	function sample(
		required string format,
		string description="",
		string body=""
	){
		appendResponse( arguments, "samples" );
		return this;
	}
    
    /**
    * Append a response to a resource
    * @args The data arguments
    * @dataKey The key to add it to
    * 
    * @return RelaxDSL
    */
	function appendResponse( required struct args, required string dataKey ){
		var data	= {};
		
		verifyResourcePivot();
		
		for(var key in arguments.args ){
			if( structKeyExists( arguments.args, key ) ){
				data[ key ] = args[ key ];
			}
		}
		
		// verify response exist, else init it
		if( NOT structKeyExists( this._definedResources[ this._currentResource ], "response" ) ){
			this._definedResources[ this._currentResource ].response = {};
		}
		// verify datakey exist, else init it
		if( NOT structKeyExists( this._definedResources[ this._currentResource ].response, dataKey ) ){
			this._definedResources[ this._currentResource ].response[ dataKey ] = [];
		}
		
		// append schema
		arrayAppend( this._definedResources[ this._currentResource ].response[ dataKey ], data ); 

		return this;
	}

	/**
    * Set all the required parameters of a resource
    * @params Set the parameters of a resource
    * 
    * @return RelaxDSL
    */
	function setParams( required array params ){
		verifyResourcePivot();
		// verify parameters exist, else init it
		this._definedResources[ this._currentResource ].parameters = arguments.params;
		
		return this;	    
	}
    
    /**
    * Set all the required placeholders of a resource
    * @placeholders Set the placeholders of a resource
    * 
    * @return RelaxDSL
    */
	function setPlaceHolders( required array placeholders ){
		verifyResourcePivot();
		// verify parameters exist, else init it
		this._definedResources[ this._currentResource ].placeholders = arguments.placeholders;
		
		return this;	    
	}

	/**
    * Set all the required headers of a resource
    * @headers Set the headers of a resource
    * 
    * @return RelaxDSL
    */
	function setHeaders( required array headers ){
		verifyResourcePivot();
		// verify parameters exist, else init it
		this._definedResources[ this._currentResource ].headers = arguments.headers;
		
		return this;	    
	}
    
    /**
    * Append Data elements
    * @args The incoming data arguments
    * @dataKey The key to append it to
    * 
    * @return RelaxDSL
    */
	function appendData( required struct args, required string dataKey ){
		var data	= {};
		
		verifyResourcePivot();
		
		for( var key in args ){
			if( structKeyExists( args, key ) ){
				data[ key ] = args[ key ];
			}
		}
		
		// verify parameters exist, else init it
		if( NOT structKeyExists( this._definedResources[ this._currentResource ], dataKey) ){
			this._definedResources[ this._currentResource ][ dataKey ] = [];
		}
		
		// append data
		arrayAppend( this._definedResources[ this._currentResource ][ dataKey ], data ); 

		return this;	    
	}
    
   	/**
    * Verify if the resource pivot exists
    */
	function verifyResourcePivot(){
    	// verify pivot
		if( NOT len(this._currentResource) ){
			throw( message="You cannot call this method unless you concatenate it with a 'resource()' call first.", type="RelaxDSL.InvalidContext" );
		} else if ( NOT structKeyExists( this._definedResources, this._currentResource) ){
			throw( message="The current resource: '#this._currentResource#' is not defined in the resources.",
				   detail="Defined resources are: #structKeyList( this._definedResources )#",
				   type="RelaxDSL.InvalidContext" );
		} 
	}
   
}