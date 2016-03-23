/**
* This is the globals placeholder file.  
* It maintains the core RJS config and will be appended with the global `deps` specified in /require.build.js
* The `baseURL` specifies the directory where RJS begins to look for JS files
* Items in the `shim` config will be globally available
**/
requirejs.config({
	baseUrl: '/modules/relax/includes/js/',
	shim: {
	    'jquery'        : ['jquery'],
	    'bootstrap'     : ['bootstrap'],
	    'backbone'		: ['backbone'],
	    'underscore'	: ['underscore']
	}
});