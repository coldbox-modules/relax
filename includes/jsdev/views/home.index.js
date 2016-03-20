/**
* This is the Backbone View for the Relax home
**/
define([
    'Backbone',
    'views/widgets/relaxer',
    'views/widgets/sidebar',
    'models/RelaxAPI',
    'scrollify'
],  function(
            Backbone,
            Relaxer,
            SidebarWidget,
            APIModel,
            scrollify
        ){
        'use strict';
        var View = Backbone.View.extend({
            el:"#main-content"

            /**
            * ----------------------------------------------
            * Event bindings
            * ----------------------------------------------
            */
            ,events:{

            }

            /**
            * ----------------------------------------------
            * Initializes this view
            * ----------------------------------------------
            */
            ,initialize: function(){
                var _this = this;
                _this.Model = APIModel;
                _this.setupDefaults().then( function( model ){
                    return _this.setupSelectors().render();
                
                });
            }

            /**
            * ----------------------------------------------
            * Caches the selectors that are used more than once
            * ----------------------------------------------
            */
            ,setupSelectors: function(){
                return this;
            }

            /**
            * ----------------------------------------------
            * Setup some default variables to be used later
            * ----------------------------------------------
            */
            ,setupDefaults: function(){
                var _this = this;
                var promise = new Promise( function( resolve, reject ){
                    _this.activeAPI = parseRequestParams().api;
                    //pull our list of APIs
                    _this.Model.fetch( {
                        success: function( model, resp ){
                            _this.availableAPIs = _.clone(model.attributes.apis);
                            //instantiate the sidebar
                            if( $( ".mc-sidebar" ).length > 0 ){
                                
                                _this.sidebar = new SidebarWidget( {
                                    "view":_this,
                                    "apis":model.attributes.apis,
                                    "default": _.isUndefined( _this.activeAPI ) ? model.attributes.default : _this.activeAPI   
                                } );   
                                
                            }

                            _this.defaultAPI = model.attributes.default;

                            if( _.isUndefined( _this.activeAPI ) ) _this.activeAPI = _this.defaultAPI;
                            
                            //pull our single API
                            _this.Model.clear().set( 'id', _this.activeAPI );
                            _this.Model.fetch({
                                success: function( model, resp ){
                                    return resolve( _this.Model );
                                }
                                ,error: function( model, err ){
                                    console.debug( "API Load failed" );
                                    console.debug( err );
                                    return reject( _this.Model );
                                }   
                            });

                        }
                        ,error: function( model, resp ){
                            return reject( _this.Model );
                        }
                    }); 
                });

                return promise;
            }

            /**
			* ----------------------------------------------
			* Renders UI
			* ----------------------------------------------
			*/
            ,render: function(){
                var _this = this;
                _this.renderLoaderMessage();
                _this.renderAPIDocumentation();

                return this;
            }

            ,renderLoaderMessage: function(){
                var _this = this;
                var APITitle = _this.availableAPIs[ _this.Model.get( 'id' ) ].title;
                var loaderMessage = '<div id="mc-loader" class="text-center">\
                    <h4 class="text-muted">Loading API <em>' + APITitle + '</em>...</h4>\
                    <p>\
                        <i class="fa fa-spin fa-spinner fa-2x text-muted"></i>\
                    </p>\
                </div>';
                $( ".api-content", "#main-content").html( loaderMessage );

            }

            ,renderAPIDocumentation: function(){
                var _this = this;
                var APIDoc = _this.Model.attributes;
                var contentTemplate = _.template( $( "#api-content-template" ).html() );
                $( ".api-content", _this.el ).html( contentTemplate( { "api": APIDoc } ) );

                _this.renderPaths( APIDoc.paths, $( ".paths-content" ,$( ".api-content", _this.el ) ) );

            }

            ,renderPaths: function( paths, $container ){
                var _this = this;
                var pathTemplate = _.template( $( "#path-template" ).html() );
                _.each( _.keys(paths), function( pathKey ){ 
                    $container.append( pathTemplate( { "key":pathKey , "path":paths[ pathKey ] } ) );
                    setTimeout( function(  ){
                        _this.renderContainerUI( $container );
                        _this.assignAnchorLinksToWindow();
                        _this.expandHash();
                    }, 1500)
                });
            }
            
            ,renderContainerUI: function( $container ){
                var _this = this;
                $( '[data-toggle="tooltip"]', $container ).each( function(){
                    $( this ).tooltip();
                });
                $( 'pre[class*="language-"],code[class*="language-"]' ).each( function(){
                    Prism.highlightElement(this); 
                });
            }

            ,assignAnchorLinksToWindow: function( $container ){
                var _this = this;
                if( _.isUndefined( $container ) ) $container = $( 'body' );
                var baseHref = $( 'base', 'head' ).attr( 'href' );
                $( "a", $container ).each( function(){
                   var $link = $( this );
                   if( !_.isUndefined( $link.attr( 'href' ) ) && $link.attr( 'href' ).indexOf( "#" ) === 0  ){
                       var hash = $link.attr( 'href' );
                       $link.attr( 'href', window.location.pathname + window.location.search + hash );
                       $link.on( 'click', function(  ){
                            if( !$( this ).is( '[aria-controls]' ) ){
                                _this.expandHash( hash );   
                            }
                       } );
                   }
                });
            }

            ,expandHash: function( hash ){
                var _this = this;
                if( _.isUndefined( hash ) ) hash = window.location.hash;
                if( hash.length > 0 ){
                    var $hashTarget = $( hash );
                    if( $hashTarget.length > 0 ){
                        _this.ensureHashTargetVisibility( $hashTarget ).then(function(){
                            if( $hashTarget.is( '.panel' ) ){
                                $hashTarget.find( '[data-toggle="collapse"]' ).click().scrollify({offset:200}).move( $hashTarget );
                            } else {
                                $.scrollify({offset:200}).move( $hashTarget );
                            }
                        });

                    }
                }
            }

            ,ensureHashTargetVisibility: function( $hashTarget ){
                var _this = this;
                var promise = new Promise( function( resolve, reject ){
                    if( $hashTarget.is(":visible") ) return resolve();

                    //recurse up to the top level container
                    var $domParents = $hashTarget.parentsUntil( ".api" );
                    console.log( $domParents );

                    var totalParents = $domParents.length;
                    var i = 1;
                    $domParents.each( function(){
                        var $parent = $( this );
                        if( $parent.not( ":visible" ) && ( $parent.is( ".collapse:not(.in)" ) || $parent.is( '.tab-pane:not(.active)' ) ) ){ 
                            $( '[aria-controls="' + $parent.attr( 'id' ) + '"]' ).click();
                        } else if( $parent.not( ":visible" ) ) {
                            $parent.css( 'display', 'block' );
                        }

                        i++;

                        if( i === totalParents ){
                            resolve();      
                        }
                    });

                });

                return promise;
            }

            /**
			* ----------------------------------------------
			* Events
			* ----------------------------------------------
			*/



            
            

        });

        return new View;
    }
);		