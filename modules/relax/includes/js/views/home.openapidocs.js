/*! Copyright 2017 - Ortus Solutions (Compiled: 30-01-2017) */
define([ "Backbone" ], function(Backbone) {
    "use strict";
    var View = Backbone.View.extend({
        el: ".main-content",
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
            $('pre[class*="language-"],code[class*="language-"]').each(function() {
                Prism.highlightElement(this);
            });
            return this;
        }
    });
    return new View();
});