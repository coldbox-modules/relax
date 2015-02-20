<cfscript>
function printDate( inDate ){
	return dateFormat( inDate, "medium" ) & " " & timeformat( inDate, "medium" );
}
function getTreatedContent( required content ){
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
function getBrush( required content ){
	if( isXML( trim( arguments.content ) ) ){
		return "xml";
	}
	return "js";
}
function xmlHumanReadable( required XmlDoc ){
    var elem = "";
    var result = "";
    var tab = "    ";
    var att = "";
    var i = 0;
    var temp = "";
    var cr = createObject("java","java.lang.System").getProperty("line.separator");
    
	arguments.XmlDoc = trim(arguments.XmlDoc);
	
	if( NOT isXMLDoc(xmlDoc) AND NOT isXML(xmlDoc) ){
		return xmlDoc;
	}
	
    if ( isXmlDoc(XmlDoc) ) {
        elem = XmlDoc.XmlRoot;//If this is an XML Document, use the root element
    } else if ( IsXmlElem(XmlDoc) ) {
        elem = XmlDoc;//If this is an XML Document, use it as-as
    } else if ( NOT isXmlDoc(XmlDoc) ) {
        XmlDoc = XmlParse(XmlDoc);//Otherwise, try to parse it as an XML string
        elem = XmlDoc.XmlRoot;//Then use the root of the resulting document
    }
    //Now we are just working with an XML element
    result = "<#elem.XmlName#";//start with the element name
    if ( StructKeyExists(elem,"XmlAttributes") ) {//Add any attributes
        for ( att in elem.XmlAttributes ) {
            result = '#result# #att#="#XmlFormat(elem.XmlAttributes[att])#"';
        }
    }
    if ( Len(elem.XmlText) OR (StructKeyExists(elem,"XmlChildren") AND ArrayLen(elem.XmlChildren)) ) {
        result = "#result#>#cr#";//Add a carriage return for text/nested elements
        if ( Len(Trim(elem.XmlText)) ) {//Add any text in this element
            result = "#result##tab##XmlFormat(Trim(elem.XmlText))##cr#";
        }
        if ( StructKeyExists(elem,"XmlChildren") AND ArrayLen(elem.XmlChildren) ) {
            for ( i=1; i lte ArrayLen(elem.XmlChildren); i=i+1 ) {
                temp = Trim(XmlHumanReadable(elem.XmlChildren[i]));
                temp = "#tab##ReplaceNoCase(trim(temp), cr, "#cr##tab#", "ALL")#";//indent
                result = "#result##temp##cr#";
            }//Add each nested-element (indented) by using recursive call
        }
        result = "#result#</#elem.XmlName#>";//Close element
    } else {
        result = "#result# />";//self-close if the element doesn't contain anything
    }
    
    return result;
}</cfscript>
<cfoutput>
<script language="javascript">
$(document).ready(function() {
    $relaxerForm    = $("##relaxerForm");
    $resultsBox     = $("##resultsBox");
    $relaxerHeader  = $("##relaxerHeader");

    <cfif structKeyExists( prc, "results" )>
        // syntax highlight
        SyntaxHighlighter.all();
        // some formatting
        <cfif( NOT isXML( prc.results.fileContent) )>
            $( "##resultsPretty" ).text( formatJSONRaw( '#JSStringFormat( prc.results.fileContent)#' ) );
        </cfif>
    </cfif>

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

    // resource js models
    $resources = {};
    <cfloop array="#prc.dsl.resources#" index="thisResource">
        $resources['#thisResource.resourceID#'] = #serializeJSON( thisResource )#;
    </cfloop>
    //json history
    reqHistory = [];
    <cfloop from="1" to="#arrayLen( prc.requestHistory)#" index="x">
    reqHistory[#x-1#] = #serializeJSON( prc.requestHistory[x] )#;
    </cfloop>
});
function showBrowserResults(){
    var w = 900, h = 750;
    var LeftPosition    = ( screen.width )  ? ( screen.width-w )  / 2 : 0;
    var TopPosition     = ( screen.height ) ? ( screen.height-h ) / 2 : 0;

    var c = window.open( "", "browserResults", "height="+h+", width="+w+", left="+LeftPosition+", top="+TopPosition+", resizable=yes, scrollbars=yes" );
    c.document.write( $("##resultsRAW").val() );
}
function resourceSelect(rData,tier){
    var resourceID = 0;
    // tier and URL selection
    if( rData != 'null' ){
        var values = rData.split(";");
        resourceID = values[0];
        $("##resourceID").val( resourceID );
        $("##httpResource").val( values[1] );
    }
    else{
        $("##httpResource").val('');
    }
    $("##entryTier").val(tier);

    // Select default HTTP Method
    selectOption("httpMethod", $resources[resourceID].DEFAULTMETHOD);
    // Select default Format
    selectOption("httpFormat", $resources[resourceID].DEFAULTFORMAT);

    // Check for required parameters
    var openAdvanced = false;
    // Clean header values and params
    cleanHeaders(); cleanParams();
    $("##httpParameters p").remove();

    // params required?
    if ($resources[resourceID].PARAMETERS != null) {
        $.each($resources[resourceID].PARAMETERS, function(index, objValue){
            if (objValue.REQUIRED == "true" || objValue.REQUIRED == true) {
                openAdvanced = true;
                addDynamicItem($("##addParameterButton"), [objValue.NAME, objValue.DEFAULT]);
            }
        });
    }
    // headers required?
    if ($resources[resourceID].HEADERS != null) {
        $.each($resources[resourceID].HEADERS, function(index, objValue){
            if (objValue.REQUIRED == "true") {
                openAdvanced = true;
                addDynamicItem($("##addHeaderButton"), [objValue.NAME, objValue.DEFAULT]);
            }
        });
    }
    // open advanced dialog
    if( openAdvanced ){ $("##advancedSettings").slideDown(); } else { $("##advancedSettings").slideUp(); }
}
function cleanHeaders(){
    $("##httpHeaders p").remove();
}
function cleanParams(){
    $("##httpParameters p").remove();
}
function showResourceHelp(){
    var val = $( "##resourceID" ).val();
    if( val != "null"){
        var values = val.split(";");
        openRemoteModal( '#event.buildLink( prc.xehResourceDoc )#',{
            resourceID: values[ 0 ]
        });
    }

    return false;
}
function addDynamicItem(_this, inData){
    var $trigger  = _this;
    var fieldType = $trigger.attr("data-type");
    // turn on the duplicate template on the requested trigger
    $("##fieldsTemplate").clone(true).attr("id","").insertBefore( $trigger ).toggle();

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
function clearHistory(){
    //activate spinners
    $("##historyLoader").fadeIn();
    $("##requestHistoryContainer").css("opacity",".5");
    // clean history
    $.post( '#event.buildLink( prc.xehPurgeHistory )#',{},
           function(response){
            // deactivate spinner
            $("##historyLoader").fadeOut();
            $("##requestHistoryContainer").css("opacity","1");
            // setup message
            $("##requestHistoryMessages").html(response.messages)
                .slideDown().delay(1500).slideUp();
            // Check if we can remove it
            if(!response.error){
                $('##requestHistory')
                    .empty()
                    .append('<option value="null">No History</option>');
            }
           },
           "json");
}
function rebuildRequest(){
    var index = $("##requestHistory").val();
    if( index != "null" ){
        var item = reqHistory[index].DATA;
        //console.log(item);

        $("##advancedSettings").slideDown();
        // main options
        selectOption("httpMethod",item.HTTPMETHOD);
        $("##httpResource").val(item.HTTPRESOURCE);
        selectOption("httpFormat",item.HTTPFORMAT);
        // HTTP Auth
        $("##username").val(item.USERNAME);
        $("##password").val(item.PASSWORD);
        // HTTP Proxy
        $("##httpProxy").val(item.HTTPPROXY);
        $("##httpProxyPort").val(item.HTTPPROXYPORT);
        // Clean header values and params
        cleanHeaders();cleanParams();

        // headers
        if (item.HEADERNAMES.toString().length) {
            var headerNames = item.HEADERNAMES.toString().split(",");
            var headerValues = item.HEADERVALUES.toString().split(",");
            $.each(headerNames, function(index, objValue){
                addDynamicItem($("##addHeaderButton"), [objValue, headerValues[index]]);
            })
        }
        // params
        if (item.PARAMETERNAMES.toString().length) {
            var paramNames = item.PARAMETERNAMES.toString().split(",");
            var paramValues = item.PARAMETERVALUES.toString().split(",");
            $.each(paramNames, function(index, objValue){
                addDynamicItem($("##addParameterButton"), [objValue, paramValues[index]]);
            })
        }
        $("##requestHistoryMessages").html("Request Rebuilt!")
                .slideDown().delay(250).slideUp();
    }
}
function selectOption(itemID,data){
    $("##"+itemID+" option").each(function(index){
        var $this = $(this);
        if( $this.val() == data){ $this.attr("selected","selected"); }
    });
}
function submitForm(){
    var $resource = $("##httpResource");
    // Verify the destination just in case:
    if( !$resource.val().length ){
        if( !$resource.hasClass("error") ){
            $resource.addClass("error");
        }
        $resource.focus();
        alert("The HTTP resource to hit cannot be empty! You are too relaxed!");
        return;
    }
    $('##bottomCenteredBar').slideUp("fast");
    $('##bottomCenteredLoader').fadeIn("slow");
    $relaxerForm.submit();
}
function advancedSettings(){
    $("##advancedSettings").slideToggle();
}
</script>
</cfoutput>