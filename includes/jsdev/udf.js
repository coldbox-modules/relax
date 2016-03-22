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

function toggleResource(id){
    var $div = $( "#resource_" + id );
    $div.slideToggle();
}

String.prototype.toProperCase = function () {
    return this.replace(/\w\S*/g, function(txt){return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();});
};