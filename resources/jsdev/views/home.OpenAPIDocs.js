/**
* This is the Backbone View extension
**/
define([
    'Backbone'
],  function(
            Backbone
        ){
        'use strict';
        var View = Backbone.View.extend({
            el:".main-content"

            ,events:{

            }

            /**
            * ----------------------------------------------
            * Initializes this view
            * ----------------------------------------------
            */
            ,initialize:function(){
                return this.setupDefaults().setupSelectors().render();
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
            	$( 'pre[class*="language-"],code[class*="language-"]' ).each( function(){
                    Prism.highlightElement(this); 
                });
                return this;
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