/**
* Global Functions and UDFS
**/
/**
* Populates and opens a modal from a remote URL
* @url      The URL to load
* @params   The query params to pass to the remote URL
**/
export const openRemoteModal = function(
    url,
    params
){
    $remoteModal    = $( "#modal" );
    // load URL
    $remoteModal.find( "#modal-dialog" )
        .load( url, params );
    // show it
    $remoteModal.modal( "show" );
}

/**
* Parses the window request params to determine if an API is specifed in the params or URL path
**/
export const parseRequestParams = function(){
    var location = window.location;

    var params = {
        hash : location.hash,
        queryString : location.search,
        path : location.pathname,
        api : getQueryVariable( "api" )
    };

    //evaluate path information for apiname
    var pathArray = params.path.split( '/' );
    if(
        (
            pathArray[ pathArray.length - 2 ] === 'api'
            ||
            pathArray[ pathArray.length - 2 ] === 'relaxer'
        )
        && pathArray[ pathArray.length - 1 ].length
    ){

        params.api = pathArray[ pathArray.length - 1 ];

    }

    return params;
}

/**
* Query variable parser function
* @link:    http://www.idealog.us/2006/06/javascript_to_p.html
**/
export const getQueryVariable = function( variable ) {
    var query = window.location.search.substring( 1 );
    var vars = query.split( '&' );
    for ( var i = 0; i < vars.length; i++ ) {
        var pair = vars[i].split( '=' );
        if ( decodeURIComponent( pair[ 0 ] ) == variable ) {
            return decodeURIComponent( pair[ 1 ] );
        }
    }
}

export const getLangFromMimetype = function( mimetype ){
	let lang = mimetype.split('/')[ mimetype.split( '/' ).length-1 ];
	return lang.indexOf( "form" ) > -1 ? 'properties' : lang;
}


/**
* Formats an API Example from a given mimetype
* @example      The example provided
* @mimetype     The mimetype of the example to use for formatting
**/
export const formatAPIExample = function(
    example,
    mimetype
){
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



/**
* Formats the JSON contained within an element
* @id           The id attribute of the element
* @deprecated:  Use formatJSONRaw() with DOM replacement
**/
export const formatJSON = function( id ){
    $( "#" + id ).val( formatJSONRaw( $( "#" + id ).val() ) );
}

/**
* Formats a raw JSON string
* @jsonData     The raw JSON string to format
* @return       string
**/
export const formatJSONRaw = function( jsonData ){
    if( !jsonData.length ){ return ''; }
    try{
        return JSON.stringify( JSON.parse( jsonData ), null, 4 ).replace(/\\\\/g, "\\");
    }
    catch(e){
        console.error(e);
        alert( "Error parsing JSON!" + e );
        return jsonData;
    }
}


/**
* Formats an XML string
* @xml      The string of XML to be formatted
* @return   string
**/
export const formatXML = function( xml ) {
    var formatted = '';
    var reg = /(>)(<)(\/*)/g;
    xml = xml.replace( reg, '$1\r\n$2$3' );
    var pad = 0;

    $.each(
        xml.split( '\r\n' ),
        function(
            index,
            node
        ) {
        var indent = 0;

        if ( node.match( /.+<\/\w[^>]*>$/ ) ) {
            indent = 0;
        } else if ( node.match( /^<\/\w/ ) ) {
            if (pad != 0) {
                pad -= 1;
            }
        } else if ( node.match( /^<\w[^>]*[^\/]>.*$/ ) ) {
            indent = 1;
        } else {
            indent = 0;
        }

        var padding = '';

        for ( var i = 0; i < pad; i++ ) {
            padding += '  ';
        }

        formatted += padding + node + '\r\n';
        pad += indent;
    });

    return formatted.trim();
}

/**
* Escapes the HTML from the string
* @string The string to be escaped
* @return string
**/
export const escapeHtml = function( string ) {
	/**
	* A map of entities for string replacement
	**/
	var entityMap = {
		"&": "&amp;",
		"<": "&lt;",
		">": "&gt;",
		'"': '&quot;',
		"'": '&#39;',
		"/": '&#x2F;'
	};
    return String( string ).replace(/[&<>"'\/]/g, function ( s ) {
      return entityMap[s];
    });
}

export const objectToXML = function (obj) {
	var xml = '';
	for (var prop in obj) {
	  xml += obj[prop] instanceof Array ? '' : "<" + prop + ">";
	  if (obj[prop] instanceof Array) {
		for (var array in obj[prop]) {
		  xml += "<" + prop + ">";
		  xml += OBJtoXML(new Object(obj[prop][array]));
		  xml += "</" + prop + ">";
		}
	  } else if (typeof obj[prop] == "object") {
		xml += OBJtoXML(new Object(obj[prop]));
	  } else {
		xml += obj[prop];
	  }
	  xml += obj[prop] instanceof Array ? '' : "</" + prop + ">";
	}
	var xml = xml.replace(/<\/?[0-9]{1,}>/g, '');
	return xml
};




/**
* ====================
* Templating UDFs
* ====================
*/


/**
* Renders the `x-` extensions from a given node
* @entity       The OpenAPI Schema Node ( e.g. paths > /users )
* @headerNode   An optional header HTML node to use for the template header
* @return string
**/
export const renderXAttributes = function(
    entity,
    headerNode
){
    var xAttributesTemplate = _.template( $( "#x-attributes-template" ).html() );
    return xAttributesTemplate( {
        "entity":entity,
        "headerNode":headerNode
    } );
}

/**
 * Relaxer response header utils
 *
 */

/**
 * Gets all response headers from the response object
 * @param {} responseObj
 */
export const getAllResponseHeaders = function( responseObj ){
	return responseObj.response.responseheader;
}

/**
 * Gets an individual response header value
 *
 * @param {} responseObj
 * @param {} headerName
 */
export const getResponseHeader = function( responseObj, headerName ){
	return responseObj.response.responseheader[ headerName ];
}