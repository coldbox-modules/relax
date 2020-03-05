/*
* Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
* www.ortussolutions.com
* ---
* The JavaLoader WireBox DSL
*/
component accessors="true"{

	/**
	* WireBox Injector
	*/
	property name="injector";

	/**
	* Logger
	*/
	property name="log";


	/**
	* Constructor as per interface
	*/
	public any function init( required any injector ){
		variables.injector 	= arguments.injector;
		variables.log		= arguments.injector.getLogBox().getLogger( this );

		return this;
	}

	/**
	* Process an incoming DSL definition and produce an object with it.
	*/
	public any function process( required definition, targetObject ){
		var DSLNamespace = listFirst( arguments.definition.dsl, ":" );
		switch( DSLNamespace ){
			case "javaloader" : { return getJavaLoaderDSL( argumentCollection=arguments );}
		}
	}

	/**
	* Get a JavaLoader Dependency
	*/
	function getJavaLoaderDSL( required definition, targetObject ){
		var className = listLast( arguments.definition.dsl, ":" );

		// Get Dependency, if not found, exception is thrown
		return variables.injector.getInstance( "loader@cbjavaloader" ).create( className );
	}

}
