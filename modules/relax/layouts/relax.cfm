<cfparam name="args.sidebar"    default="true">
<cfparam name="args.header"     default="true">
<cfparam name="args.print"      default="false">
<cfoutput>
<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js">
<!--<![endif]-->

<head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>ColdBox Relax - RESTful Tools For Lazy Experts</title>
    <!--- favicon --->
    <link href="#prc.root#/includes/images/favicon.ico" rel="shortcut icon" type="image/x-icon" />
	<!--- View Port --->
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" href="#prc.root#/includes/plugins/bootstrap/css/bootstrap.min.css">
    <!-- Fonts from Font Awsome -->
    <link rel="stylesheet" href="#prc.root#/includes/css/font-awesome.min.css">
    <!-- CSS Animate -->
    <link rel="stylesheet" href="#prc.root#/includes/css/animate.css">
    <!-- Switchery -->
    <link rel="stylesheet" href="#prc.root#/includes/plugins/switchery/switchery.min.css">
    <!-- Theme Styles -->
    <link rel="stylesheet" href="#prc.root#/includes/css/main.css">
    <!-- iCheck-->
    <link rel="stylesheet" href="#prc.root#/includes/plugins/icheck/css/_all.css">
    <!-- Custom Styles -->
    <link rel="stylesheet" href="#prc.root#/includes/css/relax.css">
    <!--- CUSTOM CSS --->
	<cfloop list="#event.getPrivateValue("cssAppendList","")#" index="css">
		<cfset addAsset("#prc.root#/includes/css/#css#.css")>
	</cfloop>
	<cfloop list="#event.getPrivateValue("cssFullAppendList","")#" index="css">
		<cfset addAsset("#css#.css")>
	</cfloop>

    <!-- Fonts -->
    <link href='//fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,900,300italic,400italic,600italic,700italic,900italic' rel='stylesheet' type='text/css'>
    <link href='//fonts.googleapis.com/css?family=Open+Sans:400,700' rel='stylesheet' type='text/css'>
    <!-- Feature detection -->
    <script src="#prc.root#/includes/js/modernizr-2.6.2.min.js"></script>
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="#prc.root#/includes/js/html5shiv.js"></script>
    <script src="#prc.root#/includes/js/respond.min.js"></script>
    <![endif]-->

    <!--========= JAVASCRIPT -->
	<script src="#prc.root#/includes/js/jquery.min.js"></script> <!--Import jquery tools-->
    <script src="#prc.root#/includes/plugins/bootstrap/js/bootstrap.min.js"></script>
    <script src="#prc.root#/includes/plugins/navgoco/jquery.navgoco.min.js"></script>
    <script src="#prc.root#/includes/plugins/switchery/switchery.min.js"></script>
	<script src="#prc.root#/includes/js/jsonlint.js"></script>
	<script src="#prc.root#/includes/js/relax.js"></script>

	<!--- loop around the jsAppendList, to add page specific js --->
	<cfloop list="#event.getPrivateValue("jsAppendList", "")#" index="js">
		<cfset addAsset("#prc.root#/includes/js/#js#.js")>
	</cfloop>
	<cfloop list="#event.getPrivateValue("jsFullAppendList", "")#" index="js">
		<cfset addAsset("#js#.js")>
	</cfloop>

	<!-- syntax highlighter -->
	<link type="text/css" rel="stylesheet" href="#prc.root#/includes/highlighter/styles/shCoreMidnight.css">
	<script src="#prc.root#/includes/highlighter/scripts/shCore.js"></script>
	<script src="#prc.root#/includes/highlighter/scripts/shBrushColdFusion.js"></script>
	<script src="#prc.root#/includes/highlighter/scripts/shBrushXml.js"></script>
	<script src="#prc.root#/includes/highlighter/scripts/shBrushSql.js"></script>
	<script src="#prc.root#/includes/highlighter/scripts/shBrushJScript.js"></script>
	<script src="#prc.root#/includes/highlighter/scripts/shBrushJava.js"></script>
	<script src="#prc.root#/includes/highlighter/scripts/shBrushCss.js"></script>
	<script>
	$(document).ready(function() {
		// syntax highlight
		SyntaxHighlighter.all();
	});
	</script>

</head>

<body class="off-canvas <cfif !args.print>animated fadeIn</cfif>" <cfif args.print>style="background-color: white"</cfif>>    
   
    <div id="container">
		<cfif args.header>
        <header id="header">
            <!--logo start-->
            <div class="brand">
                <a href="#event.buildLink( prc.xehHome )#" class="logo">
                    <img src="#prc.root#/includes/images/ColdBoxLogo2015-Solo_50.png" title="ColdBox"/>
                    <span>Relax</span>
                </a>
            </div>
            <!--Toggle-->
            <div class="toggle-navigation toggle-left">
                <button type="button" class="btn btn-default" id="toggle-left" data-toggle="tooltip" data-placement="right" title="Toggle Navigation">
                    <i class="fa fa-bars"></i>
                </button>
            </div>
            <!-- NavBar -->
            <div class="user-nav">
                <ul>
                	<li>
                  		<a  href="#event.buildLink( prc.xehRelax )#"
                            data-toggle="modal" 
                            data-target="##modal" 
                            class="btn btn-default dropdown-toggle options" 
                            title="Time to relax?">
                        	<i class="fa fa-gamepad"></i>
                    	</a>
                    </li>
                    <li class="dropdown settings">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="##">
                      		RESTFul Tools For Lazy Experts<i class="fa fa-angle-down"></i>
                    	</a>
                        <ul class="dropdown-menu animated fadeInDown">
                            
                        	<li>
                        		<a href="http://www.ortussolutions.com" title="The experts behind ColdBox"><i class="fa fa-bolt"></i> By Ortus Solutions</a>
                        	</li>
							<li>
								<a href="http://www.coldbox.org" title="The premier ColdFusion development platform"><i class="fa fa-link"></i> Powered By ColdBox</a>
							</li>
							<li>
								<a href="http://www.github.com/coldbox/coldbox-relax" title="The Relax Source Code"><i class="fa fa-github"></i> Github Repo</a>
							</li>
							<li>
								<a href="http://www.twitter.com/coldbox" title="Follow me!"><i class="fa fa-twitter"></i> Tweet</a>
							</li>
                        </ul>
                    </li>
                </ul>
            </div>
        </header>
   		</cfif>

		<!--sidebar start-->
	    <cfif args.sidebar>
	    <nav class="sidebar sidebar-left">
	        <h5 class="sidebar-header">Navigation</h5>
	            <ul class="nav nav-pills nav-stacked">
	                <li <cfif event.getCurrentEvent() eq "relax:home.index">class="active"</cfif>>
	                    <a href="#event.buildLink( prc.xehHome )#"><i class="fa fa-dashboard"></i><span>API Manager</span></a>
	                </li>
	                <li <cfif event.getCurrentHandler() eq "relax:relaxer">class="active"</cfif>>
	                    <a href="#event.buildLink( prc.xehRelaxer )#" title="Pronounced 'Relax-ER'"><i class="fa fa-flask"></i><span>RelaxURL</span></a>
	                </li>
	                <li <cfif event.getCurrentAction() eq "DSLDocs">class="active"</cfif>>
	                    <a href="#event.buildLink( prc.xehDSLDocs )#" ><i class="fa fa-code"></i><span>RelaxDSL Docs</span></a>
	                </li>
	                <li>
	                    <a href="##" title="Version Information"><i class="fa fa-info"></i>Relax v#getModuleConfig( 'relax' ).version#</a>
	                </li>
	            </ul>
	    </nav>
	    <!--sidebar end-->
	    </cfif>
	
		<!--main content start-->
	    <section class="main-content-wrapper" <cfif args.print>style="margin-left:0px"</cfif>>
	        <section id="main-content">
	           #renderView()#
	        </section>
	    </section>
	    <!--main content end-->

    </div>

    <!--- ============================ Remote Modal Window ============================ --->
    <div id="modal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog" id="modal-dialog">
            <div class="modal-content" id="remoteModelContent">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h3>Loading...</h3>
                </div>
                <div class="modal-body">
                    <i class="fa fa-spinner fa-spin fa-lg fa-4x"></i>
                </div>
            </div>
        </div>
    </div>
    <!--- Modal Template --->
    <script type="text/html" id="modal-template">
        <div class="modal-content" id="remoteModelContent">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h3>Loading...</h3>
            </div>
            <div class="modal-body">
                <i class="fa fa-spinner fa-spin fa-lg fa-4x"></i>
            </div>
        </div>
    </script>
    <!--- ============================ Remote Modal Window ============================ --->

</body>
<!--End Body-->
</html>
</cfoutput>
