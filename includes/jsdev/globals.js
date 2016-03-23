/**
* This is the globals placeholder file.  
* It maintains the core RJS config and will be appended with the global `deps` specified in /require.build.js
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