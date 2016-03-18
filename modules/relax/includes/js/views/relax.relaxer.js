/*! Copyright 2016 - Ortus Solutions (Compiled: 18-03-2016) */
define([ "Backbone", "views/widgets/relaxer", "models/RelaxAPI" ], function(Backbone, RelaxerWidget, APIModel) {
    "use strict";
    var View = Backbone.View.extend({
        el: ".main-content",
        events: {},
        initialize: function() {
            return this.setupSelectors().setupDefaults().render();
        },
        setupSelectors: function() {
            var _this = this;
            _this.$relaxerForm = $(".relaxerForm", _this.$el);
            _this.$resultsBox = $(".relaxerResults", _this.$el);
            _this.$relaxerHeader = $(".relaxerHeader", _this.$el);
            $(".dynamicAdd").click(function() {
                addDynamicItem($(this));
                return false;
            });
            $(".dynamicRemove").click(function() {
                $container = $(this).parent().parent();
                $(this).parent().remove();
                return false;
            });
            return this;
        },
        setupDefaults: function() {
            if (_.isUndefined(rootAssetPath)) {
                var rootAssetPath = "/modules/relax";
            }
            return this;
        },
        render: function() {
            $('pre[class*="language-"],code[class*="language-"]').each(function() {
                Prism.highlightElement(this);
            });
            return this;
        },
        onRelaxerSubmit: function(e) {
            var _this = this;
            if (!_this.isXML(resp)) {
                $("#resultsPretty").text(formatJSONRaw("#JSStringFormat( prc.results.fileContent)#"));
            }
        },
        showBrowserResults: function() {
            var w = 900, h = 750;
            var LeftPosition = screen.width ? (screen.width - w) / 2 : 0;
            var TopPosition = screen.height ? (screen.height - h) / 2 : 0;
            var c = window.open("", "browserResults", "height=" + h + ", width=" + w + ", left=" + LeftPosition + ", top=" + TopPosition + ", resizable=yes, scrollbars=yes");
            c.document.write($("#resultsRAW").val());
        },
        resourceSelect: function(rData, tier) {
            var resourceID = 0;
            if (rData != "null") {
                var values = rData.split(";");
                resourceID = values[0];
                $("#resourceID").val(resourceID);
                $("#httpResource").val(values[1]);
            } else {
                $("#httpResource").val("");
            }
            $("#entryTier").val(tier);
            selectOption("httpMethod", $resources[resourceID].DEFAULTMETHOD);
            selectOption("httpFormat", $resources[resourceID].DEFAULTFORMAT);
            var openAdvanced = false;
            cleanHeaders();
            cleanParams();
            $("#httpParameters p").remove();
            if ($resources[resourceID].PARAMETERS != null) {
                $.each($resources[resourceID].PARAMETERS, function(index, objValue) {
                    if (objValue.REQUIRED == "true" || objValue.REQUIRED == true) {
                        openAdvanced = true;
                        addDynamicItem($("#addParameterButton"), [ objValue.NAME, objValue.DEFAULT ]);
                    }
                });
            }
            if ($resources[resourceID].HEADERS != null) {
                $.each($resources[resourceID].HEADERS, function(index, objValue) {
                    if (objValue.REQUIRED == "true") {
                        openAdvanced = true;
                        addDynamicItem($("#addHeaderButton"), [ objValue.NAME, objValue.DEFAULT ]);
                    }
                });
            }
            if (openAdvanced) {
                $("#advancedSettings").slideDown();
            } else {
                $("#advancedSettings").slideUp();
            }
        },
        cleanHeaders: function() {
            $("#httpHeaders p").remove();
        },
        cleanParams: function() {
            $("#httpParameters p").remove();
        },
        showResourceHelp: function() {
            var val = $("#resourceID").val();
            if (val != "null") {
                var values = val.split(";");
                openRemoteModal("#event.buildLink( prc.xehResourceDoc )#", {
                    resourceID: values[0]
                });
            }
            return false;
        },
        addDynamicItem: function(_this, inData) {
            var $trigger = _this;
            var fieldType = $trigger.attr("data-type");
            $("#fieldsTemplate").clone(true).attr("id", "").insertBefore($trigger).toggle();
            $trigger.prev().find("input").each(function(index) {
                var $this = $(this);
                var fieldTitle = $this.attr("data-title");
                var fieldName = $this.attr("name");
                $this.attr("title", fieldTitle.replace(/::fieldType::/, fieldType)).attr("name", fieldName.replace(/::fieldType::/, fieldType));
                if (inData != null) {
                    $this.val(inData[index]);
                }
                $this.tooltip(toolTipSettings);
            });
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
        rebuildRequest: function() {
            var index = $("#requestHistory").val();
            if (index != "null") {
                var item = reqHistory[index].DATA;
                $("#advancedSettings").slideDown();
                selectOption("httpMethod", item.HTTPMETHOD);
                $("#httpResource").val(item.HTTPRESOURCE);
                selectOption("httpFormat", item.HTTPFORMAT);
                $("#username").val(item.USERNAME);
                $("#password").val(item.PASSWORD);
                $("#httpProxy").val(item.HTTPPROXY);
                $("#httpProxyPort").val(item.HTTPPROXYPORT);
                cleanHeaders();
                cleanParams();
                if (item.HEADERNAMES.toString().length) {
                    var headerNames = item.HEADERNAMES.toString().split(",");
                    var headerValues = item.HEADERVALUES.toString().split(",");
                    $.each(headerNames, function(index, objValue) {
                        addDynamicItem($("#addHeaderButton"), [ objValue, headerValues[index] ]);
                    });
                }
                if (item.PARAMETERNAMES.toString().length) {
                    var paramNames = item.PARAMETERNAMES.toString().split(",");
                    var paramValues = item.PARAMETERVALUES.toString().split(",");
                    $.each(paramNames, function(index, objValue) {
                        addDynamicItem($("#addParameterButton"), [ objValue, paramValues[index] ]);
                    });
                }
                $("#requestHistoryMessages").html("Request Rebuilt!").slideDown().delay(250).slideUp();
            }
        },
        selectOption: function(itemID, data) {
            $("#" + itemID + " option").each(function(index) {
                var $this = $(this);
                if ($this.val() == data) {
                    $this.attr("selected", "selected");
                }
            });
        },
        submitForm: function() {
            var $resource = $("#httpResource");
            if (!$resource.val().length) {
                if (!$resource.hasClass("error")) {
                    $resource.addClass("error");
                }
                $resource.focus();
                alert("The HTTP resource to hit cannot be empty! You are too relaxed!");
                return;
            }
            $("#bottomCenteredBar").slideUp("fast");
            $("#bottomCenteredLoader").fadeIn("slow");
            $relaxerForm.submit();
        },
        advancedSettings: function() {
            $("#advancedSettings").slideToggle();
        },
        printDate: function(inDate) {
            return dateFormat(inDate, "medium") & " " & timeformat(inDate, "medium");
        },
        getTreatedContent: function(content) {
            var rawContent = arguments.content;
            if (isXML(rawContent)) {
                return xmlHumanReadable(rawContent);
            }
            arguments.content = htmlEditFormat(trim(arguments.content));
            arguments.content = Replace(arguments.content, ":{", ":{#chr(13)#", "all");
            arguments.content = Replace(arguments.content, "}:", "{:#chr(13)#", "all");
            arguments.content = Replace(arguments.content, ":[", ":[#chr(13)#", "all");
            arguments.content = Replace(arguments.content, "]:", "]:#chr(13)#", "all");
            arguments.content = Replace(arguments.content, ",", " ,#chr(13)#", "all");
            return arguments.content;
        },
        getBrush: function(content) {
            if (isXML(trim(arguments.content))) {
                return "xml";
            }
            return "js";
        },
        loaderMsg: '	            <div id="bottomCenteredLoader" style="display:none">					<p class="text-center">						Sending Request... <br/>						<i class="fa fa-spinner fa-spin fa-3x"></i>					</p>				</div>',
        headerFormTemplate: _.template(' \n				<p style="margin:0px">					<input title="Header Name"  type="text" class="form-control" name="headerNames"  size="30" value="#rc.headerNames[ i ]#" />					<input title="Header Value" type="text" class="form-control" name="headerValues" size="50"						   value="<cfif arrayLen( rc.headerValues ) and arrayIsDefined( rc.headerValues, i )>#rc.headerValues[ i ]#</cfif>"/>					<button class="btn btn-danger btn-sm dynamicRemove" onclick="return false;"><i class="fa fa-remove"></i></button>				</p>			'),
        parameterFormTemplate: _.template('				<p style="margin:0px">					<input title="Parameter Name"  type="text" class="form-control" name="parameterNames"  size="30" value="#rc.parameterNames[ i ]#" />					<input title="Parameter Value" type="text" class="form-control" name="parameterValues" size="50"						   value="<cfif arrayLen( rc.parameterValues ) and arrayIsDefined( rc.parameterValues, i )>#rc.parameterValues[ i ]#</cfif>" />					<button class="btn btn-danger btn-sm dynamicRemove" onclick="return false;"><i class="fa fa-remove"></i></button>				</p>			')
    });
    return new View();
});