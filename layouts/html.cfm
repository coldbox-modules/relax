<!DOCTYPE html>
<html lang="en">
	<cfoutput>
		<head>
			<title>#prc.exportTitle#</title>
			<!-- Normalize our CSS for portability -->
			<style type="text/css">
			<cfinclude template="#relaxElixirPath( "css/export.css" )#"/>
			</style>
			<!-- Fonts -->
			<link href='//fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,900,300italic,400italic,600italic,700italic,900italic' rel='stylesheet' type='text/css'>
			<link href='//fonts.googleapis.com/css?family=Open+Sans:400,700' rel='stylesheet' type='text/css'>
		</head>
		<body class="export" style="background-color: white">
			<div class="container">
				<cfoutput>
				#renderView()#
				</cfoutput>
			</div>
		</body>
	</cfoutput>

	<!-- dynamic assets -->
<cfoutput>
    <!-- RJS Runtime Using CDN's to allow HTML Export -->
    <script crossorigin src="https://cdnjs.cloudflare.com/ajax/libs/require.js/2.3.6/require.min.js" type="application/javascript"></script>
    <script crossorigin type="application/javascript">
        require( [ 'https://cdnjs.cloudflare.com/ajax/libs/es6-shim/0.35.5/es6-sham.min.js' ], function(){
			require.config( {
				onNodeCreated : function(node, config, name, url){
					node.setAttribute( 'crossorigin', 'anonymous' );
				}
			} );
            require(
				[
					'https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.slim.js'
				],
				function( globals ){
					require( [
						'https://cdnjs.cloudflare.com/ajax/libs/jsonlint/1.6.0/jsonlint.min.js',
						'https://cdnjs.cloudflare.com/ajax/libs/prism/1.19.0/prism.min.js'
					], function( ){
						$( document ).ready( function(){
							$( 'pre[class*="language-"],code[class*="language-"]' ).each( function(){
								//attempt to pretify JSON
								try{
									var parsed = jsonlint.parse( $( this ).text().trim() );
									$( this ).html( JSON.stringify(parsed, false, 4).replace(/\\\\/g, "\\") );
								} catch( e ){}
								Prism.highlightElement(this);
							});
						} );
				} );
            });
        });
    </script>
</cfoutput>
</html>