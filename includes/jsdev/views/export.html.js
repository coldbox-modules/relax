/**
* This is the Backbone View extension for HTML Exports
**/
define([
    'Backbone',
    'clipboard',
    'messenger',
    'views/home.index'
],  function(
            Backbone,
            Clipboard,
            Messenger,
            APIView
        ){
        'use strict';
        var View = Backbone.View.extend({
            el:"body"

            ,events:{
            	"click #btnCopyGeneratedSource": "onCopySource"
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
                
                var $clipButton = $( "#btnCopyGeneratedSource" );

                var clipboard = new Clipboard( $clipButton[0], {
                    text: function(trigger) {
                        return $( "html" )[ 0 ].outerHTML;
                    }
                } );

                $clipButton.tooltip();


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
 			,onCopySource: function( e ){
 				var _this = this;

                Messenger().post({
                    message: "HTML Copied to your clipboard",
                    type: 'success',
                    showCloseButton: true
                });
		

 			}
            
            

        });

        return new View;
    }
);		