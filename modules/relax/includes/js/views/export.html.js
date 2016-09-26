/*! Copyright 2016 - Ortus Solutions (Compiled: 15-09-2016) */
define([ "Backbone", "clipboard", "messenger", "views/home.index" ], function(Backbone, Clipboard, Messenger, APIView) {
    "use strict";
    var View = Backbone.View.extend({
        el: "body",
        events: {
            "click #btnCopyGeneratedSource": "onCopySource"
        },
        initialize: function() {
            return this.setupDefaults().setupSelectors().render();
        },
        setupSelectors: function() {
            var $clipButton = $("#btnCopyGeneratedSource");
            var clipboard = new Clipboard($clipButton[0], {
                text: function(trigger) {
                    return $("html")[0].outerHTML;
                }
            });
            $clipButton.tooltip();
            return this;
        },
        setupDefaults: function() {
            return this;
        },
        render: function() {
            return this;
        },
        onCopySource: function(e) {
            var _this = this;
            Messenger().post({
                message: "HTML Copied to your clipboard",
                type: "success",
                showCloseButton: true
            });
        }
    });
    return new View();
});