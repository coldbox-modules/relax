<!DOCTYPE html>
<html lang="en">
	<cfoutput>
		<head>
			<title>#prc.exportTitle#</title>
			<!-- Normalize our CSS for portability -->
			<style type="text/css">
			<cfinclude template="#prc.root#/includes/css/export.css"/>
			</style>
		</head>
		<body class="export" style="background-color: white">
			<div class="container">
				<cfoutput>
				#renderView()#
				</cfoutput>
			</div>
		</body>
	</cfoutput>

</html>