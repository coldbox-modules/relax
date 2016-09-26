/*! Copyright 2016 - Ortus Solutions (Compiled: 15-09-2016) */
define([ "Backbone", "models/RelaxerHistory" ], function(Backbone, HistoryModel) {
    "use strict";
    var Relaxer = Backbone.View.extend({
        el: ".relaxer",
        events: {
            "click .dynamicAdd": "onAddDynamicItem",
            "click .dynamicRemove": "onRemoveDynamicItem",
            "click .btnSendRequest": "onRelaxerSend"
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
            console.debug(responseEcho);
            var responseObject = {
                status: responseEcho.Statuscode,
                statusText: responseEcho.Statuscode,
                responseText: responseEcho.Filecontent,
                getAllResponseHeaders: function() {
                    return responseEcho.Responseheader;
                },
                getResponseHeader: function(headerName) {
                    return responseEcho.Responseheader[headerName];
                }
            };
            $container.html(_this.relaxerResponseTemplate({
                response: responseObject
            }));
            _this.renderContainerUI($container);
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
                beforeSend: function(xhrObj){
                    xhrObj.setRequestHeader("Content-Type", "text/html");
                },
                complete: function(jqXHR, textStatus) {
                    $btn.html(btnDefaultHTML);
                    _this.renderRelaxerResponse(jqXHR, textStatus);
                    _this.HistoryModel.attributes.history.push({
                        request: relaxerRequest,
                        response: jqXHR
                    });
                }
            };
            relaxerOptions.error = relaxerOptions.success;
            $.ajax(relaxerOptions);
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
                url: $('[name="httpResource"]', _this.$relaxerForm).val(),
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
        clearHistory: function() {
            $("#historyLoader").fadeIn();
            $("#requestHistoryContainer").css("opacity", ".5");
            $.post("#event.buildLink( prc.xehPurgeHistory )#", {}, function(response) {
                $("#historyLoader").fadeOut();
                $("#requestHistoryContainer").css("opacity", "1");
                $("#requestHistoryMessages").html(response.messages).slideDown().delay(1500).slideUp();
                if (!response.error) {
                    $("#requestHistory").empty().append('<option value="null">No History</option>');
                }
            }, "json");
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
        loaderMsg: '                <div id="bottomCenteredLoader">                    <p class="text-center">                        Sending Request... <br/>                        <i class="fa fa-spinner fa-spin fa-3x"></i>                    </p>                </div>',
        headerFormTemplate: _.template(' \n                <p style="margin:0px">                    <input title="Header Name"  type="text" class="form-control" name="headerNames"  size="30" value="#rc.headerNames[ i ]#" />                    <input title="Header Value" type="text" class="form-control" name="headerValues" size="50"                           value="<cfif arrayLen( rc.headerValues ) and arrayIsDefined( rc.headerValues, i )>#rc.headerValues[ i ]#</cfif>"/>                    <button class="btn btn-danger btn-sm dynamicRemove" onclick="return false;"><i class="fa fa-remove"></i></button>                </p>            '),
        parameterFormTemplate: _.template('                <p style="margin:0px">                    <input title="Parameter Name"  type="text" class="form-control" name="parameterNames"  size="30" value="#rc.parameterNames[ i ]#" />                    <input title="Parameter Value" type="text" class="form-control" name="parameterValues" size="50"                           value="<cfif arrayLen( rc.parameterValues ) and arrayIsDefined( rc.parameterValues, i )>#rc.parameterValues[ i ]#</cfif>" />                    <button class="btn btn-danger btn-sm dynamicRemove" onclick="return false;"><i class="fa fa-remove"></i></button>                </p>            ')
    });
    return Relaxer;
});
