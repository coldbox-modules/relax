module.exports = function(grunt) {
	grunt.initConfig({
		pkg: grunt.file.readJSON( 'package.json' ),

		watch: {
			sass: {
				files: ['resources/scss/*.{scss,sass}','resources/scss/**/*.{scss,sass}','resources/scss/**/**/*.{scss,sass}'],
				tasks: ['sass:dist','sass:distTheme']
			},
            jsView: {
            	files: ['resources/jsdev/views/*.js','resources/jsdev/views/widgets/*.js'],
            	tasks: ['uglify:viewJS']
            },

            jsModel: {
            	files: ['resources/jsdev/models/*.js'],
            	tasks: ['uglify:modelJS']
            },

            jsGlobals: {
            	files: [
            		'resources/jsdev/app.js',
            		'resources/jsdev/globals.js',
            		'resources/jsdev/udf.js'
            	],
            	tasks: ['requirejs:compile','uglify:viewJS','uglify:modelJS']
            }
		},

		sass: {
			options: {
				sourceMap: true,
				outputStyle: 'compressed'
			},
			dist: {
				files: {
					'includes/css/relax.css' : 'resources/scss/relax.scss',
				}
			},
			distTheme: {
			    options: {
			      style: 'expanded',
			      lineNumbers: true, // 1
			      sourcemap: false
			    },
			    files: {
					'includes/css/theme.css': 'resources/scss/theme.scss',
					'includes/css/relax.css': 'resources/scss/relax.scss',
					'includes/css/export.css': 'resources/scss/export.scss'
				}
			 }
		},

		requirejs: {
		  compile: {
		    options: {
				baseUrl: "resources/jsdev",
				mainConfigFile: "require.build.js",
				wrap: true,
				optimize: "none",
				dir: "includes/js",
				// Define the modules to compile.
				modules: [
					//Core application libraries, including theme
				    {
				        name: "globals",

				        // Use the *shallow* exclude; otherwise, dependencies of
				        // (including jQuery and text and util modules). In other
				        // words, a deep-exclude would override our above include.
				        excludeShallow: []
				    }
				]
		    }
		  }
		},

		//uglification/copy of views and pages
		uglify: {
			 viewJS: {
			 	options: {
			  	beautify: true,
			  	mangle: false,
			  	compress: false,
			    // the banner is inserted at the top of the output
			    banner: '/*! Copyright <%= grunt.template.today("yyyy") %> - Ortus Solutions (Compiled: <%= grunt.template.today("dd-mm-yyyy") %>) */\n'
			  	},
			  	files: [{
		          expand: true,
			      cwd: 'resources/jsdev',
		          src: 'views/**/*.js',
		          dest: 'includes/js/'
			    }]
		    },
		    modelJS: {
			 	options: {
			  	beautify: true,
			  	mangle: false,
			  	compress: false,
			    // the banner is inserted at the top of the output
			    banner: '/*! Copyright <%= grunt.template.today("yyyy") %> - Ortus Solutions (Compiled: <%= grunt.template.today("dd-mm-yyyy") %>) */\n'
			  	},
			  	files: [{
		          expand: true,
			      cwd: 'resources/jsdev',
		          src: 'models/**/*.js',
		          dest: 'includes/js/'
			    }]
		    }
		}

	});

	grunt.loadNpmTasks( 'grunt-sass' );
	grunt.loadNpmTasks( 'grunt-contrib-requirejs' );
	grunt.loadNpmTasks( 'grunt-contrib-watch' );
	grunt.loadNpmTasks( 'grunt-contrib-uglify' );
	grunt.registerTask( 'default', [
		'sass:dist',
		'sass:distTheme',
		'requirejs:compile',
		'uglify:viewJS',
		'uglify:modelJS',
		'watch'
		]
	);

};