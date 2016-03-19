/**
* This is the Backbone View extension for Relaxer
**/
define([
    'Backbone',
    'views/widgets/relaxer',
    'views/widgets/sidebar',
    'models/RelaxAPI'
],  function(
            Backbone,
            RelaxerWidget,
            SidebarWidget,
            APIModel
        ){
        'use strict';
        var View = Backbone.View.extend({
            el: '#main-content'
            
            ,events:{
            }

            /**
            * ----------------------------------------------
            * Initializes this view
            * ----------------------------------------------
            */
            ,initialize:function(){
                return this.setupSelectors().setupDefaults().render();
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
                var _this = this;
            	if( _.isUndefined( rootAssetPath ) ){
            		var rootAssetPath = '/modules/relax';
            	}

                _this.sidebar = new SidebarWidget( {
                    "view":_this
                });

                var $relaxer = $( ".relaxer", _this.el );
                
                _this.Relaxer = new RelaxerWidget({
                    "el":".relaxer",
                    "$el":$relaxer
                });

    
                return this;
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