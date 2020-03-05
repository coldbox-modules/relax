/*! Copyright 2020 - Ortus Solutions (Compiled: 05-03-2020) */

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