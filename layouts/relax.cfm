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

<body class="hold-transition sidebar-mini control-sidebar-slide-open control-sidebar-push-slide layout-fixed layout-navbar-fixed <cfif !args.print>animated fadeIn<cfelse>print</cfif>" <cfif args.print>style="background-color: white"</cfif>>

   <cfif args.print>
       <a href="javascript:void(0)" id="btnCopyGeneratedSource" class="btn btn-default pull-right" data-toggle="tooltip" data-placement="bottom" title="Copy generated source to clipboard"><i class="fa fa-clipboard"></i></a>
   </cfif>
    <div class="wrapper" style="height: auto; min-height: 100%;">
		<cfif args.header>
        <nav class="main-header navbar navbar-expand navbar-white navbar-light">
			<!--Toggle-->
			<ul class="navbar-nav">
				<li class="nav-item">
					<a class="nav-link" data-widget="pushmenu" href="##" role="button"><i class="fa fa-bars"></i></a>
				</li>
			</ul>
			<!-- NavBar -->
			<ul class="navbar-nav ml-auto pull-right">
				<li class="nav-item d-none d-sm-inline-block">
					<a  href="#event.buildLink( prc.xehRelax )#"
						data-toggle="modal"
						data-target="##modal"
						class="nav-link"
						title="Time to relax?">
						<i class="fa fa-gamepad"></i>
					</a>
				</li>
				<li class="nav-item dropdown d-none d-sm-inline-block">
					<a class="nav-link" data-toggle="dropdown" href="##">
						RESTFul Tools For Lazy Experts<i class="fa fa-angle-down"></i>
					</a>
					<ul class="dropdown-menu dropdown-menu-lg dropdown-menu-right">

						<li>
							<a class="nav-link" href="//www.ortussolutions.com" title="The experts behind ColdBox"><i class="fa fa-bolt"></i> By Ortus Solutions</a>
						</li>
						<li>
							<a class="nav-link" href="//www.coldbox.org" title="The premier ColdFusion development platform"><i class="fa fa-link"></i> Powered By ColdBox</a>
						</li>
						<li>
							<a class="nav-link" href="//www.github.com/coldbox/coldbox-relax" title="The Relax Source Code"><i class="fa fa-github"></i> Github Repo</a>
						</li>
						<li>
							<a class="nav-link" href="//www.twitter.com/coldbox" title="Follow me!"><i class="fa fa-twitter"></i> Tweet</a>
						</li>
					</ul>
				</li>
				<li class="nav-item">
					<a class="nav-link" data-widget="control-sidebar" data-slide="true" href="##" role="button">
					  <i class="fa fa-th-large"></i>
					</a>
				</li>
			</ul>
        </nav>
   		</cfif>

		<!--sidebar start-->
		<cfif args.sidebar>
			<aside class="main-sidebar sidebar-dark-primary elevation-4">
				<!--logo start-->
				<a href="#event.buildLink( prc.xehHome )#" class="brand-link">
					<img src="#prc.root#/includes/static/images/ColdBoxLogo2015-Solo_50.png" title="ColdBox" class="brand-image img-circle elevation-3"/>
					<span class="brand-text font-weight-light"><strong>Relax</strong></span>
				</a>
				<div class="sidebar">
					<nav class="mt2">
						<ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
							<li class="nav-item">
								<a class="nav-link" href="#event.buildLink( prc.xehHome )#">
									<i class="fa fa-desktop nav-icon"></i>
									<p>API Manager</p></a>
							</li>
							<li class="nav-item">
								<a class="nav-link" href="#event.buildLink( prc.xehRelaxer )#" title="Pronounced 'Relax-ER'">
									<i class="fa fa-flask nav-icon"></i>
									<p>API Test Tool</p>
								</a>
							</li>

							<li class="nav-item">
								<a class="nav-link" href="https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.2.md" target="_blank">
									<i class="fa fa-rocket nav-icon"></i>
									<p>OpenAPI Docs</p>
								</a>
							</li>

							<li class="nav-item">
								<a class="nav-link" href="##" title="Version Information">
									<i class="fa fa-info nav-icon"></i>
									<p>Relax v#getModuleConfig( 'relax' ).version#</p>
								</a>
							</li>
						</ul>
					</nav>
				</div>
			</aside>
	    <!--sidebar end-->
	    </cfif>

		<!--main content start-->
	    #renderView()#
	    <!--main content end-->
    </div>

    <cfinclude template="inc/HTMLBodyEnd.cfm">

</body>
<!--End Body-->
</cfoutput>
</html>
