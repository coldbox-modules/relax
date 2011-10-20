<cfoutput>
<!--============================Sidebar============================-->
<div class="sidebar">
	<!--- Loaded API --->
	<div class="small_box">
		<div class="header">
			<img src="#rc.root#/includes/images/sofa.png" alt="info" width="24" height="24" />Loaded Relaxed APIs
		</div>
		<div class="body">
			From here you can switch to another Relaxed API in your <strong>resources</strong> folder:<br/>
			
			<p class="center">
				<!--- My Apis --->
				<select name="myAPI" id="myAPI" title="Your defined Relaxed APIs" onchange="window.location='#event.buildLink(rc.xehLoadAPI)#?apiName='+this.value">
					<cfloop query="rc.loadedAPIs">
						<option value="#rc.loadedAPis.name#" <cfif rc.loadedAPIs.name eq rc.loadedAPIName>selected="selected"</cfif>>#rc.loadedAPis.name#</option>
					</cfloop>
				</select>
			</p>
		</div>
	</div>	
	
	<!--- Import/Export Box --->
	<div class="small_box">
		<div class="header">
			<img src="#rc.root#/includes/images/export.png" alt="info" width="24" height="24" />API Export/Import
		</div>
		<div class="body">
			You can export your Relaxed Service API to JSON and also import one.<br/><br/>
			
			<p class="center">
				<!--- Export --->
				<a href="javascript:openRemoteModal('#event.buildLink(rc.xehExportAPI)#')" 
					class="button" 
				   	title="Export API">
					<span>
						<img src="#rc.root#/includes/images/export_16.png" alt="export"/> Export
					</span>
				</a>
				<!--- Import --->
				<a href="javascript:openRemoteModal('#event.buildLink(rc.xehImportAPI)#')" 
					class="button" 
				   	title="Import API">
					<span>
						<img src="#rc.root#/includes/images/import_16.png" alt="import"/> Import
					</span>
				</a>
			</p>
		</div>
	</div>	
	
	<!--- Export Box --->
	<div class="small_box">
		<div class="header">
			<img src="#rc.root#/includes/images/documents_icon.png" alt="info" width="24" height="24" />Docs Export Lounge
		</div>
		<div class="body">
			<p>You can export your Relaxed Service Documentation in several formats: <br/></p>
			
			<!--- Export COmmands --->
			<p class="center">
				<!--- html --->
				<a href="#event.buildLink(rc.xehExportHTML)#" 
					target="_blank"
					class="button" 
				   	title="Export as HTML">
					<span>
						<img src="#rc.root#/includes/images/html.png" border="0" align="absmiddle" alt="html" />
					</span>
				</a>
				<!--- pdf --->
				<a href="#event.buildLink(rc.xehExportPDF)#" class="button" 
				    target="_blank"
					title="Export as PDF">
					<span>
						<img src="#rc.root#/includes/images/pdf.png" border="0" align="absmiddle" alt="html" />
					</span>
				</a>
				<!--- mediawiki --->
				<a href="#event.buildLink(rc.xehExportwiki)#" class="button" 
				    target="_blank"
					title="Export as MediaWiki">
					<span>
						<img src="#rc.root#/includes/images/wikipedia.png" border="0" align="absmiddle" alt="html" />
					</span>
				</a>
				<!--- trac --->
				<a href="#event.buildLink(rc.xehExporttrac)#" class="button" 
				    target="_blank"
					title="Export as TracMarkup">
					<span>
						<img src="#rc.root#/includes/images/trac.png" border="0" align="absmiddle" alt="html" />
					</span>
				</a>
			</p>
		</div>
	</div>		
	
	<!--- Info Box --->
	<div class="small_box">
		<div class="header">
			<img src="#rc.root#/includes/images/info.png" alt="info" width="24" height="24" />Need Help?
		</div>
		<div class="body">
			<a href="http://www.ortussolutions.com" target="_blank" title="The Gurus behind ColdBox">
			<img src="#rc.root#/includes/images/ortus-top-logo.png" alt="Ortus Solutions" border="0" /></a><br/>
			
			<p><strong>Ortus Solutions</strong> is the company behind anything ColdBox. Need professional support, architecture analysis,
			code reviews, custom development or anything ColdFusion, ColdBox related? 
			<a href="mailto:help@ortussolutions.com">Contact us</a>, we are here
			to help!</p>
			
			<p class="center">
			<a href="javascript:openRemoteModal('#event.buildLink(rc.xehRelaxUpdates)#')" class="button" 
			   title="Check for Updates">
				<span>
					<img src="#rc.root#/includes/images/download.png" border="0" align="absmiddle" alt="updates" />
					Check For Updates
				</span>
			</a>
		</div>
	</div>	
	
</div>
<!--End sidebar-->

<!--============================Main Column============================-->
<div class="main_column">
	<div class="box">
		<div class="header" id="relaxerHeader">
			<img src="#rc.root#/includes/images/sofa.png" alt="Database" width="30" height="30" title="Go Relax!" />
			Welcome To Relax
		</div>
		<!--- Body --->
		<div class="body">
			<!--- MessageBox --->
			#getPlugin("MessageBox").renderit()#
			<!--- Body --->
			<p>Welcome to your Relax Console.  We have succesfully read the <em>Relax DSL</em>
				for your loaded API: <strong>#rc.loadedAPIName#</strong>.  Below is the RESTful 
				documentation.  From here you can also tap into our <strong>RelaxURL</strong> console to test the resources or any web 
				RESTful service or view our awesome <strong>RelaxLogs</strong> log viewer.
			</p>			
		</div>
		<div class="body_vertical_nav clearfix">
			<!--- Documentation Navigation Bar --->
			<ul class="vertical_nav">
				<li class="active"><a href="##overview">Service Overview</a></li>
				<li><a href="##resources">Defined Resources</a></li>
				<li><a href="##httpcodes">HTTP Codes</a></li>
				<li><a href="##routes">Generated Routes</a></li>
			</ul>		
			<!--- Documentation Panes --->	
			<div class="main_column">
				<!-- Content area that wil show the form and stuff -->
				<div class="panes_vertical">
					<!--- OverView Panel --->
					<div>
						#renderView(view="home/docs/serviceOverview",prePostExempt=true)#
					</div>
					<!--- Resources Panel --->
					<div>
						#renderView(view="home/docs/resourceDefinitions",prePostExempt=true)#						
					</div>
					<!--- HTTP Codes Panel --->
					<div>
						#renderView(view="home/docs/httpcodes",prePostExempt=true)#
					</div>
					<!--- Generated Routes --->
					<div>
						#renderView(view="home/docs/generatedRoutes",prePostExempt=true)#
					</div>
				</div>
			</div>
			
		</div>
	
	</div>

</div>
<script language="javascript">
$(document).ready(function() {
	// syntax highlight
	SyntaxHighlighter.all();
});
function toggleResource(id){
	var $div = $("##resource_"+id);
	$div.slideToggle();	
}
</script>
</cfoutput>