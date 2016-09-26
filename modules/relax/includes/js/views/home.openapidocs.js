/*! Copyright 2016 - Ortus Solutions (Compiled: 15-09-2016) */
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