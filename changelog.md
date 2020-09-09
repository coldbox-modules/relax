# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

----

## [4.1.1] => 2020-SEP-09

### Added

* New changelog standards
* Github release publishing of changelogs
* New formatting scripts

### Fixed

* ColdBox 6 compat on build links

----

## [4.1.0] => 2020-MAY-07

### Improvements

* Converts the UI from a BackboneJS implementation to VueJS
* Performance improvements in rendering large APIs
* Theme and nested objects updated for better meta/list rendering and display

## Features

* Adds additional support for OpenAPI v3 schema definitions ( content, items )
* Adds auto-generation of examples from schema from examples defined within items/properties, when not explicitly provided
* Adds a module setting to exclude APIs from display listings


### Compat

* Removes the direct export of PDF documents due to lack of HTML5 support w/in CFDocument.  Export button now routes to HTML after providing PDF print instructions
* Additional OpenAPI v3.x support

----

## [4.0.1]

### Improvements

* Added suport for OpenAPIv3 `requestBody` schema
* UI enhancements to sample code displays in HTML format


----

## [4.0.0] => 2019-OCT-02

### Features

* Open API v3.x Support
* CBSwagger v2.x Support

### Improvements

* Migrated to use ColdBox 5 routers
* Multiple UI Fixes on missing fonts

### Compat

* cbswagger updates to version 2.0 to stay compliant with OpenAPI Spec
* Dropped ACF 11 Support
* Moved to use ColdBox `modulesettings` instead of root `relax` struct in the `config/ColdBox.cfc`.  Just move your configuration into the `moduleSettings` struct.

----

## [3.1.0]

* Updated all JS libraries
* Updated npm libraries
* Updated grunt to leverage new locations of module template
* CommandBox Readiness for static assets
* Fix console logs left behind
* Dropped lucee 4 support
* Added acf2018 support
* module layout updates
* Fixes on module root when embedeed in app

----

## [3.0.4]

* Bumps cbjavaloader dependency version to ^2

----

## [3.0.3]

* Fixes `cbswagger` dependency tracking
  
----

## [3.0.2]

* Adds integration with `cbswagger` module to introspect application RESTful route metadata

----

## [3.0.1]

* Fixes a bug where POST methods were passing a conditional key used in preHandler
* Fixes a bug where Relaxer auth password was being transmitted as username
* Fixes an issue where Relaxer history became unusable because of bad response
* Fixes an issue where form parameters where not being interpreted correctly by the Relaxer Service

----

## [3.0.0]

* Standardizes OpenAPI specification
* Relax DSL marked as deprecated ( EOL @ 4.0.0 )
* ACF Compatibility updates
* PDF/HTML Export strategy updates
* UI Bug fixes and enhancements
* Relaxer Test Tool UI and history replay improvements
* ACF Compatibility updates
* Performance enhancements for OpenAPI doc parsing
* Improvements to `$ref` parsing and recursion
* Relaxer service not sending form data correctly
* Refactoring of Relaxer to support typed API on calls to HTTP
* Relaxer not sending http proxy ports
* Relaxer not sending right name for params
* PDF Export Capabilities

----

## [2.3.1]

* Migrates core OpenAPI parsing to swagger-sdk module
* Implements one-click route population and testing in API test tool
* Misc bug fixes and additional support for recursion

----

## [2.3.0]

* [RELAX-25] - SSL support for assets
* Converts development workflow to user Grunt/SASS/RJS Optimizer
* [RELAX-5] - Implements OpenAPI Specification as Relax default
* Implements backward compatiblity for RelaxDSL
* [RELAX-3] - Relaxer is now async
* [RELAX-11] - Relaxer functionality is now rendered in-page
* [RELAX-7] - Udates DSL Documentation to use dynamic JS Templating
* Documentation loading is now async
* Adds OpenAPI specification documentation
* Exports for Trac and WikiMedia are now async
* Import issues resolved and converted to async
* Converts code highlighter from SyntaxHighlighter to Prism.js

----

## [2.2.0]

* [RELAX-22] - Updated build scripts for using DocBox
* [RELAX-23] - Travis CI integration for tests
* [RELAX-24] - Update of all dependencies of the shell tester
* [RELAX-21] - Update StringBuffer to StringBuilders
* [RELAX-4] - Remove dependency on sessions
* [RELAX-12] - Sample API is excluded
* [RELAX-20] - The Resource URL changes for every code change, updated internal hash to pattern hash
* [RELAX-1] - Implement display and DSLDoc modeling modifications to the Relax module
* [RELAX-17] - Make test shell full URL rewritable
* [RELAX-18] - Ability to view resource details from doc viewer

----

## [2.1.0]

* Updates on box.json and locations
* Updated readme
* Updated full skin assets
* Included sample resources in build
* Navigation fixes
* Module Standalone route generation

----

## [2.0.1]

* Fixed resource headers, as they are not showing

----

## [2.0.0]

* https://ortussolutions.atlassian.net/browse/RELAX/fixforversion/13801
