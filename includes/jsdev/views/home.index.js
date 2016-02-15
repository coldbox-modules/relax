/**
* This is the Backbone View for the Relax home
**/
define([
    'Backbone'
],  function(
            Backbone
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