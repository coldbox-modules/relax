component output="false" hint="The file chooser handler"{
	
	// dependencies
	property name="sessionStorage" 	inject="coldbox:plugin:SessionStorage";
	property name="antiSamy"		inject="coldbox:plugin:AntiSamy";
	
	function preHandler(event,currentAction){
		var prc = event.getCollection(private=true);
		
		prc.modRoot	 = event.getModuleRoot();
		prc.settings = getModuleSettings("filebrowser").settings;
	}
	
	function index(event,rc,prc){
		// params
		event.paramValue("path","");
		event.paramValue("callback","");
		event.paramValue("cancelCallback","");
		
		// exit handlers
		prc.xehBrowser 		= "filebrowser/";
		prc.xehNewFolder 	= "filebrowser/createfolder";
		
		// Inflat flash params
		inflateFlashParams(event,rc,prc);
		
		// clean incoming path
		rc.path = URLDecode( trim( antiSamy.clean( rc.path ) ) );
		// Store directory root
		prc.dirRoot 	= prc.settings.directoryRoot;
		// Get the current Root
		if( !len(rc.path) ){
			prc.currentRoot = prc.settings.directoryRoot;
		}
		else{
			prc.currentRoot = rc.path;
		}
		prc.currentRoot = REReplace(prc.currentRoot,"(/|\\){1,}$","","all");
		prc.currentRoot = REReplace(prc.currentRoot,"\\","/","all");
		
		// Do a safe current root
		prc.safeCurrentRoot = URLEncodedFormat( prc.currentRoot );
		
		// traversal test
		if( prc.settings.traversalSecurity AND NOT findNoCase(prc.settings.directoryRoot, prc.currentRoot) ){
			getPlugin("MessageBox").warn("Traversal security exception");
			setNextEvent(prc.xehBrowser);
		}
		
		// get directory listing.
		prc.qListing = directoryList( prc.currentRoot, false, "query", prc.settings.extensionFilter, "asc");
		
		// view
		event.setView(view="home/index",noLayout=event.isAjax());
	}
	
	/**
	* Creates folders asynchrounsly return json information: 
	*/
	function createfolder(event,rc,prc){
		var data = {
			errors = false,
			messages = ""
		};
		// param value
		event.paramValue("path","");
		event.paramValue("dName","");
		
		// Verify credentials else return invalid
		if( !prc.settings.createFolders ){
			data.errors = true;
			data.messages = "CreateFolders permission is disabled.";
			event.renderData(data=data,type="json");
			return;
		}
		
		// clean incoming path and names
		rc.path = URLDecode( trim( antiSamy.clean( rc.path ) ) );
		rc.dName = URLDecode( trim( antiSamy.clean( rc.dName ) ) );
		if( !len(rc.path) OR !len(rc.dName) ){
			data.errors = true;
			data.messages = "The path and name sent are invalid!";
			event.renderData(data=data,type="json");
			return;
		}
		
		// creation
		try{
			directoryCreate( rc.path & "/" & rc.dName );
			data.errors = false;
			data.messages = "Folder '#rc.path#/#rc.dName#' created successfully!";
		}
		catch(Any e){
			data.errors = true;
			data.messages = "Error creating folder: #e.message# #e.detail#";
			log.error(data.messages, e);
		}
		// render stuff out
		event.renderData(data=data,type="jsont");
	}
	
	/**
	* Inflate flash params if they exist into the appropriate function variables.
	*/
	private function inflateFlashParams(event,rc,prc){
		// Check for incoming callback via flash, else default from incoming rc.
		if( structKeyExists( flash.get( "fileBrowser", {} ), "callback") ){
			rc.callback = flash.get("fileBrowser").callback;
		}
		// clean callback
		rc.callBack = antiSamy.clean( rc.callback );
		// cancel callback
		if( structKeyExists( flash.get( "fileBrowser", {} ), "cancelCallback") ){
			rc.cancelCallback = flash.get("fileBrowser").cancelCallback;
		}
		// clean callback
		rc.cancelCallback = antiSamy.clean( rc.cancelCallback );
		
		// keep flash backs
		flash.keep("filebrowser");
	}
	
}