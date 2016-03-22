require.config({
    //Note: paths are relative to the compiling cwd - see Gruntfile.js
    paths:{
        require:'../../node_modules/requirejs/require'
        ,underscore:'../../bower_components/underscore/underscore-min'
        ,jquery:'../../bower_components/jquery/dist/jquery.min'
        ,Backbone:'../../bower_components/backbone/backbone-min'
        ,bootstrap:'../../bower_components/bootstrap-sass/assets/javascripts/bootstrap.min'
        ,html5shiv: '../../bower_components/html5shiv/dist/html5shiv.min'
        ,fastclick: '../../bower_components/fastclick/lib/fastclick'
        ,iCheck: '../../bower_components/iCheck/icheck.min'
        ,jsonlint: '../../bower_components/jsonlint/lib/jsonlint'
        ,modernizr: '../../bower_components/modernizr/lib/build'
        ,respond: '../../bower_components/respond/dest/respond.min'
        ,switchery: '../../bower_components/switchery/dist/switchery.min'
        ,navgoco: '../../bower_components/navgoco/src/jquery.navgoco.min'
        ,"es6-shim": '../../bower_components/es6-shim/es6-shim.min'
        ,prism: '../../bower_components/prism/prism'
        ,udf:'udf'
    }
    ,shim:{
        underscore:{exports:'_'}
        ,jquery:{exports:['jQuery','$']}
        ,Backbone:{exports:'Backbone', deps:['jquery', 'underscore'] }
        ,bootstrap:{ exports:'Bootstrap', deps:['jquery'] }
        ,html5shiv:{exports:'html5shiv'}
        ,navgoco:{exports:'navgoco',deps:['jquery']}
        ,"es6-shim":{exports:'es6-shim'}
        ,jsonlint:{exports:'jsonlint'}
    }
    ,deps:['jquery','bootstrap','underscore','Backbone','respond','switchery','navgoco','html5shiv','iCheck','fastclick']
});