/*! Copyright 2016 - Ortus Solutions (Compiled: 15-09-2016) */
define([ "Backbone", "views/widgets/relaxer", "views/widgets/sidebar", "models/RelaxAPI", "clipboard", "messenger", "scrollify" ], function(Backbone, Relaxer, SidebarWidget, APIModel, Clipboard, Messenger, scrollify) {
    "use strict";
    var View = Backbone.View.extend({
        el: "#main-content",
        events: {
            "click .btnCopyDocumentLink": "onCopyResourceLink"
        },
        initialize: function() {
            var _this = this;
            _this.Model = APIModel;
            _this.setupDefaults().then(function(model) {
                return _this.setupSelectors().render();
            });
        },
        setupSelectors: function() {
            Messenger.options = {
                extraClasses: "messenger-fixed messenger-on-bottom messenger-on-right",
                theme: "flat"
            };
            return this;
        },
        setupDefaults: function() {
            var _this = this;
            var promise = new Promise(function(resolve, reject) {
                _this.activeAPI = parseRequestParams().api;
                _this.Model.fetch({
                    success: function(model, resp) {
                        _this.availableAPIs = _.clone(model.attributes.apis);
                        if ($(".mc-sidebar").length > 0) {
                            _this.sidebar = new SidebarWidget({
                                view: _this,
                                apis: model.attributes.apis,
                                "default": _.isUndefined(_this.activeAPI) ? model.attributes.default : _this.activeAPI
                            });
                        }
                        _this.defaultAPI = model.attributes.default;
                        if (_.isUndefined(_this.activeAPI)) _this.activeAPI = _this.defaultAPI;
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
            });
            setTimeout(function() {
                _this.renderContainerUI($container);
                _this.assignAnchorLinksToWindow();
                _this.expandHash();
                _this.renderClipboardIndicators();
            }, 1500);
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
        renderClipboardIndicators: function() {
            var _this = this;
            var $clipableLinks = $("#paths .path-panel, #paths .path-panel .method-panel", _this.$el);
            var clipBtnTemplate = _.template('<a href="javascript:void(0)" class="btnCopyDocumentLink btn btn-link text-muted btn-xs pull-left" data-toggle="tooltip" title="Copy link to this resource"><i class="fa fa-link"></i></a>');
            $clipableLinks.each(function() {
                var linkHash = $(this).attr("id");
                var $linkHeader = $(".panel-heading .panel-title", $(this)).first();
                if ($linkHeader.length > 0) {
                    var link = window.location.href;
                    if (window.location.hash.length > 0) {
                        link = link.replace(window.location.hash, "#" + linkHash);
                    } else {
                        link += "#" + linkHash;
                    }
                    var $btn = $linkHeader.prepend(clipBtnTemplate({
                        link: link
                    }));
                    var clipboard = new Clipboard($btn[0], {
                        text: function(trigger) {
                            return link;
                        }
                    });
                    _this.renderContainerUI($linkHeader);
                }
            });
        },
        onCopyResourceLink: function() {
            Messenger().post({
                message: "Resource link copied to your clipboard",
                type: "success",
                showCloseButton: true
            });
        },
        assignAnchorLinksToWindow: function($container) {
            var _this = this;
            if (_.isUndefined($container)) $container = $("body");
            var baseHref = $("base", "head").attr("href");
            $("a", $container).each(function() {
                var $link = $(this);
                if (!_.isUndefined($link.attr("href")) && $link.attr("href").indexOf("#") === 0) {
                    var hash = $link.attr("href");
                    $link.attr("href", window.location.pathname + window.location.search + hash);
                    $link.on("click", function() {
                        if (!$(this).is("[aria-controls]")) {
                            _this.expandHash(hash);
                        }
                    });
                }
            });
        },
        expandHash: function(hash) {
            var _this = this;
            if (_.isUndefined(hash)) hash = window.location.hash;
            if (hash.length > 0) {
                var $hashTarget = $(hash);
                if ($hashTarget.length > 0) {
                    _this.ensureHashTargetVisibility($hashTarget).then(function() {
                        if ($hashTarget.is(".panel") && $hashTarget.find(".in").length === 0) {
                            $hashTarget.find('[data-toggle="collapse"]').click();
                        } else {}
                    });
                }
            }
        },
        ensureHashTargetVisibility: function($hashTarget) {
            var _this = this;
            var promise = new Promise(function(resolve, reject) {
                if ($hashTarget.is(":visible")) return resolve();
                var $domParents = $hashTarget.parentsUntil(".api");
                var totalParents = $domParents.length;
                var i = 1;
                $domParents.each(function() {
                    var $parent = $(this);
                    if ($parent.not(":visible") && ($parent.is(".collapse:not(.in)") || $parent.is(".tab-pane:not(.active)"))) {
                        $('[aria-controls="' + $parent.attr("id") + '"]').click();
                    } else if ($parent.not(":visible")) {
                        $parent.css("display", "block");
                    }
                    i++;
                    if (i === totalParents) {
                        resolve();
                    }
                });
            });
            return promise;
        }
    });
    return new View();
});