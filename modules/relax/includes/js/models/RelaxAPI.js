/*! Copyright 2016 - Ortus Solutions (Compiled: 15-09-2016) */
define([ "Backbone" ], function(Backbone) {
    "use strict";
    var Model = Backbone.Model.extend({
        urlRoot: window.relax.apiDocBaseUrl,
        initialize: function(attributes, options) {
            if (typeof moduleAPIRoot === "undefined") moduleAPIRoot = window.relax.baseUrl;
            this.urlRoot = moduleAPIRoot + "apidoc";
            if (typeof attributes !== "undefined") this.set(attributes);
            return this;
        }
    });
    return new Model();
});