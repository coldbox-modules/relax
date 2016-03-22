/*! Copyright 2016 - Ortus Solutions (Compiled: 13-03-2016) */
define([ "Backbone" ], function(Backbone) {
    "use strict";
    var View = Backbone.View.extend({
        el: "#main-content",
        events: {},
        initialize: function() {
            return this.setupDefaults().setupSelectors().render();
        },
        setupSelectors: function() {
            return this;
        },
        setupDefaults: function() {
            return this;
        },
        render: function() {
            return this;
        }
    });
    return new View();
});