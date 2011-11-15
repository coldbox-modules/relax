<cfoutput>
<div class="box clear">
	<div class="header">
		<img src="#rc.root#/includes/images/help.png" alt="help" width="30" height="30" />Relax Logs DSL Help
	</div>
	<div class="body_vertical_nav clearfix">
		
		<div class="main_column">
			<!-- Content area that wil show the form and stuff -->
			<div class="panes_vertical">
				#prc.docs#
			</div>
		</div>
	</div>
</div>


<script language="javascript">
$(document).ready(function() {
	// syntax highlight
	SyntaxHighlighter.all();
});
</script>
</cfoutput>