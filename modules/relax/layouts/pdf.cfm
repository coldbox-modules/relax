<cfsetting showdebugoutput="false">
<!--- CFFDocument --->
<cfdocument pagetype="letter" format="pdf" localurl="true">
<!DOCTYPE html>
	<html lang="en">
	
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
				<title>#prc.exportTitle#</title>
				<!-- Fonts -->
				<link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,900,300italic,400italic,600italic,700italic,900italic" rel="stylesheet" type="text/css">
				<link href="https://fonts.googleapis.com/css?family=Open+Sans:400,700" rel="stylesheet" type="text/css"/>
				<!-- Theme CSS -->
			    <link rel="stylesheet" type="text/css" href="#expandPath( prc.root )#/includes/css/theme.css"/>
			    <!-- App CSS -->
			    <link rel="stylesheet" type="text/css" href="#expandPath( prc.root )#/includes/css/relax.css"/>
			</head>

			<body class="off-canvas" style="background-color: white; font-size: 10px">
				<div class="container">
					<cfoutput>
					#renderView()#
					</cfoutput>
				</div>
			</body>
		</cfoutput>

	</html>
</cfdocument>
