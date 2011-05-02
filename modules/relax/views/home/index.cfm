<cfoutput>
<!--============================Sidebar============================-->
<div class="sidebar">
	<!--- Info Box --->
	<div class="small_box">
		<div class="header">
			<img src="#rc.root#/includes/images/iinfo_icon.png" alt="info" width="24" height="24" />RelaxURL
		</div>
		<div class="body">
			<strong>RelaxURL</strong>, pronounced "Relax-ER", is a utility to help you test against your Relaxed
			RESTful service definitions or any other RESTful web service.
		</div>
	</div>	
	
	<!--- Export Box --->
	<div class="small_box">
		<div class="header">
			<img src="#rc.root#/includes/images/export.png" alt="info" width="24" height="24" />Export Lounge
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
			<p>Welcome to your Relax Console.  We have succesfully read the <em>Relax DSL CFC</em>
				you configured at <strong>#rc.settings.configCFC#.cfc</strong>.  Below is the RESTful 
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