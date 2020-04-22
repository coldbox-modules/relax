<cfscript>

	public string function relaxElixirPath(
        required string fileName,
        boolean useModuleRoot = true,
        boolean fileIsHref = false
    )
    output="false"
    hint="finds the versioned path for an asset"
    {
        var includesLocation    = "includes";
        // call this through the application scope in case we are outside of a handler
        var event = application.cbController.getRequestService().getContext();
        var mapping             = ( useModuleRoot && len( event.getCurrentModule() ) ) ?
                                        event.getModuleRoot() :
                                        application.cbController.getSetting( "appMapping" );
        var filePath            = expandPath( "#mapping#/#includesLocation#/rev-manifest.json" );

        if( fileIsHref ){
        	var href = "/" & arguments.fileName;
        } else {
        	var href = "/#includesLocation#/#arguments.fileName#";
            //remove preceeding slash to find the key
        }

		var key = right( href, len( href )-1 );

        if ( ! fileExists( filePath ) ) {
            return href;
        }


        try{
            var templateCache = getCache( "template" );
            var fileContents = templateCache.getOrSet(
                "relaxElixirManifest",
                function(){
                    return fileRead( filePath );
                }
            );
        } catch( any e ){
            var fileContents = fileRead( filePath );
        }
        if ( ! isJSON( fileContents ) ) {
            return href;
        }

        var json = deserializeJSON( fileContents );

        if ( ! structKeyExists( json, key ) ) {
            return fileIsHref ? href : mapping & href;
        }

        return fileIsHref ? "#json[ key ]#" : "#mapping##json[ key ]#";

	}

</cfscript>