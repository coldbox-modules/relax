<cfscript>
function printDate(inDate){
	return dateFormat(inDate,"medium") & " " & timeformat(inDate,"medium");
}
function getTreatedContent(content){
	var rawContent = arguments.content;
	if( isXML(rawContent) ){
		return xmlHumanReadable(rawContent);
	}
	arguments.content = htmlEditFormat(trim(arguments.content));
	arguments.content = Replace(arguments.content,":{",":{#chr(13)#","all");
	arguments.content = Replace(arguments.content,"}:","{:#chr(13)#","all");
	arguments.content = Replace(arguments.content,":[",":[#chr(13)#","all");
	arguments.content = Replace(arguments.content,"]:","]:#chr(13)#","all");
	arguments.content = Replace(arguments.content,',',',#chr(13)#',"all");

	return arguments.content;
}
function getBrush(content){
	if(isXML(trim(arguments.content)) ){
		return "xml";
	}
	return "js";
}
function xmlHumanReadable(XmlDoc) {
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