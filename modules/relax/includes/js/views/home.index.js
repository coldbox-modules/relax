/*! Copyright 2016 - Ortus Solutions (Compiled: 18-03-2016) */
define([ "Backbone", "views/widgets/relaxer", "views/widgets/sidebar", "models/RelaxAPI" ], function(Backbone, Relaxer, SidebarWidget, APIModel) {
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
            var promise = new Promise(function(resolve, reject) {
                _this.Model.fetch({
                    success: function(model, resp) {
                        _this.availableAPIs = _.clone(model.attributes.apis);
                        if ($(".mc-sidebar").length > 0) {
                            _this.sidebar = new SidebarWidget({
                                view: _this,
                                apis: model.attributes.apis,
                                "default": model.attributes.default
                            });
                        }
                        _this.defaultAPI = model.attributes.default;
                        if (typeof _this.activeAPI === "undefined") _this.activeAPI = _this.defaultAPI;
                        _this.Model.clear().set("id", _this.activeAPI);
                        _this.Model.fetch({
                            success: function(model, resp) {
                                return resolve(_this.Model);
                            },
                            error: function(model, err) {
                                console.debug("API Load failed");
                                console.debug(err);
                                return reject(_this.Model);
                            }
                        });
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
            _this.renderLoaderMessage();
            _this.renderAPIDocumentation();
            return this;
        },
        renderLoaderMessage: function() {
            var _this = this;
            var APITitle = _this.availableAPIs[_this.Model.get("id")].title;
            var loaderMessage = '<div id="mc-loader" class="text-center">                    <h4 class="text-muted">Loading API <em>' + APITitle + '</em>...</h4>                    <p>                        <i class="fa fa-spin fa-spinner fa-2x text-muted"></i>                    </p>                </div>';
            $(".api-content", "#main-content").html(loaderMessage);
        },
        renderAPIDocumentation: function() {
            var _this = this;
            var APIDoc = _this.Model.attributes;
            var contentTemplate = _.template($("#api-content-template").html());
            $(".api-content", _this.el).html(contentTemplate({
                api: APIDoc
            }));
            _this.renderPaths(APIDoc.paths, $(".paths-content", $(".api-content", _this.el)));
        },
        renderPaths: function(paths, $container) {
            var _this = this;
            var pathTemplate = _.template($("#path-template").html());
            _.each(_.keys(paths), function(pathKey) {
                $container.append(pathTemplate({
                    key: pathKey,
                    path: paths[pathKey]
                }));
                setTimeout(function() {
                    _this.renderContainerUI($container);
                }, 2e3);
            });
        },
        renderContainerUI: function($container) {
            var _this = this;
            $('[data-toggle="tooltip"]', $container).each(function() {
                $(this).tooltip();
            });
            $('pre[class*="language-"],code[class*="language-"]').each(function() {
                Prism.highlightElement(this);
            });
        }
    });
    return new View();
});