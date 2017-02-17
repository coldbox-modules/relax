/*! Copyright 2017 - Ortus Solutions (Compiled: 30-01-2017) */
define([ "Backbone" ], function(Backbone) {
    "use strict";
    var Model = Backbone.Model.extend({
        urlRoot: "",
        fetch: function() {
            return false;
        },
        sync: function() {
            return false;
        },
        initialize: function(attributes, options) {
            this.set("history", []);
            if (typeof attributes !== "undefined") this.set(attributes);
            return this;
        }
    });
    return Model;
});