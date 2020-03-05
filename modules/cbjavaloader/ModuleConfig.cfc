/**
* Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
* www.ortussolutions.com
* ---
*/
component {

	// Module Properties
	this.title 				= "JavaLoader";
	this.author 			= "Ortus Solutions";
	this.webURL 			= "https://www.ortussolutions.com";
	this.description 		= "A JavaLoader Module for ColdBox";
	this.version			= "2.0.0+44";
	this.cfmapping			= "cbjavaloader";

	/**
	* Configure module
	*/	
	function configure(){
		
		settings = {
			// The array paths to load
			loadPaths = [],
			// Load ColdFusion classes with loader
			loadColdFusionClassPath = false,
			// Attach a custom class loader as a parent
			parentClassLoader = "",
			// Directories that contain Java source code that are to be dynamically compiled
			sourceDirectories = [],
			// the directory to build the .jar file for dynamic compilation in, defaults to ./tmp
			compileDirectory = variables.modulePath & "models/javaloader/tmp",
			// Whether or not the source is trusted, i.e. it is going to change? Defaults to false, so changes will be recompiled and loaded
			trustedSource = false
		};
		
		// Register Custom DSL, don't map it because it is too late, mapping DSLs are only good by the parent app
		wireBox
			.registerDSL( namespace="javaloader", path="#moduleMapping#.models.JavaLoaderDSL" );
	}

	/**
	* Fired when the module is registered and activated.
	*/
	function onLoad(){

		// Bind Core JavaLoader
		binder.map( "jl@cbjavaloader" )
			.to( "#moduleMapping#.models.javaloader.JavaLoader" );
	
		// Duplicating so our final change won't affect the main module settings
		var finalSettings = duplicate( settings );
		
		// Start with empty array
		finalSettings.loadPaths = [];

		// Grab module settings
		var moduleSettingsLoadPath = settings.loadPaths;

		// Force array
		if( isSimpleValue( moduleSettingsLoadPath ) ) {
			moduleSettingsLoadPath = moduleSettingsLoadPath.listToArray();
		}
		
		// Loop over settings, adding files and expanding directories
		for( var thisLocation in moduleSettingsLoadPath ){
			if( directoryExists( thisLocation ) ) {
				finalSettings.loadPaths.addAll( getJars( thisLocation ) );
			} else if ( fileExists( thisLocation ) ) {
				finalSettings.loadPaths.append( thisLocation );
			} else {
				throw( "Javalaoder cannot load #thisLocation# as it is not a valid path or file" );				
			}
		}

		// Dynamic Proxy
		arrayPrepend(
			finalSettings.loadPaths,
			variables.modulePath & "/models/javaloader/support/cfcdynamicproxy/lib/cfcdynamicproxy.jar"
		);
				
		// Load JavaLoader and class loading
		wirebox.getInstance( "loader@cbjavaloader" ).setup( finalSettings );
	}

	/**
	* Get an array of jar files
	*/
	private array function getJars( required string dirPath, string filter="*.jar" ){
		if( not directoryExists( arguments.dirPath ) ){
			throw( message="Invalid library path", detail="The path is #arguments.dirPath#", type="JavaLoader.DirectoryNotFoundException" );
		}

		return directoryList( 
			arguments.dirPath, 
			true, 
			"array", 
			arguments.filter, 
			"name desc" 
		);
	}

}
