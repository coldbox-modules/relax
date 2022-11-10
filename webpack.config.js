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
	module: {
		rules: [
		  {
			test: /test\.js$/,
			use: 'mocha-loader',
			exclude: /node_modules/
		  }
		],
	}
});

module.exports = elixir(function(mix) {
	mix.sass( "app.scss" )
		.sass( "export.scss" )
		.vue( "app.js" );

});
