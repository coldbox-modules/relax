<!DOCTYPE html>
<html lang="en">
	<cfoutput>
		<head>
			<title>#prc.exportTitle#</title>
			<!-- Normalize our CSS for portability -->
			<style type="text/css">
			<cfinclude template="#prc.root#/includes/css/export.css"/>
			<cfinclude template="#prc.root#/includes/plugins/prism/prism-solarizedlight.css"/>
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
    <!-- RJS Runtime -->
    <script src="#prc.root#/includes/js/require.js" type="application/javascript"></script>
    <script type="application/javascript">
        require( [ '#prc.root#/includes/js/es6-shim.js' ], function(){
            require( [ '#prc.root#/includes/js/globals.js' ], function( globals ){
                require.config( {
                   baseUrl : '#prc.root#/includes/js/',
                } );
				window[ "_" ]       = _;
				require( [
					'#prc.root#/includes/js/jsonlint.js',
					'#prc.root#/includes/js/prism.js'
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