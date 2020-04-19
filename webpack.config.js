const elixir = require("coldbox-elixir");
const webpack = require("webpack");

elixir.config.mergeConfig({
    plugins: [
        // globally scoped items which need to be available in all templates
        new webpack.ProvidePlugin({
			$              : "jquery",
			jQuery         : "jquery",
			"window.jQuery": "jquery",
			"window.$"     : "jquery",
            "Vue"          : ["vue/dist/vue.esm.js", "default"],
			"window.Vue"   : ["vue/dist/vue.esm.js", "default"],
			"Prism"        : "prismjs",
			"window.Prism" : "prismjs"
        })
	],
	// pack all of our images and fonts in as base64 to prevent URL pathing issues
	module: {
		rules: [
			{
				test: /\.(woff2?|eot|ttf|otf)(\?.*)?$/,
				loader: "url-loader",
				options: {
					limit: 100000,
					name: global.elixir.versioning
						? "includes/fonts/[name].[hash:7].[ext]"
						: "includes/fonts/[name].[ext]"
				}
			},
			{
				test: /\.(png|jpe?g|gif|svg)(\?.*)?$/,
				loader: "url-loader",
				options: {
					limit: 100000,
					name: global.elixir.versioning
						? "includes/images/[name].[hash:7].[ext]"
						: "includes/images/[name].[ext]"
				}
			}
		]
	}
});

module.exports = elixir(function(mix) {
	mix.sass( "app.scss" )
		.sass( "export.scss" )
		.vue( "app.js" );

});
