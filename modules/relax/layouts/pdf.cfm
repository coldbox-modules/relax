<cfsetting showdebugoutput="false">
<!--- CFFDocument --->
<cfdocument pagetype="letter" format="pdf">

	<!--- Header --->
	<cfdocumentitem type="header">
	<cfoutput>
	<div style="font-size: 9px; text-align: right;">
	#prc.exportTitle#
	</div>
	</cfoutput>
	</cfdocumentitem>

	<!--- Footer --->
	<cfdocumentitem type="footer">
	<cfoutput>
	<div style="font-size: 9px; text-align: right;">
	Page #cfdocument.currentpagenumber# of #cfdocument.totalpagecount#
	</div>
	</cfoutput>
	</cfdocumentitem>

	<cfoutput>
	<head>
		<!-- Fonts -->
		<link href='//fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,900,300italic,400italic,600italic,700italic,900italic' rel='stylesheet' type='text/css'>
		<link href='//fonts.googleapis.com/css?family=Open+Sans:400,700' rel='stylesheet' type='text/css'>
		<!--- View Port --->
    	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
		<!-- Theme CSS -->
	    <link rel="stylesheet" href="#prc.root#/includes/css/theme.css">
	    <!-- App CSS -->
	    <link rel="stylesheet" href="#prc.root#/includes/css/relax.css">
	    
	    <!-- Runtime CSS -->
		<cfloop array="#prc.runtimeAssets.css#" index="css">
			<cfset addAsset( css )>
		</cfloop>
	</head>

	<body class="off-canvas" style="background-color: white; font-size: 10px">
		<div class="container">
			<cfoutput>
			#renderView()#
			</cfoutput>
		</div>
	</body>
	</cfoutput>
</cfdocument>
