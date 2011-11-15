<!-----------------------------------------------------------------------
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldbox.org | www.luismajano.com | www.ortussolutions.com
********************************************************************************

Author     :	Luis Majano
Description :
	The Relax DSL configuration object which is mixed into a simple Relax CFC Definition Object
----------------------------------------------------------------------->
<cfcomponent output="false" hint="The Relax DSL configuration object which is mixed into a simple Relax CFC Definition Object so you can use all the methods in this CFC to define RESTful web services.  All functions can be concatenated to create a nice programmatic DSL.">

	<cfscript>
		// setup defaults
		this.relax 				= {};
		this.globalHeaders 		= [];
		this.globalParameters	= [];
		this.resources			= [];	
		// Internal pivots
		this._currentResource	= "";	
		this._definedResources	= {};
	</cfscript>
	
	<!--- service --->    
    <cffunction name="service" output="false" access="public" returntype="any" hint="The relaxed service information. From here you will define the RESTful service endpoints, extension detection, valid formats, and more.">
		<cfargument name="title" 					required="true" hint="The title of the RESTful service"/>
		<cfargument name="description" 				required="true" hint="The description of the RESTful service"/>
		<cfargument name="entryPoint" 				required="true" hint="A simple URL or a structure of entry points"/>
		<cfargument name="extensionDetection" 		required="false" default="true" hint="Will this API do extension detection"/>
		<cfargument name="validExtensions" 			required="false" default="json,jsont,xml,html,htm,rss" hint="The valid extensions to detect"/>    
    	<cfargument name="throwOnInvalidExtensions" required="false" default="false" hint="Throw on invalid extensions or not"/>    
    	<cfscript>
			var key = "";
				    
			for(key in arguments){
				if( structKeyExists(arguments,key) ){
					this.relax[ key ] = arguments[key];
				}
			}
			
			return this;
    	</cfscript>    
    </cffunction>
    
    <!--- globalHeader --->    
    <cffunction name="globalHeader" output="false" access="public" returntype="any" hint="Add a global header to the relax definition">
		<cfargument name="name" 		required="true" hint="The name of the header"/>
		<cfargument name="description" 	required="false" default="" hint="The description of the header"/>
		<cfargument name="required" 	required="false" default="false" hint="Is the header required or not"/>
		<cfargument name="default" 		required="false" default="" hint="The default value of this header"/>
		<cfargument name="type" 		required="false" default="string" hint="The type of the incoming header"/>   
    	<cfscript>
			var key 		= "";
			var thisHeader 	= {};
			
			for(key in arguments){
				if( structKeyExists(arguments,key) ){
					thisHeader[key] = arguments[key];
				}
			}
			
			arrayAppend( this.globalHeaders, thisHeader);
			
			return this;
    	</cfscript>    
    </cffunction>
    
    <!--- globalParam --->    
    <cffunction name="globalParam" output="false" access="public" returntype="any" hint="Add a global parameter to the relax definition">
		<cfargument name="name" 		required="true" hint="The name of the parameter"/>
		<cfargument name="description" 	required="false" default="" hint="The description of the parameter"/>
		<cfargument name="required" 	required="false" default="false" hint="Is the parameter required or not"/>
		<cfargument name="default" 		required="false" default="" hint="The default value of this parameter"/>
		<cfargument name="type" 		required="false" default="string" hint="The type of the incoming parameter"/>   
    	<cfscript>
			var key 		= "";
			var thisParam 	= {};
			
			for(key in arguments){
				if( structKeyExists(arguments,key) ){
					thisParam[key] = arguments[key];
				}
			}
			
			arrayAppend( this.globalParameters, thisParam);
			
			return this;
    	</cfscript>    
    </cffunction>
    
    <!--- resource --->    
    <cffunction name="resource" output="false" access="public" returntype="any" hint="Add a new resource to the API definition, you can then concatenate more methods to the same resource: methods(),description(),header(),parameter(),placeholder(),schema(),sample()">
		<cfargument name="pattern" 	required="true" 	hint="The SES pattern to register for the resource"/>
		<cfargument name="handler" 	required="false" 	hint="The description of the parameter"/>
		<cfargument name="action" 	required="false" 	hint="Is the parameter required or not"/>
		<cfscript>
			var key 	= "";
			var data	= {};
			
			for(key in arguments){
				if( structKeyExists(arguments,key) ){
					data[key] = arguments[key];
				}
			}
			
			// store resource definition and current pivot point
			this._definedResources[arguments.pattern] = data;
			this._currentResource = arguments.pattern;
			
			// add reference to resources
			arrayAppend(this.resources, this._definedResources[arguments.pattern]);
			
			defaultMethod("GET");
			
			return this;
    	</cfscript>    
    </cffunction>
    
    <!--- methods --->    
    <cffunction name="methods" output="false" access="public" returntype="any" hint="Add methods to a resource">    
    	<cfargument name="methods" required="true" hint="The methods list to allow"/>
    	<cfscript>	    
			verifyResourcePivot();
			
			this._definedResources[ this._currentResource ].methods = arguments.methods;
			
			return this;
    	</cfscript>    
    </cffunction>
    
    <!--- defaultMethod --->    
    <cffunction name="defaultMethod" output="false" access="public" returntype="any" hint="Define a default HTTP method for a resource">    
    	<cfargument name="method" required="true" hint="The HTTP method that will be the default"/>
    	<cfscript>	    
			verifyResourcePivot();
			
			this._definedResources[ this._currentResource ].defaultMethod = arguments.method;
			
			return this;
    	</cfscript>    
    </cffunction>
    
    <!--- defaultFormat --->    
    <cffunction name="defaultFormat" output="false" access="public" returntype="any" hint="Define a default return format for a resource">    
    	<cfargument name="format" required="true" hint="The format that will be the default"/>
    	<cfscript>	    
			verifyResourcePivot();
			
			this._definedResources[ this._currentResource ].defaultFormat = arguments.format;
			
			return this;
    	</cfscript>    
    </cffunction>
    
    <!--- description --->    
    <cffunction name="description" output="false" access="public" returntype="any" hint="Add a description to a resource">    
    	<cfargument name="description" required="true" hint="The description"/>
    	<cfscript>	    
			verifyResourcePivot();
			
			this._definedResources[ this._currentResource ].description = arguments.description;
			
			return this;
    	</cfscript>    
    </cffunction>
    
    <!--- header --->    
    <cffunction name="header" output="false" access="public" returntype="any" hint="Add a header to a resource">    
    	<cfargument name="name" 		required="true" hint="The name of the header"/>
		<cfargument name="description" 	required="false" default="" hint="The description of the header"/>
		<cfargument name="required" 	required="false" default="false" hint="Is the header required"/>
		<cfargument name="default" 		required="false" default="" hint="The default value of the header"/>
		<cfargument name="type" 		required="false" default="string" hint="The type of the header"/>
		<cfscript>	    
			appendData(arguments,"headers");
			return this;
    	</cfscript>    
    </cffunction>
    
    <!--- param --->    
    <cffunction name="param" output="false" access="public" returntype="any" hint="Add a param to a resource">    
    	<cfargument name="name" 		required="true" hint="The name of the param"/>
		<cfargument name="description" 	required="false" default="" hint="The description of the param"/>
		<cfargument name="required" 	required="false" default="false" hint="Is the param required"/>
		<cfargument name="default" 		required="false" default="" hint="The default value of the param"/>
		<cfargument name="type" 		required="false" default="string" hint="The type of the param"/>
		<cfscript>	    
			appendData(arguments,"parameters");
			return this;
    	</cfscript>    
    </cffunction>
    
    <!--- placeholder --->    
    <cffunction name="placeholder" output="false" access="public" returntype="any" hint="Add a placeholder to a resource">    
    	<cfargument name="name" 		required="true" hint="The name of the placeholder"/>
		<cfargument name="description" 	required="false" default="" hint="The description of the placeholder"/>
		<cfargument name="required" 	required="false" default="false" hint="Is the placeholder required"/>
		<cfargument name="default" 		required="false" default="" hint="The default value of the placeholder"/>
		<cfargument name="type" 		required="false" default="string" hint="The type of the placeholder"/>
		<cfscript>	    
			appendData(arguments,"placeholders");
			return this;
    	</cfscript>    
    </cffunction>
    
    <!--- schema --->    
    <cffunction name="schema" output="false" access="public" returntype="any" hint="Append a schema to a resource">    
		<cfargument name="format" 		required="true" hint="The format of the schema"/>
		<cfargument name="description" 	required="false" default="" hint="The description of the schema"/>
		<cfargument name="body" 		required="false" default="" hint="The body contents of the schema"/>
		<cfscript>	  
			appendResponse(arguments,"schemas");
			return this;
    	</cfscript>    
    </cffunction>
    
    <!--- sample --->    
    <cffunction name="sample" output="false" access="public" returntype="any" hint="Append a sample to a resource">    
		<cfargument name="format" 		required="true" hint="The format of the sample"/>
		<cfargument name="description" 	required="false" default="" hint="The description of the sample"/>
		<cfargument name="body" 		required="false" default="" hint="The body contents of the sample"/>
		<cfscript>	  
			appendResponse(arguments,"samples");
			return this;
    	</cfscript>    
    </cffunction>
    
    <!--- appendResponse --->    
    <cffunction name="appendResponse" output="false" access="public" returntype="any" hint="Append a response to a resource">    
		<cfargument name="args" 	type="struct" required="true" hint="The data arguments"/>
		<cfargument name="dataKey"	type="string" required="true" hint="The key to add it to"/>
    	<cfscript>	  
			var key 	= "";
			var data	= {};
			
			verifyResourcePivot();
			
			for(key in args){
				if( structKeyExists(args,key) ){
					data[key] = args[key];
				}
			}
			
			// verify response exist, else init it
			if( NOT structKeyExists(this._definedResources[ this._currentResource ],"response") ){
				this._definedResources[ this._currentResource ].response = {};
			}
			// verify datakey exist, else init it
			if( NOT structKeyExists(this._definedResources[ this._currentResource ].response, dataKey) ){
				this._definedResources[ this._currentResource ].response[dataKey] = [];
			}
			
			// append schema
			arrayAppend( this._definedResources[ this._currentResource ].response[dataKey], data ); 
    	</cfscript>    
    </cffunction>
    
    <!--- setParams --->    
    <cffunction name="setParams" output="false" access="public" returntype="any" hint="Set all the required parameters of a resource">    
    	<cfargument name="params" type="array" required="true" hint="Set the parameters of a resource"/>
    	<cfscript>
			verifyResourcePivot();
			
			// verify parameters exist, else init it
			this._definedResources[ this._currentResource ].parameters = arguments.params;
			
			return this;	    
    	</cfscript>    
    </cffunction>
    
    <!--- setPlaceHolders --->    
    <cffunction name="setPlaceHolders" output="false" access="public" returntype="any" hint="Set all the required placeholders of a resource">    
    	<cfargument name="placeholders" type="array" required="true" hint="Set the placeholders of a resource"/>
    	<cfscript>
			verifyResourcePivot();
			
			// verify parameters exist, else init it
			this._definedResources[ this._currentResource ].placeholders = arguments.params;
			
			return this;	    
    	</cfscript>    
    </cffunction>
    
    <!--- setHeaders --->    
    <cffunction name="setHeaders" output="false" access="public" returntype="any" hint="Set all the required headers of a resource">    
    	<cfargument name="headers" type="array" required="true" hint="Set the headers of a resource"/>
    	<cfscript>
			verifyResourcePivot();
			
			// verify parameters exist, else init it
			this._definedResources[ this._currentResource ].headers = arguments.params;
			
			return this;	    
    	</cfscript>    
    </cffunction>
    
    <!--- appendData --->    
    <cffunction name="appendData" output="false" access="public" returntype="any" hint="Append Data elements">    
		<cfargument name="args" 	type="struct" required="true" hint="The data arguments"/>
		<cfargument name="dataKey"	type="string" required="true" hint="The key to add it to"/>
    	<cfscript>	  
			var key 	= "";
			var data	= {};
			
			verifyResourcePivot();
			
			for(key in args){
				if( structKeyExists(args,key) ){
					data[key] = args[key];
				}
			}
			
			// verify parameters exist, else init it
			if( NOT structKeyExists(this._definedResources[ this._currentResource ], dataKey) ){
				this._definedResources[ this._currentResource ][ dataKey ] = [];
			}
			
			// append data
			arrayAppend( this._definedResources[ this._currentResource ][ dataKey ], data ); 
    	</cfscript>    
    </cffunction>
    
    <!--- verifyResourcePivot --->    
    <cffunction name="verifyResourcePivot" output="false" access="public" returntype="void" hint="Verify if the resource pivot exists">    
    	<cfscript>	 
			// verify pivot
			if( NOT len(this._currentResource) ){
				$throw(message="You cannot call this method unless you concatenate it with a 'resource()' call first.",type="RelaxDSL.InvalidContext");
			}
			else if( NOT structKeyExists(this._definedResources, this._currentResource) ){
				$throw(message="The current resource: '#this._currentResource#' is not defined in the resources.",
					   detail="Defined resources are: #structKeyList( this._definedResources )#",
					   type="RelaxDSL.InvalidContext");
			}   
    	</cfscript>    
    </cffunction>    
    
    <!--- Throw Facade --->
	<cffunction name="$throw" access="public" hint="Facade for cfthrow" output="false">
		<cfargument name="message" 	type="string" 	required="yes">
		<cfargument name="detail" 	type="string" 	required="no" default="">
		<cfargument name="type"  	type="string" 	required="no" default="Framework">
		<cfthrow type="#arguments.type#" message="#arguments.message#"  detail="#arguments.detail#">
	</cffunction>
	
</cfcomponent>