/*! Copyright 2017 - Ortus Solutions (Compiled: 08-04-2017) */
define([ "Backbone", "views/widgets/relaxer", "views/widgets/sidebar", "models/RelaxAPI" ], function(Backbone, RelaxerWidget, SidebarWidget, APIModel) {
    "use strict";
    var View = Backbone.View.extend({
        el: "#main-content",
        events: {},
        initialize: function() {
            var _this = this;
            _this.Model = APIModel;
            _this.setupDefaults().then(function(model) {
                return _this.setupSelectors().render();
            });
        },
        setupSelectors: function() {
            return this;
        },
        setupDefaults: function() {
            var _this = this;
            if (_.isUndefined(rootAssetPath)) {
                var rootAssetPath = "/modules/relax";
            }
            var promise = new Promise(function(resolve, reject) {
                _this.activeAPI = parseRequestParams().api;
                _this.Model.fetch({
                    success: function(model, resp) {
                        _this.activeAPI = parseRequestParams().api;
                        _this.sidebar = new SidebarWidget({
                            view: _this,
                            apis: model.attributes.apis,
                            default: _.isUndefined(_this.activeAPI) ? model.attributes.default : _this.activeAPI
                        });
                        var $relaxer = $(".relaxer", _this.el);
                        _this.Relaxer = new RelaxerWidget({
                            el: ".relaxer",
                            $el: $relaxer
                        });
                        return resolve(_this.Model);
                    },
                    error: function(model, resp) {
                        return reject(_this.Model);
                    }
                });
            });
            return promise;
        },
        render: function() {
            var _this = this;
            return _this;
        }
    });
    return new View();
});