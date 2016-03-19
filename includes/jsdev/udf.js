/**
* Global Functions and UDFS
**/

function openRemoteModal( url, params ){
    $remoteModal    = $( "#modal" );
    // load URL
    $remoteModal.find( "#modal-dialog" )
        .load( url, params );
    // show it
    $remoteModal.modal( "show" );
}

function formatAPIExample( example, mimetype ){
    switch( mimetype ){
        case "application/xml":
        case "text/xml":
        case "xml":
        
            return escapeHtml( formatXML(example) );

        case "application/json":
        case "application/jsonp":
        case "application/jsont":
            if( typeof( example ) === 'object' ){
                return formatJSONRaw( JSON.stringify( example ) ).trim();
            } else {
                return formatJSONRaw( example ).trim();
            }
        default:
            if( typeof( example ) === 'object' || typeof( example ) === 'array' ){
                return formatJSONRaw( JSON.stringify( example ) ).trim();
            } else {
                return example;
            }
    }
}

function formatJSON( id ){
    $( "#" + id ).val( formatJSONRaw( $( "#" + id ).val() ) ); 
}

function formatJSONRaw( jsonData ){
    if( !jsonData.length ){ return ''; }
    try{
        var result = jsonlint.parse( jsonData );
        if (result) {
            // Reformat and replace double-escaped slashes:
            return JSON.stringify(result, false, 4).replace(/\\\\/g, "\\");
        }
        return jsonData;
    }
    catch(e){
        console.log(e);
        alert( "Error parsing JSON!" + e );
        return jsonData;
    }
}

function formatXML(xml) {
    var formatted = '';
    var reg = /(>)(<)(\/*)/g;
    xml = xml.replace(reg, '$1\r\n$2$3');
    var pad = 0;
    $.each(xml.split('\r\n'), function(index, node) {
        var indent = 0;
        if (node.match( /.+<\/\w[^>]*>$/ )) {
            indent = 0;
        } else if (node.match( /^<\/\w/ )) {
            if (pad != 0) {
                pad -= 1;
            }
        } else if (node.match( /^<\w[^>]*[^\/]>.*$/ )) {
            indent = 1;
        } else {
            indent = 0;
        }

        var padding = '';
        for (var i = 0; i < pad; i++) {
            padding += '  ';
        }

        formatted += padding + node + '\r\n';
        pad += indent;
    });

    return formatted.trim();
}


 var entityMap = {
    "&": "&amp;",
    "<": "&lt;",
    ">": "&gt;",
    '"': '&quot;',
    "'": '&#39;',
    "/": '&#x2F;'
};

function escapeHtml(string) {
    return String(string).replace(/[&<>"'\/]/g, function (s) {
      return entityMap[s];
    });
}

/**
* Templating UDFs
**/

function renderXAttributes( entity, headerNode ){
    var xAttributesTemplate = _.template( $( "#x-attributes-template" ).html() );
    return xAttributesTemplate( {
        "entity":entity,
        "headerNode":headerNode
    } );
}


/**
* Prototype extensions
*/
String.prototype.toProperCase = function () {
    return this.replace(/\w\S*/g, function(txt){return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();});
};