<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!-->
<html>
<!--<![endif]-->
<cfinclude template="inc/HTMLHead.cfm"/>
<body class="off-canvas" style="background-color: white">
	<div class="container">
		<cfoutput>#renderView( view='apidoc/cfTemplate/api-content',args={"api":prc.dsl})#</cfoutput>
	</div>
</body>
</html>
