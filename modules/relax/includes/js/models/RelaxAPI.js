/*! Copyright 2016 - Ortus Solutions (Compiled: 23-03-2016) */
define([ "Backbone" ], function(Backbone) {
    "use strict";
    var Model = Backbone.Model.extend({
        urlRoot: "/relax/apidoc",
        initialize: function(attributes, options) {
            if (typeof moduleAPIRoot === "undefined") moduleAPIRoot = "/relax/";
            this.urlRoot = moduleAPIRoot + "apidoc";
            if (typeof attributes !== "undefined") this.set(attributes);
            return this;
        }
    });
    return new Model();
});