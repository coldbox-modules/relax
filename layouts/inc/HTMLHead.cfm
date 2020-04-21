<cfoutput>
<head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>ColdBox Relax - RESTful Tools For Lazy Experts</title>
    <!--- favicon --->
    <link href="#prc.root#/includes/static/images/ortus-mini-icon.png" rel="shortcut icon" type="image/png" />
	<!--- View Port --->
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<cfoutput>
		<link rel="stylesheet" href="#relaxElixirPath( "css/app.css" )#"/>
		<script type="application/javascript">
			var rootAssetPath = '#prc.root#';
			var moduleAPIRoot = '#(len( getSetting( "AppMapping" ) ) ? '/' & getSetting( "AppMapping" ) : '')#/relax/';
		</script>
    </cfoutput>

</head>
</cfoutput>