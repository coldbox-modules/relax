/*! Copyright 2020 - Ortus Solutions (Compiled: 05-03-2020) */

define([ "Backbone", "models/RelaxAPI", "models/RelaxerHistory" ], function(Backbone, APIModel, HistoryModel) {
    "use strict";
    var View = Backbone.View.extend({
        el: ".mc-sidebar",
        events: {
            "change #myAPI": "onSelectAPI",
            "click .btnExportJSON": "onExportAPIJSON",
            "click .btnExportFormat": "onExportFormat",
            "click .btnImportAPI": "onShowImportAPI",
            "click .relaxer-resource-info": "onDisplayResourceInfo",
            "change .relaxerResourceSelector": "onRelaxerResourceSelect"
        },
        initialize: function(options) {
            var _this = this;
            if (typeof moduleAPIRoot === "undefined") moduleAPIRoot = window.relax.baseUrl;
            if (!_.isUndefined(options.apis)) {
                _this.availableAPIs = options.apis;
                _this.defaultAPI = options.default;
            }
            if (!_.isUndefined(options.view)) {
                _this.View = options.view;
                if (_.isUndefined(_this.View.Model)) {
                    _this.View.Model = APIModel;
                }
                _this.ViewModel = _this.View.Model;
            }
            if (typeof _this.availableAPIs === "undefined") {
                _this.ViewModel.fetch({
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
            _this.renderAPISelectors().then(function() {
                if (_this.$el.hasClass("relaxer-sidebar")) {
                    _this.assignAPI(_this.defaultAPI);
                    $("#myAPI").change();
                    _this.initializeRelaxerHistory();
                }
            });
            return this;
        },
        renderAPISelectors: function() {
            var _this = this;
            var promise = new Promise(function(resolve, reject) {
                if (typeof _this.availableAPIs === "undefined") return reject();
                var selectorTemplate = _.template($("#api-selector-template").html());
                $(".mc-sidebar .api-selector").html(selectorTemplate({
                    apis: _this.availableAPIs,
                    defaultAPI: _this.defaultAPI
                }));
                return resolve();
            });
            return promise;
        },
        renderRelaxerResources: function() {
            var _this = this;
            var resourceTemplate = _.template($("#relaxer-resources-template").html());
            $(".relaxer-resources", _this.$el).html(resourceTemplate({
                api: _this.ViewModel.attributes
            }));
        },
        initializeRelaxerHistory: function() {
            var _this = this;
            if (_.isUndefined(_this.View.HistoryModel)) {
                _this.View.HistoryModel = new HistoryModel();
            }
            _this.View.HistoryModel.on("change:history", function() {
                _this.renderRelaxerHistory();
            });
        },
        renderRelaxerHistory: function() {
            var _this = this;
            var historyTemplate = _.template($("#relaxer-resources-template").html());
            var $historyContainer = $(".relaxer-history", _this.el);
            $historyContainer.empty().html(historyTemplate({
                history: _this.HistoryModel.attributes.history
            }));
        },
        assignAPI: function(api) {
            var $selectorOptions = $("#myAPI options");
            $selectorOptions.each(function() {
                var $option = $(this);
                if ($option.attr("value") === api) {
                    $option.prop("selected", true);
                }
            });
        },
        onDisplayResourceInfo: function(e) {
            var _this = this;
            var $btn = $(e.currentTarget);
            var infoPath = $btn.data("path");
            var pathTemplate = _.template($("#path-template").html());
            var pathData = _this.ViewModel.attributes.paths[infoPath];
            var $modal = $("#modal");
            var blankModalHTML = '<div class="modal-content" style="left:10px;top: 50px;"><div class="modal-header"><button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button><h2></h2></div><div class="modal-body"></div><div class="modal-footer"></div></div>';
            $modal.html(blankModalHTML);
            $(".modal-header h2", $modal).html("Path Documentation for: <code>" + infoPath + "</code>");
            $(".modal-body", $modal).html(pathTemplate({
                key: infoPath,
                path: pathData
            }));
            $modal.modal("show");
            $("h3.pathHeader", $modal).find('a[role="button"]').click();
        },
        onSelectAPI: function(e) {
            var _this = this;
            var $select = $(e.currentTarget);
            var selectedAPI = $select.val();
            _this.ViewModel.set("id", selectedAPI);
            if (!_.isUndefined(_this.View.renderLoaderMessage)) _this.View.renderLoaderMessage();
            _this.ViewModel.fetch({
                success: function(model, resp) {
                    if ($(".relaxer .relaxer-form").length) {
                        history.pushState(null, null, moduleAPIRoot + "relaxer/" + selectedAPI);
                    } else {
                        history.pushState(null, null, moduleAPIRoot + "api/" + selectedAPI);
                    }
                    if (_this.$el.hasClass("relaxer-sidebar")) {
                        _this.renderRelaxerResources();
                    } else {
                        _this.View.render();
                    }
                },
                error: function(model, err) {
                    console.error(err);
                }
            });
        },
        onExportAPIJSON: function(e) {
            var _this = this;
            var $btn = $(e.currentTarget);
            $.get($btn.data("link") + "/" + $('[name="myAPI"]', _this.$el).val(), function(exportHTML) {
                var $modal = $("#modal");
                $modal.html(exportHTML);
                $modal.modal("show");
            });
        },
        onShowImportAPI: function(e) {
            var _this = this;
            var importForm = _.template($("#api-import-form-template").html());
            var $modal = $("#modal");
            $modal.html(importForm({}));
            $modal.modal("show");
            $(".btnProcessImport", $modal).on("click", function(e) {
                _this.onConfirmImportAPI(e.currentTarget);
            });
            $('[name="apiName"]').on("change", function(e) {
                _this.onValidateAPIName(e);
            });
            $('[name="apiJSON"]').on("blur", function(e) {
                if ($(e.currentTarget).val().length) {
                    $(e.currentTarget).val(formatJSONRaw($(e.currentTarget).val().trim()));
                }
            });
        },
        onConfirmImportAPI: function(e) {
            var _this = this;
            _this.onProcessImportAPI(e);
        },
        onValidateAPIName: function(e) {
            var _this = this;
            var $apiName = $(e.currentTarget);
            $apiName.parent().find(".alert").remove();
            var enteredName = $apiName.val();
            var $apiSelect = $('[name="myAPI"]');
            var exists = false;
            $apiSelect.find("option").each(function() {
                if ($(this).attr("value").toLowerCase() === enteredName.trim().toLowerCase()) exists = true;
            });
            if (exists) {
                $apiName.after('<p class="alert alert-danger" style="margin-top: 10px">The API Name entered already exists.  You may not import an API that overwrites an existing one at this time.</p>');
                $apiName.closest(".modal-content").find(".modal-footer").find(".btnProcessImport").prop("disabled", true);
            } else {
                $apiName.closest(".modal-content").find(".modal-footer").find(".btnProcessImport").prop("disabled", false);
            }
        },
        onProcessImportAPI: function(e) {
            var _this = this;
            var $btn = $(e.currentTarget);
            $btn.append('<i class="fa fa-spin fa-spinner fa-xs"></>');
            var $form = $btn.closest(".modal-body");
            var formData = {};
            $("input,textarea").each(function() {
                formData[$(this).attr("name")] = $(this).val();
            });
            $.post(moduleAPIRoot + "apidoc", formData).done(function(data) {
                $btn.find("i.fa-spin").remove();
                if (!_.isUndefined(data.name) && !_.isUndefined(data.document)) {
                    var $modal = $("#modal");
                    $modal.modal("hide");
                    $modal.find(".modal-body, .modal-header ,.modal-footer").empty();
                    _this.ViewModel.clear().fetch({
                        success: function(model, resp) {
                            _this.availableAPIs = model.attributes.apis;
                            _this.View.availableAPIs = _this.availableAPIs;
                            _this.defaultAPI = model.attributes.default;
                            _this.renderAPISelectors().then(function() {
                                $('[name="myAPI"]').after('<p class="alert alert-success alert-dismissable" style="margin-top:10px">' + _this.alertDismiss + "API " + formData.apiName + " successfully created.  You may select it here to view the documentation.</p>");
                                $('[name="myAPI"]').focus();
                            });
                        },
                        error: function(model, resp) {
                            $("#system-messages").append('<p class="alert alert-danger alert-dismissable" style="margin-top:10px">' + _this.alertDismiss + "An error occurred while attempting to fetch the available APIS.  Please check the console for details.</a>");
                            console.error(resp);
                        }
                    });
                } else {
                    $form.append('<p class="alert alert-danger alert-dismissable" style="margin-top:10px">' + _this.alertDismiss + "The API could not be reported due to the following reason: <strong><em>" + data.message + "</em></strong>. Please correct your errors and try again.");
                }
            }).fail(function(data) {
                $btn.find("i.fa-spin").remove();
                if (!_.isUndefined(data.message)) {
                    $form.append('<p class="alert alert-danger alert-dismissable">The API could not be reported due to the following reason: <strong><em>' + data.message + "</em></strong>. Please correct your errors and try again.");
                } else {
                    $form.append('<p class="alert alert-danger alert-dismissable">An unexpected error occurred while attempting to create the API. Please check the logs for additional information.');
                }
            });
        },
        onExportFormat: function(e) {
            var _this = this;
            var $btn = $(e.currentTarget);
            var location = $btn.data("link");
            var selectedAPI = $('[name="myAPI"]', _this.el).val();
            window.open(location + "/" + selectedAPI);
        },
        onRelaxerResourceSelect: function(e) {
            var _this = this;
            var $resourceSelector = $(e.currentTarget);
            var resource = $resourceSelector.val().split(";");
            var methodName = resource[0];
            if (methodName === "null") {
                $('[name="httpResource"]').val("");
            } else {
                var pathName = resource[1];
                var apiPath = _this.ViewModel.attributes.paths[pathName];
                var apiMethod = apiPath[methodName];
                var tierEntry = $('[name="resourceTier"]').val();
                $('[name="httpResource"]').val(tierEntry + pathName);
                var $methodSelect = $('[name="httpMethod"]');
                $("option", $methodSelect).each(function() {
                    var $option = $(this);
                    if (methodName.toUpperCase() === $option.val()) $option.prop("selected", true);
                });
            }
        },
        exportWrapper: function(exportContent) {
            return '<textarea id="exportContent" class="form-control" rows="20">' + exportContent + "</textarea>";
        },
        alertDismiss: '<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>'
    });
    return View;
});