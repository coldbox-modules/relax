<!-----------------------------------------------------------------------
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldbox.org | www.luismajano.com | www.ortussolutions.com
********************************************************************************

Author     :	Luis Majano
Description :
	The Relax DSL Service
----------------------------------------------------------------------->
<cfcomponent output="false" hint="The Relax DSL Service" singleton>

	<!--- More Dependencies --->
	<cfproperty name="fileUtils" 		inject="coldbox:plugin:FileUtils">
	<cfproperty name="userStorage" 		inject="coldbox:plugin:SessionStorage">
	
	<!--- Constructor --->
	<cffunction name="init" hint="Constructor" access="public" returntype="DSLService" output="false">
		<cfargument name="logBox" 		inject="logBox"/>
		<cfargument name="configBean" 	inject="coldbox:configBean">
		<cfscript>
			// Logger
			instance.log = arguments.logBox.getLogger(this);
			// Relax Settings
			instance.settings = arguments.configBean.getKey("modules").relax.settings;
			// The API definitions
			instance.APIDefinitions = {};
			
			return this;
		</cfscript>
	</cffunction>
	
	<!--- listAPIs --->
	<cffunction name="listAPIs" output="false" access="public" returntype="any" hint="Get a listing of all the APIs in the resources folder">    
    	
    	<cfset var results = "">
		
    	<cfdirectory action="list" directory="#instance.settings.apiLocationExpandedPath#" name="results" recurse="false" sort="asc" type="dir">
		
		<cfreturn results>    		    
    </cffunction>
    
    <!--- getAPI --->
	<cffunction name="getAPI" output="false" access="public" returntype="any" hint="Get an API definition">    
    	<cfargument name="name" type="string" required="true" hint="The name of the API to load"/>
    	
    	<cfreturn instance.APIDefinitions[ arguments.name ]>	    
    </cffunction>
    
    <!--- getLoadedAPI --->    
    <cffunction name="getLoadedAPI" output="false" access="public" returntype="any" hint="Get the loaded API representation">    
    	<cfscript>
			var apiName = getLoadedAPIName();
			// lazy load API if not in scope
			if( NOT structKeyExists(instance.APIDefinitions, apiName) ){ loadAPI(apiName); }
			// return it.
			return instance.APIDefinitions[ apiName ];   
    	</cfscript>    
    </cffunction>
   
    <!--- getLoadedAPIName --->    
    <cffunction name="getLoadedAPIName" output="false" access="public" returntype="any" hint="Get the loaded API name">    
    	<cfscript>
			return userStorage.getVar("relax-api","");
    	</cfscript>    
    </cffunction>
    
    <!--- isLoadedAPI --->    
    <cffunction name="isLoadedAPI" output="false" access="public" returntype="boolean" hint="Checks if an API is loaded or not, usually by checking the user's data">    
    	<cfscript>	 
			if( len( getLoadedAPIName() ) ){ return true; }
			return false;   
    	</cfscript>    
    </cffunction>
	
	<!--- loadAPI --->    
    <cffunction name="loadAPI" output="false" access="public" returntype="any" hint="Load an API into the service and get its representation">    
    	<cfargument name="name" type="string" required="true" hint="The name of the API to load"/>
    	<cfscript>
			var dataCFC = createObject("component",instance.settings.apiLocationPath & ".#arguments.name#.Relax");
			var x = 1;
			
			// cleanup relax data
			if( NOT structKeyExists(dataCFC.relax,"validExtensions") ){
				dataCFC.relax.validExtensions = "";
			}
			if( NOT structKeyExists(dataCFC.relax,"throwOnInvalidExtension") ){
				dataCFC.relax.throwOnInvalidExtension = false;
			}
			
			// cleanup global headers
			if( NOT structKeyExists(dataCFC,"globalHeaders") ){
				dataCFC.globalHeaders = [];
			}
			// cleanup global parameters
			if( NOT structKeyExists(dataCFC,"globalParameters") ){
				dataCFC.globalParameters = [];
			}
			// cleanup of resources
			if( NOT structKeyExists(dataCFC,"resources") ){
				dataCFC.resources = [];
			}
			// cleanup entry point
			if( isSimpleValue(dataCFC.relax.entryPoint) ){
				dataCFC.relax.entryPoint = { production = dataCFC.relax.entryPoint };
			}
			// Process resources
			for(x=1; x lte arrayLen(dataCFC.resources); x++){
				dataCFC.resources[x].resourceID = hash(dataCFC.resources[x].toString());
				if( NOT structKeyExists(dataCFC.resources[x],"headers") ){
					dataCFC.resources[x].headers = [];
				}
				if( NOT structKeyExists(dataCFC.resources[x],"placeholders") ){
					dataCFC.resources[x].placeholders = [];
				}
				if( NOT structKeyExists(dataCFC.resources[x],"parameters") ){
					dataCFC.resources[x].parameters = [];
				}
				if( NOT structKeyExists(dataCFC.resources[x],"methods") ){
					dataCFC.resources[x].methods = "GET";
				}
				if( NOT structKeyExists(dataCFC.resources[x],"description") ){
					dataCFC.resources[x].description = "";
				}
				if( NOT structKeyExists(dataCFC.resources[x],"handler") ){
					dataCFC.resources[x].handler = "";
				}
				if( NOT structKeyExists(dataCFC.resources[x],"action") ){
					dataCFC.resources[x].action = "";
				}
				if( NOT structKeyExists(dataCFC.resources[x],"response") ){
					dataCFC.resources[x].response = {};
				}
			}		
			// Store the definitions
			instance.APIDefinitions[ arguments.name ] = dataCFC;
			
			// Store user's selection
			userStorage.setVar( "relax-api", arguments.name );
			
			return dataCFC;	    
    	</cfscript>    
    </cffunction>
	
	<!--- import --->    
    <cffunction name="import" output="false" access="public" returntype="any" hint="Import a relax API">    
    	<cfargument name="name" type="string" required="true" hint="The name of the API to save as"/>
		<cfargument name="json" type="string" required="true" hint="The JSON representation of the API"/>
    	<cfscript>
			
			var targetDir = instance.settings.apiLocationExpandedPath & "/" & arguments.name;
			var targetAPI = targetDir & "/Relax.json";
			
			// create the directory enclosure
			fileUtils.directoryCreate(path=instance.settings.apiLocationExpandedPath & "/" & arguments.name);
			
			// create the relax.json file
			fileUtils.saveFile(FileToSave=targetAPI,fileContents=arguments.json);
			
			return this;
    	</cfscript>    
    </cffunction>
	

</cfcomponent>