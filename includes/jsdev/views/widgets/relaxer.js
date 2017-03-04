/**
* This is the Backbone View For Relaxer
**/
define(
    /**
    * RequireJS Resources loaded in this view.  
    * If not avaialable in the globals file, they will be loaded via HTTP request before the View is instantiated
    **/
    [
    'Backbone',
    'models/RelaxerHistory'
    ],  
    /**
    * Function arguments are the local resource variables for the above
    **/
    function(
            Backbone,
            HistoryModel
        ){
        'use strict';
        var Relaxer = Backbone.View.extend({
            //The jQuery scope for this view
            el:".relaxer"

            /**
            * ----------------------------------------------
            * Event bindings
            * ----------------------------------------------
            */
            //event bindings - restricted to the scope of `this.el` ( DOM selector ) or `this.$el` ( jQuery object )
            ,events:{
                "click .dynamicAdd"             : "onAddDynamicItem",
                "click .dynamicRemove"          : "onRemoveDynamicItem",
                "click .btnSendRequest"         : "onRelaxerSend",
                "click .relaxer-resource-info"  : "onDisplayResourceInfo"
            }
            /**
            * ----------------------------------------------
            * Initializes this view
            * ----------------------------------------------
            */
            ,initialize:function( options ){
                var _this = this;

                if( _.isUndefined( rootAssetPath ) ){
                    _this.baseHref = '/modules/relax';
                } else {
                    _this.baseHref = rootAssetPath;
                }
                
                if( !_.isUndefined( options ) ){
                    _.each( _.keys( options ), function( optionKey ){
                        _this[ optionKey ] = options[ optionKey ];
                    });
                }

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
                var _this = this;
                _this.HistoryModel = new HistoryModel();
                _this.relaxerFormTemplate = _.template( $( "#relaxer-form-template" ).html() );
                _this.relaxerResponseTemplate = _.template( $( "#relaxer-response-template" ).html() );

                return this;
            }

            /**
			* ----------------------------------------------
			* Renders UI
			* ----------------------------------------------
			*/
            ,render:function(){
                var _this = this;
                var relaxerFormData = _this.getRelaxerFormData();
                $( ".relaxer-form", _this.el ).html( _this.relaxerFormTemplate( relaxerFormData ) );
                _this.onRelaxerRendered();
                return _this.this;
            }

            /**
            * Renders the Relaxer response
            * @param jqXHR          The response jqXHR object
            * @param textStatus     The response text status
            **/
            ,renderRelaxerResponse:function( jqXHR, textStatus ){
                var _this = this;
                var $container = $( ".relaxer-results", _this.$el );

                var responseEcho = JSON.parse( jqXHR.responseText );
                
                console.debug( responseEcho );

                if( typeof( responseEcho.status_code ) === 'undefined' ){

                    var errorMessage = responseEcho.errordetail ? responseEcho.errordetail : responseEcho.error;
                    $container.html('<div class="clearfix"></div>');
                    $container.after( '<p id="relaxer-response-error" class="alert alert-danger">There was an error servicing your request.  The response received was: <em>' +errorMessage+ '</em></p>' )
                    
                } else {

                    //reformat our echo to emulate a jqXHR object
                    var responseObject = {
                        "status": responseEcho.status_code,
                        "statusText": responseEcho.status_text,
                        "responseText": responseEcho.filecontent,
                        getAllResponseHeaders: function(){ 
                            return responseEcho.responseheader;
                        },
                        getResponseHeader: function( headerName ){
                            return responseEcho.responseheader[ headerName ];
                        }
                    }

                    $container.html( _this.relaxerResponseTemplate( {"response":responseObject} ) );
                    _this.renderContainerUI( $container );
   
                }
            }


            /**
            * Data Marshalling
            **/
            ,getRelaxerFormData: function(){
                var _this = this;
                var relaxerData = {
                    
                    "api":_this.APIDocument,
                    
                    "relaxer":{
                        "method":"",
                        "endpoint":"",
                        "extensionDetection":false    
                    }
                }

                return relaxerData;
            }
            
            /**
			* ----------------------------------------------
			* Events
			* ----------------------------------------------
			*/
            ,onRelaxerRendered: function(){
                var _this = this;
                _this.$relaxerForm    = $(".relaxerForm", _this.$el);
                _this.$resultsBox     = $(".relaxerResults", _this.$el);
                _this.$relaxerHeader  = $(".relaxerHeader", _this.$el);

            }

            /**
            * Relax send event
            * @param e      The event object
            **/
            ,onRelaxerSend: function( e ){
                var _this = this;
                var $btn = $( e.currentTarget );

                $( "#relaxer-response-error" ).remove();
                
                //save our html so we can use it when the request is done
                var btnDefaultHTML = $btn.html();
                $btn.find( 'i' ).removeClass( 'fa-paper-plane' ).addClass( 'fa-spin fa-spinner' );
                if( $( ".advancedSettings", _this.$el ).hasClass( "in" ) ) $( ".advancedSettings", _this.$el ).removeClass( "in" );
                //show the loader
                $( ".relaxer-results", _this.$el ).html( _this.loaderMsg );
                
                var _this = this;
                var relaxerRequest = _this.marshallRelaxerRequest();

                var relaxerOptions = {
                    url: '/relax/relaxer/send',
                    method: "POST",
                    data: JSON.stringify( relaxerRequest ),
                    complete: function( jqXHR, textStatus ){
                        $btn.html( btnDefaultHTML );
                        _this.renderRelaxerResponse( jqXHR, textStatus );
                        _this.HistoryModel.attributes.history.push( {
                             "request":relaxerRequest,
                             "response":jqXHR
                         } );
                    }
                };
                relaxerOptions.error = relaxerOptions.success;

                $.ajax( relaxerOptions ); 
            }

            /**
            * Dynamic object addition event
            * @param e      The event object
            **/
            ,onAddDynamicItem: function( e ){
                return this.addDynamicItem( $(e.currentTarget) )
            }

            /**
            * Dynamic object removal
            * @param e      The event object
            **/
            ,onRemoveDynamicItem: function( e ){
                var $btn = $( e.currentTarget );
                var $field = $btn.closest( '.dynamicField' );
                $field.fadeOut( 300, function(){
                    $field.remove();
                });
            }

            ,onDisplayResourceInfo:function( e ){
                var _this = this;
                var $btn = $( e.currentTarget );
                var infoPath = $btn.data( 'path' );


            }
            
            /**
            * Marshalls the relaxer response for the view
            **/
            ,marshallRelaxerRequest: function(){
                var _this = this;
                var request = {
                    resource : $( '[name="httpResource"]', _this.$relaxerForm ).val(),
                    method : $( '[name="httpMethod"]', _this.$relaxerForm ).val(),
                    headers : {},
                    data : {}
                }

                if( $( '[name="httpAccept"]', _this.$relaxerForm ).length > 0 ){
                    request.accepts = $( '[name="httpAccept"]', _this.$relaxerForm ).val();
                }

                if( $( '[name="httpProxy"]', _this.$relaxerForm ).val().length > 0 ){
                    request.httpProxy = $( '[name="httpProxy"]', _this.$relaxerForm ).val();
                }

                if( $( '[name="username"]', _this.$relaxerForm ).val().length > 0 ){
                    request.authUsername = $( '[name="username"]', _this.$relaxerForm ).val();
                }

                if( $( '[name="password"]', _this.$relaxerForm ).val().length > 0 ){
                    request.authPassword = $( '[name="username"]', _this.$relaxerForm ).val();
                }
                
                $( ".requestHeaders", _this.$relaxerForm ).find(".dynamicField").each( function(){
                    var $headerContainer = $( this );
                    request.headers[ $headerContainer.find( '[name="headerName"]' ).val() ] = $headerContainer.find( '[name="headerValue"]' ).val();
                });
                
                $( ".requestParams", _this.$relaxerForm ).find(".dynamicField").each( function(){
                    var $paramContainer = $( this );
                    request.data[ $paramContainer.find( '[name="parameterName"]' ).val() ] = $paramContainer.find( '[name="parameterValue"]' ).val();
                });

                return request;
            }

            /**
            * Adds a dynamic item to the headers or params
            * @param $trigger      The button used to fire the addition
            * @param inData        Any data which should populate the dynamic item
            **/
            ,addDynamicItem: function( $trigger, inData){
                var fieldType = $trigger.attr("data-type");
                var fieldsTemplate = _.template( $( "#dynamicFieldsTemplate" ).html() );
                $trigger.before( fieldsTemplate( {
                    "field":_.isUndefined( inData )?{}:inData,
                    "fieldType":fieldType
                } ) );
            }

            ,renderHistory: function(){
                $("#historyLoader").fadeIn();
                $("#requestHistoryContainer").css("opacity",".5");
            }

            /**
            * Clears the relaxer history
            **/
            ,clearHistory: function(){
                //activate spinners
                $("#historyLoader").fadeIn();
                $("#requestHistoryContainer").css("opacity",".5");
                // clean history
                $.post( '#event.buildLink( prc.xehPurgeHistory )#',{},
                       function(response){
                        // deactivate spinner
                        $("#historyLoader").fadeOut();
                        $("#requestHistoryContainer").css("opacity","1");
                        // setup message
                        $("#requestHistoryMessages").html(response.messages)
                            .slideDown().delay(1500).slideUp();
                        // Check if we can remove it
                        if(!response.error){
                            $('#requestHistory')
                                .empty()
                                .append('<option value="null">No History</option>');
                        }
                       },
                       "json");
            }

            /**
            * Renders the default container UI
            * @param $container      The target container
            **/
            ,renderContainerUI: function( $container ){
                var _this = this;
                $( '[data-toggle="tooltip"]', $container ).each( function(){
                    $( this ).tooltip();
                });
                $( 'pre[class*="language-"],code[class*="language-"]' ).each( function(){
                    Prism.highlightElement(this); 
                });
            }
            
            //Miscellaneous Templates
            ,loaderMsg:'\
                <div id="bottomCenteredLoader">\
                    <p class="text-center">\
                        Sending Request... <br/>\
                        <i class="fa fa-spinner fa-spin fa-3x"></i>\
                    </p>\
                </div>'

        });

        return Relaxer;
    }
);		