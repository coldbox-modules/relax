/**
* This is the Backbone View extension for Relaxer
**/
define([
    'Backbone',
    'views/widgets/relaxer',
    'models/RelaxAPI'
],  function(
            Backbone,
            RelaxerWidget,
            APIModel
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
                return this.setupSelectors().setupDefaults().render();
            }

            /**
            * ----------------------------------------------
            * Caches the selectors that are used more than once
            * ----------------------------------------------
            */
            ,setupSelectors:function(){
            	var _this = this;
            	_this.$relaxerForm    = $(".relaxerForm", _this.$el);
			    _this.$resultsBox     = $(".relaxerResults", _this.$el);
			    _this.$relaxerHeader  = $(".relaxerHeader", _this.$el);

			    // Dynamic Add
			    $(".dynamicAdd").click(function() {
			        addDynamicItem($(this));
			        return false;
			    });
			    // Removal Dynamic
			    $(".dynamicRemove").click(function() {
			        $container = $(this).parent().parent();
			        $(this).parent().remove();
			        return false;
			    });

                return this;
            }

            /**
            * ----------------------------------------------
            * Setup some default variables to be used later
            * ----------------------------------------------
            */
            ,setupDefaults:function(){
            	if( _.isUndefined( rootAssetPath ) ){
            		var rootAssetPath = '/modules/relax';
            	}

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

 			,onRelaxerSubmit: function( e ){
 				var _this = this;

 				if( !_this.isXML( resp ) ){
 					$( "#resultsPretty" ).text( formatJSONRaw( '#JSStringFormat( prc.results.fileContent)#' ) );
 				}
 			}

			,showBrowserResults: function(){
			    var w = 900, h = 750;
			    var LeftPosition    = ( screen.width )  ? ( screen.width-w )  / 2 : 0;
			    var TopPosition     = ( screen.height ) ? ( screen.height-h ) / 2 : 0;

			    var c = window.open( "", "browserResults", "height="+h+", width="+w+", left="+LeftPosition+", top="+TopPosition+", resizable=yes, scrollbars=yes" );
			    c.document.write( $("#resultsRAW").val() );
			}
			,resourceSelect: function(rData,tier){
			    var resourceID = 0;
			    // tier and URL selection
			    if( rData != 'null' ){
			        var values = rData.split(";");
			        resourceID = values[0];
			        $("#resourceID").val( resourceID );
			        $("#httpResource").val( values[1] );
			    }
			    else{
			        $("#httpResource").val('');
			    }
			    $("#entryTier").val(tier);

			    // Select default HTTP Method
			    selectOption("httpMethod", $resources[resourceID].DEFAULTMETHOD);
			    // Select default Format
			    selectOption("httpFormat", $resources[resourceID].DEFAULTFORMAT);

			    // Check for required parameters
			    var openAdvanced = false;
			    // Clean header values and params
			    cleanHeaders(); cleanParams();
			    $("#httpParameters p").remove();

			    // params required?
			    if ($resources[resourceID].PARAMETERS != null) {
			        $.each($resources[resourceID].PARAMETERS, function(index, objValue){
			            if (objValue.REQUIRED == "true" || objValue.REQUIRED == true) {
			                openAdvanced = true;
			                addDynamicItem($("#addParameterButton"), [objValue.NAME, objValue.DEFAULT]);
			            }
			        });
			    }
			    // headers required?
			    if ($resources[resourceID].HEADERS != null) {
			        $.each($resources[resourceID].HEADERS, function(index, objValue){
			            if (objValue.REQUIRED == "true") {
			                openAdvanced = true;
			                addDynamicItem($("#addHeaderButton"), [objValue.NAME, objValue.DEFAULT]);
			            }
			        });
			    }
			    // open advanced dialog
			    if( openAdvanced ){ $("#advancedSettings").slideDown(); } else { $("#advancedSettings").slideUp(); }
			}
			,cleanHeaders: function(){
			    $("#httpHeaders p").remove();
			}
			,cleanParams: function(){
			    $("#httpParameters p").remove();
			}
			,showResourceHelp: function(){
			    var val = $( "#resourceID" ).val();
			    if( val != "null"){
			        var values = val.split(";");
			        openRemoteModal( '#event.buildLink( prc.xehResourceDoc )#',{
			            resourceID: values[ 0 ]
			        });
			    }

			    return false;
			}
			,addDynamicItem: function(_this, inData){
			    var $trigger  = _this;
			    var fieldType = $trigger.attr("data-type");
			    // turn on the duplicate template on the requested trigger
			    $("#fieldsTemplate").clone(true).attr("id","").insertBefore( $trigger ).toggle();

			    $trigger.prev().find("input").each(function(index){
			        var $this = $(this);
			        var fieldTitle = $this.attr("data-title");
			        var fieldName  = $this.attr("name");

			        $this.attr("title", fieldTitle.replace(/::fieldType::/,fieldType) )
			            .attr("name", fieldName.replace(/::fieldType::/,fieldType));
			        if (inData != null) {
			            $this.val(inData[index]);
			        }
			        $this.tooltip(toolTipSettings);
			    });
			}
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
			,rebuildRequest: function(){
			    var index = $("#requestHistory").val();
			    if( index != "null" ){
			        var item = reqHistory[index].DATA;
			        //console.log(item);

			        $("#advancedSettings").slideDown();
			        // main options
			        selectOption("httpMethod",item.HTTPMETHOD);
			        $("#httpResource").val(item.HTTPRESOURCE);
			        selectOption("httpFormat",item.HTTPFORMAT);
			        // HTTP Auth
			        $("#username").val(item.USERNAME);
			        $("#password").val(item.PASSWORD);
			        // HTTP Proxy
			        $("#httpProxy").val(item.HTTPPROXY);
			        $("#httpProxyPort").val(item.HTTPPROXYPORT);
			        // Clean header values and params
			        cleanHeaders();cleanParams();

			        // headers
			        if (item.HEADERNAMES.toString().length) {
			            var headerNames = item.HEADERNAMES.toString().split(",");
			            var headerValues = item.HEADERVALUES.toString().split(",");
			            $.each(headerNames, function(index, objValue){
			                addDynamicItem($("#addHeaderButton"), [objValue, headerValues[index]]);
			            })
			        }
			        // params
			        if (item.PARAMETERNAMES.toString().length) {
			            var paramNames = item.PARAMETERNAMES.toString().split(",");
			            var paramValues = item.PARAMETERVALUES.toString().split(",");
			            $.each(paramNames, function(index, objValue){
			                addDynamicItem($("#addParameterButton"), [objValue, paramValues[index]]);
			            })
			        }
			        $("#requestHistoryMessages").html("Request Rebuilt!")
			                .slideDown().delay(250).slideUp();
			    }
			}
			,selectOption: function(itemID,data){
			    $("#"+itemID+" option").each(function(index){
			        var $this = $(this);
			        if( $this.val() == data){ $this.attr("selected","selected"); }
			    });
			}
			,submitForm: function(){
			    var $resource = $("#httpResource");
			    // Verify the destination just in case:
			    if( !$resource.val().length ){
			        if( !$resource.hasClass("error") ){
			            $resource.addClass("error");
			        }
			        $resource.focus();
			        alert("The HTTP resource to hit cannot be empty! You are too relaxed!");
			        return;
			    }
			    $('#bottomCenteredBar').slideUp("fast");
			    $('#bottomCenteredLoader').fadeIn("slow");
			    $relaxerForm.submit();
			}
			,advancedSettings: function(){
			    $("#advancedSettings").slideToggle();
			}


			//CFML Function Conversions
			,printDate: function( inDate ){
				return dateFormat( inDate, "medium" ) & " " & timeformat( inDate, "medium" );
			}
			,getTreatedContent: function( content ){
				var rawContent = arguments.content;
				if( isXML( rawContent ) ){
					return xmlHumanReadable( rawContent );
				}
				arguments.content = htmlEditFormat( trim( arguments.content ) );
				arguments.content = Replace( arguments.content, ":{", ":{#chr(13)#", "all" );
				arguments.content = Replace( arguments.content, "}:", "{:#chr(13)#", "all" );
				arguments.content = Replace( arguments.content, ":[", ":[#chr(13)#", "all" );
				arguments.content = Replace( arguments.content, "]:", "]:#chr(13)#", "all" );
				arguments.content = Replace( arguments.content, ',',' ,#chr(13)#', "all" );

				return arguments.content;
			}
			,getBrush: function( content ){
				if( isXML( trim( arguments.content ) ) ){
					return "xml";
				}
				return "js";
			}
			// ,xmlHumanReadable: function( XmlDoc ){
			//     var elem = "";
			//     var result = "";
			//     var tab = "    ";
			//     var att = "";
			//     var i = 0;
			//     var temp = "";
			//     var cr = createObject("java","java.lang.System").getProperty("line.separator");
			    
			// 	arguments.XmlDoc = trim(arguments.XmlDoc);
				
			// 	if( !isXMLDoc(xmlDoc) && !isXML(xmlDoc) ){
			// 		return xmlDoc;
			// 	}
				
			//     if ( isXmlDoc(XmlDoc) ) {
			//         elem = XmlDoc.XmlRoot;//If this is an XML Document, use the root element
			//     } else if ( IsXmlElem(XmlDoc) ) {
			//         elem = XmlDoc;//If this is an XML Document, use it as-as
			//     } else if ( !isXmlDoc(XmlDoc) ) {
			//         XmlDoc = XmlParse(XmlDoc);//Otherwise, try to parse it as an XML string
			//         elem = XmlDoc.XmlRoot;//Then use the root of the resulting document
			//     }
			//     //Now we are just working with an XML element
			//     result = "<#elem.XmlName#";//start with the element name
			//     if ( StructKeyExists(elem,"XmlAttributes") ) {//Add any attributes
			//         for ( att in elem.XmlAttributes ) {
			//             result = '#result# #att#="#XmlFormat(elem.XmlAttributes[att])#"';
			//         }
			//     }
			//     if ( Len(elem.XmlText) || (StructKeyExists(elem,"XmlChildren") && ArrayLen(elem.XmlChildren)) ) {
			//         result = "#result#>#cr#";//Add a carriage return for text/nested elements
			//         if ( Len(Trim(elem.XmlText)) ) {//Add any text in this element
			//             result = "#result##tab##XmlFormat(Trim(elem.XmlText))##cr#";
			//         }
			//         if ( StructKeyExists(elem,"XmlChildren") && ArrayLen(elem.XmlChildren) ) {
			//             for ( i=1; i <= ArrayLen(elem.XmlChildren); i=i+1 ) {
			//                 temp = Trim(XmlHumanReadable(elem.XmlChildren[i]));
			//                 temp = "#tab##ReplaceNoCase(trim(temp), cr, "#cr##tab#", 'ALL')#";//indent
			//                 result = "#result##temp##cr#";
			//             }//Add each nested-element (indented) by using recursive call
			//         }
			//         result = "#result#</#elem.XmlName#>";//Close element
			//     } else {
			//         result = "#result# />";//self-close if the element doesn't contain anything
			//     }
			    
			//     return result;
			// }
            

			//Miscellaneous Templates
            ,loaderMsg:'\
	            <div id="bottomCenteredLoader" style="display:none">\
					<p class="text-center">\
						Sending Request... <br/>\
						<i class="fa fa-spinner fa-spin fa-3x"></i>\
					</p>\
				</div>'

			,headerFormTemplate:_.template( '\ 
				<p style="margin:0px">\
					<input title="Header Name"  type="text" class="form-control" name="headerNames"  size="30" value="#rc.headerNames[ i ]#" />\
					<input title="Header Value" type="text" class="form-control" name="headerValues" size="50"\
						   value="<cfif arrayLen( rc.headerValues ) and arrayIsDefined( rc.headerValues, i )>#rc.headerValues[ i ]#</cfif>"/>\
					<button class="btn btn-danger btn-sm dynamicRemove" onclick="return false;"><i class="fa fa-remove"></i></button>\
				</p>\
			')

			,parameterFormTemplate:_.template( '\
				<p style="margin:0px">\
					<input title="Parameter Name"  type="text" class="form-control" name="parameterNames"  size="30" value="#rc.parameterNames[ i ]#" />\
					<input title="Parameter Value" type="text" class="form-control" name="parameterValues" size="50"\
						   value="<cfif arrayLen( rc.parameterValues ) and arrayIsDefined( rc.parameterValues, i )>#rc.parameterValues[ i ]#</cfif>" />\
					<button class="btn btn-danger btn-sm dynamicRemove" onclick="return false;"><i class="fa fa-remove"></i></button>\
				</p>\
			')

        });

        return new View;
    }
);		