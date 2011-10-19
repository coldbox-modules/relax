<!-----------------------------------------------------------------------
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldbox.org | www.luismajano.com | www.ortussolutions.com
********************************************************************************

Author     :	Luis Majano
Description :
	The Relax DSL Service
----------------------------------------------------------------------->
<cfcomponent output="false" hint="The Relax DSL Service">

	<!--- More Dependencies --->
	<cfproperty name="fileUtils" inject="coldbox:plugin:FileUtils">
	
	<!--- Constructor --->
	<cffunction name="init" hint="Constructor" access="public" returntype="DSLService" output="false">
		<cfargument name="logBox" 		inject="logBox"/>
		<cfargument name="configBean" 	inject="coldbox:configBean">
		<cfscript>
			// Logger
			instance.log = arguments.logBox.getLogger(this);
			// Relax Settings
			instance.settings = arguments.configBean.getKey("modules").relax.settings;
			
			return this;
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