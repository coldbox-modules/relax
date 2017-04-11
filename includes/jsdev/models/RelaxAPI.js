/**
* This is the Backbone Model for Relax APIDocs
**/
define([
    'Backbone'
],  function(
            Backbone
        ){
        'use strict';
        var Model = Backbone.Model.extend({
            /**
            * The API Path of the model ( sans the ID value )
            */
            urlRoot: window.relax.apiDocBaseUrl
            /**
            * ----------------------------------------------
            * Initializes this model
            * ----------------------------------------------
            */
            ,initialize:function( attributes, options ){
            	
            	if( typeof( moduleAPIRoot ) === 'undefined' ) moduleAPIRoot = window.relax.baseUrl;
            	
                this.urlRoot = moduleAPIRoot + 'apidoc';

                if(typeof(attributes) !== 'undefined') this.set(attributes);
                return this;
            }            

        });

        return new Model;
    }
);
      