Relax Module Development
========================


Environment Setup:
-----------------

Development requires the installation NPM.  To set up your development evironment from scratch, first install NPM, then:

```
npm install -g bower
npm install
bower install
Grunt
```  

Once Grunt begins, your development JS and SCCS files will be automatically compiled as you make edits or add files in `/includes/js` and `/includes/scss`.  If you make a change to the `/require.build.js` file, you will need to restart `Grunt`.

Directory structure and key files:
-------------------

- `/includes/jsdev`: Development Javascript files.  Will be compiled by Grunt to the target module `includes/js` directory
- `/includes/scss`: Development SCSS files.  Will be compiled by Grunt to the target module `includes/css` directory
- `/module/relax/includes/plugins`: Normalized plugin assets ( e.g. - Vendor CSS which may not be brought in via SCSS or is used intermittently ).  If at all possible use SCSS versions from bower.  Global imports of non-SCSS assets are included in `/includes/scss/theme.scss`
- `/includes/jsdev/udf.js`: Global UDF file.  All methods in this file are available in all scopes
- `/includes/jsdev/views/`: The BackboneJS views directory.  Any files created with the following conventions will be loaded automatically by the Relax core layout: `[ handler ].js` and `[ handler ].[ action ].js`
- `/includes/js/widgets/`: Re-usable BackboneJS stub views which may be re-used during DOM changes
- `/includes/js/models`: BackboneJS Models ( [http://backbonejs.org/#Model](http://backbonejs.org/#Model) )

