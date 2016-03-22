<head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>ColdBox Relax - RESTful Tools For Lazy Experts</title>
    <!--- favicon --->
    <link href="#prc.root#/includes/images/favicon.ico" rel="shortcut icon" type="image/x-icon" />
    <!--- SES --->
	<base href="#getSetting( 'htmlBaseURL' )#" />
	<!--- View Port --->
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <cfoutput>
    <!-- Theme CSS -->
    <link rel="stylesheet" href="#prc.root#/includes/css/theme.css">
    <!-- App CSS -->
    <link rel="stylesheet" href="#prc.root#/includes/css/relax.css">
    
    <!-- Runtime CSS -->
	<cfloop array="#event.getPrivateValue("runtimeAssets",[]).css#" index="css">
		<cfset addAsset(css)>
	</cfloop>
    </cfoutput>
    <!-- Fonts -->
    <link href='http://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,900,300italic,400italic,600italic,700italic,900italic' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700' rel='stylesheet' type='text/css'>
    
    <!-- Feature detection -->
    <script src="#prc.root#/includes/js/modernizr.js"></script>
    
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="#prc.root#/includes/js/html5shiv.js"></script>
    <script src="#prc.root#/includes/js/respond.min.js"></script>
    <![endif]-->

</head>