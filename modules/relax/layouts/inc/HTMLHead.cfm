<cfoutput>
<head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>ColdBox Relax - RESTful Tools For Lazy Experts</title>
    <!--- favicon --->
    <link href="#prc.root#/includes/images/ortus-mini-icon.png" rel="shortcut icon" type="image/png" />
    <!--- SES --->
	<base href="#replacenocase( event.buildLink( linkTo='', ssl=event.isSSL() ), "index.cfm", "" )#"/>
	<!--- View Port --->
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <cfoutput>
    <!-- Theme CSS -->
    <link rel="stylesheet" href="#prc.root#/includes/css/theme.css">
    <!-- App CSS -->
    <link rel="stylesheet" href="#prc.root#/includes/css/relax.css">
    
    <!-- Runtime CSS -->
	<cfloop array="#event.getPrivateValue("runtimeAssets",arrayNew( 1 )).css#" index="css">
		<cfset addAsset(css)>
	</cfloop>
    </cfoutput>
    
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="#prc.root#/includes/js/html5shiv.js"></script>
    <script src="#prc.root#/includes/js/respond.min.js"></script>
    <![endif]-->
        
    <cfoutput>
        <!--- <cfdump var="#event#" abort> --->
    <script type="application/javascript">
        var rootAssetPath = '#prc.root#';
        var moduleAPIRoot = '#(len( getSetting( "AppMapping" ) ) ? '/' & getSetting( "AppMapping" ) : '')#/relax/';
    </script>
    </cfoutput>

</head>
</cfoutput>