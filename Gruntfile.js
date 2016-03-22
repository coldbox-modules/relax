module.exports = function(grunt) {
	grunt.initConfig({
		pkg: grunt.file.readJSON('package.json'),
		watch: {
			sass: {
				files: ['includes/scss/*.{scss,sass}','includes/scss/**/*.{scss,sass}','includes/scss/**/**/*.{scss,sass}'],
				tasks: ['sass:dist','sass:distTheme']
			},
            jsView: {
            	files: ['includes/jsdev/views/*.js','includes/jsdev/views/widgets/*.js'],
            	tasks: ['uglify:viewJS']
            },

            jsModel: {
            	files: ['includes/jsdev/models/*.js'],
            	tasks: ['uglify:modelJS']
            }
		},
		sass: {
			options: {
				sourceMap: true,
				outputStyle: 'compressed'
			},
			dist: {
				files: {
					'modules/relax/includes/css/relax.css': 'includes/scss/relax.scss',
				}
			},
			distTheme: {
			    options: {
			      style: 'expanded',
			      lineNumbers: true, // 1
			      sourcemap: false
			    },
			    files: {
					'modules/relax/includes/css/theme.css': 'includes/scss/theme.scss',
				}
			 }
		},

		requirejs: {
		  compile: {
		    options: {
				baseUrl: "includes/jsdev",
				mainConfigFile: "require.build.js",
				wrap:true,
				optimize: "none",
				dir:"modules/relax/includes/js",
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
			      cwd: 'includes/jsdev',
		          src: 'views/**/*.js',
		          dest: 'modules/relax/includes/js/'
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
			      cwd: 'includes/js',
		          src: 'models/**/*.js',
		          dest: 'modules/relax/includes/js/'
			    }]
		    }
		}

	});
	grunt.loadNpmTasks('grunt-sass');
	grunt.loadNpmTasks('grunt-contrib-requirejs');
	grunt.loadNpmTasks('grunt-contrib-watch');
	grunt.loadNpmTasks('grunt-contrib-uglify');
	grunt.registerTask('default', ['sass:dist','sass:distTheme','requirejs:compile','uglify:viewJS','uglify:modelJS', 'watch']);
	
};