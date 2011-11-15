<cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!--============================Head============================-->
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="robots" content="noindex,nofollow" />	
	<!--- SES --->
	<base href="#getSetting('htmlBaseURL')#" />
	<!--=========Title=========-->
    <title>ColdBox Relax - RESTful Tools For Lazy Experts</title> 
	<link href="#rc.root#/includes/images/favicon.ico" rel="shortcut icon" type="image/x-icon" />
	<!--=========Stylesheets=========-->
	<link href="#rc.root#/includes/css/style.css"	 	rel="stylesheet" type="text/css"/>
	<link href="#rc.root#/includes/css/teal.css" 		rel="stylesheet" type="text/css"/>
	<link href="#rc.root#/includes/css/invalid.css" 	rel="stylesheet" type="text/css"/>
    <link href="#rc.root#/includes/css/sort.css"	 	rel="stylesheet" type="text/css"/>
	<!--- loop around the cssAppendList, to add page specific css --->
	<cfloop list="#event.getValue("cssAppendList","")#" index="css">
		<cfset addAsset("#rc.root#/includes/css/#css#.css")>
	</cfloop>
	<cfloop list="#event.getValue("cssFullAppendList","")#" index="css">
		<cfset addAsset("#css#.css")>
	</cfloop>
	        
	<!--========= JAVASCRIPT -->
	<script type="text/javascript" src="#rc.root#/includes/javascript/jquery-1.4.4.min.js"></script> <!--Import jquery tools-->
	<script type="text/javascript" src="#rc.root#/includes/javascript/jquery.tools.min.js"></script> <!--Import jquery tools-->
	<script type="text/javascript" src="#rc.root#/includes/javascript/jquery.uitablefilter.js"></script>
	<script type="text/javascript" src="#rc.root#/includes/javascript/metadata.pack.js"></script>
	<script type="text/javascript" src="#rc.root#/includes/javascript/tablesorter.min.js"></script>
	<script type="text/javascript" src="#rc.root#/includes/javascript/relax.js"></script>
	<script type="text/javascript" src="#rc.root#/includes/javascript/jsonlint.js"></script>
	<!--- loop around the jsAppendList, to add page specific js --->
	<cfloop list="#event.getValue("jsAppendList", "")#" index="js">
		<cfset addAsset("#rc.root#/includes/javascript/#js#.js")>
	</cfloop>
	<cfloop list="#event.getValue("jsFullAppendList", "")#" index="js">
		<cfset addAsset("#js#.js")>
	</cfloop>

</head>
<!--End Head-->
<!--============================Body============================-->
<body>

<!--==================== Header =======================-->
<div id="header_bg">

	<!--============Header Wrapper============-->
	<div class="wrapper">
       
		<!--=======Top Header area======-->
		<div id="header_top">
			<span class="fr">
		  		<a href="http://www.ortussolutions.com" title="The experts behind ColdBox">www.ortussolutions.com</a>
				<a href="http://www.coldbox.org" title="The premier ColdFusion development platform">www.coldbox.org</a>
				<a href="http://www.github.com/coldbox/coldbox-relax" title="The Relax Source Code">Github Repo</a>
				<a href="http://www.twitter.com/coldbox" title="Follow me!">Tweet</a>
			</span>
		  RESTful Tools For Lazy Experts
		</div>
		<!--End Header top Area=-->
    
		<!--=========Header Area including search field and logo=========-->
		<div id="logo">
			<a title="Wanna Relax? Click Me!" href="javascript:openRemoteModal('#event.buildLink(rc.xehRelax)#')"><img src="#rc.root#/includes/images/Coldbox-Relax_125.png" height="120" border="0" alt="logo" /></a>
		</div>
		
		<div id="header_main" class="clearfix">
           	<a href="#event.buildLink(rc.xehHome)#"><h1>Relax <span>v.#getModuleSettings('relax').version#</span></h1></a>
		</div>
		<!--End Search field and logo Header Area-->
      
		<!--=========Main Navigation=========-->
		<ul id="main_nav">
			<!--- Main Nav --->
			<li> 
				<a href="##" title="Relax Dashboard" <cfif event.getCurrentHandler() eq "relax:home"> class="current"</cfif>>Dashboard</a>
				<ul>
					<li><a href="#event.buildLink(rc.xehHome)#"  <cfif event.getCurrentAction() eq "index"> class="current"</cfif>>Home</a></li>
					<li><a title="Pronounced 'Relax-ER'" href="#event.buildLink(rc.xehRelaxer)#"  <cfif event.getCurrentAction() eq "relaxer"> class="current"</cfif>>RelaxURL</a></li>
					<li><a href="javascript:openRemoteModal('#event.buildLink(rc.xehRelaxUpdates)#')" title="Check For Relax Updates">Check For Updates</a></li>
					<li><a href="#event.buildLink(rc.xehDSLDocs)#"  <cfif event.getCurrentAction() eq "DSLDocs"> class="current"</cfif>>RelaxDSL Docs</a></li>
				</ul>
			</li>
			<!--- LogBox Nav --->
			<li>
				<a href="##" title="LogBox Integration" <cfif event.getCurrentHandler() eq "relax:logs"> class="current"</cfif>>LogBox</a>
				<ul>
					<li>
						<a href="#event.buildLink(rc.xehLogViewer)#" <cfif event.getCurrentAction() eq "index"> class="current"</cfif>
						   title="The Most Relaxed Log Viewer On Earth!">RelaxLogs</a>
					</li>
					<li>
						<a href="#event.buildLink(rc.xehLogHelp)#" <cfif event.getCurrentAction() eq "help"> class="current"</cfif>
						   title="Get some setup help!">Help</a>
					</li>
				</ul>
			</li>
		</ul>
		<!--End Main Navigation-->
    
  	</div>
  <!--End Wrapper-->
</div>
<!--End Header-->

<!--============================ Template Content Background ============================-->
<div id="content_bg" class="clearfix">
	<!--============================ Main Content Area ============================-->
	<div class="content wrapper clearfix">
		#renderView()#		
	</div>
<!--End main content area-->
</div>

<!--End Template Content bacground-->
<!--============================Footer============================-->
<div id="footer">
	<div class="wrapper">
	Copyright (C) #dateformat(now(),"yyyy")# <a href="http://www.ortussolutions.com">Ortus Solutions, Corp</a>  . All Rights Reserved.<br/>
	<a href="http://www.ortussolutions.com">Need Professional ColdFusion/ColdBox Support, Architecture, Design, or Development?</a>
	</div>
</div>
<!--End Footer-->

<!--- ============================ confirm it modal dialog ============================ --->
<div id="confirmIt"> 
	<div> 
		<h2 id="confirmItTitle">Are you sure?</h2> 
		<p id="confirmItMessage">Are you sure you want to perform this action?</p> 
		<hr />
		<p class="textRight">
			<button class="close button" 	data-action="cancel"> Cancel </button>
			<button class="close buttonred" data-action="confirm"> Confirm </button>
		</p>
	</div> 
</div>
<!--- ============================ end Confirmit ============================ --->

<!--- ============================ Remote Modal Window ============================ --->
<div id="remoteModal">
	<div id="remoteModelContent">
		<img src="#rc.root#/includes/images/ajax-loader-blue.gif" alt="loader" />
	</div>
</div>
<!--- ============================ end Confirmit ============================ --->

</body>
<!--End Body-->
</html>
</cfoutput>