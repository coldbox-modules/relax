<cfscript>
  /**
  * Mixin variables to assist translation between legacy RelaxDSL specification and OpenAPI
  **/

  //We need to use Linked Hashmaps to maintain struct order for serialization and deserialization
  VARIABLES.openAPITemplate = createObject( "java", "java.util.LinkedHashMap" );
  VARIABLES.templateDefaults = [ 
    {"swagger": "2.0"},
    {
      "info": {
          "version": "",
          "title": "",
          "description": "",
          "termsOfService": "",
          "contact": createObject( "java", "java.util.LinkedHashMap" ),
          "license": createObject( "java", "java.util.LinkedHashMap" )
        }
    },
    {"host": ""},
    {"basePath": ""},
    {"schemes": []},
    {"consumes": ["application/json","multipart/form-data","application/x-www-form-urlencoded"]},
    {"produces": ["application/json"]},
    {"paths": createObject( "java", "java.util.LinkedHashMap" )}

  ];

  //Utility arrays for default methods and responses
  VARIABLES.HTTPMethods = [ "GET", "PUT", "POST" , "PATCH" , "DELETE" , "HEAD" ];
  VARIABLES.HTTPMethodResponses = [ 200, 200, 201, 200, 204, 204 ];
</cfscript>