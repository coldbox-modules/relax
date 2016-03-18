/*! Copyright 2016 - Ortus Solutions (Compiled: 18-03-2016) */
define([ "Backbone", "models/RelaxAPI" ], function(Backbone, APIModel) {
    "use strict";
    var View = Backbone.View.extend({
        el: ".mc-sidebar",
        events: {
            "change #myAPI": "onSelectAPI",
            "click .btnExportMediaWiki": "onExportMediaWiki",
            "click .btnExportTrac": "onExportTrac"
        },
        initialize: function(options) {
            var _this = this;
            if (typeof moduleAPIRoot === "undefined") moduleAPIRoot = "/relax/";
            if (!_.isUndefined(options.apis)) {
                _this.availableAPIs = options.apis;
                _this.defaultAPI = options.default;
            }
            if (!_.isUndefined(options.view)) {
                _this.View = options.view;
                _this.ViewModel = _this.View.Model;
            }
            if (typeof _this.availableAPIs === "undefined") {
                APIModel.fetch({
                    success: function(model, resp) {
                        _this.availableAPIs = model.attributes.apis;
                        _this.defaultAPI = model.attributes.default;
                        return _this.setupDefaults().setupSelectors().render();
                    },
                    error: function(model, resp) {
                        $("#system-messages").append('<p class="alert alert-danger">An error occurred while attempting to fetch the available APIS.  Please check the console for details.</a>');
                        console.error(resp);
                    }
                });
            } else {
                return _this.setupDefaults().setupSelectors().render();
            }
        },
        setupSelectors: function() {
            return this;
        },
        setupDefaults: function() {
            return this;
        },
        render: function() {
            var _this = this;
            _this.renderAPISelectors();
            return this;
        },
        renderAPISelectors: function() {
            var _this = this;
            if (typeof _this.availableAPIs === "undefined") return;
            var selectorTemplate = _.template($("#api-selector-template").html());
            $(".mc-sidebar .api-selector").html(selectorTemplate({
                apis: _this.availableAPIs,
                defaultAPI: _this.defaultAPI
            }));
        },
        onSelectAPI: function(e) {
            var _this = this;
            var $select = $(e.currentTarget);
            var selectedAPI = $select.val();
            _this.ViewModel.set("id", selectedAPI);
            _this.View.renderLoaderMessage();
            _this.ViewModel.fetch({
                success: function(model, resp) {
                    _this.View.render();
                },
                error: function(model, err) {
                    console.error(err);
                }
            });
        },
        onExportTrac: function(e) {
            var _this = this;
            var documentationHTML = $(".api-content")[0].outerHTML;
            $.post(moduleAPIRoot + "export/trac", {
                content: documentationHTML
            }, function(translationContent) {
                var $modal = $("#modal");
                var modalContent = '<div class="panel panel-solid-default"><pre>' + translationContent + "</pre></div>";
                $modal.find(".modal-header").html('<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>                         <h3><i class="fa fa-lg fa-paw"></i> API Export: Trac </h3>');
                $modal.find(".modal-body").html(_this.exportWrapper(modalContent));
                $modal.modal("show");
            });
        },
        onExportMediaWiki: function(e) {
            var _this = this;
            var documentationHTML = $(".api-content")[0].outerHTML;
            $.post(moduleAPIRoot + "export/mediawiki", {
                content: documentationHTML
            }, function(translationContent) {
                var $modal = $("#modal");
                var modalContent = '<div class="panel panel-solid-default"><pre>' + translationContent + "</pre></div>";
                $modal.find(".modal-header").html('<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>                         <h3><i class="fa fa-lg fa-code-o"></i> API Export: MediaWiki</h3>');
                $modal.find(".modal-body").html(_this.exportWrapper(modalContent));
                $modal.modal("show");
            });
        },
        exportWrapper: function(exportContent) {
            return '<textarea id="exportContent" class="form-control" rows="20">' + exportContent + "</textarea>";
        }
    });
    return View;
});