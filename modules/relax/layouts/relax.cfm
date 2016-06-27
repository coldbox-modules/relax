<cfsilent>
<cfparam name="args.sidebar"    default="true">
<cfparam name="args.header"     default="true">
<cfparam name="args.print"      default="false">    
</cfsilent>
<!DOCTYPE html>
<cfoutput>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!-->
<html>
<!--<![endif]-->

<cfinclude template="inc/HTMLHead.cfm"/>

<body class="off-canvas <cfif !args.print>animated fadeIn><cfelse>print</cfif>" <cfif args.print>style="background-color: white"</cfif>>    
   <cfif args.print>
       <a href="javascript:void(0)" id="btnCopyGeneratedSource" class="btn btn-default pull-right" data-toggle="tooltip" data-placement="bottom" title="Copy generated source to clipboard"><i class="fa fa-clipboard"></i></a>
   </cfif>
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
                        		<a href="//www.ortussolutions.com" title="The experts behind ColdBox"><i class="fa fa-bolt"></i> By Ortus Solutions</a>
                        	</li>
							<li>
								<a href="//www.coldbox.org" title="The premier ColdFusion development platform"><i class="fa fa-link"></i> Powered By ColdBox</a>
							</li>
							<li>
								<a href="//www.github.com/coldbox/coldbox-relax" title="The Relax Source Code"><i class="fa fa-github"></i> Github Repo</a>
							</li>
							<li>
								<a href="//www.twitter.com/coldbox" title="Follow me!"><i class="fa fa-twitter"></i> Tweet</a>
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
	                    <a href="#event.buildLink( prc.xehRelaxer )#" title="Pronounced 'Relax-ER'"><i class="fa fa-flask"></i><span>API Test Tool</span></a>
	                </li>

                    <li <cfif event.getCurrentAction() eq "OpenAPIDocs">class="active"</cfif>>
                        <a href="#event.buildLink( prc.xehOpenAPIDocs )#" ><i class="fa fa-rocket"></i><span>OpenAPI Docs</span></a>
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

    <cfinclude template="inc/HTMLBodyEnd.cfm">

</body>
<!--End Body-->
</cfoutput>
</html>
