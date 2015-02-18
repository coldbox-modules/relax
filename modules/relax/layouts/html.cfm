<cfsetting showdebugoutput="false">
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
	<link href="#prc.root#/includes/images/favicon.ico" rel="shortcut icon" type="image/x-icon" />
	<!--=========Stylesheets=========-->
	<link href="#prc.root#/includes/css/style.css"	 	rel="stylesheet" type="text/css"/>
	<link href="#prc.root#/includes/css/teal.css" 		rel="stylesheet" type="text/css"/>
	<link href="#prc.root#/includes/css/invalid.css" 	rel="stylesheet" type="text/css"/>

	<!--- loop around the cssAppendList, to add page specific css --->
	<cfloop list="#event.getPrivateValue("cssAppendList","")#" index="css">
		<cfset addAsset("#prc.root#/includes/css/#css#.css")>
	</cfloop>
	<cfloop list="#event.getPrivateValue("cssFullAppendList","")#" index="css">
		<cfset addAsset("#css#.css")>
	</cfloop>

	<!--========= JAVASCRIPT -->
	<script type="text/javascript" src="#prc.root#/includes/javascript/jquery-1.4.4.min.js"></script> <!--Import jquery tools-->
	<script type="text/javascript" src="#prc.root#/includes/javascript/jquery.tools.min.js"></script> <!--Import jquery tools-->
	<script type="text/javascript" src="#prc.root#/includes/javascript/metadata.pack.js"></script>
	<script type="text/javascript" src="#prc.root#/includes/javascript/relax.js"></script>

	<!--- loop around the jsAppendList, to add page specific js --->
	<cfloop list="#event.getPrivateValue("jsAppendList", "")#" index="js">
		<cfset addAsset("#prc.root#/includes/javascript/#js#.js")>
	</cfloop>
	<cfloop list="#event.getPrivateValue("jsFullAppendList", "")#" index="js">
		<cfset addAsset("#js#.js")>
	</cfloop>

	<!-- syntax highlighter -->
	<link type="text/css" rel="stylesheet" href="#prc.root#/includes/highlighter/styles/shCoreDefault.css">
	<script src="#prc.root#/includes/highlighter/scripts/shCore.js"></script>
	<script src="#prc.root#/includes/highlighter/scripts/shBrushColdFusion.js"></script>
	<script src="#prc.root#/includes/highlighter/scripts/shBrushXml.js"></script>
	<script src="#prc.root#/includes/highlighter/scripts/shBrushSql.js"></script>
	<script src="#prc.root#/includes/highlighter/scripts/shBrushJScript.js"></script>
	<script src="#prc.root#/includes/highlighter/scripts/shBrushJava.js"></script>
	<script src="#prc.root#/includes/highlighter/scripts/shBrushCss.js"></script>
	
</head>
<body>
	<div>
		<div class="content wrapper clearfix">
			#renderView()#
		</div>
	</div>
</body>
<script language="javascript">
$(document).ready(function() {
	// syntax highlight
	SyntaxHighlighter.all();
});
</script>
</cfoutput>