<cfoutput>
<div id="FileBrowser">
	#html.startForm(name="filebrowser")#
	<div id="container">
		
		<!--- Roots 
		<div style="float:right;margin-right:3px">
			<strong>Volumes:</strong>
			<select name="roots" id="roots" onChange="javascript:doEventNOUI('#rc.xehBrowser#','FileBrowser',{computerRoot:this.value})" style="width:50px">
				<cfloop from="1" to="#arrayLen(rc.roots)#" index="i">
				<option value="#urlEncodedFormat(rc.roots[i].getAbsolutePath())#" <cfif rc.roots[i].getAbsolutePath() eq rc.computerRoot>selected=selected</cfif>>#rc.roots[i].getAbsolutePath()#</option>
				</cfloop>
			</select>
		</div>
		--->
		
		<!--- Your Current Location --->
		<div id="titleBar">
			<div id="title">#prc.settings.title#</div>
			<a href="javascript:fbRefresh()" title="Refresh Listing"><img src="#prc.modRoot#/includes/images/arrow_refresh.png" align="absmiddle" border="0"></a>
			<a href="javascript:fbDrilldown()" title="Go Home"><img src="#prc.modRoot#/includes/images/home.png" align="absmiddle" border="0"></a>
		</div>
		
		
		<!--- Show the File Listing --->
		<div id="fileListing">
		    <!--- Messagebox --->
		    #getPlugin("MessageBox").renderit()#
		    
		    <!--- Display back links --->
			<cfif prc.currentRoot NEQ prc.dirRoot>
				<a href="javascript:fbDrilldown('#$getBackPath(prc.currentRoot)#')" title="Go Back"><img src="#prc.modRoot#/includes/images/folder.png" border="0" align="absmiddle" alt="Folder"></a>
				<a href="javascript:fbDrilldown('#$getBackPath(prc.currentRoot)#')" title="Go Back">..</a><br>
			</cfif>
			
			<!--- Display directories --->
			<cfif prc.qListing.recordcount>
			<cfloop query="prc.qListing">
				
				<!--- Check Name Filter --->
				<cfif NOT reFindNoCase(prc.settings.nameFilter, prc.qListing.name)> <cfcontinue> </cfif>
				
				<!--- ID Name of the div --->
				<cfset validIDName = $validIDName( prc.qListing.name ) >
				<!--- URL used for selection --->
				<cfset plainURL = prc.currentroot & "/" & prc.qListing.name>
					
				<!--- Directory or File --->
				<cfif prc.qListing.type eq "Dir">
					<!--- Folder --->
					<div id="#validIDName#" 
						 onClick="fbSelect('#validIDName#','#JSStringFormat(plainURL)#')" 
						 class="folders"
						 onDblclick="fbDrilldown('#JSStringFormat(plainURL)#')">
						<a href="javascript:fbDrilldown('#JSStringFormat(plainURL)#')"><img src="#prc.modRoot#/includes/images/folder.png" border="0" align="absmiddle" alt="Folder"></a>
						#prc.qListing.name#
					</div>
				<cfelseif prc.settings.showFiles>
					<!--- Display the DiV --->
					<div id="#validIDName#" 
						 class="files"
						 onClick="fbSelect('#validIDName#','#JSStringFormat(plainURL)#')">
						<img src="#prc.modRoot#/includes/images/file.png" border="0" align="absmiddle" alt="file">
						#prc.qListing.name#
					</div>
				</cfif>
			</cfloop>
			<cfelse>
			<em>Empty Directory.</em>
			</cfif>			
		</div> <!--- end fileListing --->
		
		<!--- Location Bar --->
		<div id="locationBar">
			#replace(prc.currentroot,"/",'<img class="divider" src="#prc.modRoot#/includes/images/bullet_go.png" alt="arrow" />&nbsp;',"all")#
		</div>
	
		<!--- The Bottom Bar --->
		<div class="bottomBar">
			<!--- Loader Bar --->
			<div id="loaderBar">
				<img src="#prc.modRoot#/includes/images/ajax-loader.gif" />
			</div>
			<!--- Selected Item --->
			<input type="hidden" name="selectedItem" id="selectedItem" value="">
			<!--- Cancel Button --->
			<cfif len(rc.cancelCallback)>
				<input type="button" id="bt_cancel" value="Cancel" onClick="#rc.cancelCallback#()"> &nbsp;
			</cfif>
			<!--- New Folder --->
			<cfif prc.settings.createFolders>
			<input type="button" id="bt_newfolder"  value="New Folder"  onClick="fbNewFolder()" title="Create New Folder"> &nbsp;
			</cfif>
			<!--- Select Item --->
			<cfif len(rc.callback)>
			<input type="button" id="bt_select"  value="Choose" onClick="fbChoose()" disabled="true" title="Choose selected file/directory">
			</cfif>
		</div>
		
	</div>
	#html.endForm()#
</div>
<script language="javascript">
$(document).ready(function() {
	$fileBrowser 		= $("##FileBrowser");
	$fileLoaderBar 		= $("##loaderBar");
	$selectedItem		= $("##selectedItem");
	$selectedItemSpan	= $("##selectedItemSpan");
	selectedHistory = "";
	$("##bt_select").attr("disabled",true);
});
function fbRefresh(){
	$fileLoaderBar.slideDown();
	$fileBrowser.parent().load( '#event.buildLink(prc.xehBrowser)#', {path:'#prc.safeCurrentRoot#'},function(){
		$fileLoaderBar.slideUp();
	});
}
function fbDrilldown(inPath){
	if( inPath == null ){ inPath = ""; }
	$fileLoaderBar.slideDown();
	$fileBrowser.parent().load( '#event.buildLink(prc.xehBrowser)#', {path:inPath},function(){
		$fileLoaderBar.slideUp();
	});
}
function fbSelect(sID,sURL){
	if (selectedHistory.length) {
		$("##" + selectedHistory).removeClass("selected");
	}
	$( "##"+sID ).addClass("selected");
	$selectedItemSpan.html( sURL );
	$selectedItem.val( sURL );
	selectedHistory = sID;
	$("##bt_select").attr("disabled",false);
}
<cfif prc.settings.createFolders>
function fbNewFolder(){
	var dName = prompt("Enter the new directory name?");
	if( dName != null){
		$fileLoaderBar.slideDown();
		$.post('#event.buildLink(prc.xehNewFolder)#',{dName:dName,path:'#prc.safeCurrentRoot#'},function(data){
			if( data.errors ){ alert(data.messages); }
			fbRefresh();
		},"json");
	}
}
<cfif len(rc.callback)>
function fbChoose(){
	#rc.callback#( $selectedItem.val() );
}
</cfif>
</cfif>
</script>
</cfoutput>