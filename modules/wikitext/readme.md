# WELCOME TO THE WIKITEXT MODULE

This module translates [mediawiki](https://www.mediawiki.org/wiki/MediaWiki) syntax into HTML, but it can also convert HTML into several markup languages like:

* Wikipedia (Mediawiki)
* googlecode
* Trac
* Moin Moin
* JSP Wiki

## LICENSE

Apache License, Version 2.0.

## SYSTEM REQUIREMENTS

* Lucee 5+
* ColdFusion 11+

# INSTRUCTIONS

Just drop into your modules folder or use CommandBox to install

`box install wikitext`

The module registers the wiki converter model: `wikitext@wikitext`.  You can then use the following functions to convert markup and HTML and vice-versa:

```js
/**
* Convert an HTML string to wiki syntax
* @wikiTranslator The wiki syntax to use. It must be using a valid translator. See getTranslators()
* @htmlString The html string to convert
*/
function toWiki( required wikiTranslator, required htmlString )

/**
* Convert wiki text and return a structure with two keys: [wikiModel=The java wiki model object,html=the converted html string]
* @wikitext The wiki text to convert to HTML
*/
function toHTML( required wikitext )

```


## Settings
You can create a `wikitext` settings structure in your `ColdBox.cfc` with the following options:

```js
//defaults
wikitext = {
    // The link pattern to translate internal links
    linkPattern = "${title}",
    // The base URL of the UI module
    linkBaseURL = "",
    // The image base URL
    imageBaseURL = "",
    // Allowed wiki attributed
    allowedAttributes = "style,url",
    // Ignored tags on conversion
    ignoreTagList = "img,iframe"
};
```

********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldbox.org | www.luismajano.com | www.ortussolutions.com
********************************************************************************

#### HONOR GOES TO GOD ABOVE ALL

Because of His grace, this project exists. If you don't like this, then don't read it, its not for you.

>"Therefore being justified by faith, we have peace with God through our Lord Jesus Christ:
By whom also we have access by faith into this grace wherein we stand, and rejoice in hope of the glory of God.
And not only so, but we glory in tribulations also: knowing that tribulation worketh patience;
And patience, experience; and experience, hope:
And hope maketh not ashamed; because the love of God is shed abroad in our hearts by the 
Holy Ghost which is given unto us. ." Romans 5:5

### THE DAILY BREAD

 > "I am the way, and the truth, and the life; no one comes to the Father, but by me (JESUS)" Jn 14:1-12