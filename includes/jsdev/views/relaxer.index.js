/**
* This is the Backbone View extension for Relaxer
**/
define(
    /**
    * RequireJS Resources loaded in this view.  
    * If not avaialable in the globals file, they will be loaded via HTTP request before the View is instantiated
    **/
    [
    'Backbone',
    'views/widgets/relaxer',
    'views/widgets/sidebar',
    'models/RelaxAPI'
    ],  
    /**
    * Function arguments are the local resource variables for the above
    **/
    function(
            Backbone,
            RelaxerWidget,
            SidebarWidget,
            APIModel
        ){
        'use strict';
        var View = Backbone.View.extend({
            //The jQuery scope for this view
            el: '#main-content'
            
            //event bindings - restricted to the scope of `this.el` ( DOM selector ) or `this.$el` ( jQuery object )
            ,events:{
            }

            /**
            * ----------------------------------------------
            * Initializes this view
            * ----------------------------------------------
            */
            ,initialize:function(){

                var _this = this;
                
                _this.Model = APIModel;
                
                _this.setupDefaults().then( function( model ){
                    return _this.setupSelectors().render();
                });
            }

            /**
            * ----------------------------------------------
            * Sets up the selectors that are used more than once in this view
            * ----------------------------------------------
            */
            ,setupSelectors:function(){
                return this;
            }

            /**
            * ----------------------------------------------
            * Setup the default variables used in this view
            * ----------------------------------------------
            */
            ,setupDefaults:function(){
                var _this = this;
            	if( _.isUndefined( rootAssetPath ) ){
            		var rootAssetPath = '/modules/relax';
            	}

                var promise = new Promise( function( resolve, reject ){
                    _this.activeAPI = parseRequestParams().api;
                    //pull our list of APIs
                    _this.Model.fetch( {
                        success: function( model, resp ){
                            _this.activeAPI = parseRequestParams().api;

                            _this.sidebar = new SidebarWidget( {
                                "view"      : _this,
                                "apis"      : model.attributes.apis,
                                "default"   : _.isUndefined( _this.activeAPI ) ? model.attributes.default : _this.activeAPI
                            });

                            var $relaxer = $( ".relaxer", _this.el );
                            
                            _this.Relaxer = new RelaxerWidget({
                                "el":".relaxer",
                                "$el":$relaxer
                            });

                
                            return resolve( _this.Model );
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
            ,render:function(){
            	var _this = this;
                return _this;
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