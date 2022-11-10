Relax Module Development
========================


Environment Setup:
-----------------

Development requires the installation of [https://www.npmjs.com/](NPM).  To set up your development evironment from scratch, first install NPM, then from the root of the application:

```
npm install
box install
```  

Then change directory to the `test-harness` directory and re-run `box install` to seed the coldbox application.  Once dependencies are installed and assets are compiled ( see below ), you can start the following servers from within the `test-harness` directory to browse the application:

- `box server start serverconfigFile=server-lucee@5.json`
- `box server start serverconfigFile=server-adobe@2018.json`
- `box server start serverconfigFile=server-adobe@2018.json`


To compile the packed assets you can use the following webpack commands:

- `npm run dev` - compiles development assets
- `npm run watch` - compiles development assets and watches for changes
- `npm run prod` - compiles production minified and packed production assets

Directory structure and key asset development files:
-------------------

- `/resources/assets/js`: Development Javascript files.  Will be compiled by webpack in to the `includes/js/app.js` and `includes/js/vendor.js` files
- `/resources/assets/js/components`: Development VueJS components.  Will be compiled by webpack to the `includes/js/app.js` file
- `/resources/assets/sass`: Development SCSS files.  Will be compiled by webpack to the  `includes/css/app.css` file

