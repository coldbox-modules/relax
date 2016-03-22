/**
* This is the Relaxer History Model
* It allows the tracking and persistence of relaxer request/reponse actions
**/
define([
    'Backbone'
],  function(
            Backbone
        ){
        'use strict';
        var Model = Backbone.Model.extend({
            urlRoot: ''
            ,fetch:function(){return false;}
            ,sync:function(){return false;}
            /**
            * ----------------------------------------------
            * Initializes this model
            * ----------------------------------------------
            */
            ,initialize:function(attributes,options){
            	this.set( 'history', [] );
                if(typeof(attributes) !== 'undefined') this.set(attributes);
                return this;
            }            

        });

        return Model;
    }
);		