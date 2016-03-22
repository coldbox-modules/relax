/**
* This is the Backbone View extension for MyView
**/
define([
    'Backbone',
    'models/RelaxAPI'
],  function(
            Backbone,
            APIModel
        ){
        'use strict';
        var View = Backbone.View.extend({
            el:".mc-sidebar"

            ,events:{
                "change #myAPI":"onSelectAPI"
            }

            /**
            * ----------------------------------------------
            * Initializes this view
            * ----------------------------------------------
            */
            ,initialize:function( options ){
            	var _this = this;

                if( !_.isUndefined( options.apis ) ){
                  _this.availableAPIs = options.apis;  
                  _this.defaultAPI = options.default;
                } 

                if( !_.isUndefined( options.view ) ){
                    _this.View = options.view;
                    _this.ViewModel = _this.View.Model;
                }

     			if( typeof( _this.availableAPIs ) === 'undefined' ){
					APIModel.fetch({
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
             * Renders UI
             * ----------------------------------------------
             */
            ,render:function(){
            	var _this = this;

            	_this.renderAPISelectors();

                return this;
            }

            ,renderAPISelectors:function(){
            	var _this = this;
            	if( typeof( _this.availableAPIs ) === 'undefined' ) return;

            	var selectorTemplate = _.template( $( "#api-selector-template" ).html() );
            	$( ".mc-sidebar .api-selector" ).html( selectorTemplate( { "apis":_this.availableAPIs,"defaultAPI":_this.defaultAPI } ) );
            }
            
            /**
             * ----------------------------------------------
             * Events
             * ----------------------------------------------
             */
            ,onSelectAPI: function( e ){
                var _this = this;
                var $select = $( e.currentTarget );
                console.log( $select.length );
                console.log( $select.val() );
                var selectedAPI = $select.val();
                _this.ViewModel.set( 'id', selectedAPI );
                _this.View.renderLoaderMessage();
                _this.ViewModel.fetch({
                    success:function( model, resp ){

                        _this.View.render();
                    },
                    error: function( model, err ){
                        console.error( err );     
                    }
                });
            }
            

        });

        return View;
    }
);		