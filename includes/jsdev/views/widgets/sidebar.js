/**
* This is the Backbone View extension for MyView
**/
define([
    'Backbone',
    'models/RelaxAPI',
    'models/RelaxerHistory'
],  function(
            Backbone,
            APIModel,
            HistoryModel
        ){
        'use strict';
        var View = Backbone.View.extend({
            el:".mc-sidebar"

            ,events:{
                "change #myAPI":"onSelectAPI",
                "click .btnExportMediaWiki":"onExportMediaWiki",
                "click .btnExportTrac":"onExportTrac",
                "change .relaxerResourceSelector":"onRelaxerResourceSelect"
            }

            /**
            * ----------------------------------------------
            * Initializes this view
            * ----------------------------------------------
            */
            ,initialize:function( options ){
            	var _this = this;

                if( typeof( moduleAPIRoot ) === 'undefined' ) moduleAPIRoot = '/relax/';

                if( !_.isUndefined( options.apis ) ){
                  _this.availableAPIs = options.apis;  
                  _this.defaultAPI = options.default;
                } 

                if( !_.isUndefined( options.view ) ){
                    _this.View = options.view;

                    if( _.isUndefined( _this.View.Model ) ){
                        _this.View.Model = APIModel;  
                    }

                    _this.ViewModel = _this.View.Model;
                }

     			if( typeof( _this.availableAPIs ) === 'undefined' ){
					_this.ViewModel.fetch({
						success:function( model, resp ){
                            _this.availableAPIs = model.attributes.apis;
                            _this.defaultAPI = model.attributes.default;
							return _this.setupDefaults().setupSelectors().render();
						},
						error: function( model, resp ){
							$( "#system-messages" ).append( '<p class="alert alert-danger">An error occurred while attempting to fetch the available APIS.  Please check the console for details.</a>' );
							console.error( resp );
						}
					});     					
     			} else {
     				return _this.setupDefaults().setupSelectors().render();
     			}
            }

            /**
            * ----------------------------------------------
            * Caches the selectors that are used more than once
            * ----------------------------------------------
            */
            ,setupSelectors:function(){

                return this;
            }

            /**
            * ----------------------------------------------
            * Setup some default variables to be used later
            * ----------------------------------------------
            */
            ,setupDefaults:function(){

                return this;
            }

            /**
			* ----------------------------------------------
			* Rendering Methods
			* ----------------------------------------------
			*/
            ,render:function(){
            	var _this = this;

            	_this.renderAPISelectors();

                if( _this.$el.hasClass( 'relaxer-sidebar' ) ){
                    
                    _this.assignAPI( _this.defaultAPI );
                    $( "#myAPI" ).change();
                    _this.initializeRelaxerHistory();
                }

                return this;
            }

            ,renderAPISelectors:function(){
            	var _this = this;
            	if( typeof( _this.availableAPIs ) === 'undefined' ) return;
            	var selectorTemplate = _.template( $( "#api-selector-template" ).html() );
            	$( ".mc-sidebar .api-selector" ).html( selectorTemplate( { "apis":_this.availableAPIs,"defaultAPI":_this.defaultAPI } ) );
            }

            ,renderRelaxerResources:function( api ){
                var _this = this;
                var resourceTemplate = _.template( $( "#relaxer-resources-template" ).html() );
                $( ".relaxer-resources", _this.$el ).html( resourceTemplate( {
                    "api":_this.ViewModel.attributes
                } ) )
                
            }

            ,initializeRelaxerHistory:function(){
                var _this = this;

                if( _.isUndefined( _this.View.HistoryModel ) ){
                    
                    _this.View.HistoryModel = new HistoryModel();

                }

                //when the relaxer history changes, re-render in the sidebar
                _this.View.HistoryModel.on( 'change:history', function(){
                    _this.renderRelaxerHistory();
                });
            }

            ,renderRelaxerHistory:function(){
                var _this = this;

                var historyTemplate = _.template( $( "#relaxer-resources-template" ).html() );
                var $historyContainer = $( ".relaxer-history", _this.el );
               
                $historyContainer.empty().html( historyTemplate( {
                    "history":_this.HistoryModel.attributes.history
                } ) );

            }
            
            /**
			* ----------------------------------------------
			* Event Methods
			* ----------------------------------------------
			*/
            ,assignAPI: function( api ){
                var $selectorOptions = $( "#myAPI options" );
                $selectorOptions.each( function(){
                    var $option = $( this );
                    if( $option.attr( 'value' ) === api ){
                        $option.prop( 'selected',true );
                    }
                } );
            }
            ,onSelectAPI: function( e ){
                var _this = this;
                var $select = $( e.currentTarget );
                var selectedAPI = $select.val();
                _this.ViewModel.set( 'id', selectedAPI );
                if( !_.isUndefined( _this.View.renderLoaderMessage ) ) _this.View.renderLoaderMessage();
                _this.ViewModel.fetch({
                    success:function( model, resp ){
                        console.log( model )
                        
                        if( _this.$el.hasClass( 'relaxer-sidebar' ) ){
                            _this.renderRelaxerResources();
                        } else {
                            _this.View.render();    
                        }

                    },
                    error: function( model, err ){
                        console.error( err );  
                        if( typeof( callback ) !== 'undefined' ){
                            callback( model );
                        }   
                    }
                });
            }

            /**
            * Exporter methods
            **/

            ,onExportTrac: function( e ){
                var _this = this;
                var documentationHTML = $( ".api-content" )[ 0 ].outerHTML;
                $.post( 
                    moduleAPIRoot + "export/trac", 
                    {
                    "content":documentationHTML
                    },
                    function( translationContent ){
                       var $modal = $( "#modal" );
                       var modalContent = '<div class="panel panel-solid-default"><pre>' + translationContent + '</pre></div>';
                       $modal.find( ".modal-header" ).html( 
                        '<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>\
                         <h3><i class="fa fa-lg fa-paw"></i> API Export: Trac </h3>' 
                        );
                       $modal.find( ".modal-body" ).html( _this.exportWrapper( modalContent ) );
                       $modal.modal("show");
                    }
                );
            }

            ,onExportMediaWiki: function( e ){
                var _this = this;
                var documentationHTML = $( ".api-content" )[ 0 ].outerHTML;
                $.post( 
                    moduleAPIRoot + "export/mediawiki", 
                    {
                    "content":documentationHTML
                    },
                    function( translationContent ){
                       var $modal = $( "#modal" );
                       var modalContent = '<div class="panel panel-solid-default"><pre>' + translationContent + '</pre></div>';
                       $modal.find( ".modal-header" ).html( 
                        '<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>\
                         <h3><i class="fa fa-lg fa-code-o"></i> API Export: MediaWiki</h3>' 
                        );
                       $modal.find( ".modal-body" ).html( _this.exportWrapper( modalContent ) );
                       $modal.modal("show");
                    }
                );   
            }

            ,onRelaxerResourceSelect: function( e ){
                var _this = this;
                var $resourceSelector = $( e.currentTarget );
                var resource = $resourceSelector.val().split( ";" );
                var methodName = resource[ 0 ];
                var pathName = resource[ 1 ];
                var apiPath = _this.ViewModel.attributes.paths[ pathName ];
                var apiMethod = apiPath[ methodName ];
                var tierEntry = $( '[name="resourceTier"]' ).val();
                //populate our URL and set the method
                $( '[name="httpResource"]' ).val( tierEntry + pathName );
                var $methodSelect = $( '[name="httpMethod"]' );
                $( 'option', $methodSelect ).each( function(){
                    var $option = $( this );
                    if( methodName.toUpperCase() === $option.val() ) $option.prop( 'selected', true );
                });

                //handle any advanced options or headers specified in the path

            }


            /**
            * ----------------------------------------------
            * Event Methods
            * ----------------------------------------------
            */

            ,exportWrapper: function( exportContent ){
                return '<textarea id="exportContent" class="form-control" rows="20">' + exportContent + '</textarea>';
            }
        });

        return View;
    }
);		