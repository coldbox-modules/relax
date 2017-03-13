/*! Copyright 2017 - Ortus Solutions (Compiled: 13-03-2017) */
define([ "Backbone", "models/RelaxerHistory" ], function(Backbone, HistoryModel) {
    "use strict";
    var Relaxer = Backbone.View.extend({
        el: ".relaxer",
        events: {
            "click .dynamicAdd": "onAddDynamicItem",
            "click .dynamicRemove": "onRemoveDynamicItem",
            "click .btnSendRequest": "onRelaxerSend",
            "click .btnReplayHistoryIndex": "onReplayHistoryIndex",
            "click .btnClearHistory": "clearHistory"
        },
        initialize: function(options) {
            var _this = this;
            if (_.isUndefined(rootAssetPath)) {
                _this.baseHref = "/modules/relax";
            } else {
                _this.baseHref = rootAssetPath;
            }
            if (!_.isUndefined(options)) {
                _.each(_.keys(options), function(optionKey) {
                    _this[optionKey] = options[optionKey];
                });
            }
            return this.setupDefaults().setupSelectors().render();
        },
        setupSelectors: function() {
            return this;
        },
        setupDefaults: function() {
            var _this = this;
            _this.HistoryModel = new HistoryModel();
            _this.relaxerFormTemplate = _.template($("#relaxer-form-template").html());
            _this.relaxerResponseTemplate = _.template($("#relaxer-response-template").html());
            return this;
        },
        render: function() {
            var _this = this;
            var relaxerFormData = _this.getRelaxerFormData();
            $(".relaxer-form", _this.el).html(_this.relaxerFormTemplate(relaxerFormData));
            _this.onRelaxerRendered();
            return _this.this;
        },
        renderRelaxerResponse: function(jqXHR, textStatus) {
            var _this = this;
            var $container = $(".relaxer-results", _this.$el);
            var responseEcho = JSON.parse(jqXHR.responseText);
            if (typeof responseEcho.status_code === "undefined") {
                var errorMessage = responseEcho.errordetail ? responseEcho.errordetail : responseEcho.error;
                $container.html('<div class="clearfix"></div>');
                $container.after('<p id="relaxer-response-error" class="alert alert-danger">There was an error servicing your request.  The response received was: <em>' + errorMessage + "</em></p>");
            } else {
                var responseObject = {
                    status: responseEcho.status_code,
                    statusText: responseEcho.status_text,
                    responseText: responseEcho.filecontent,
                    getAllResponseHeaders: function() {
                        return responseEcho.responseheader;
                    },
                    getResponseHeader: function(headerName) {
                        return responseEcho.responseheader[headerName];
                    }
                };
                $container.html(_this.relaxerResponseTemplate({
                    response: responseObject
                }));
                _this.renderContainerUI($container);
            }
        },
        getRelaxerFormData: function() {
            var _this = this;
            var relaxerData = {
                api: _this.APIDocument,
                relaxer: {
                    method: "",
                    endpoint: "",
                    extensionDetection: false
                }
            };
            return relaxerData;
        },
        onRelaxerRendered: function() {
            var _this = this;
            _this.$relaxerForm = $(".relaxerForm", _this.$el);
            _this.$resultsBox = $(".relaxerResults", _this.$el);
            _this.$relaxerHeader = $(".relaxerHeader", _this.$el);
        },
        onRelaxerSend: function(e) {
            var _this = this;
            var $btn = $(e.currentTarget);
            $("#relaxer-response-error").remove();
            var btnDefaultHTML = $btn.html();
            $btn.find("i").removeClass("fa-paper-plane").addClass("fa-spin fa-spinner");
            if ($(".advancedSettings", _this.$el).hasClass("in")) $(".advancedSettings", _this.$el).removeClass("in");
            $(".relaxer-results", _this.$el).html(_this.loaderMsg);
            var _this = this;
            var relaxerRequest = _this.marshallRelaxerRequest();
            var relaxerOptions = {
                url: "/relax/relaxer/send",
                method: "POST",
                data: JSON.stringify(relaxerRequest),
                complete: function(jqXHR, textStatus) {
                    $btn.html(btnDefaultHTML);
                    _this.renderRelaxerResponse(jqXHR, textStatus);
                    _this.HistoryModel.attributes.history.push({
                        request: relaxerRequest,
                        response: jqXHR
                    });
                    _this.renderHistory();
                }
            };
            relaxerOptions.error = relaxerOptions.success;
            $.ajax(relaxerOptions);
        },
        onReplayHistoryIndex: function(e) {
            var _this = this;
            var $btn = $(e.currentTarget);
            var historyIndex = parseInt($btn.closest(".relaxer-history-panel").data("index"));
            var indexData = _this.HistoryModel.attributes.history[historyIndex];
            $('[name="httpResource"]', _this.$relaxerForm).val(indexData.request.resource);
            $('[name="httpMethod"]', _this.$relaxerForm).val(indexData.request.method);
            $(".httpHeaders", _this.$relaxerForm).find(".dynamicField").remove();
            $(".requestParams", _this.$relaxerForm).find(".dynamicField").remove();
            $('[name="httpProxy"]', _this.$relaxerForm).val("");
            $('[name="username"]', _this.$relaxerForm).val("");
            $('[name="password"]', _this.$relaxerForm).val("");
            _.each(indexData.request.headers, function(headerValue, headerName, headers) {
                $(".httpHeaders .btn.dynamicAdd", _this.$relaxerForm).click();
                var $dynamicField = $(".httpHeaders .dynamicField", _this.$relaxerForm).last();
                $('[name="headerName"]', $dynamicField).val(headerName);
                $('[name="headerValue"]', $dynamicField).val(headerValue);
            });
            _.each(indexData.request.data, function(paramValue, paramName, params) {
                $(".httpParameters .btn.dynamicAdd", _this.$relaxerForm).click();
                var $dynamicField = $(".httpParameters .dynamicField", _this.$relaxerForm).last();
                $('[name="parameterName"]', $dynamicField).val(paramName);
                $('[name="parameterValue"]', $dynamicField).val(paramValue);
            });
        },
        onAddDynamicItem: function(e) {
            return this.addDynamicItem($(e.currentTarget));
        },
        onRemoveDynamicItem: function(e) {
            var $btn = $(e.currentTarget);
            var $field = $btn.closest(".dynamicField");
            $field.fadeOut(300, function() {
                $field.remove();
            });
        },
        marshallRelaxerRequest: function() {
            var _this = this;
            var request = {
                resource: $('[name="httpResource"]', _this.$relaxerForm).val(),
                method: $('[name="httpMethod"]', _this.$relaxerForm).val(),
                headers: {},
                data: {}
            };
            if ($('[name="httpAccept"]', _this.$relaxerForm).length > 0) {
                request.accepts = $('[name="httpAccept"]', _this.$relaxerForm).val();
            }
            if ($('[name="httpProxy"]', _this.$relaxerForm).val().length > 0) {
                request.httpProxy = $('[name="httpProxy"]', _this.$relaxerForm).val();
            }
            if ($('[name="username"]', _this.$relaxerForm).val().length > 0) {
                request.authUsername = $('[name="username"]', _this.$relaxerForm).val();
            }
            if ($('[name="password"]', _this.$relaxerForm).val().length > 0) {
                request.authPassword = $('[name="username"]', _this.$relaxerForm).val();
            }
            $(".requestHeaders", _this.$relaxerForm).find(".dynamicField").each(function() {
                var $headerContainer = $(this);
                request.headers[$headerContainer.find('[name="headerName"]').val()] = $headerContainer.find('[name="headerValue"]').val();
            });
            $(".requestParams", _this.$relaxerForm).find(".dynamicField").each(function() {
                var $paramContainer = $(this);
                request.data[$paramContainer.find('[name="parameterName"]').val()] = $paramContainer.find('[name="parameterValue"]').val();
            });
            return request;
        },
        addDynamicItem: function($trigger, inData) {
            var fieldType = $trigger.attr("data-type");
            var fieldsTemplate = _.template($("#dynamicFieldsTemplate").html());
            $trigger.before(fieldsTemplate({
                field: _.isUndefined(inData) ? {} : inData,
                fieldType: fieldType
            }));
        },
        renderHistory: function() {
            var _this = this;
            var historyTemplate = _.template($("#relaxer-history-template").html());
            var $historyContainer = $(".relaxer-history", _this.el);
            $historyContainer.empty();
            if (_this.HistoryModel.attributes.history.length > 0) {
                $historyContainer.html(historyTemplate({
                    history: _this.HistoryModel.attributes.history,
                    responseTemplate: _.template($("#relaxer-response-template").html())
                }));
                _this.renderContainerUI($historyContainer);
            }
        },
        clearHistory: function(e) {
            var _this = this;
            var $btn = $(e.currentTarget);
            var $historyContainer = $(".relaxer-history", _this.el);
            $historyContainer.fadeOut(600, function() {
                _this.HistoryModel.attributes.history = [];
                _this.renderHistory();
                $historyContainer.show();
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
        },
        loaderMsg: '                <div id="bottomCenteredLoader">                    <p class="text-center">                        Sending Request... <br/>                        <i class="fa fa-spinner fa-spin fa-3x"></i>                    </p>                </div>'
    });
    return Relaxer;
});