/*! Copyright 2016 - Ortus Solutions (Compiled: 15-09-2016) */
define([ "Backbone", "views/widgets/relaxer", "views/widgets/sidebar", "models/RelaxAPI" ], function(Backbone, RelaxerWidget, SidebarWidget, APIModel) {
    "use strict";
    var View = Backbone.View.extend({
        el: "#main-content",
        events: {},
        initialize: function() {
            return this.setupSelectors().setupDefaults().render();
        },
        setupSelectors: function() {
            return this;
        },
        setupDefaults: function() {
            var _this = this;
            if (_.isUndefined(rootAssetPath)) {
                var rootAssetPath = "/modules/relax";
            }
            _this.sidebar = new SidebarWidget({
                view: _this
            });
            var $relaxer = $(".relaxer", _this.el);
            _this.Relaxer = new RelaxerWidget({
                el: ".relaxer",
                $el: $relaxer
            });
            return this;
        },
        render: function() {
            var _this = this;
            return _this;
        }
    });
    return new View();
});