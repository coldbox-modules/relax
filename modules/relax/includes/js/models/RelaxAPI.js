/*! Copyright 2017 - Ortus Solutions (Compiled: 10-04-2017) */
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