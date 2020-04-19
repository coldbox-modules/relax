//Prototype extensions
String.prototype.toAcronym = function() {
    var words, acronym, nextWord;
    for (words = this.split(" "), acronym = "", index = 0; index < words.length; ) nextWord = words[index],
    acronym += nextWord.charAt(0).toUpperCase(), index += 1;
    return acronym;
};

String.prototype.HTMLBreakLines = function(){
	return this.replace(/(?:\r\n|\r|\n)/g, '<br />');
}

String.prototype.toCamelCase = function() {
    return this.replace(/\s(.)/g, function($1) {
        return $1.toUpperCase();
    }).replace(/\s/g, "").replace(/^(.)/, function($1) {
        return $1.toLowerCase();
    });
};

String.prototype.toTitleCase = function() {
    return this.replace(/\w\S*/g, function(txt) {
        return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();
    });
};


String.prototype.toBoolean = function(){
	switch(this.toLowerCase().trim()){
        case "true": case "yes": case "1": return true;
        case "false": case "no": case "0": case null: return false;
        default: return Boolean(this);
    }
}

String.prototype.uuid = function(){
    return ([1e7] + -1e3 + -4e3 + -8e3 + -1e11).replace(/[018]/g, c =>
        (c ^ crypto.getRandomValues(new Uint8Array(1))[0] & 15 >> c / 4).toString(16)
    );
}

String.prototype.toPlural = function(){
    var lastLetter = this.slice( -1 );
    switch( lastLetter ){
        case "s":
            return this;
        break;
        case "y":
            return this.substring( name.length - 1 ) + "ies";
        break;
        default:
            return this + "s";
        break;
    }
}