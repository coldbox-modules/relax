# Changelog

## v2.0.0

* Open API 3.02 support instead of swagger
* New template layout
* Engine removals: lucee4.5, ACF10, ACF11
* Upgraded jackson-core to latest v2.9.9
* Upgraded snakeyaml to latest v1.24
* Added more tests
* Added ability to chain methods on all methods that where void before.
* `document.asYAML()` is not fully implemented so you can convert the document to yaml.
* Upgraded `createLinkedHashMap()` to use new ACF `structNew( "ordered" )` instead.

## v1.0.4

*  Adds security definitions to default template 

## v1.0.2

* Adobe Coldfusion compatibility updates

## v1.0.1

* Adds $ref support for relative and remote ( http[s] )

## v1.0.0 

* Initial Module Release