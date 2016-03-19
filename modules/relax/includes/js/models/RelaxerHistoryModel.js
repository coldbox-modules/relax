/*! Copyright 2016 - Ortus Solutions (Compiled: 19-03-2016) */
define([ "Backbone" ], function(Backbone) {
    "use strict";
    var Model = Backbone.Model.extend({
        urlRoot: "",
        initialize: function(attributes, options) {
            if (typeof attributes !== "undefined") this.set(attributes);
            return this;
        }
    });
    return new Model();
});