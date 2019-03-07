<div id="readme" class="readme blob instapaper_body">
	<article class="markdown-body entry-content" itemprop="text">
		<h1>
			<a id="openapi-specification" class="anchor" href="#openapi-specification" aria-hidden="true">
				</a>
			OpenAPI Specification
		</h1>
		<h4 class="text-muted">(fka Swagger RESTful API Documentation Specification)</h4>
		<h4>
			<a id="version-20" class="anchor" href="#version-20" aria-hidden="true">
				</a>
			Version 2.0
		</h4>
		<p>
			The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be interpreted as described in 
			<a href="http://www.ietf.org/rfc/rfc2119.txt">
				RFC 2119
			</a>
			.
		</p>
		<p>
			The OpenAPI specification is licensed under 
			<a href="http://www.apache.org/licenses/LICENSE-2.0.html">
				The Apache License, Version 2.0
			</a>
			.
		</p>
		<h2>
			<a id="introductions" class="anchor" href="#introductions" aria-hidden="true">
				</a>
			Introductions
		</h2>
		<p>
			OpenAPI™ is a project used to describe and document RESTful APIs.
		</p>
		<p>
			The OpenAPI specification defines a set of files required to describe such an API. These files can then be used by the OpenAPI-UI project to display the API and OpenAPI-Codegen to generate clients in various languages. Additional utilities can also take advantage of the resulting files, such as testing tools.
		</p>
		<h2>
			<a id="revision-history" class="anchor" href="#revision-history" aria-hidden="true">
				</a>
			Revision History
		</h2>
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>
						Version
					</th>
					<th>
						Date
					</th>
					<th>
						Notes
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						2.0
					</td>
					<td>
						2014-09-08
					</td>
					<td>
						Release of OpenAPI 2.0
					</td>
				</tr>
				<tr>
					<td>
						1.2
					</td>
					<td>
						2014-03-14
					</td>
					<td>
						Initial release of the formal document.
					</td>
				</tr>
				<tr>
					<td>
						1.1
					</td>
					<td>
						2012-08-22
					</td>
					<td>
						Release of OpenAPI 1.1
					</td>
				</tr>
				<tr>
					<td>
						1.0
					</td>
					<td>
						2011-08-10
					</td>
					<td>
						First release of the OpenAPI Specification
					</td>
				</tr>
			</tbody>
		</table>
		<h2>
			<a id="definitions" class="anchor" href="#definitions" aria-hidden="true">
				</a>
			Definitions
		</h2>
		<h5>
			<a id="path-templating" class="anchor" href="#path-templating" aria-hidden="true">
				</a>
			<a name="pathTemplating">
			</a>
			Path Templating
		</h5>
		<p>
			Path templating refers to the usage of curly braces ({}) to mark a section of a URL path as replaceable using path parameters.
		</p>
		<h5>
			<a id="mime-types" class="anchor" href="#mime-types" aria-hidden="true">
				</a>
			<a name="mimeTypes">
			</a>
			Mime Types
		</h5>
		<p>
			Mime type definitions are spread across several resources. The mime type definitions should be in compliance with 
			<a href="http://tools.ietf.org/html/rfc6838">
				RFC 6838
			</a>
			.
		</p>
		<p>
			Some examples of possible mime type definitions:
		</p>
		<pre class="language-bash"><code class="language-bash">  text/plain; charset=utf-8
  application/json
  application/vnd.github+json
  application/vnd.github.v3+json
  application/vnd.github.v3.raw+json
  application/vnd.github.v3.text+json
  application/vnd.github.v3.html+json
  application/vnd.github.v3.full+json
  application/vnd.github.v3.diff
  application/vnd.github.v3.patch
</code></pre> 
		<h5>
			<a id="http-status-codes" class="anchor" href="#http-status-codes" aria-hidden="true">
				</a>
			<a name="httpCodes">
			</a>
			HTTP Status Codes
		</h5>
		<p>
			The HTTP Status Codes are used to indicate the status of the executed operation. The available status codes are described by 
			<a href="http://tools.ietf.org/html/rfc7231#section-6">
				RFC 7231
			</a>
			and in the 
			<a href="http://www.iana.org/assignments/http-status-codes/http-status-codes.xhtml">
				IANA Status Code Registry
			</a>
			.
		</p>
		<h2>
			<a id="specification" class="anchor" href="#specification" aria-hidden="true">
				</a>
			Specification
		</h2>
		<h3>
			<a id="format" class="anchor" href="#format" aria-hidden="true">
				</a>
			Format
		</h3>
		<p>
			The files describing the RESTful API in accordance with the OpenAPI specification are represented as JSON objects and conform to the JSON standards. YAML, being a superset of JSON, can be used as well to represent a OpenAPI specification file.
		</p>
		<p>
			For example, if a field is said to have an array value, the JSON array representation will be used:
		</p>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
   <span class="pl-s"><span class="pl-pds">"</span>field<span class="pl-pds">"</span></span> <span class="pl-k">:</span> [<span class="pl-k">...</span>]
}</pre>
		</div>
		<p>
			While the API is described using JSON it does not impose a JSON input/output to the API itself.
		</p>
		<p>
			All field names in the specification are 
			<strong>
				case sensitive
			</strong>
			.
		</p>
		<p>
			The schema exposes two types of fields. Fixed fields, which have a declared name, and Patterned fields, which declare a regex pattern for the field name. Patterned fields can have multiple occurrences as long as each has a unique name. 
		</p>
		<h3>
			<a id="file-structure" class="anchor" href="#file-structure" aria-hidden="true">
				</a>
			File Structure
		</h3>
		<p>
			The OpenAPI representation of the API is made of a single file. However, parts of the definitions can be split into separate files, at the discretion of the user. This is applicable for 
			<code>
				$ref
			</code>
			fields in the specification as follows from the 
			<a href="http://json-schema.org">
				JSON Schema
			</a>
			definitions.
		</p>
		<p>
			By convention, the OpenAPI specification file is named 
			<code>
				OpenAPI.json
			</code>
			.
		</p>
		<h3>
			<a id="data-types" class="anchor" href="#data-types" aria-hidden="true">
				</a>
			Data Types
		</h3>
		<p>
			Primitive data types in the OpenAPI Specification are based on the types supported by the 
			<a href="http://json-schema.org/latest/json-schema-core.html#anchor8">
				JSON-Schema Draft 4
			</a>
			. Models are described using the 
			<a href="/relax/home/OpenAPIDocs#schemaObject">
				Schema Object
			</a>
			which is a subset of JSON Schema Draft 4.
		</p>
		<p>
			An additional primitive data type 
			<code>
				"file"
			</code>
			is used by the 
			<a href="/relax/home/OpenAPIDocs#parameterObject">
				Parameter Object
			</a>
			and the 
			<a href="/relax/home/OpenAPIDocs#responseObject">
				Response Object
			</a>
			to set the parameter type or the response as being a file.
		</p>
		<p>
			<a name="dataTypeFormat">
			</a>
			Primitives have an optional modifier property 
			<code>
				format
			</code>
			. OpenAPI uses several known formats to more finely define the data type being used. However, the 
			<code>
				format
			</code>
			property is an open 
			<code>
				string
			</code>
			-valued property, and can have any value to support documentation needs. Formats such as 
			<code>
				"email"
			</code>
			, 
			<code>
				"uuid"
			</code>
			, etc., can be used even though they are not defined by this specification. Types that are not accompanied by a 
			<code>
				format
			</code>
			property follow their definition from the JSON Schema (except for 
			<code>
				file
			</code>
			type which is defined above). The formats defined by the OpenAPI Specification are:
		</p>
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>
						Common Name
					</th>
					<th>
						<a href="/relax/home/OpenAPIDocs#dataTypeType">
							<code>
								type
							</code>
						</a>
					</th>
					<th>
						<a href="/relax/home/OpenAPIDocs#dataTypeFormat">
							<code>
								format
							</code>
						</a>
					</th>
					<th>
						Comments
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						integer
					</td>
					<td>
						<code>
							integer
						</code>
					</td>
					<td>
						<code>
							int32
						</code>
					</td>
					<td>
						signed 32 bits
					</td>
				</tr>
				<tr>
					<td>
						long
					</td>
					<td>
						<code>
							integer
						</code>
					</td>
					<td>
						<code>
							int64
						</code>
					</td>
					<td>
						signed 64 bits
					</td>
				</tr>
				<tr>
					<td>
						float
					</td>
					<td>
						<code>
							number
						</code>
					</td>
					<td>
						<code>
							float
						</code>
					</td>
					<td>
					</td>
				</tr>
				<tr>
					<td>
						double
					</td>
					<td>
						<code>
							number
						</code>
					</td>
					<td>
						<code>
							double
						</code>
					</td>
					<td>
					</td>
				</tr>
				<tr>
					<td>
						string
					</td>
					<td>
						<code>
							string
						</code>
					</td>
					<td>
					</td>
					<td>
					</td>
				</tr>
				<tr>
					<td>
						byte
					</td>
					<td>
						<code>
							string
						</code>
					</td>
					<td>
						<code>
							byte
						</code>
					</td>
					<td>
						base64 encoded characters
					</td>
				</tr>
				<tr>
					<td>
						binary
					</td>
					<td>
						<code>
							string
						</code>
					</td>
					<td>
						<code>
							binary
						</code>
					</td>
					<td>
						any sequence of octets
					</td>
				</tr>
				<tr>
					<td>
						boolean
					</td>
					<td>
						<code>
							boolean
						</code>
					</td>
					<td>
					</td>
					<td>
					</td>
				</tr>
				<tr>
					<td>
						date
					</td>
					<td>
						<code>
							string
						</code>
					</td>
					<td>
						<code>
							date
						</code>
					</td>
					<td>
						As defined by 
						<code>
							full-date
						</code>
						- 
						<a href="http://xml2rfc.ietf.org/public/rfc/html/rfc3339.html#anchor14">
							RFC3339
						</a>
					</td>
				</tr>
				<tr>
					<td>
						dateTime
					</td>
					<td>
						<code>
							string
						</code>
					</td>
					<td>
						<code>
							date-time
						</code>
					</td>
					<td>
						As defined by 
						<code>
							date-time
						</code>
						- 
						<a href="http://xml2rfc.ietf.org/public/rfc/html/rfc3339.html#anchor14">
							RFC3339
						</a>
					</td>
				</tr>
				<tr>
					<td>
						password
					</td>
					<td>
						<code>
							string
						</code>
					</td>
					<td>
						<code>
							password
						</code>
					</td>
					<td>
						Used to hint UIs the input needs to be obscured.
					</td>
				</tr>
			</tbody>
		</table>
		<h3>
			<a id="schema" class="anchor" href="#schema" aria-hidden="true">
				</a>
			Schema
		</h3>
		<h4>
			<a id="OpenAPI-object" class="anchor" href="#OpenAPI-object" aria-hidden="true">
				</a>
			<a name="OpenAPIObject">
			</a>
			OpenAPI Object
		</h4>
		<p>
			This is the root document object for the API specification. It combines what previously was the Resource Listing and API Declaration (version 1.2 and earlier) together into one document.
		</p>
		<h5>
			<a id="fixed-fields" class="anchor" href="#fixed-fields" aria-hidden="true">
				</a>
			Fixed Fields
		</h5>
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>
						Field Name
					</th>
					<th align="center">
						Type
					</th>
					<th>
						Description
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<a name="OpenAPIOpenAPI">
						</a>
						OpenAPI
					</td>
					<td align="center">
						<code>
							string
						</code>
					</td>
					<td>
						<strong>
							Required.
						</strong>
						Specifies the OpenAPI Specification version being used. It can be used by the OpenAPI UI and other clients to interpret the API listing. The value MUST be 
						<code>
							"2.0"
						</code>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="OpenAPIInfo">
						</a>
						info
					</td>
					<td align="center">
						<a href="/relax/home/OpenAPIDocs#infoObject">
							Info Object
						</a>
					</td>
					<td>
						<strong>
							Required.
						</strong>
						Provides metadata about the API. The metadata can be used by the clients if needed.
					</td>
				</tr>
				<tr>
					<td>
						<a name="OpenAPIHost">
						</a>
						host
					</td>
					<td align="center">
						<code>
							string
						</code>
					</td>
					<td>
						The host (name or ip) serving the API. This MUST be the host only and does not include the scheme nor sub-paths. It MAY include a port. If the 
						<code>
							host
						</code>
						is not included, the host serving the documentation is to be used (including the port). The 
						<code>
							host
						</code>
						does not support 
						<a href="/relax/home/OpenAPIDocs#pathTemplating">
							path templating
						</a>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="OpenAPIBasePath">
						</a>
						basePath
					</td>
					<td align="center">
						<code>
							string
						</code>
					</td>
					<td>
						The base path on which the API is served, which is relative to the 
						<a href="/relax/home/OpenAPIDocs#OpenAPIHost">
							<code>
								host
							</code>
						</a>
						. If it is not included, the API is served directly under the 
						<code>
							host
						</code>
						. The value MUST start with a leading slash (
						<code>
							/
						</code>
						). The 
						<code>
							basePath
						</code>
						does not support 
						<a href="/relax/home/OpenAPIDocs#pathTemplating">
							path templating
						</a>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="OpenAPISchemes">
						</a>
						schemes
					</td>
					<td align="center">
						[
						<code>
							string
						</code>
						]
					</td>
					<td>
						The transfer protocol of the API. Values MUST be from the list: 
						<code>
							"http"
						</code>
						, 
						<code>
							"https"
						</code>
						, 
						<code>
							"ws"
						</code>
						, 
						<code>
							"wss"
						</code>
						. If the 
						<code>
							schemes
						</code>
						is not included, the default scheme to be used is the one used to access the OpenAPI definition itself.
					</td>
				</tr>
				<tr>
					<td>
						<a name="OpenAPIConsumes">
						</a>
						consumes
					</td>
					<td align="center">
						[
						<code>
							string
						</code>
						]
					</td>
					<td>
						A list of MIME types the APIs can consume. This is global to all APIs but can be overridden on specific API calls. Value MUST be as described under 
						<a href="/relax/home/OpenAPIDocs#mimeTypes">
							Mime Types
						</a>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="OpenAPIProduces">
						</a>
						produces
					</td>
					<td align="center">
						[
						<code>
							string
						</code>
						]
					</td>
					<td>
						A list of MIME types the APIs can produce. This is global to all APIs but can be overridden on specific API calls. Value MUST be as described under 
						<a href="/relax/home/OpenAPIDocs#mimeTypes">
							Mime Types
						</a>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="OpenAPIPaths">
						</a>
						paths
					</td>
					<td align="center">
						<a href="/relax/home/OpenAPIDocs#pathsObject">
							Paths Object
						</a>
					</td>
					<td>
						<strong>
							Required.
						</strong>
						The available paths and operations for the API.
					</td>
				</tr>
				<tr>
					<td>
						<a name="OpenAPIDefinitions">
						</a>
						definitions
					</td>
					<td align="center">
						<a href="/relax/home/OpenAPIDocs#definitionsObject">
							Definitions Object
						</a>
					</td>
					<td>
						An object to hold data types produced and consumed by operations.
					</td>
				</tr>
				<tr>
					<td>
						<a name="OpenAPIParameters">
						</a>
						parameters
					</td>
					<td align="center">
						<a href="/relax/home/OpenAPIDocs#parametersDefinitionsObject">
							Parameters Definitions Object
						</a>
					</td>
					<td>
						An object to hold parameters that can be used across operations. This property 
						<em>
							does not
						</em>
						define global parameters for all operations.
					</td>
				</tr>
				<tr>
					<td>
						<a name="OpenAPIResponses">
						</a>
						responses
					</td>
					<td align="center">
						<a href="/relax/home/OpenAPIDocs#responsesDefinitionsObject">
							Responses Definitions Object
						</a>
					</td>
					<td>
						An object to hold responses that can be used across operations. This property 
						<em>
							does not
						</em>
						define global responses for all operations.
					</td>
				</tr>
				<tr>
					<td>
						<a name="OpenAPISecurityDefinitions">
						</a>
						securityDefinitions
					</td>
					<td align="center">
						<a href="/relax/home/OpenAPIDocs#securityDefinitionsObject">
							Security Definitions Object
						</a>
					</td>
					<td>
						Security scheme definitions that can be used across the specification.
					</td>
				</tr>
				<tr>
					<td>
						<a name="OpenAPISecurity">
						</a>
						security
					</td>
					<td align="center">
						[
						<a href="/relax/home/OpenAPIDocs#securityRequirementObject">
							Security Requirement Object
						</a>
						]
					</td>
					<td>
						A declaration of which security schemes are applied for the API as a whole. The list of values describes alternative security schemes that can be used (that is, there is a logical OR between the security requirements). Individual operations can override this definition.
					</td>
				</tr>
				<tr>
					<td>
						<a name="OpenAPITags">
						</a>
						tags
					</td>
					<td align="center">
						[
						<a href="/relax/home/OpenAPIDocs#tagObject">
							Tag Object
						</a>
						]
					</td>
					<td>
						A list of tags used by the specification with additional metadata. The order of the tags can be used to reflect on their order by the parsing tools. Not all tags that are used by the 
						<a href="/relax/home/OpenAPIDocs#operationObject">
							Operation Object
						</a>
						must be declared. The tags that are not declared may be organized randomly or based on the tools' logic. Each tag name in the list MUST be unique.
					</td>
				</tr>
				<tr>
					<td>
						<a name="externalDocumentationObject">
						</a>
						externalDocs
					</td>
					<td align="center">
						<a href="/relax/home/OpenAPIDocs#externalDocumentationObject">
							External Documentation Object
						</a>
					</td>
					<td>
						Additional external documentation.
					</td>
				</tr>
			</tbody>
		</table>
		<h5>
			<a id="patterned-objects" class="anchor" href="#patterned-objects" aria-hidden="true">
				</a>
			Patterned Objects
		</h5>
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>
						Field Pattern
					</th>
					<th align="center">
						Type
					</th>
					<th>
						Description
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<a name="OpenAPIExtensions">
						</a>
						^x-
					</td>
					<td align="center">
						Any
					</td>
					<td>
						Allows extensions to the OpenAPI Schema. The field name MUST begin with 
						<code>
							x-
						</code>
						, for example, 
						<code>
							x-internal-id
						</code>
						. The value can be 
						<code>
							null
						</code>
						, a primitive, an array or an object. See 
						<a href="/relax/home/OpenAPIDocs#vendorExtensions">
							Vendor Extensions
						</a>
						for further details.
					</td>
				</tr>
			</tbody>
		</table>
		<h4>
			<a id="info-object" class="anchor" href="#info-object" aria-hidden="true">
				</a>
			<a name="infoObject">
			</a>
			Info Object
		</h4>
		<p>
			The object provides metadata about the API. The metadata can be used by the clients if needed, and can be presented in the OpenAPI-UI for convenience.
		</p>
		<h5>
			<a id="fixed-fields-1" class="anchor" href="#fixed-fields-1" aria-hidden="true">
				</a>
			Fixed Fields
		</h5>
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>
						Field Name
					</th>
					<th align="center">
						Type
					</th>
					<th>
						Description
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<a name="infoTitle">
						</a>
						title
					</td>
					<td align="center">
						<code>
							string
						</code>
					</td>
					<td>
						<strong>
							Required.
						</strong>
						The title of the application.
					</td>
				</tr>
				<tr>
					<td>
						<a name="infoDescription">
						</a>
						description
					</td>
					<td align="center">
						<code>
							string
						</code>
					</td>
					<td>
						A short description of the application. 
						<a href="https://help.github.com/articles/github-flavored-markdown">
							GFM syntax
						</a>
						can be used for rich text representation.
					</td>
				</tr>
				<tr>
					<td>
						<a name="infoTermsOfService">
						</a>
						termsOfService
					</td>
					<td align="center">
						<code>
							string
						</code>
					</td>
					<td>
						The Terms of Service for the API.
					</td>
				</tr>
				<tr>
					<td>
						<a name="infoContact">
						</a>
						contact
					</td>
					<td align="center">
						<a href="/relax/home/OpenAPIDocs#contactObject">
							Contact Object
						</a>
					</td>
					<td>
						The contact information for the exposed API.
					</td>
				</tr>
				<tr>
					<td>
						<a name="infoLicense">
						</a>
						license
					</td>
					<td align="center">
						<a href="/relax/home/OpenAPIDocs#licenseObject">
							License Object
						</a>
					</td>
					<td>
						The license information for the exposed API.
					</td>
				</tr>
				<tr>
					<td>
						<a name="infoVersion">
						</a>
						version
					</td>
					<td align="center">
						<code>
							string
						</code>
					</td>
					<td>
						<strong>
							Required
						</strong>
						Provides the version of the application API (not to be confused with the specification version).
					</td>
				</tr>
			</tbody>
		</table>
		<h5>
			<a id="patterned-objects-1" class="anchor" href="#patterned-objects-1" aria-hidden="true">
				</a>
			Patterned Objects
		</h5>
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>
						Field Pattern
					</th>
					<th align="center">
						Type
					</th>
					<th>
						Description
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<a name="infoExtensions">
						</a>
						^x-
					</td>
					<td align="center">
						Any
					</td>
					<td>
						Allows extensions to the OpenAPI Schema. The field name MUST begin with 
						<code>
							x-
						</code>
						, for example, 
						<code>
							x-internal-id
						</code>
						. The value can be 
						<code>
							null
						</code>
						, a primitive, an array or an object. See 
						<a href="/relax/home/OpenAPIDocs#vendorExtensions">
							Vendor Extensions
						</a>
						for further details.
					</td>
				</tr>
			</tbody>
		</table>
		<h5>
			<a id="info-object-example" class="anchor" href="#info-object-example" aria-hidden="true">
				</a>
			Info Object Example:
		</h5>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
  <span class="pl-s"><span class="pl-pds">"</span>title<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>OpenAPI Sample App<span class="pl-pds">"</span></span>,
  <span class="pl-s"><span class="pl-pds">"</span>description<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>This is a sample server Petstore server.<span class="pl-pds">"</span></span>,
  <span class="pl-s"><span class="pl-pds">"</span>termsOfService<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>http://OpenAPI.io/terms/<span class="pl-pds">"</span></span>,
  <span class="pl-s"><span class="pl-pds">"</span>contact<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
    <span class="pl-s"><span class="pl-pds">"</span>name<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>API Support<span class="pl-pds">"</span></span>,
    <span class="pl-s"><span class="pl-pds">"</span>url<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>http://www.OpenAPI.io/support<span class="pl-pds">"</span></span>,
    <span class="pl-s"><span class="pl-pds">"</span>email<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>support@OpenAPI.io<span class="pl-pds">"</span></span>
  },
  <span class="pl-s"><span class="pl-pds">"</span>license<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
    <span class="pl-s"><span class="pl-pds">"</span>name<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>Apache 2.0<span class="pl-pds">"</span></span>,
    <span class="pl-s"><span class="pl-pds">"</span>url<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>http://www.apache.org/licenses/LICENSE-2.0.html<span class="pl-pds">"</span></span>
  },
  <span class="pl-s"><span class="pl-pds">"</span>version<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>1.0.1<span class="pl-pds">"</span></span>
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">title:</span> <span class="pl-s">OpenAPI Sample App</span></span>
<span class="pl-s"><span class="pl-ent">description:</span> <span class="pl-s">This is a sample server Petstore server.</span></span>
<span class="pl-s"><span class="pl-ent">termsOfService:</span> <span class="pl-s">http://OpenAPI.io/terms/</span></span>
<span class="pl-s"><span class="pl-ent">contact:</span></span>
  <span class="pl-s"><span class="pl-ent">name:</span> <span class="pl-s">API Support</span></span>
  <span class="pl-s"><span class="pl-ent">url:</span> <span class="pl-s">http://www.OpenAPI.io/support</span></span>
  <span class="pl-s"><span class="pl-ent">email:</span> <span class="pl-s">support@OpenAPI.io</span></span>
<span class="pl-s"><span class="pl-ent">license:</span></span>
  <span class="pl-s"><span class="pl-ent">name:</span> <span class="pl-s">Apache 2.0</span></span>
  <span class="pl-s"><span class="pl-ent">url:</span> <span class="pl-s">http://www.apache.org/licenses/LICENSE-2.0.html</span></span>
<span class="pl-s"><span class="pl-ent">version:</span> <span class="pl-s">1.0.1</span></span></pre>
		</div>
		<h4>
			<a id="contact-object" class="anchor" href="#contact-object" aria-hidden="true">
				</a>
			<a name="contactObject">
			</a>
			Contact Object
		</h4>
		<p>
			Contact information for the exposed API.
		</p>
		<h5>
			<a id="fixed-fields-2" class="anchor" href="#fixed-fields-2" aria-hidden="true">
				</a>
			Fixed Fields
		</h5>
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>
						Field Name
					</th>
					<th align="center">
						Type
					</th>
					<th>
						Description
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<a name="contactName">
						</a>
						name
					</td>
					<td align="center">
						<code>
							string
						</code>
					</td>
					<td>
						The identifying name of the contact person/organization.
					</td>
				</tr>
				<tr>
					<td>
						<a name="contactUrl">
						</a>
						url
					</td>
					<td align="center">
						<code>
							string
						</code>
					</td>
					<td>
						The URL pointing to the contact information. MUST be in the format of a URL.
					</td>
				</tr>
				<tr>
					<td>
						<a name="contactEmail">
						</a>
						email
					</td>
					<td align="center">
						<code>
							string
						</code>
					</td>
					<td>
						The email address of the contact person/organization. MUST be in the format of an email address.
					</td>
				</tr>
			</tbody>
		</table>
		<h5>
			<a id="patterned-objects-2" class="anchor" href="#patterned-objects-2" aria-hidden="true">
				</a>
			Patterned Objects
		</h5>
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>
						Field Pattern
					</th>
					<th align="center">
						Type
					</th>
					<th>
						Description
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<a name="contactExtensions">
						</a>
						^x-
					</td>
					<td align="center">
						Any
					</td>
					<td>
						Allows extensions to the OpenAPI Schema. The field name MUST begin with 
						<code>
							x-
						</code>
						, for example, 
						<code>
							x-internal-id
						</code>
						. The value can be 
						<code>
							null
						</code>
						, a primitive, an array or an object. See 
						<a href="/relax/home/OpenAPIDocs#vendorExtensions">
							Vendor Extensions
						</a>
						for further details.
					</td>
				</tr>
			</tbody>
		</table>
		<h5>
			<a id="contact-object-example" class="anchor" href="#contact-object-example" aria-hidden="true">
				</a>
			Contact Object Example:
		</h5>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
  <span class="pl-s"><span class="pl-pds">"</span>name<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>API Support<span class="pl-pds">"</span></span>,
  <span class="pl-s"><span class="pl-pds">"</span>url<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>http://www.OpenAPI.io/support<span class="pl-pds">"</span></span>,
  <span class="pl-s"><span class="pl-pds">"</span>email<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>support@OpenAPI.io<span class="pl-pds">"</span></span>
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">name:</span> <span class="pl-s">API Support</span></span>
<span class="pl-s"><span class="pl-ent">url:</span> <span class="pl-s">http://www.OpenAPI.io/support</span></span>
<span class="pl-s"><span class="pl-ent">email:</span> <span class="pl-s">support@OpenAPI.io</span></span></pre>
		</div>
		<h4>
			<a id="license-object" class="anchor" href="#license-object" aria-hidden="true">
				</a>
			<a name="licenseObject">
			</a>
			License Object
		</h4>
		<p>
			License information for the exposed API.
		</p>
		<h5>
			<a id="fixed-fields-3" class="anchor" href="#fixed-fields-3" aria-hidden="true">
				</a>
			Fixed Fields
		</h5>
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>
						Field Name
					</th>
					<th align="center">
						Type
					</th>
					<th>
						Description
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<a name="licenseName">
						</a>
						name
					</td>
					<td align="center">
						<code>
							string
						</code>
					</td>
					<td>
						<strong>
							Required.
						</strong>
						The license name used for the API.
					</td>
				</tr>
				<tr>
					<td>
						<a name="licenseUrl">
						</a>
						url
					</td>
					<td align="center">
						<code>
							string
						</code>
					</td>
					<td>
						A URL to the license used for the API. MUST be in the format of a URL.
					</td>
				</tr>
			</tbody>
		</table>
		<h5>
			<a id="patterned-objects-3" class="anchor" href="#patterned-objects-3" aria-hidden="true">
				</a>
			Patterned Objects
		</h5>
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>
						Field Pattern
					</th>
					<th align="center">
						Type
					</th>
					<th>
						Description
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<a name="licenseExtensions">
						</a>
						^x-
					</td>
					<td align="center">
						Any
					</td>
					<td>
						Allows extensions to the OpenAPI Schema. The field name MUST begin with 
						<code>
							x-
						</code>
						, for example, 
						<code>
							x-internal-id
						</code>
						. The value can be 
						<code>
							null
						</code>
						, a primitive, an array or an object. See 
						<a href="/relax/home/OpenAPIDocs#vendorExtensions">
							Vendor Extensions
						</a>
						for further details.
					</td>
				</tr>
			</tbody>
		</table>
		<h5>
			<a id="license-object-example" class="anchor" href="#license-object-example" aria-hidden="true">
				</a>
			License Object Example:
		</h5>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
  <span class="pl-s"><span class="pl-pds">"</span>name<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>Apache 2.0<span class="pl-pds">"</span></span>,
  <span class="pl-s"><span class="pl-pds">"</span>url<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>http://www.apache.org/licenses/LICENSE-2.0.html<span class="pl-pds">"</span></span>
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">name:</span> <span class="pl-s">Apache 2.0</span></span>
<span class="pl-s"><span class="pl-ent">url:</span> <span class="pl-s">http://www.apache.org/licenses/LICENSE-2.0.html</span></span></pre>
		</div>
		<h4>
			<a id="paths-object" class="anchor" href="#paths-object" aria-hidden="true">
				</a>
			<a name="pathsObject">
			</a>
			Paths Object
		</h4>
		<p>
			Holds the relative paths to the individual endpoints. The path is appended to the 
			<a href="/relax/home/OpenAPIDocs#OpenAPIBasePath">
				<code>
					basePath
				</code>
			</a>
			in order to construct the full URL. The Paths may be empty, due to 
			<a href="/relax/home/OpenAPIDocs#securityFiltering">
				ACL constraints
			</a>
			.
		</p>
		<h5>
			<a id="patterned-fields" class="anchor" href="#patterned-fields" aria-hidden="true">
				</a>
			Patterned Fields
		</h5>
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>
						Field Pattern
					</th>
					<th align="center">
						Type
					</th>
					<th>
						Description
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<a name="pathsPath">
						</a>
						/{path}
					</td>
					<td align="center">
						<a href="/relax/home/OpenAPIDocs#pathItemObject">
							Path Item Object
						</a>
					</td>
					<td>
						A relative path to an individual endpoint. The field name MUST begin with a slash. The path is appended to the 
						<a href="/relax/home/OpenAPIDocs#OpenAPIBasePath">
							<code>
								basePath
							</code>
						</a>
						in order to construct the full URL. 
						<a href="/relax/home/OpenAPIDocs#pathTemplating">
							Path templating
						</a>
						is allowed.
					</td>
				</tr>
				<tr>
					<td>
						<a name="pathsExtensions">
						</a>
						^x-
					</td>
					<td align="center">
						Any
					</td>
					<td>
						Allows extensions to the OpenAPI Schema. The field name MUST begin with 
						<code>
							x-
						</code>
						, for example, 
						<code>
							x-internal-id
						</code>
						. The value can be 
						<code>
							null
						</code>
						, a primitive, an array or an object. See 
						<a href="/relax/home/OpenAPIDocs#vendorExtensions">
							Vendor Extensions
						</a>
						for further details.
					</td>
				</tr>
			</tbody>
		</table>
		<h5>
			<a id="paths-object-example" class="anchor" href="#paths-object-example" aria-hidden="true">
				</a>
			Paths Object Example
		</h5>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
  <span class="pl-s"><span class="pl-pds">"</span>/pets<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
    <span class="pl-s"><span class="pl-pds">"</span>get<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
      <span class="pl-s"><span class="pl-pds">"</span>description<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>Returns all pets from the system that the user has access to<span class="pl-pds">"</span></span>,
      <span class="pl-s"><span class="pl-pds">"</span>produces<span class="pl-pds">"</span></span><span class="pl-k">:</span> [
        <span class="pl-s"><span class="pl-pds">"</span>application/json<span class="pl-pds">"</span></span>
      ],
      <span class="pl-s"><span class="pl-pds">"</span>responses<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
        <span class="pl-s"><span class="pl-pds">"</span>200<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
          <span class="pl-s"><span class="pl-pds">"</span>description<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>A list of pets.<span class="pl-pds">"</span></span>,
          <span class="pl-s"><span class="pl-pds">"</span>schema<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
            <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>array<span class="pl-pds">"</span></span>,
            <span class="pl-s"><span class="pl-pds">"</span>items<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
              <span class="pl-s"><span class="pl-pds">"</span>$ref<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>#/definitions/pet<span class="pl-pds">"</span></span>
            }
          }
        }
      }
    }
  }
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">/pets:</span></span>
  <span class="pl-s"><span class="pl-ent">get:</span></span>
    <span class="pl-s"><span class="pl-ent">description:</span> <span class="pl-s">Returns all pets from the system that the user has access to</span></span>
    <span class="pl-s"><span class="pl-ent">produces:</span></span>
    <span class="pl-s">- <span class="pl-s">application/json</span></span>
    <span class="pl-s"><span class="pl-ent">responses:</span></span>
      <span class="pl-s"><span class="pl-ent">'200':</span></span>
        <span class="pl-s"><span class="pl-ent">description:</span> <span class="pl-s">A list of pets.</span></span>
        <span class="pl-s"><span class="pl-ent">schema:</span></span>
          <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">array</span></span>
          <span class="pl-s"><span class="pl-ent">items:</span></span>
            <span class="pl-s"><span class="pl-ent">$ref:</span> <span class="pl-s"><span class="pl-pds">'</span>#/definitions/pet<span class="pl-pds">'</span></span></span></pre>
		</div>
		<h4>
			<a id="path-item-object" class="anchor" href="#path-item-object" aria-hidden="true">
				</a>
			<a name="pathItemObject">
			</a>
			Path Item Object
		</h4>
		<p>
			Describes the operations available on a single path. A Path Item may be empty, due to 
			<a href="/relax/home/OpenAPIDocs#securityFiltering">
				ACL constraints
			</a>
			. The path itself is still exposed to the documentation viewer but they will not know which operations and parameters are available.
		</p>
		<h5>
			<a id="fixed-fields-4" class="anchor" href="#fixed-fields-4" aria-hidden="true">
				</a>
			Fixed Fields
		</h5>
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>
						Field Name
					</th>
					<th align="center">
						Type
					</th>
					<th>
						Description
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<a name="pathItemRef">
						</a>
						$ref
					</td>
					<td align="center">
						<code>
							string
						</code>
					</td>
					<td>
						Allows for an external definition of this path item. The referenced structure MUST be in the format of a 
						<a href="/relax/home/OpenAPIDocs#pathItemObject">
							Path Item Object
						</a>
						. If there are conflicts between the referenced definition and this Path Item's definition, the behavior is 
						<em>
							undefined
						</em>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="pathItemGet">
						</a>
						get
					</td>
					<td align="center">
						<a href="/relax/home/OpenAPIDocs#operationObject">
							Operation Object
						</a>
					</td>
					<td>
						A definition of a GET operation on this path.
					</td>
				</tr>
				<tr>
					<td>
						<a name="pathItemPut">
						</a>
						put
					</td>
					<td align="center">
						<a href="/relax/home/OpenAPIDocs#operationObject">
							Operation Object
						</a>
					</td>
					<td>
						A definition of a PUT operation on this path.
					</td>
				</tr>
				<tr>
					<td>
						<a name="pathItemPost">
						</a>
						post
					</td>
					<td align="center">
						<a href="/relax/home/OpenAPIDocs#operationObject">
							Operation Object
						</a>
					</td>
					<td>
						A definition of a POST operation on this path.
					</td>
				</tr>
				<tr>
					<td>
						<a name="pathItemDelete">
						</a>
						delete
					</td>
					<td align="center">
						<a href="/relax/home/OpenAPIDocs#operationObject">
							Operation Object
						</a>
					</td>
					<td>
						A definition of a DELETE operation on this path.
					</td>
				</tr>
				<tr>
					<td>
						<a name="pathItemOptions">
						</a>
						options
					</td>
					<td align="center">
						<a href="/relax/home/OpenAPIDocs#operationObject">
							Operation Object
						</a>
					</td>
					<td>
						A definition of a OPTIONS operation on this path.
					</td>
				</tr>
				<tr>
					<td>
						<a name="pathItemHead">
						</a>
						head
					</td>
					<td align="center">
						<a href="/relax/home/OpenAPIDocs#operationObject">
							Operation Object
						</a>
					</td>
					<td>
						A definition of a HEAD operation on this path.
					</td>
				</tr>
				<tr>
					<td>
						<a name="pathItemPatch">
						</a>
						patch
					</td>
					<td align="center">
						<a href="/relax/home/OpenAPIDocs#operationObject">
							Operation Object
						</a>
					</td>
					<td>
						A definition of a PATCH operation on this path.
					</td>
				</tr>
				<tr>
					<td>
						<a name="pathItemParameters">
						</a>
						parameters
					</td>
					<td align="center">
						[
						<a href="/relax/home/OpenAPIDocs#parameterObject">
							Parameter Object
						</a>
						| 
						<a href="/relax/home/OpenAPIDocs#referenceObject">
							Reference Object
						</a>
						]
					</td>
					<td>
						A list of parameters that are applicable for all the operations described under this path. These parameters can be overridden at the operation level, but cannot be removed there. The list MUST NOT include duplicated parameters. A unique parameter is defined by a combination of a 
						<a href="/relax/home/OpenAPIDocs#parameterName">
							name
						</a>
						and 
						<a href="/relax/home/OpenAPIDocs#parameterIn">
							location
						</a>
						. The list can use the 
						<a href="/relax/home/OpenAPIDocs#referenceObject">
							Reference Object
						</a>
						to link to parameters that are defined at the 
						<a href="/relax/home/OpenAPIDocs#OpenAPIParameters">
							OpenAPI Object's parameters
						</a>
						. There can be one "body" parameter at most.
					</td>
				</tr>
			</tbody>
		</table>
		<h5>
			<a id="patterned-fields-1" class="anchor" href="#patterned-fields-1" aria-hidden="true">
				</a>
			Patterned Fields
		</h5>
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>
						Field Pattern
					</th>
					<th align="center">
						Type
					</th>
					<th>
						Description
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<a name="pathItemExtensions">
						</a>
						^x-
					</td>
					<td align="center">
						Any
					</td>
					<td>
						Allows extensions to the OpenAPI Schema. The field name MUST begin with 
						<code>
							x-
						</code>
						, for example, 
						<code>
							x-internal-id
						</code>
						. The value can be 
						<code>
							null
						</code>
						, a primitive, an array or an object. See 
						<a href="/relax/home/OpenAPIDocs#vendorExtensions">
							Vendor Extensions
						</a>
						for further details.
					</td>
				</tr>
			</tbody>
		</table>
		<h5>
			<a id="path-item-object-example" class="anchor" href="#path-item-object-example" aria-hidden="true">
				</a>
			Path Item Object Example
		</h5>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
  <span class="pl-s"><span class="pl-pds">"</span>get<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
    <span class="pl-s"><span class="pl-pds">"</span>description<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>Returns pets based on ID<span class="pl-pds">"</span></span>,
    <span class="pl-s"><span class="pl-pds">"</span>summary<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>Find pets by ID<span class="pl-pds">"</span></span>,
    <span class="pl-s"><span class="pl-pds">"</span>operationId<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>getPetsById<span class="pl-pds">"</span></span>,
    <span class="pl-s"><span class="pl-pds">"</span>produces<span class="pl-pds">"</span></span><span class="pl-k">:</span> [
      <span class="pl-s"><span class="pl-pds">"</span>application/json<span class="pl-pds">"</span></span>,
      <span class="pl-s"><span class="pl-pds">"</span>text/html<span class="pl-pds">"</span></span>
    ],
    <span class="pl-s"><span class="pl-pds">"</span>responses<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
      <span class="pl-s"><span class="pl-pds">"</span>200<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
        <span class="pl-s"><span class="pl-pds">"</span>description<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>pet response<span class="pl-pds">"</span></span>,
        <span class="pl-s"><span class="pl-pds">"</span>schema<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
          <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>array<span class="pl-pds">"</span></span>,
          <span class="pl-s"><span class="pl-pds">"</span>items<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
            <span class="pl-s"><span class="pl-pds">"</span>$ref<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>#/definitions/Pet<span class="pl-pds">"</span></span>
          }
        }
      },
      <span class="pl-s"><span class="pl-pds">"</span>default<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
        <span class="pl-s"><span class="pl-pds">"</span>description<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>error payload<span class="pl-pds">"</span></span>,
        <span class="pl-s"><span class="pl-pds">"</span>schema<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
          <span class="pl-s"><span class="pl-pds">"</span>$ref<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>#/definitions/ErrorModel<span class="pl-pds">"</span></span>
        }
      }
    }
  },
  <span class="pl-s"><span class="pl-pds">"</span>parameters<span class="pl-pds">"</span></span><span class="pl-k">:</span> [
    {
      <span class="pl-s"><span class="pl-pds">"</span>name<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>id<span class="pl-pds">"</span></span>,
      <span class="pl-s"><span class="pl-pds">"</span>in<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>path<span class="pl-pds">"</span></span>,
      <span class="pl-s"><span class="pl-pds">"</span>description<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>ID of pet to use<span class="pl-pds">"</span></span>,
      <span class="pl-s"><span class="pl-pds">"</span>required<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-c1">true</span>,
      <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>array<span class="pl-pds">"</span></span>,
      <span class="pl-s"><span class="pl-pds">"</span>items<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
        <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>string<span class="pl-pds">"</span></span>
      },
      <span class="pl-s"><span class="pl-pds">"</span>collectionFormat<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>csv<span class="pl-pds">"</span></span>
    }
  ]
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">get:</span></span>
  <span class="pl-s"><span class="pl-ent">description:</span> <span class="pl-s">Returns pets based on ID</span></span>
  <span class="pl-s"><span class="pl-ent">summary:</span> <span class="pl-s">Find pets by ID</span></span>
  <span class="pl-s"><span class="pl-ent">operationId:</span> <span class="pl-s">getPetsById</span></span>
  <span class="pl-s"><span class="pl-ent">produces:</span></span>
  <span class="pl-s">- <span class="pl-s">application/json</span></span>
  <span class="pl-s">- <span class="pl-s">text/html</span></span>
  <span class="pl-s"><span class="pl-ent">responses:</span></span>
    <span class="pl-s"><span class="pl-ent">'200':</span></span>
      <span class="pl-s"><span class="pl-ent">description:</span> <span class="pl-s">pet response</span></span>
      <span class="pl-s"><span class="pl-ent">schema:</span></span>
        <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">array</span></span>
        <span class="pl-s"><span class="pl-ent">items:</span></span>
          <span class="pl-s"><span class="pl-ent">$ref:</span> <span class="pl-s"><span class="pl-pds">'</span>#/definitions/Pet<span class="pl-pds">'</span></span></span>
    <span class="pl-s"><span class="pl-ent">default:</span></span>
      <span class="pl-s"><span class="pl-ent">description:</span> <span class="pl-s">error payload</span></span>
      <span class="pl-s"><span class="pl-ent">schema:</span></span>
        <span class="pl-s"><span class="pl-ent">$ref:</span> <span class="pl-s"><span class="pl-pds">'</span>#/definitions/ErrorModel<span class="pl-pds">'</span></span></span>
<span class="pl-s"><span class="pl-ent">parameters:</span></span>
<span class="pl-s">- <span class="pl-ent">name:</span> <span class="pl-s">id</span></span>
  <span class="pl-s"><span class="pl-ent">in:</span> <span class="pl-s">path</span></span>
  <span class="pl-s"><span class="pl-ent">description:</span> <span class="pl-s">ID of pet to use</span></span>
  <span class="pl-s"><span class="pl-ent">required:</span> <span class="pl-s">true</span></span>
  <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">array</span></span>
  <span class="pl-s"><span class="pl-ent">items:</span></span>
    <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">string</span></span>
  <span class="pl-s"><span class="pl-ent">collectionFormat:</span> <span class="pl-s">csv</span></span></pre>
		</div>
		<h4>
			<a id="operation-object" class="anchor" href="#operation-object" aria-hidden="true">
				</a>
			<a name="operationObject">
			</a>
			Operation Object
		</h4>
		<p>
			Describes a single API operation on a path.
		</p>
		<h5>
			<a id="fixed-fields-5" class="anchor" href="#fixed-fields-5" aria-hidden="true">
				</a>
			Fixed Fields
		</h5>
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>
						Field Name
					</th>
					<th align="center">
						Type
					</th>
					<th>
						Description
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<a name="operationTags">
						</a>
						tags
					</td>
					<td align="center">
						[
						<code>
							string
						</code>
						]
					</td>
					<td>
						A list of tags for API documentation control. Tags can be used for logical grouping of operations by resources or any other qualifier.
					</td>
				</tr>
				<tr>
					<td>
						<a name="operationSummary">
						</a>
						summary
					</td>
					<td align="center">
						<code>
							string
						</code>
					</td>
					<td>
						A short summary of what the operation does. For maximum readability in the OpenAPI-ui, this field SHOULD be less than 120 characters.
					</td>
				</tr>
				<tr>
					<td>
						<a name="operationDescription">
						</a>
						description
					</td>
					<td align="center">
						<code>
							string
						</code>
					</td>
					<td>
						A verbose explanation of the operation behavior. 
						<a href="https://help.github.com/articles/github-flavored-markdown">
							GFM syntax
						</a>
						can be used for rich text representation.
					</td>
				</tr>
				<tr>
					<td>
						<a name="operationExternalDocs">
						</a>
						externalDocs
					</td>
					<td align="center">
						<a href="/relax/home/OpenAPIDocs#externalDocumentationObject">
							External Documentation Object
						</a>
					</td>
					<td>
						Additional external documentation for this operation.
					</td>
				</tr>
				<tr>
					<td>
						<a name="operationId">
						</a>
						operationId
					</td>
					<td align="center">
						<code>
							string
						</code>
					</td>
					<td>
						Unique string used to identify the operation. The id MUST be unique among all operations described in the API. Tools and libraries MAY use the operationId to uniquely identify an operation, therefore, it is recommended to follow common programming naming conventions.
					</td>
				</tr>
				<tr>
					<td>
						<a name="operationConsumes">
						</a>
						consumes
					</td>
					<td align="center">
						[
						<code>
							string
						</code>
						]
					</td>
					<td>
						A list of MIME types the operation can consume. This overrides the 
						<a href="/relax/home/OpenAPIDocs#OpenAPIConsumes">
							<code>
								consumes
							</code>
						</a>
						definition at the OpenAPI Object. An empty value MAY be used to clear the global definition. Value MUST be as described under 
						<a href="/relax/home/OpenAPIDocs#mimeTypes">
							Mime Types
						</a>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="operationProduces">
						</a>
						produces
					</td>
					<td align="center">
						[
						<code>
							string
						</code>
						]
					</td>
					<td>
						A list of MIME types the operation can produce. This overrides the 
						<a href="/relax/home/OpenAPIDocs#OpenAPIProduces">
							<code>
								produces
							</code>
						</a>
						definition at the OpenAPI Object. An empty value MAY be used to clear the global definition. Value MUST be as described under 
						<a href="/relax/home/OpenAPIDocs#mimeTypes">
							Mime Types
						</a>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="operationParameters">
						</a>
						parameters
					</td>
					<td align="center">
						[
						<a href="/relax/home/OpenAPIDocs#parameterObject">
							Parameter Object
						</a>
						| 
						<a href="/relax/home/OpenAPIDocs#referenceObject">
							Reference Object
						</a>
						]
					</td>
					<td>
						A list of parameters that are applicable for this operation. If a parameter is already defined at the 
						<a href="/relax/home/OpenAPIDocs#pathItemParameters">
							Path Item
						</a>
						, the new definition will override it, but can never remove it. The list MUST NOT include duplicated parameters. A unique parameter is defined by a combination of a 
						<a href="/relax/home/OpenAPIDocs#parameterName">
							name
						</a>
						and 
						<a href="/relax/home/OpenAPIDocs#parameterIn">
							location
						</a>
						. The list can use the 
						<a href="/relax/home/OpenAPIDocs#referenceObject">
							Reference Object
						</a>
						to link to parameters that are defined at the 
						<a href="/relax/home/OpenAPIDocs#OpenAPIParameters">
							OpenAPI Object's parameters
						</a>
						. There can be one "body" parameter at most.
					</td>
				</tr>
				<tr>
					<td>
						<a name="operationResponses">
						</a>
						responses
					</td>
					<td align="center">
						<a href="/relax/home/OpenAPIDocs#responsesObject">
							Responses Object
						</a>
					</td>
					<td>
						<strong>
							Required.
						</strong>
						The list of possible responses as they are returned from executing this operation.
					</td>
				</tr>
				<tr>
					<td>
						<a name="operationSchemes">
						</a>
						schemes
					</td>
					<td align="center">
						[
						<code>
							string
						</code>
						]
					</td>
					<td>
						The transfer protocol for the operation. Values MUST be from the list: 
						<code>
							"http"
						</code>
						, 
						<code>
							"https"
						</code>
						, 
						<code>
							"ws"
						</code>
						, 
						<code>
							"wss"
						</code>
						. The value overrides the OpenAPI Object 
						<a href="/relax/home/OpenAPIDocs#OpenAPISchemes">
							<code>
								schemes
							</code>
						</a>
						definition.
					</td>
				</tr>
				<tr>
					<td>
						<a name="operationDeprecated">
						</a>
						deprecated
					</td>
					<td align="center">
						<code>
							boolean
						</code>
					</td>
					<td>
						Declares this operation to be deprecated. Usage of the declared operation should be refrained. Default value is 
						<code>
							false
						</code>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="operationSecurity">
						</a>
						security
					</td>
					<td align="center">
						[
						<a href="/relax/home/OpenAPIDocs#securityRequirementObject">
							Security Requirement Object
						</a>
						]
					</td>
					<td>
						A declaration of which security schemes are applied for this operation. The list of values describes alternative security schemes that can be used (that is, there is a logical OR between the security requirements). This definition overrides any declared top-level 
						<a href="/relax/home/OpenAPIDocs#OpenAPISecurity">
							<code>
								security
							</code>
						</a>
						. To remove a top-level security declaration, an empty array can be used.
					</td>
				</tr>
			</tbody>
		</table>
		<h5>
			<a id="patterned-objects-4" class="anchor" href="#patterned-objects-4" aria-hidden="true">
				</a>
			Patterned Objects
		</h5>
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>
						Field Pattern
					</th>
					<th align="center">
						Type
					</th>
					<th>
						Description
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<a name="operationExtensions">
						</a>
						^x-
					</td>
					<td align="center">
						Any
					</td>
					<td>
						Allows extensions to the OpenAPI Schema. The field name MUST begin with 
						<code>
							x-
						</code>
						, for example, 
						<code>
							x-internal-id
						</code>
						. The value can be 
						<code>
							null
						</code>
						, a primitive, an array or an object. See 
						<a href="/relax/home/OpenAPIDocs#vendorExtensions">
							Vendor Extensions
						</a>
						for further details.
					</td>
				</tr>
			</tbody>
		</table>
		<h5>
			<a id="operation-object-example" class="anchor" href="#operation-object-example" aria-hidden="true">
				</a>
			Operation Object Example
		</h5>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
  <span class="pl-s"><span class="pl-pds">"</span>tags<span class="pl-pds">"</span></span><span class="pl-k">:</span> [
    <span class="pl-s"><span class="pl-pds">"</span>pet<span class="pl-pds">"</span></span>
  ],
  <span class="pl-s"><span class="pl-pds">"</span>summary<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>Updates a pet in the store with form data<span class="pl-pds">"</span></span>,
  <span class="pl-s"><span class="pl-pds">"</span>description<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span><span class="pl-pds">"</span></span>,
  <span class="pl-s"><span class="pl-pds">"</span>operationId<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>updatePetWithForm<span class="pl-pds">"</span></span>,
  <span class="pl-s"><span class="pl-pds">"</span>consumes<span class="pl-pds">"</span></span><span class="pl-k">:</span> [
    <span class="pl-s"><span class="pl-pds">"</span>application/x-www-form-urlencoded<span class="pl-pds">"</span></span>
  ],
  <span class="pl-s"><span class="pl-pds">"</span>produces<span class="pl-pds">"</span></span><span class="pl-k">:</span> [
    <span class="pl-s"><span class="pl-pds">"</span>application/json<span class="pl-pds">"</span></span>,
    <span class="pl-s"><span class="pl-pds">"</span>application/xml<span class="pl-pds">"</span></span>
  ],
  <span class="pl-s"><span class="pl-pds">"</span>parameters<span class="pl-pds">"</span></span><span class="pl-k">:</span> [
    {
      <span class="pl-s"><span class="pl-pds">"</span>name<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>petId<span class="pl-pds">"</span></span>,
      <span class="pl-s"><span class="pl-pds">"</span>in<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>path<span class="pl-pds">"</span></span>,
      <span class="pl-s"><span class="pl-pds">"</span>description<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>ID of pet that needs to be updated<span class="pl-pds">"</span></span>,
      <span class="pl-s"><span class="pl-pds">"</span>required<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-c1">true</span>,
      <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>string<span class="pl-pds">"</span></span>
    },
    {
      <span class="pl-s"><span class="pl-pds">"</span>name<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>name<span class="pl-pds">"</span></span>,
      <span class="pl-s"><span class="pl-pds">"</span>in<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>formData<span class="pl-pds">"</span></span>,
      <span class="pl-s"><span class="pl-pds">"</span>description<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>Updated name of the pet<span class="pl-pds">"</span></span>,
      <span class="pl-s"><span class="pl-pds">"</span>required<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-c1">false</span>,
      <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>string<span class="pl-pds">"</span></span>
    },
    {
      <span class="pl-s"><span class="pl-pds">"</span>name<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>status<span class="pl-pds">"</span></span>,
      <span class="pl-s"><span class="pl-pds">"</span>in<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>formData<span class="pl-pds">"</span></span>,
      <span class="pl-s"><span class="pl-pds">"</span>description<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>Updated status of the pet<span class="pl-pds">"</span></span>,
      <span class="pl-s"><span class="pl-pds">"</span>required<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-c1">false</span>,
      <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>string<span class="pl-pds">"</span></span>
    }
  ],
  <span class="pl-s"><span class="pl-pds">"</span>responses<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
    <span class="pl-s"><span class="pl-pds">"</span>200<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
      <span class="pl-s"><span class="pl-pds">"</span>description<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>Pet updated.<span class="pl-pds">"</span></span>
    },
    <span class="pl-s"><span class="pl-pds">"</span>405<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
      <span class="pl-s"><span class="pl-pds">"</span>description<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>Invalid input<span class="pl-pds">"</span></span>
    }
  },
  <span class="pl-s"><span class="pl-pds">"</span>security<span class="pl-pds">"</span></span><span class="pl-k">:</span> [
    {
      <span class="pl-s"><span class="pl-pds">"</span>petstore_auth<span class="pl-pds">"</span></span><span class="pl-k">:</span> [
        <span class="pl-s"><span class="pl-pds">"</span>write:pets<span class="pl-pds">"</span></span>,
        <span class="pl-s"><span class="pl-pds">"</span>read:pets<span class="pl-pds">"</span></span>
      ]
    }
  ]
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">tags:</span></span>
<span class="pl-s">- <span class="pl-s">pet</span></span>
<span class="pl-s"><span class="pl-ent">summary:</span> <span class="pl-s">Updates a pet in the store with form data</span></span>
<span class="pl-s"><span class="pl-ent">description:</span> <span class="pl-s"><span class="pl-pds">"</span><span class="pl-pds">"</span></span></span>
<span class="pl-s"><span class="pl-ent">operationId:</span> <span class="pl-s">updatePetWithForm</span></span>
<span class="pl-s"><span class="pl-ent">consumes:</span></span>
<span class="pl-s">- <span class="pl-s">application/x-www-form-urlencoded</span></span>
<span class="pl-s"><span class="pl-ent">produces:</span></span>
<span class="pl-s">- <span class="pl-s">application/json</span></span>
<span class="pl-s">- <span class="pl-s">application/xml</span></span>
<span class="pl-s"><span class="pl-ent">parameters:</span></span>
<span class="pl-s">- <span class="pl-ent">name:</span> <span class="pl-s">petId</span></span>
  <span class="pl-s"><span class="pl-ent">in:</span> <span class="pl-s">path</span></span>
  <span class="pl-s"><span class="pl-ent">description:</span> <span class="pl-s">ID of pet that needs to be updated</span></span>
  <span class="pl-s"><span class="pl-ent">required:</span> <span class="pl-s">true</span></span>
  <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">string</span></span>
<span class="pl-s">- <span class="pl-ent">name:</span> <span class="pl-s">name</span></span>
  <span class="pl-s"><span class="pl-ent">in:</span> <span class="pl-s">formData</span></span>
  <span class="pl-s"><span class="pl-ent">description:</span> <span class="pl-s">Updated name of the pet</span></span>
  <span class="pl-s"><span class="pl-ent">required:</span> <span class="pl-s">false</span></span>
  <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">string</span></span>
<span class="pl-s">- <span class="pl-ent">name:</span> <span class="pl-s">status</span></span>
  <span class="pl-s"><span class="pl-ent">in:</span> <span class="pl-s">formData</span></span>
  <span class="pl-s"><span class="pl-ent">description:</span> <span class="pl-s">Updated status of the pet</span></span>
  <span class="pl-s"><span class="pl-ent">required:</span> <span class="pl-s">false</span></span>
  <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">string</span></span>
<span class="pl-s"><span class="pl-ent">responses:</span></span>
  <span class="pl-s"><span class="pl-ent">'200':</span></span>
    <span class="pl-s"><span class="pl-ent">description:</span> <span class="pl-s">Pet updated.</span></span>
  <span class="pl-s"><span class="pl-ent">'405':</span></span>
    <span class="pl-s"><span class="pl-ent">description:</span> <span class="pl-s">Invalid input</span></span>
<span class="pl-s"><span class="pl-ent">security:</span></span>
<span class="pl-s">- <span class="pl-ent">petstore_auth:</span></span>
  <span class="pl-s">- <span class="pl-s">write:pets</span></span>
  <span class="pl-s">- <span class="pl-s">read:pets</span></span></pre>
		</div>
		<h4>
			<a id="external-documentation-object" class="anchor" href="#external-documentation-object" aria-hidden="true">
				</a>
			<a name="externalDocumentationObject">
			</a>
			External Documentation Object
		</h4>
		<p>
			Allows referencing an external resource for extended documentation.
		</p>
		<h5>
			<a id="fixed-fields-6" class="anchor" href="#fixed-fields-6" aria-hidden="true">
				</a>
			Fixed Fields
		</h5>
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>
						Field Name
					</th>
					<th align="center">
						Type
					</th>
					<th>
						Description
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<a name="externalDocDescription">
						</a>
						description
					</td>
					<td align="center">
						<code>
							string
						</code>
					</td>
					<td>
						A short description of the target documentation. 
						<a href="https://help.github.com/articles/github-flavored-markdown">
							GFM syntax
						</a>
						can be used for rich text representation.
					</td>
				</tr>
				<tr>
					<td>
						<a name="externalDocUrl">
						</a>
						url
					</td>
					<td align="center">
						<code>
							string
						</code>
					</td>
					<td>
						<strong>
							Required.
						</strong>
						The URL for the target documentation. Value MUST be in the format of a URL.
					</td>
				</tr>
			</tbody>
		</table>
		<h5>
			<a id="patterned-objects-5" class="anchor" href="#patterned-objects-5" aria-hidden="true">
				</a>
			Patterned Objects
		</h5>
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>
						Field Pattern
					</th>
					<th align="center">
						Type
					</th>
					<th>
						Description
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<a name="externalDocExtensions">
						</a>
						^x-
					</td>
					<td align="center">
						Any
					</td>
					<td>
						Allows extensions to the OpenAPI Schema. The field name MUST begin with 
						<code>
							x-
						</code>
						, for example, 
						<code>
							x-internal-id
						</code>
						. The value can be 
						<code>
							null
						</code>
						, a primitive, an array or an object. See 
						<a href="/relax/home/OpenAPIDocs#vendorExtensions">
							Vendor Extensions
						</a>
						for further details.
					</td>
				</tr>
			</tbody>
		</table>
		<h5>
			<a id="external-documentation-object-example" class="anchor" href="#external-documentation-object-example" aria-hidden="true">
				</a>
			External Documentation Object Example
		</h5>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
  <span class="pl-s"><span class="pl-pds">"</span>description<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>Find more info here<span class="pl-pds">"</span></span>,
  <span class="pl-s"><span class="pl-pds">"</span>url<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>https://OpenAPI.io<span class="pl-pds">"</span></span>
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">description:</span> <span class="pl-s">Find more info here</span></span>
<span class="pl-s"><span class="pl-ent">url:</span> <span class="pl-s">https://OpenAPI.io</span></span></pre>
		</div>
		<h4>
			<a id="parameter-object" class="anchor" href="#parameter-object" aria-hidden="true">
				</a>
			<a name="parameterObject">
			</a>
			Parameter Object
		</h4>
		<p>
			Describes a single operation parameter.
		</p>
		<p>
			A unique parameter is defined by a combination of a 
			<a href="/relax/home/OpenAPIDocs#parameterName">
				name
			</a>
			and 
			<a href="/relax/home/OpenAPIDocs#parameterIn">
				location
			</a>
			.
		</p>
		<p>
			There are five possible parameter types.
		</p>
		<ul>
			<li>
				Path - Used together with 
				<a href="/relax/home/OpenAPIDocs#pathTemplating">
					Path Templating
				</a>
				, where the parameter value is actually part of the operation's URL. This does not include the host or base path of the API. For example, in 
				<code>
					/items/{itemId}
				</code>
				, the path parameter is 
				<code>
					itemId
				</code>
				.
			</li>
			<li>
				Query - Parameters that are appended to the URL. For example, in 
				<code>
					/items?id=###
				</code>
				, the query parameter is 
				<code>
					id
				</code>
				.
			</li>
			<li>
				Header - Custom headers that are expected as part of the request.
			</li>
			<li>
				Body - The payload that's appended to the HTTP request. Since there can only be one payload, there can only be 
				<em>
					one
				</em>
				body parameter. The name of the body parameter has no effect on the parameter itself and is used for documentation purposes only. Since Form parameters are also in the payload, body and form parameters cannot exist together for the same operation.
			</li>
			<li>
				Form - Used to describe the payload of an HTTP request when either 
				<code>
					application/x-www-form-urlencoded
				</code>
				, 
				<code>
					multipart/form-data
				</code>
				or both are used as the content type of the request (in OpenAPI's definition, the 
				<a href="/relax/home/OpenAPIDocs#operationConsumes">
					<code>
						consumes
					</code>
				</a>
				property of an operation). This is the only parameter type that can be used to send files, thus supporting the 
				<code>
					file
				</code>
				type. Since form parameters are sent in the payload, they cannot be declared together with a body parameter for the same operation. Form parameters have a different format based on the content-type used (for further details, consult 
				<a href="http://www.w3.org/TR/html401/interact/forms.html#h-17.13.4">
					http://www.w3.org/TR/html401/interact/forms.html#h-17.13.4
				</a>
				): 
				<ul>
					<li>
						<code>
							application/x-www-form-urlencoded
						</code>
						- Similar to the format of Query parameters but as a payload. For example, 
						<code>
							foo=1&amp;bar=OpenAPI
						</code>
						- both 
						<code>
							foo
						</code>
						and 
						<code>
							bar
						</code>
						are form parameters. This is normally used for simple parameters that are being transferred.
					</li>
					<li>
						<code>
							multipart/form-data
						</code>
						- each parameter takes a section in the payload with an internal header. For example, for the header 
						<code>
							Content-Disposition: form-data; name="submit-name"
						</code>
						the name of the parameter is 
						<code>
							submit-name
						</code>
						. This type of form parameters is more commonly used for file transfers.
					</li>
				</ul>
			</li>
		</ul>
		<h5>
			<a id="fixed-fields-7" class="anchor" href="#fixed-fields-7" aria-hidden="true">
				</a>
			Fixed Fields
		</h5>
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>
						Field Name
					</th>
					<th align="center">
						Type
					</th>
					<th>
						Description
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<a name="parameterName">
						</a>
						name
					</td>
					<td align="center">
						<code>
							string
						</code>
					</td>
					<td>
						<strong>
							Required.
						</strong>
						The name of the parameter. Parameter names are 
						<em>
							case sensitive
						</em>
						. 
						<ul>
							<li>
								If 
								<a href="/relax/home/OpenAPIDocs#parameterIn">
									<code>
										in
									</code>
								</a>
								is 
								<code>
									"path"
								</code>
								, the 
								<code>
									name
								</code>
								field MUST correspond to the associated path segment from the 
								<a href="/relax/home/OpenAPIDocs#pathsPath">
									path
								</a>
								field in the 
								<a href="/relax/home/OpenAPIDocs#pathsObject">
									Paths Object
								</a>
								. See 
								<a href="/relax/home/OpenAPIDocs#pathTemplating">
									Path Templating
								</a>
								for further information.
							</li>
							<li>
								For all other cases, the 
								<code>
									name
								</code>
								corresponds to the parameter name used based on the 
								<a href="/relax/home/OpenAPIDocs#parameterIn">
									<code>
										in
									</code>
								</a>
								property.
							</li>
						</ul>
					</td>
				</tr>
				<tr>
					<td>
						<a name="parameterIn">
						</a>
						in
					</td>
					<td align="center">
						<code>
							string
						</code>
					</td>
					<td>
						<strong>
							Required.
						</strong>
						The location of the parameter. Possible values are "query", "header", "path", "formData" or "body".
					</td>
				</tr>
				<tr>
					<td>
						<a name="parameterDescription">
						</a>
						description
					</td>
					<td align="center">
						<code>
							string
						</code>
					</td>
					<td>
						A brief description of the parameter. This could contain examples of use. 
						<a href="https://help.github.com/articles/github-flavored-markdown">
							GFM syntax
						</a>
						can be used for rich text representation.
					</td>
				</tr>
				<tr>
					<td>
						<a name="parameterRequired">
						</a>
						required
					</td>
					<td align="center">
						<code>
							boolean
						</code>
					</td>
					<td>
						Determines whether this parameter is mandatory. If the parameter is 
						<a href="/relax/home/OpenAPIDocs#parameterIn">
							<code>
								in
							</code>
						</a>
						"path", this property is 
						<strong>
							required
						</strong>
						and its value MUST be 
						<code>
							true
						</code>
						. Otherwise, the property MAY be included and its default value is 
						<code>
							false
						</code>
						.
					</td>
				</tr>
			</tbody>
		</table>
		<p>
			If 
			<a href="/relax/home/OpenAPIDocs#parameterIn">
				<code>
					in
				</code>
			</a>
			is 
			<code>
				"body"
			</code>
			:
		</p>
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>
						Field Name
					</th>
					<th align="center">
						Type
					</th>
					<th>
						Description
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<a name="parameterSchema">
						</a>
						schema
					</td>
					<td align="center">
						<a href="/relax/home/OpenAPIDocs#schemaObject">
							Schema Object
						</a>
					</td>
					<td>
						<strong>
							Required.
						</strong>
						The schema defining the type used for the body parameter.
					</td>
				</tr>
			</tbody>
		</table>
		<p>
			If 
			<a href="/relax/home/OpenAPIDocs#parameterIn">
				<code>
					in
				</code>
			</a>
			is any value other than 
			<code>
				"body"
			</code>
			:
		</p>
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>
						Field Name
					</th>
					<th align="center">
						Type
					</th>
					<th>
						Description
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<a name="parameterType">
						</a>
						type
					</td>
					<td align="center">
						<code>
							string
						</code>
					</td>
					<td>
						<strong>
							Required.
						</strong>
						The type of the parameter. Since the parameter is not located at the request body, it is limited to simple types (that is, not an object). The value MUST be one of 
						<code>
							"string"
						</code>
						, 
						<code>
							"number"
						</code>
						, 
						<code>
							"integer"
						</code>
						, 
						<code>
							"boolean"
						</code>
						, 
						<code>
							"array"
						</code>
						or 
						<code>
							"file"
						</code>
						. If 
						<code>
							type
						</code>
						is 
						<code>
							"file"
						</code>
						, the 
						<a href="/relax/home/OpenAPIDocs#operationConsumes">
							<code>
								consumes
							</code>
						</a>
						MUST be either 
						<code>
							"multipart/form-data"
						</code>
						, 
						<code>
							" application/x-www-form-urlencoded"
						</code>
						or both and the parameter MUST be 
						<a href="/relax/home/OpenAPIDocs#parameterIn">
							<code>
								in
							</code>
						</a>
						<code>
							"formData"
						</code>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="parameterFormat">
						</a>
						format
					</td>
					<td align="center">
						<code>
							string
						</code>
					</td>
					<td>
						The extending format for the previously mentioned 
						<a href="/relax/home/OpenAPIDocs#parameterType">
							<code>
								type
							</code>
						</a>
						. See 
						<a href="/relax/home/OpenAPIDocs#dataTypeFormat">
							Data Type Formats
						</a>
						for further details.
					</td>
				</tr>
				<tr>
					<td>
						<a name="parameterAllowEmptyValue">
							allowEmptyValue
						</a>
					</td>
					<td align="center">
						<code>
							boolean
						</code>
					</td>
					<td>
						Sets the ability to pass empty-valued parameters. This is valid only for either 
						<code>
							query
						</code>
						or 
						<code>
							formData
						</code>
						parameters and allows you to send a parameter with a name only or an empty value. Default value is 
						<code>
							false
						</code>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="parameterItems">
						</a>
						items
					</td>
					<td align="center">
						<a href="/relax/home/OpenAPIDocs#itemsObject">
							Items Object
						</a>
					</td>
					<td>
						<strong>
							Required if 
							<a href="/relax/home/OpenAPIDocs#parameterType">
								<code>
									type
								</code>
							</a>
							is "array".
						</strong>
						Describes the type of items in the array.
					</td>
				</tr>
				<tr>
					<td>
						<a name="parameterCollectionFormat">
						</a>
						collectionFormat
					</td>
					<td align="center">
						<code>
							string
						</code>
					</td>
					<td>
						Determines the format of the array if type array is used. Possible values are: 
						<ul>
							<li>
								<code>
									csv
								</code>
								- comma separated values 
								<code>
									foo,bar
								</code>
								. 
							</li>
							<li>
								<code>
									ssv
								</code>
								- space separated values 
								<code>
									foo bar
								</code>
								. 
							</li>
							<li>
								<code>
									tsv
								</code>
								- tab separated values 
								<code>
									foo\tbar
								</code>
								. 
							</li>
							<li>
								<code>
									pipes
								</code>
								- pipe separated values 
								<code>
									foo|bar
								</code>
								. 
							</li>
							<li>
								<code>
									multi
								</code>
								- corresponds to multiple parameter instances instead of multiple values for a single instance 
								<code>
									foo=bar&amp;foo=baz
								</code>
								. This is valid only for parameters 
								<a href="/relax/home/OpenAPIDocs#parameterIn">
									<code>
										in
									</code>
								</a>
								"query" or "formData". 
							</li>
						</ul>
						Default value is 
						<code>
							csv
						</code>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="parameterDefault">
						</a>
						default
					</td>
					<td align="center">
						*
					</td>
					<td>
						Declares the value of the parameter that the server will use if none is provided, for example a "count" to control the number of results per page might default to 100 if not supplied by the client in the request. (Note: "default" has no meaning for required parameters.) See 
						<a href="http://json-schema.org/latest/json-schema-validation.html#anchor101">
							http://json-schema.org/latest/json-schema-validation.html#anchor101
						</a>
						. Unlike JSON Schema this value MUST conform to the defined 
						<a href="/relax/home/OpenAPIDocs#parameterType">
							<code>
								type
							</code>
						</a>
						for this parameter.
					</td>
				</tr>
				<tr>
					<td>
						<a name="parameterMaximum">
						</a>
						maximum
					</td>
					<td align="center">
						<code>
							number
						</code>
					</td>
					<td>
						See 
						<a href="http://json-schema.org/latest/json-schema-validation.html#anchor17">
							http://json-schema.org/latest/json-schema-validation.html#anchor17
						</a>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="parameterExclusiveMaximum">
						</a>
						exclusiveMaximum
					</td>
					<td align="center">
						<code>
							boolean
						</code>
					</td>
					<td>
						See 
						<a href="http://json-schema.org/latest/json-schema-validation.html#anchor17">
							http://json-schema.org/latest/json-schema-validation.html#anchor17
						</a>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="parameterMinimum">
						</a>
						minimum
					</td>
					<td align="center">
						<code>
							number
						</code>
					</td>
					<td>
						See 
						<a href="http://json-schema.org/latest/json-schema-validation.html#anchor21">
							http://json-schema.org/latest/json-schema-validation.html#anchor21
						</a>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="parameterExclusiveMinimum">
						</a>
						exclusiveMinimum
					</td>
					<td align="center">
						<code>
							boolean
						</code>
					</td>
					<td>
						See 
						<a href="http://json-schema.org/latest/json-schema-validation.html#anchor21">
							http://json-schema.org/latest/json-schema-validation.html#anchor21
						</a>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="parameterMaxLength">
						</a>
						maxLength
					</td>
					<td align="center">
						<code>
							integer
						</code>
					</td>
					<td>
						See 
						<a href="http://json-schema.org/latest/json-schema-validation.html#anchor26">
							http://json-schema.org/latest/json-schema-validation.html#anchor26
						</a>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="parameterMinLength">
						</a>
						minLength
					</td>
					<td align="center">
						<code>
							integer
						</code>
					</td>
					<td>
						See 
						<a href="http://json-schema.org/latest/json-schema-validation.html#anchor29">
							http://json-schema.org/latest/json-schema-validation.html#anchor29
						</a>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="parameterPattern">
						</a>
						pattern
					</td>
					<td align="center">
						<code>
							string
						</code>
					</td>
					<td>
						See 
						<a href="http://json-schema.org/latest/json-schema-validation.html#anchor33">
							http://json-schema.org/latest/json-schema-validation.html#anchor33
						</a>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="parameterMaxItems">
						</a>
						maxItems
					</td>
					<td align="center">
						<code>
							integer
						</code>
					</td>
					<td>
						See 
						<a href="http://json-schema.org/latest/json-schema-validation.html#anchor42">
							http://json-schema.org/latest/json-schema-validation.html#anchor42
						</a>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="parameterMinItems">
						</a>
						minItems
					</td>
					<td align="center">
						<code>
							integer
						</code>
					</td>
					<td>
						See 
						<a href="http://json-schema.org/latest/json-schema-validation.html#anchor45">
							http://json-schema.org/latest/json-schema-validation.html#anchor45
						</a>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="parameterUniqueItems">
						</a>
						uniqueItems
					</td>
					<td align="center">
						<code>
							boolean
						</code>
					</td>
					<td>
						See 
						<a href="http://json-schema.org/latest/json-schema-validation.html#anchor49">
							http://json-schema.org/latest/json-schema-validation.html#anchor49
						</a>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="parameterEnum">
						</a>
						enum
					</td>
					<td align="center">
						[*]
					</td>
					<td>
						See 
						<a href="http://json-schema.org/latest/json-schema-validation.html#anchor76">
							http://json-schema.org/latest/json-schema-validation.html#anchor76
						</a>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="parameterMultipleOf">
						</a>
						multipleOf
					</td>
					<td align="center">
						<code>
							number
						</code>
					</td>
					<td>
						See 
						<a href="http://json-schema.org/latest/json-schema-validation.html#anchor14">
							http://json-schema.org/latest/json-schema-validation.html#anchor14
						</a>
						.
					</td>
				</tr>
			</tbody>
		</table>
		<h5>
			<a id="patterned-fields-2" class="anchor" href="#patterned-fields-2" aria-hidden="true">
				</a>
			Patterned Fields
		</h5>
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>
						Field Pattern
					</th>
					<th align="center">
						Type
					</th>
					<th>
						Description
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<a name="parameterExtensions">
						</a>
						^x-
					</td>
					<td align="center">
						Any
					</td>
					<td>
						Allows extensions to the OpenAPI Schema. The field name MUST begin with 
						<code>
							x-
						</code>
						, for example, 
						<code>
							x-internal-id
						</code>
						. The value can be 
						<code>
							null
						</code>
						, a primitive, an array or an object. See 
						<a href="/relax/home/OpenAPIDocs#vendorExtensions">
							Vendor Extensions
						</a>
						for further details.
					</td>
				</tr>
			</tbody>
		</table>
		<h5>
			<a id="parameter-object-examples" class="anchor" href="#parameter-object-examples" aria-hidden="true">
				</a>
			Parameter Object Examples
		</h5>
		<h6>
			<a id="body-parameters" class="anchor" href="#body-parameters" aria-hidden="true">
				</a>
			Body Parameters
		</h6>
		<p>
			A body parameter with a referenced schema definition (normally for a model definition):
		</p>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
  <span class="pl-s"><span class="pl-pds">"</span>name<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>user<span class="pl-pds">"</span></span>,
  <span class="pl-s"><span class="pl-pds">"</span>in<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>body<span class="pl-pds">"</span></span>,
  <span class="pl-s"><span class="pl-pds">"</span>description<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>user to add to the system<span class="pl-pds">"</span></span>,
  <span class="pl-s"><span class="pl-pds">"</span>required<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-c1">true</span>,
  <span class="pl-s"><span class="pl-pds">"</span>schema<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
    <span class="pl-s"><span class="pl-pds">"</span>$ref<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>#/definitions/User<span class="pl-pds">"</span></span>
  }
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">name:</span> <span class="pl-s">user</span></span>
<span class="pl-s"><span class="pl-ent">in:</span> <span class="pl-s">body</span></span>
<span class="pl-s"><span class="pl-ent">description:</span> <span class="pl-s">user to add to the system</span></span>
<span class="pl-s"><span class="pl-ent">required:</span> <span class="pl-s">true</span></span>
<span class="pl-s"><span class="pl-ent">schema:</span></span>
  <span class="pl-s"><span class="pl-ent">$ref:</span> <span class="pl-s"><span class="pl-pds">'</span>#/definitions/User<span class="pl-pds">'</span></span></span></pre>
		</div>
		<p>
			A body parameter that is an array of string values:
		</p>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
  <span class="pl-s"><span class="pl-pds">"</span>name<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>user<span class="pl-pds">"</span></span>,
  <span class="pl-s"><span class="pl-pds">"</span>in<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>body<span class="pl-pds">"</span></span>,
  <span class="pl-s"><span class="pl-pds">"</span>description<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>user to add to the system<span class="pl-pds">"</span></span>,
  <span class="pl-s"><span class="pl-pds">"</span>required<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-c1">true</span>,
  <span class="pl-s"><span class="pl-pds">"</span>schema<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
    <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>array<span class="pl-pds">"</span></span>,
    <span class="pl-s"><span class="pl-pds">"</span>items<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
      <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>string<span class="pl-pds">"</span></span>
    }
  }
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">name:</span> <span class="pl-s">user</span></span>
<span class="pl-s"><span class="pl-ent">in:</span> <span class="pl-s">body</span></span>
<span class="pl-s"><span class="pl-ent">description:</span> <span class="pl-s">user to add to the system</span></span>
<span class="pl-s"><span class="pl-ent">required:</span> <span class="pl-s">true</span></span>
<span class="pl-s"><span class="pl-ent">schema:</span></span>
  <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">array</span></span>
  <span class="pl-s"><span class="pl-ent">items:</span></span>
    <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">string</span></span></pre>
		</div>
		<h6>
			<a id="other-parameters" class="anchor" href="#other-parameters" aria-hidden="true">
				</a>
			Other Parameters
		</h6>
		<p>
			A header parameter with an array of 64 bit integer numbers:
		</p>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
  <span class="pl-s"><span class="pl-pds">"</span>name<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>token<span class="pl-pds">"</span></span>,
  <span class="pl-s"><span class="pl-pds">"</span>in<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>header<span class="pl-pds">"</span></span>,
  <span class="pl-s"><span class="pl-pds">"</span>description<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>token to be passed as a header<span class="pl-pds">"</span></span>,
  <span class="pl-s"><span class="pl-pds">"</span>required<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-c1">true</span>,
  <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>array<span class="pl-pds">"</span></span>,
  <span class="pl-s"><span class="pl-pds">"</span>items<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
    <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>integer<span class="pl-pds">"</span></span>,
    <span class="pl-s"><span class="pl-pds">"</span>format<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>int64<span class="pl-pds">"</span></span>
  },
  <span class="pl-s"><span class="pl-pds">"</span>collectionFormat<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>csv<span class="pl-pds">"</span></span>
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">name:</span> <span class="pl-s">token</span></span>
<span class="pl-s"><span class="pl-ent">in:</span> <span class="pl-s">header</span></span>
<span class="pl-s"><span class="pl-ent">description:</span> <span class="pl-s">token to be passed as a header</span></span>
<span class="pl-s"><span class="pl-ent">required:</span> <span class="pl-s">true</span></span>
<span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">array</span></span>
<span class="pl-s"><span class="pl-ent">items:</span></span>
  <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">integer</span></span>
  <span class="pl-s"><span class="pl-ent">format:</span> <span class="pl-s">int64</span></span>
<span class="pl-s"><span class="pl-ent">collectionFormat:</span> <span class="pl-s">csv</span></span></pre>
		</div>
		<p>
			A path parameter of a string value:
		</p>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
  <span class="pl-s"><span class="pl-pds">"</span>name<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>username<span class="pl-pds">"</span></span>,
  <span class="pl-s"><span class="pl-pds">"</span>in<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>path<span class="pl-pds">"</span></span>,
  <span class="pl-s"><span class="pl-pds">"</span>description<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>username to fetch<span class="pl-pds">"</span></span>,
  <span class="pl-s"><span class="pl-pds">"</span>required<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-c1">true</span>,
  <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>string<span class="pl-pds">"</span></span>
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">name:</span> <span class="pl-s">username</span></span>
<span class="pl-s"><span class="pl-ent">in:</span> <span class="pl-s">path</span></span>
<span class="pl-s"><span class="pl-ent">description:</span> <span class="pl-s">username to fetch</span></span>
<span class="pl-s"><span class="pl-ent">required:</span> <span class="pl-s">true</span></span>
<span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">string</span></span></pre>
		</div>
		<p>
			An optional query parameter of a string value, allowing multiple values by repeating the query parameter:
		</p>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
  <span class="pl-s"><span class="pl-pds">"</span>name<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>id<span class="pl-pds">"</span></span>,
  <span class="pl-s"><span class="pl-pds">"</span>in<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>query<span class="pl-pds">"</span></span>,
  <span class="pl-s"><span class="pl-pds">"</span>description<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>ID of the object to fetch<span class="pl-pds">"</span></span>,
  <span class="pl-s"><span class="pl-pds">"</span>required<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-c1">false</span>,
  <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>array<span class="pl-pds">"</span></span>,
  <span class="pl-s"><span class="pl-pds">"</span>items<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
    <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>string<span class="pl-pds">"</span></span>
  },
  <span class="pl-s"><span class="pl-pds">"</span>collectionFormat<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>multi<span class="pl-pds">"</span></span>
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">name:</span> <span class="pl-s">id</span></span>
<span class="pl-s"><span class="pl-ent">in:</span> <span class="pl-s">query</span></span>
<span class="pl-s"><span class="pl-ent">description:</span> <span class="pl-s">ID of the object to fetch</span></span>
<span class="pl-s"><span class="pl-ent">required:</span> <span class="pl-s">false</span></span>
<span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">array</span></span>
<span class="pl-s"><span class="pl-ent">items:</span></span>
  <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">string</span></span>
<span class="pl-s"><span class="pl-ent">collectionFormat:</span> <span class="pl-s">multi</span></span></pre>
		</div>
		<p>
			A form data with file type for a file upload:
		</p>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
  <span class="pl-s"><span class="pl-pds">"</span>name<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>avatar<span class="pl-pds">"</span></span>,
  <span class="pl-s"><span class="pl-pds">"</span>in<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>formData<span class="pl-pds">"</span></span>,
  <span class="pl-s"><span class="pl-pds">"</span>description<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>The avatar of the user<span class="pl-pds">"</span></span>,
  <span class="pl-s"><span class="pl-pds">"</span>required<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-c1">true</span>,
  <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>file<span class="pl-pds">"</span></span>
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">name:</span> <span class="pl-s">avatar</span></span>
<span class="pl-s"><span class="pl-ent">in:</span> <span class="pl-s">formData</span></span>
<span class="pl-s"><span class="pl-ent">description:</span> <span class="pl-s">The avatar of the user</span></span>
<span class="pl-s"><span class="pl-ent">required:</span> <span class="pl-s">true</span></span>
<span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">file</span></span></pre>
		</div>
		<h4>
			<a id="items-object" class="anchor" href="#items-object" aria-hidden="true">
				</a>
			<a name="itemsObject">
			</a>
			Items Object
		</h4>
		<p>
			A limited subset of JSON-Schema's items object. It is used by parameter definitions that are not located 
			<a href="/relax/home/OpenAPIDocs#parameterIn">
				<code>
					in
				</code>
			</a>
			<code>
				"body"
			</code>
			.
		</p>
		<h5>
			<a id="fixed-fields-8" class="anchor" href="#fixed-fields-8" aria-hidden="true">
				</a>
			Fixed Fields
		</h5>
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>
						Field Name
					</th>
					<th align="center">
						Type
					</th>
					<th>
						Description
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<a name="itemsType">
						</a>
						type
					</td>
					<td align="center">
						<code>
							string
						</code>
					</td>
					<td>
						<strong>
							Required.
						</strong>
						The internal type of the array. The value MUST be one of 
						<code>
							"string"
						</code>
						, 
						<code>
							"number"
						</code>
						, 
						<code>
							"integer"
						</code>
						, 
						<code>
							"boolean"
						</code>
						, or 
						<code>
							"array"
						</code>
						. Files and models are not allowed.
					</td>
				</tr>
				<tr>
					<td>
						<a name="itemsFormat">
						</a>
						format
					</td>
					<td align="center">
						<code>
							string
						</code>
					</td>
					<td>
						The extending format for the previously mentioned 
						<a href="/relax/home/OpenAPIDocs#parameterType">
							<code>
								type
							</code>
						</a>
						. See 
						<a href="/relax/home/OpenAPIDocs#dataTypeFormat">
							Data Type Formats
						</a>
						for further details.
					</td>
				</tr>
				<tr>
					<td>
						<a name="itemsItems">
						</a>
						items
					</td>
					<td align="center">
						<a href="/relax/home/OpenAPIDocs#itemsObject">
							Items Object
						</a>
					</td>
					<td>
						<strong>
							Required if 
							<a href="/relax/home/OpenAPIDocs#itemsType">
								<code>
									type
								</code>
							</a>
							is "array".
						</strong>
						Describes the type of items in the array.
					</td>
				</tr>
				<tr>
					<td>
						<a name="itemsCollectionFormat">
						</a>
						collectionFormat
					</td>
					<td align="center">
						<code>
							string
						</code>
					</td>
					<td>
						Determines the format of the array if type array is used. Possible values are: 
						<ul>
							<li>
								<code>
									csv
								</code>
								- comma separated values 
								<code>
									foo,bar
								</code>
								. 
							</li>
							<li>
								<code>
									ssv
								</code>
								- space separated values 
								<code>
									foo bar
								</code>
								. 
							</li>
							<li>
								<code>
									tsv
								</code>
								- tab separated values 
								<code>
									foo\tbar
								</code>
								. 
							</li>
							<li>
								<code>
									pipes
								</code>
								- pipe separated values 
								<code>
									foo|bar
								</code>
								. 
							</li>
						</ul>
						Default value is 
						<code>
							csv
						</code>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="itemsDefault">
						</a>
						default
					</td>
					<td align="center">
						*
					</td>
					<td>
						Declares the value of the item that the server will use if none is provided. (Note: "default" has no meaning for required items.) See 
						<a href="http://json-schema.org/latest/json-schema-validation.html#anchor101">
							http://json-schema.org/latest/json-schema-validation.html#anchor101
						</a>
						. Unlike JSON Schema this value MUST conform to the defined 
						<a href="/relax/home/OpenAPIDocs#itemsType">
							<code>
								type
							</code>
						</a>
						for the data type.
					</td>
				</tr>
				<tr>
					<td>
						<a name="itemsMaximum">
						</a>
						maximum
					</td>
					<td align="center">
						<code>
							number
						</code>
					</td>
					<td>
						See 
						<a href="http://json-schema.org/latest/json-schema-validation.html#anchor17">
							http://json-schema.org/latest/json-schema-validation.html#anchor17
						</a>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="itemsMaximum">
						</a>
						exclusiveMaximum
					</td>
					<td align="center">
						<code>
							boolean
						</code>
					</td>
					<td>
						See 
						<a href="http://json-schema.org/latest/json-schema-validation.html#anchor17">
							http://json-schema.org/latest/json-schema-validation.html#anchor17
						</a>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="itemsMinimum">
						</a>
						minimum
					</td>
					<td align="center">
						<code>
							number
						</code>
					</td>
					<td>
						See 
						<a href="http://json-schema.org/latest/json-schema-validation.html#anchor21">
							http://json-schema.org/latest/json-schema-validation.html#anchor21
						</a>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="itemsExclusiveMinimum">
						</a>
						exclusiveMinimum
					</td>
					<td align="center">
						<code>
							boolean
						</code>
					</td>
					<td>
						See 
						<a href="http://json-schema.org/latest/json-schema-validation.html#anchor21">
							http://json-schema.org/latest/json-schema-validation.html#anchor21
						</a>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="itemsMaxLength">
						</a>
						maxLength
					</td>
					<td align="center">
						<code>
							integer
						</code>
					</td>
					<td>
						See 
						<a href="http://json-schema.org/latest/json-schema-validation.html#anchor26">
							http://json-schema.org/latest/json-schema-validation.html#anchor26
						</a>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="itemsMinLength">
						</a>
						minLength
					</td>
					<td align="center">
						<code>
							integer
						</code>
					</td>
					<td>
						See 
						<a href="http://json-schema.org/latest/json-schema-validation.html#anchor29">
							http://json-schema.org/latest/json-schema-validation.html#anchor29
						</a>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="itemsPattern">
						</a>
						pattern
					</td>
					<td align="center">
						<code>
							string
						</code>
					</td>
					<td>
						See 
						<a href="http://json-schema.org/latest/json-schema-validation.html#anchor33">
							http://json-schema.org/latest/json-schema-validation.html#anchor33
						</a>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="itemsMaxItems">
						</a>
						maxItems
					</td>
					<td align="center">
						<code>
							integer
						</code>
					</td>
					<td>
						See 
						<a href="http://json-schema.org/latest/json-schema-validation.html#anchor42">
							http://json-schema.org/latest/json-schema-validation.html#anchor42
						</a>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="itemsMinItems">
						</a>
						minItems
					</td>
					<td align="center">
						<code>
							integer
						</code>
					</td>
					<td>
						See 
						<a href="http://json-schema.org/latest/json-schema-validation.html#anchor45">
							http://json-schema.org/latest/json-schema-validation.html#anchor45
						</a>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="itemsUniqueItems">
						</a>
						uniqueItems
					</td>
					<td align="center">
						<code>
							boolean
						</code>
					</td>
					<td>
						See 
						<a href="http://json-schema.org/latest/json-schema-validation.html#anchor49">
							http://json-schema.org/latest/json-schema-validation.html#anchor49
						</a>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="itemsEnum">
						</a>
						enum
					</td>
					<td align="center">
						[*]
					</td>
					<td>
						See 
						<a href="http://json-schema.org/latest/json-schema-validation.html#anchor76">
							http://json-schema.org/latest/json-schema-validation.html#anchor76
						</a>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="itemsMultipleOf">
						</a>
						multipleOf
					</td>
					<td align="center">
						<code>
							number
						</code>
					</td>
					<td>
						See 
						<a href="http://json-schema.org/latest/json-schema-validation.html#anchor14">
							http://json-schema.org/latest/json-schema-validation.html#anchor14
						</a>
						.
					</td>
				</tr>
			</tbody>
		</table>
		<h5>
			<a id="patterned-objects-6" class="anchor" href="#patterned-objects-6" aria-hidden="true">
				</a>
			Patterned Objects
		</h5>
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>
						Field Pattern
					</th>
					<th align="center">
						Type
					</th>
					<th>
						Description
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<a name="itemsExtensions">
						</a>
						^x-
					</td>
					<td align="center">
						Any
					</td>
					<td>
						Allows extensions to the OpenAPI Schema. The field name MUST begin with 
						<code>
							x-
						</code>
						, for example, 
						<code>
							x-internal-id
						</code>
						. The value can be 
						<code>
							null
						</code>
						, a primitive, an array or an object. See 
						<a href="/relax/home/OpenAPIDocs#vendorExtensions">
							Vendor Extensions
						</a>
						for further details.
					</td>
				</tr>
			</tbody>
		</table>
		<h5>
			<a id="items-object-examples" class="anchor" href="#items-object-examples" aria-hidden="true">
				</a>
			Items Object Examples
		</h5>
		<p>
			Items must be of type string and have the minimum length of 2 characters:
		</p>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
    <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>string<span class="pl-pds">"</span></span>,
    <span class="pl-s"><span class="pl-pds">"</span>minLength<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-c1">2</span>
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">string</span></span>
<span class="pl-c1"><span class="pl-ent">minLength:</span> 2</span></pre>
		</div>
		<p>
			An array of arrays, the internal array being of type integer, numbers must be between 0 and 63 (inclusive):
		</p>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
    <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>array<span class="pl-pds">"</span></span>,
    <span class="pl-s"><span class="pl-pds">"</span>items<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
        <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>integer<span class="pl-pds">"</span></span>,
        <span class="pl-s"><span class="pl-pds">"</span>minimum<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-c1">0</span>,
        <span class="pl-s"><span class="pl-pds">"</span>maximum<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-c1">63</span>
    }
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">array</span></span>
<span class="pl-s"><span class="pl-ent">items:</span></span>
  <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">integer</span></span>
  <span class="pl-c1"><span class="pl-ent">minimum:</span> 0</span>
  <span class="pl-c1"><span class="pl-ent">maximum:</span> 63</span></pre>
		</div>
		<h4>
			<a id="responses-object" class="anchor" href="#responses-object" aria-hidden="true">
				</a>
			<a name="responsesObject">
			</a>
			Responses Object
		</h4>
		<p>
			A container for the expected responses of an operation. The container maps a HTTP response code to the expected response. It is not expected from the documentation to necessarily cover all possible HTTP response codes, since they may not be known in advance. However, it is expected from the documentation to cover a successful operation response and any known errors.
		</p>
		<p>
			The 
			<code>
				default
			</code>
			can be used a default response object for all HTTP codes that are not covered individually by the specification.
		</p>
		<p>
			The 
			<code>
				Responses Object
			</code>
			MUST contain at least one response code, and it SHOULD be the response for a successful operation call.
		</p>
		<h5>
			<a id="fixed-fields-9" class="anchor" href="#fixed-fields-9" aria-hidden="true">
				</a>
			Fixed Fields
		</h5>
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>
						Field Name
					</th>
					<th align="center">
						Type
					</th>
					<th>
						Description
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<a name="responsesDefault">
						</a>
						default
					</td>
					<td align="center">
						<a href="/relax/home/OpenAPIDocs#responseObject">
							Response Object
						</a>
						| 
						<a href="/relax/home/OpenAPIDocs#referenceObject">
							Reference Object
						</a>
					</td>
					<td>
						The documentation of responses other than the ones declared for specific HTTP response codes. It can be used to cover undeclared responses. 
						<a href="/relax/home/OpenAPIDocs#referenceObject">
							Reference Object
						</a>
						can be used to link to a response that is defined at the 
						<a href="/relax/home/OpenAPIDocs#OpenAPIResponses">
							OpenAPI Object's responses
						</a>
						section.
					</td>
				</tr>
			</tbody>
		</table>
		<h5>
			<a id="patterned-fields-3" class="anchor" href="#patterned-fields-3" aria-hidden="true">
				</a>
			Patterned Fields
		</h5>
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>
						Field Pattern
					</th>
					<th align="center">
						Type
					</th>
					<th>
						Description
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<a name="responsesCode">
						</a>
						{
						<a href="/relax/home/OpenAPIDocs#httpCodes">
							HTTP Status Code
						</a>
						}
					</td>
					<td align="center">
						<a href="/relax/home/OpenAPIDocs#responseObject">
							Response Object
						</a>
						| 
						<a href="/relax/home/OpenAPIDocs#referenceObject">
							Reference Object
						</a>
					</td>
					<td>
						Any 
						<a href="/relax/home/OpenAPIDocs#httpCodes">
							HTTP status code
						</a>
						can be used as the property name (one property per HTTP status code). Describes the expected response for that HTTP status code. 
						<a href="/relax/home/OpenAPIDocs#referenceObject">
							Reference Object
						</a>
						can be used to link to a response that is defined at the 
						<a href="/relax/home/OpenAPIDocs#OpenAPIResponses">
							OpenAPI Object's responses
						</a>
						section.
					</td>
				</tr>
				<tr>
					<td>
						<a name="responsesExtensions">
						</a>
						^x-
					</td>
					<td align="center">
						Any
					</td>
					<td>
						Allows extensions to the OpenAPI Schema. The field name MUST begin with 
						<code>
							x-
						</code>
						, for example, 
						<code>
							x-internal-id
						</code>
						. The value can be 
						<code>
							null
						</code>
						, a primitive, an array or an object. See 
						<a href="/relax/home/OpenAPIDocs#vendorExtensions">
							Vendor Extensions
						</a>
						for further details.
					</td>
				</tr>
			</tbody>
		</table>
		<h5>
			<a id="responses-object-example" class="anchor" href="#responses-object-example" aria-hidden="true">
				</a>
			Responses Object Example
		</h5>
		<p>
			A 200 response for successful operation and a default response for others (implying an error):
		</p>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
  <span class="pl-s"><span class="pl-pds">"</span>200<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
    <span class="pl-s"><span class="pl-pds">"</span>description<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>a pet to be returned<span class="pl-pds">"</span></span>,
    <span class="pl-s"><span class="pl-pds">"</span>schema<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
      <span class="pl-s"><span class="pl-pds">"</span>$ref<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>#/definitions/Pet<span class="pl-pds">"</span></span>
    }
  },
  <span class="pl-s"><span class="pl-pds">"</span>default<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
    <span class="pl-s"><span class="pl-pds">"</span>description<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>Unexpected error<span class="pl-pds">"</span></span>,
    <span class="pl-s"><span class="pl-pds">"</span>schema<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
      <span class="pl-s"><span class="pl-pds">"</span>$ref<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>#/definitions/ErrorModel<span class="pl-pds">"</span></span>
    }
  }
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">'200':</span></span>
  <span class="pl-s"><span class="pl-ent">description:</span> <span class="pl-s">a pet to be returned</span></span>
  <span class="pl-s"><span class="pl-ent">schema:</span></span>
    <span class="pl-s"><span class="pl-ent">$ref:</span> <span class="pl-s"><span class="pl-pds">'</span>#/definitions/Pet<span class="pl-pds">'</span></span></span>
<span class="pl-s"><span class="pl-ent">default:</span></span>
  <span class="pl-s"><span class="pl-ent">description:</span> <span class="pl-s">Unexpected error</span></span>
  <span class="pl-s"><span class="pl-ent">schema:</span></span>
    <span class="pl-s"><span class="pl-ent">$ref:</span> <span class="pl-s"><span class="pl-pds">'</span>#/definitions/ErrorModel<span class="pl-pds">'</span></span></span></pre>
		</div>
		<h4>
			<a id="response-object" class="anchor" href="#response-object" aria-hidden="true">
				</a>
			<a name="responseObject">
			</a>
			Response Object
		</h4>
		<p>
			Describes a single response from an API Operation.
		</p>
		<h5>
			<a id="fixed-fields-10" class="anchor" href="#fixed-fields-10" aria-hidden="true">
				</a>
			Fixed Fields
		</h5>
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>
						Field Name
					</th>
					<th align="center">
						Type
					</th>
					<th>
						Description
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<a name="responseDescription">
						</a>
						description
					</td>
					<td align="center">
						<code>
							string
						</code>
					</td>
					<td>
						<strong>
							Required.
						</strong>
						A short description of the response. 
						<a href="https://help.github.com/articles/github-flavored-markdown">
							GFM syntax
						</a>
						can be used for rich text representation.
					</td>
				</tr>
				<tr>
					<td>
						<a name="responseSchema">
						</a>
						schema
					</td>
					<td align="center">
						<a href="/relax/home/OpenAPIDocs#schemaObject">
							Schema Object
						</a>
					</td>
					<td>
						A definition of the response structure. It can be a primitive, an array or an object. If this field does not exist, it means no content is returned as part of the response. As an extension to the 
						<a href="/relax/home/OpenAPIDocs#schemaObject">
							Schema Object
						</a>
						, its root 
						<code>
							type
						</code>
						value may also be 
						<code>
							"file"
						</code>
						. This SHOULD be accompanied by a relevant 
						<code>
							produces
						</code>
						mime-type.
					</td>
				</tr>
				<tr>
					<td>
						<a name="responseHeaders">
						</a>
						headers
					</td>
					<td align="center">
						<a href="/relax/home/OpenAPIDocs#headersObject">
							Headers Object
						</a>
					</td>
					<td>
						A list of headers that are sent with the response.
					</td>
				</tr>
				<tr>
					<td>
						<a name="responseExamples">
						</a>
						examples
					</td>
					<td align="center">
						<a href="/relax/home/OpenAPIDocs#exampleObject">
							Example Object
						</a>
					</td>
					<td>
						An example of the response message.
					</td>
				</tr>
			</tbody>
		</table>
		<h5>
			<a id="patterned-objects-7" class="anchor" href="#patterned-objects-7" aria-hidden="true">
				</a>
			Patterned Objects
		</h5>
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>
						Field Pattern
					</th>
					<th align="center">
						Type
					</th>
					<th>
						Description
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<a name="responseExtensions">
						</a>
						^x-
					</td>
					<td align="center">
						Any
					</td>
					<td>
						Allows extensions to the OpenAPI Schema. The field name MUST begin with 
						<code>
							x-
						</code>
						, for example, 
						<code>
							x-internal-id
						</code>
						. The value can be 
						<code>
							null
						</code>
						, a primitive, an array or an object. See 
						<a href="/relax/home/OpenAPIDocs#vendorExtensions">
							Vendor Extensions
						</a>
						for further details.
					</td>
				</tr>
			</tbody>
		</table>
		<h5>
			<a id="response-object-examples" class="anchor" href="#response-object-examples" aria-hidden="true">
				</a>
			Response Object Examples
		</h5>
		<p>
			Response of an array of a complex type:
		</p>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
  <span class="pl-s"><span class="pl-pds">"</span>description<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>A complex object array response<span class="pl-pds">"</span></span>,
  <span class="pl-s"><span class="pl-pds">"</span>schema<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
    <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>array<span class="pl-pds">"</span></span>,
    <span class="pl-s"><span class="pl-pds">"</span>items<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
      <span class="pl-s"><span class="pl-pds">"</span>$ref<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>#/definitions/VeryComplexType<span class="pl-pds">"</span></span>
    }
  }
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">description:</span> <span class="pl-s">A complex object array response</span></span>
<span class="pl-s"><span class="pl-ent">schema:</span></span>
  <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">array</span></span>
  <span class="pl-s"><span class="pl-ent">items:</span></span>
    <span class="pl-s"><span class="pl-ent">$ref:</span> <span class="pl-s"><span class="pl-pds">'</span>#/definitions/VeryComplexType<span class="pl-pds">'</span></span></span></pre>
		</div>
		<p>
			Response with a string type:
		</p>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
  <span class="pl-s"><span class="pl-pds">"</span>description<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>A simple string response<span class="pl-pds">"</span></span>,
  <span class="pl-s"><span class="pl-pds">"</span>schema<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
    <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>string<span class="pl-pds">"</span></span>
  }
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">description:</span> <span class="pl-s">A simple string response</span></span>
<span class="pl-s"><span class="pl-ent">schema:</span></span>
  <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">string</span></span></pre>
		</div>
		<p>
			Response with headers:
		</p>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
  <span class="pl-s"><span class="pl-pds">"</span>description<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>A simple string response<span class="pl-pds">"</span></span>,
  <span class="pl-s"><span class="pl-pds">"</span>schema<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
    <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>string<span class="pl-pds">"</span></span>
  },
  <span class="pl-s"><span class="pl-pds">"</span>headers<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
    <span class="pl-s"><span class="pl-pds">"</span>X-Rate-Limit-Limit<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
      <span class="pl-s"><span class="pl-pds">"</span>description<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>The number of allowed requests in the current period<span class="pl-pds">"</span></span>,
      <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>integer<span class="pl-pds">"</span></span>
    },
    <span class="pl-s"><span class="pl-pds">"</span>X-Rate-Limit-Remaining<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
      <span class="pl-s"><span class="pl-pds">"</span>description<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>The number of remaining requests in the current period<span class="pl-pds">"</span></span>,
      <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>integer<span class="pl-pds">"</span></span>
    },
    <span class="pl-s"><span class="pl-pds">"</span>X-Rate-Limit-Reset<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
      <span class="pl-s"><span class="pl-pds">"</span>description<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>The number of seconds left in the current period<span class="pl-pds">"</span></span>,
      <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>integer<span class="pl-pds">"</span></span>
    }
  }
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">description:</span> <span class="pl-s">A simple string response</span></span>
<span class="pl-s"><span class="pl-ent">schema:</span></span>
  <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">string</span></span>
<span class="pl-s"><span class="pl-ent">headers:</span></span>
  <span class="pl-s"><span class="pl-ent">X-Rate-Limit-Limit:</span></span>
    <span class="pl-s"><span class="pl-ent">description:</span> <span class="pl-s">The number of allowed requests in the current period</span></span>
    <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">integer</span></span>
  <span class="pl-s"><span class="pl-ent">X-Rate-Limit-Remaining:</span></span>
    <span class="pl-s"><span class="pl-ent">description:</span> <span class="pl-s">The number of remaining requests in the current period</span></span>
    <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">integer</span></span>
  <span class="pl-s"><span class="pl-ent">X-Rate-Limit-Reset:</span></span>
    <span class="pl-s"><span class="pl-ent">description:</span> <span class="pl-s">The number of seconds left in the current period</span></span>
    <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">integer</span></span></pre>
		</div>
		<p>
			Response with no return value:
		</p>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
  <span class="pl-s"><span class="pl-pds">"</span>description<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>object created<span class="pl-pds">"</span></span>
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">description:</span> <span class="pl-s">object created</span></span></pre>
		</div>
		<h4>
			<a id="headers-object" class="anchor" href="#headers-object" aria-hidden="true">
				</a>
			<a name="headersObject">
			</a>
			Headers Object
		</h4>
		<p>
			Lists the headers that can be sent as part of a response.
		</p>
		<h5>
			<a id="patterned-fields-4" class="anchor" href="#patterned-fields-4" aria-hidden="true">
				</a>
			Patterned Fields
		</h5>
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>
						Field Pattern
					</th>
					<th align="center">
						Type
					</th>
					<th>
						Description
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<a name="headersName">
						</a>
						{name}
					</td>
					<td align="center">
						<a href="/relax/home/OpenAPIDocs#headerObject">
							Header Object
						</a>
					</td>
					<td>
						The name of the property corresponds to the name of the header. The value describes the type of the header.
					</td>
				</tr>
			</tbody>
		</table>
		<h5>
			<a id="headers-object-example" class="anchor" href="#headers-object-example" aria-hidden="true">
				</a>
			Headers Object Example
		</h5>
		<p>
			Rate-limit headers:
		</p>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
    <span class="pl-s"><span class="pl-pds">"</span>X-Rate-Limit-Limit<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
        <span class="pl-s"><span class="pl-pds">"</span>description<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>The number of allowed requests in the current period<span class="pl-pds">"</span></span>,
        <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>integer<span class="pl-pds">"</span></span>
    },
    <span class="pl-s"><span class="pl-pds">"</span>X-Rate-Limit-Remaining<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
        <span class="pl-s"><span class="pl-pds">"</span>description<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>The number of remaining requests in the current period<span class="pl-pds">"</span></span>,
        <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>integer<span class="pl-pds">"</span></span>
    },
    <span class="pl-s"><span class="pl-pds">"</span>X-Rate-Limit-Reset<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
        <span class="pl-s"><span class="pl-pds">"</span>description<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>The number of seconds left in the current period<span class="pl-pds">"</span></span>,
        <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>integer<span class="pl-pds">"</span></span>
    }
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">X-Rate-Limit-Limit:</span></span>
  <span class="pl-s"><span class="pl-ent">description:</span> <span class="pl-s">The number of allowed requests in the current period</span></span>
  <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">integer</span></span>
<span class="pl-s"><span class="pl-ent">X-Rate-Limit-Remaining:</span></span>
  <span class="pl-s"><span class="pl-ent">description:</span> <span class="pl-s">The number of remaining requests in the current period</span></span>
  <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">integer</span></span>
<span class="pl-s"><span class="pl-ent">X-Rate-Limit-Reset:</span></span>
  <span class="pl-s"><span class="pl-ent">description:</span> <span class="pl-s">The number of seconds left in the current period</span></span>
  <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">integer</span></span></pre>
		</div>
		<h4>
			<a id="example-object" class="anchor" href="#example-object" aria-hidden="true">
				</a>
			<a name="exampleObject">
			</a>
			Example Object
		</h4>
		<p>
			Allows sharing examples for operation responses.
		</p>
		<h5>
			<a id="patterned-fields-5" class="anchor" href="#patterned-fields-5" aria-hidden="true">
				</a>
			Patterned Fields
		</h5>
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>
						Field Pattern
					</th>
					<th align="center">
						Type
					</th>
					<th>
						Description
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<a name="exampleMimeType">
						</a>
						{
						<a href="/relax/home/OpenAPIDocs#mimeTypes">
							mime type
						</a>
						}
					</td>
					<td align="center">
						Any
					</td>
					<td>
						The name of the property MUST be one of the Operation 
						<code>
							produces
						</code>
						values (either implicit or inherited). The value SHOULD be an example of what such a response would look like.
					</td>
				</tr>
			</tbody>
		</table>
		<h5>
			<a id="example-object-example" class="anchor" href="#example-object-example" aria-hidden="true">
				</a>
			Example Object Example
		</h5>
		<p>
			Example response for application/json mimetype of a Pet data type:
		</p>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
  <span class="pl-s"><span class="pl-pds">"</span>application/json<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
    <span class="pl-s"><span class="pl-pds">"</span>name<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>Puma<span class="pl-pds">"</span></span>,
    <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>Dog<span class="pl-pds">"</span></span>,
    <span class="pl-s"><span class="pl-pds">"</span>color<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>Black<span class="pl-pds">"</span></span>,
    <span class="pl-s"><span class="pl-pds">"</span>gender<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>Female<span class="pl-pds">"</span></span>,
    <span class="pl-s"><span class="pl-pds">"</span>breed<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>Mixed<span class="pl-pds">"</span></span>
  }
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">application/json:</span></span>
  <span class="pl-s"><span class="pl-ent">name:</span> <span class="pl-s">Puma</span></span>
  <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">Dog</span></span>
  <span class="pl-s"><span class="pl-ent">color:</span> <span class="pl-s">Black</span></span>
  <span class="pl-s"><span class="pl-ent">gender:</span> <span class="pl-s">Female</span></span>
  <span class="pl-s"><span class="pl-ent">breed:</span> <span class="pl-s">Mixed</span></span></pre>
		</div>
		<h4>
			<a id="header-object" class="anchor" href="#header-object" aria-hidden="true">
				</a>
			<a name="headerObject">
			</a>
			Header Object
		</h4>
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>
						Field Name
					</th>
					<th align="center">
						Type
					</th>
					<th>
						Description
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<a name="headerDescription">
						</a>
						description
					</td>
					<td align="center">
						<code>
							string
						</code>
					</td>
					<td>
						A short description of the header.
					</td>
				</tr>
				<tr>
					<td>
						<a name="headerType">
						</a>
						type
					</td>
					<td align="center">
						<code>
							string
						</code>
					</td>
					<td>
						<strong>
							Required.
						</strong>
						The type of the object. The value MUST be one of 
						<code>
							"string"
						</code>
						, 
						<code>
							"number"
						</code>
						, 
						<code>
							"integer"
						</code>
						, 
						<code>
							"boolean"
						</code>
						, or 
						<code>
							"array"
						</code>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="headerFormat">
						</a>
						format
					</td>
					<td align="center">
						<code>
							string
						</code>
					</td>
					<td>
						The extending format for the previously mentioned 
						<a href="/relax/home/OpenAPIDocs#stType">
							<code>
								type
							</code>
						</a>
						. See 
						<a href="/relax/home/OpenAPIDocs#dataTypeFormat">
							Data Type Formats
						</a>
						for further details.
					</td>
				</tr>
				<tr>
					<td>
						<a name="headerItems">
						</a>
						items
					</td>
					<td align="center">
						<a href="/relax/home/OpenAPIDocs#itemsObject">
							Items Object
						</a>
					</td>
					<td>
						<strong>
							Required if 
							<a href="/relax/home/OpenAPIDocs#stType">
								<code>
									type
								</code>
							</a>
							is "array".
						</strong>
						Describes the type of items in the array.
					</td>
				</tr>
				<tr>
					<td>
						<a name="headerCollectionFormat">
						</a>
						collectionFormat
					</td>
					<td align="center">
						<code>
							string
						</code>
					</td>
					<td>
						Determines the format of the array if type array is used. Possible values are: 
						<ul>
							<li>
								<code>
									csv
								</code>
								- comma separated values 
								<code>
									foo,bar
								</code>
								. 
							</li>
							<li>
								<code>
									ssv
								</code>
								- space separated values 
								<code>
									foo bar
								</code>
								. 
							</li>
							<li>
								<code>
									tsv
								</code>
								- tab separated values 
								<code>
									foo\tbar
								</code>
								. 
							</li>
							<li>
								<code>
									pipes
								</code>
								- pipe separated values 
								<code>
									foo|bar
								</code>
								. 
							</li>
						</ul>
						Default value is 
						<code>
							csv
						</code>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="headerDefault">
						</a>
						default
					</td>
					<td align="center">
						*
					</td>
					<td>
						Declares the value of the header that the server will use if none is provided. (Note: "default" has no meaning for required headers.) See 
						<a href="http://json-schema.org/latest/json-schema-validation.html#anchor101">
							http://json-schema.org/latest/json-schema-validation.html#anchor101
						</a>
						. Unlike JSON Schema this value MUST conform to the defined 
						<a href="/relax/home/OpenAPIDocs#headerDefault">
							<code>
								type
							</code>
						</a>
						for the header.
					</td>
				</tr>
				<tr>
					<td>
						<a name="headerMaximum">
						</a>
						maximum
					</td>
					<td align="center">
						<code>
							number
						</code>
					</td>
					<td>
						See 
						<a href="http://json-schema.org/latest/json-schema-validation.html#anchor17">
							http://json-schema.org/latest/json-schema-validation.html#anchor17
						</a>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="headerMaximum">
						</a>
						exclusiveMaximum
					</td>
					<td align="center">
						<code>
							boolean
						</code>
					</td>
					<td>
						See 
						<a href="http://json-schema.org/latest/json-schema-validation.html#anchor17">
							http://json-schema.org/latest/json-schema-validation.html#anchor17
						</a>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="headerMinimum">
						</a>
						minimum
					</td>
					<td align="center">
						<code>
							number
						</code>
					</td>
					<td>
						See 
						<a href="http://json-schema.org/latest/json-schema-validation.html#anchor21">
							http://json-schema.org/latest/json-schema-validation.html#anchor21
						</a>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="headerExclusiveMinimum">
						</a>
						exclusiveMinimum
					</td>
					<td align="center">
						<code>
							boolean
						</code>
					</td>
					<td>
						See 
						<a href="http://json-schema.org/latest/json-schema-validation.html#anchor21">
							http://json-schema.org/latest/json-schema-validation.html#anchor21
						</a>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="headerMaxLength">
						</a>
						maxLength
					</td>
					<td align="center">
						<code>
							integer
						</code>
					</td>
					<td>
						See 
						<a href="http://json-schema.org/latest/json-schema-validation.html#anchor26">
							http://json-schema.org/latest/json-schema-validation.html#anchor26
						</a>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="headerMinLength">
						</a>
						minLength
					</td>
					<td align="center">
						<code>
							integer
						</code>
					</td>
					<td>
						See 
						<a href="http://json-schema.org/latest/json-schema-validation.html#anchor29">
							http://json-schema.org/latest/json-schema-validation.html#anchor29
						</a>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="headerPattern">
						</a>
						pattern
					</td>
					<td align="center">
						<code>
							string
						</code>
					</td>
					<td>
						See 
						<a href="http://json-schema.org/latest/json-schema-validation.html#anchor33">
							http://json-schema.org/latest/json-schema-validation.html#anchor33
						</a>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="headerMaxItems">
						</a>
						maxItems
					</td>
					<td align="center">
						<code>
							integer
						</code>
					</td>
					<td>
						See 
						<a href="http://json-schema.org/latest/json-schema-validation.html#anchor42">
							http://json-schema.org/latest/json-schema-validation.html#anchor42
						</a>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="headerMinItems">
						</a>
						minItems
					</td>
					<td align="center">
						<code>
							integer
						</code>
					</td>
					<td>
						See 
						<a href="http://json-schema.org/latest/json-schema-validation.html#anchor45">
							http://json-schema.org/latest/json-schema-validation.html#anchor45
						</a>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="headerUniqueItems">
						</a>
						uniqueItems
					</td>
					<td align="center">
						<code>
							boolean
						</code>
					</td>
					<td>
						See 
						<a href="http://json-schema.org/latest/json-schema-validation.html#anchor49">
							http://json-schema.org/latest/json-schema-validation.html#anchor49
						</a>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="headerEnum">
						</a>
						enum
					</td>
					<td align="center">
						[*]
					</td>
					<td>
						See 
						<a href="http://json-schema.org/latest/json-schema-validation.html#anchor76">
							http://json-schema.org/latest/json-schema-validation.html#anchor76
						</a>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="headerMultipleOf">
						</a>
						multipleOf
					</td>
					<td align="center">
						<code>
							number
						</code>
					</td>
					<td>
						See 
						<a href="http://json-schema.org/latest/json-schema-validation.html#anchor14">
							http://json-schema.org/latest/json-schema-validation.html#anchor14
						</a>
						.
					</td>
				</tr>
			</tbody>
		</table>
		<h5>
			<a id="patterned-objects-8" class="anchor" href="#patterned-objects-8" aria-hidden="true">
				</a>
			Patterned Objects
		</h5>
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>
						Field Pattern
					</th>
					<th align="center">
						Type
					</th>
					<th>
						Description
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<a name="headerExtensions">
						</a>
						^x-
					</td>
					<td align="center">
						Any
					</td>
					<td>
						Allows extensions to the OpenAPI Schema. The field name MUST begin with 
						<code>
							x-
						</code>
						, for example, 
						<code>
							x-internal-id
						</code>
						. The value can be 
						<code>
							null
						</code>
						, a primitive, an array or an object. See 
						<a href="/relax/home/OpenAPIDocs#vendorExtensions">
							Vendor Extensions
						</a>
						for further details.
					</td>
				</tr>
			</tbody>
		</table>
		<h5>
			<a id="header-object-example" class="anchor" href="#header-object-example" aria-hidden="true">
				</a>
			Header Object Example
		</h5>
		<p>
			A simple header with of an integer type:
		</p>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
  <span class="pl-s"><span class="pl-pds">"</span>description<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>The number of allowed requests in the current period<span class="pl-pds">"</span></span>,
  <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>integer<span class="pl-pds">"</span></span>
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">description:</span> <span class="pl-s">The number of allowed requests in the current period</span></span>
<span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">integer</span></span></pre>
		</div>
		<h4>
			<a id="tag-object" class="anchor" href="#tag-object" aria-hidden="true">
				</a>
			<a name="tagObject">
			</a>
			Tag Object
		</h4>
		<p>
			Allows adding meta data to a single tag that is used by the 
			<a href="/relax/home/OpenAPIDocs#operationObject">
				Operation Object
			</a>
			. It is not mandatory to have a Tag Object per tag used there.
		</p>
		<h5>
			<a id="fixed-fields-11" class="anchor" href="#fixed-fields-11" aria-hidden="true">
				</a>
			Fixed Fields
		</h5>
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>
						Field Name
					</th>
					<th align="center">
						Type
					</th>
					<th>
						Description
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<a name="tagName">
						</a>
						name
					</td>
					<td align="center">
						<code>
							string
						</code>
					</td>
					<td>
						<strong>
							Required.
						</strong>
						The name of the tag.
					</td>
				</tr>
				<tr>
					<td>
						<a name="tagDescription">
						</a>
						description
					</td>
					<td align="center">
						<code>
							string
						</code>
					</td>
					<td>
						A short description for the tag. 
						<a href="https://help.github.com/articles/github-flavored-markdown">
							GFM syntax
						</a>
						can be used for rich text representation.
					</td>
				</tr>
				<tr>
					<td>
						<a name="tagExternalDocs">
						</a>
						externalDocs
					</td>
					<td align="center">
						<a href="/relax/home/OpenAPIDocs#externalDocumentationObject">
							External Documentation Object
						</a>
					</td>
					<td>
						Additional external documentation for this tag.
					</td>
				</tr>
			</tbody>
		</table>
		<h5>
			<a id="patterned-fields-6" class="anchor" href="#patterned-fields-6" aria-hidden="true">
				</a>
			Patterned Fields
		</h5>
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>
						Field Pattern
					</th>
					<th align="center">
						Type
					</th>
					<th>
						Description
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<a name="tagExtensions">
						</a>
						^x-
					</td>
					<td align="center">
						Any
					</td>
					<td>
						Allows extensions to the OpenAPI Schema. The field name MUST begin with 
						<code>
							x-
						</code>
						, for example, 
						<code>
							x-internal-id
						</code>
						. The value can be 
						<code>
							null
						</code>
						, a primitive, an array or an object. See 
						<a href="/relax/home/OpenAPIDocs#vendorExtensions">
							Vendor Extensions
						</a>
						for further details.
					</td>
				</tr>
			</tbody>
		</table>
		<h5>
			<a id="tag-object-example" class="anchor" href="#tag-object-example" aria-hidden="true">
				</a>
			Tag Object Example
		</h5>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
    <span class="pl-s"><span class="pl-pds">"</span>name<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>pet<span class="pl-pds">"</span></span>,
    <span class="pl-s"><span class="pl-pds">"</span>description<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>Pets operations<span class="pl-pds">"</span></span>
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">name:</span> <span class="pl-s">pet</span></span>
<span class="pl-s"><span class="pl-ent">description:</span> <span class="pl-s">Pets operations</span></span></pre>
		</div>
		<h4>
			<a id="reference-object" class="anchor" href="#reference-object" aria-hidden="true">
				</a>
			<a name="referenceObject">
			</a>
			Reference Object
		</h4>
		<p>
			A simple object to allow referencing other definitions in the specification. It can be used to reference parameters and responses that are defined at the top level for reuse.
		</p>
		<p>
			The Reference Object is a 
			<a href="http://tools.ietf.org/html/draft-pbryan-zyp-json-ref-02">
				JSON Reference
			</a>
			that uses a 
			<a href="http://tools.ietf.org/html/rfc6901">
				JSON Pointer
			</a>
			as its value. For this specification, only 
			<a href="http://json-schema.org/latest/json-schema-core.html#anchor27">
				canonical dereferencing
			</a>
			is supported.
		</p>
		<h5>
			<a id="fixed-fields-12" class="anchor" href="#fixed-fields-12" aria-hidden="true">
				</a>
			Fixed Fields
		</h5>
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>
						Field Name
					</th>
					<th align="center">
						Type
					</th>
					<th>
						Description
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<a name="referenceRef">
						</a>
						$ref
					</td>
					<td align="center">
						<code>
							string
						</code>
					</td>
					<td>
						<strong>
							Required.
						</strong>
						The reference string.
					</td>
				</tr>
			</tbody>
		</table>
		<h5>
			<a id="reference-object-example" class="anchor" href="#reference-object-example" aria-hidden="true">
				</a>
			Reference Object Example
		</h5>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
    <span class="pl-s"><span class="pl-pds">"</span>$ref<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>#/definitions/Pet<span class="pl-pds">"</span></span>
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">$ref:</span> <span class="pl-s"><span class="pl-pds">'</span>#/definitions/Pet<span class="pl-pds">'</span></span></span></pre>
		</div>
		<h5>
			<a id="relative-schema-file-example" class="anchor" href="#relative-schema-file-example" aria-hidden="true">
				</a>
			Relative Schema File Example
		</h5>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
  <span class="pl-s"><span class="pl-pds">"</span>$ref<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>Pet.json<span class="pl-pds">"</span></span>
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">$ref:</span> <span class="pl-s"><span class="pl-pds">'</span>Pet.yaml<span class="pl-pds">'</span></span></span></pre>
		</div>
		<h5>
			<a id="relative-files-with-embedded-schema-example" class="anchor" href="#relative-files-with-embedded-schema-example" aria-hidden="true">
				</a>
			Relative Files With Embedded Schema Example
		</h5>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
  <span class="pl-s"><span class="pl-pds">"</span>$ref<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>definitions.json#/Pet<span class="pl-pds">"</span></span>
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">$ref:</span> <span class="pl-s"><span class="pl-pds">'</span>definitions.yaml#/Pet<span class="pl-pds">'</span></span></span></pre>
		</div>
		<h4>
			<a id="schema-object" class="anchor" href="#schema-object" aria-hidden="true">
				</a>
			<a name="schemaObject">
			</a>
			Schema Object
		</h4>
		<p>
			The Schema Object allows the definition of input and output data types. These types can be objects, but also primitives and arrays. This object is based on the 
			<a href="http://json-schema.org/">
				JSON Schema Specification Draft 4
			</a>
			and uses a predefined subset of it. On top of this subset, there are extensions provided by this specification to allow for more complete documentation.
		</p>
		<p>
			Further information about the properties can be found in 
			<a href="http://json-schema.org/latest/json-schema-core.html">
				JSON Schema Core
			</a>
			and 
			<a href="http://json-schema.org/latest/json-schema-validation.html">
				JSON Schema Validation
			</a>
			. Unless stated otherwise, the property definitions follow the JSON Schema specification as referenced here.
		</p>
		<p>
			The following properties are taken directly from the JSON Schema definition and follow the same specifications:
		</p>
		<ul>
			<li>
				$ref - As a 
				<a href="https://tools.ietf.org/html/draft-pbryan-zyp-json-ref-03">
					JSON Reference
				</a>
			</li>
			<li>
				format (See 
				<a href="/relax/home/OpenAPIDocs#dataTypeFormat">
					Data Type Formats
				</a>
				for further details)
			</li>
			<li>
				title
			</li>
			<li>
				description (
				<a href="https://help.github.com/articles/github-flavored-markdown">
					GFM syntax
				</a>
				can be used for rich text representation)
			</li>
			<li>
				default (Unlike JSON Schema, the value MUST conform to the defined type for the Schema Object)
			</li>
			<li>
				multipleOf
			</li>
			<li>
				maximum
			</li>
			<li>
				exclusiveMaximum
			</li>
			<li>
				minimum
			</li>
			<li>
				exclusiveMinimum
			</li>
			<li>
				maxLength
			</li>
			<li>
				minLength
			</li>
			<li>
				pattern
			</li>
			<li>
				maxItems
			</li>
			<li>
				minItems
			</li>
			<li>
				uniqueItems
			</li>
			<li>
				maxProperties
			</li>
			<li>
				minProperties
			</li>
			<li>
				required
			</li>
			<li>
				enum
			</li>
			<li>
				type
			</li>
		</ul>
		<p>
			The following properties are taken from the JSON Schema definition but their definitions were adjusted to the OpenAPI Specification. Their definition is the same as the one from JSON Schema, only where the original definition references the JSON Schema definition, the 
			<a href="/relax/home/OpenAPIDocs#schemaObject">
				Schema Object
			</a>
			definition is used instead.
		</p>
		<ul>
			<li>
				items
			</li>
			<li>
				allOf
			</li>
			<li>
				properties
			</li>
			<li>
				additionalProperties
			</li>
		</ul>
		<p>
			Other than the JSON Schema subset fields, the following fields may be used for further schema documentation.
		</p>
		<h5>
			<a id="fixed-fields-13" class="anchor" href="#fixed-fields-13" aria-hidden="true">
				</a>
			Fixed Fields
		</h5>
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>
						Field Name
					</th>
					<th align="center">
						Type
					</th>
					<th>
						Description
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<a name="schemaDiscriminator">
						</a>
						discriminator
					</td>
					<td align="center">
						<code>
							string
						</code>
					</td>
					<td>
						Adds support for polymorphism. The discriminator is the schema property name that is used to differentiate between other schema that inherit this schema. The property name used MUST be defined at this schema and it MUST be in the 
						<code>
							required
						</code>
						property list. When used, the value MUST be the name of this schema or any schema that inherits it.
					</td>
				</tr>
				<tr>
					<td>
						<a name="schemaReadOnly">
						</a>
						readOnly
					</td>
					<td align="center">
						<code>
							boolean
						</code>
					</td>
					<td>
						Relevant only for Schema 
						<code>
							"properties"
						</code>
						definitions. Declares the property as "read only". This means that it MAY be sent as part of a response but MUST NOT be sent as part of the request. Properties marked as 
						<code>
							readOnly
						</code>
						being 
						<code>
							true
						</code>
						SHOULD NOT be in the 
						<code>
							required
						</code>
						list of the defined schema. Default value is 
						<code>
							false
						</code>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="schemaXml">
						</a>
						xml
					</td>
					<td align="center">
						<a href="/relax/home/OpenAPIDocs#xmlObject">
							XML Object
						</a>
					</td>
					<td>
						This MAY be used only on properties schemas. It has no effect on root schemas. Adds Additional metadata to describe the XML representation format of this property.
					</td>
				</tr>
				<tr>
					<td>
						<a name="schemaExternalDocs">
						</a>
						externalDocs
					</td>
					<td align="center">
						<a href="/relax/home/OpenAPIDocs#externalDocumentationObject">
							External Documentation Object
						</a>
					</td>
					<td>
						Additional external documentation for this schema.
					</td>
				</tr>
				<tr>
					<td>
						<a name="schemaExample">
						</a>
						example
					</td>
					<td align="center">
						Any
					</td>
					<td>
						A free-form property to include a an example of an instance for this schema.
					</td>
				</tr>
			</tbody>
		</table>
		<h5>
			<a id="patterned-objects-9" class="anchor" href="#patterned-objects-9" aria-hidden="true">
				</a>
			Patterned Objects
		</h5>
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>
						Field Pattern
					</th>
					<th align="center">
						Type
					</th>
					<th>
						Description
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<a name="schemaExtensions">
						</a>
						^x-
					</td>
					<td align="center">
						Any
					</td>
					<td>
						Allows extensions to the OpenAPI Schema. The field name MUST begin with 
						<code>
							x-
						</code>
						, for example, 
						<code>
							x-internal-id
						</code>
						. The value can be 
						<code>
							null
						</code>
						, a primitive, an array or an object. See 
						<a href="/relax/home/OpenAPIDocs#vendorExtensions">
							Vendor Extensions
						</a>
						for further details.
					</td>
				</tr>
			</tbody>
		</table>
		<h6>
			<a id="composition-and-inheritance-polymorphism" class="anchor" href="#composition-and-inheritance-polymorphism" aria-hidden="true">
				</a>
			Composition and Inheritance (Polymorphism)
		</h6>
		<p>
			OpenAPI allows combining and extending model definitions using the 
			<code>
				allOf
			</code>
			property of JSON Schema, in effect offering model composition. 
			<code>
				allOf
			</code>
			takes in an array of object definitions that are validated 
			<em>
				independently
			</em>
			but together compose a single object. 
		</p>
		<p>
			While composition offers model extensibility, it does not imply a hierarchy between the models. To support polymorphism, OpenAPI adds the support of the 
			<code>
				discriminator
			</code>
			field. When used, the 
			<code>
				discriminator
			</code>
			will be the name of the property used to decide which schema definition is used to validate the structure of the model. As such, the 
			<code>
				discriminator
			</code>
			field MUST be a required field. The value of the chosen property has to be the friendly name given to the model under the 
			<code>
				definitions
			</code>
			property. As such, inline schema definitions, which do not have a given id, 
			<em>
				cannot
			</em>
			be used in polymorphism.
		</p>
		<h6>
			<a id="xml-modeling" class="anchor" href="#xml-modeling" aria-hidden="true">
				</a>
			XML Modeling
		</h6>
		<p>
			The 
			<a href="/relax/home/OpenAPIDocs#schemaXml">
				xml
			</a>
			property allows extra definitions when translating the JSON definition to XML. The 
			<a href="/relax/home/OpenAPIDocs#xmlObject">
				XML Object
			</a>
			contains additional information about the available options.
		</p>
		<h5>
			<a id="schema-object-examples" class="anchor" href="#schema-object-examples" aria-hidden="true">
				</a>
			Schema Object Examples
		</h5>
		<h6>
			<a id="primitive-sample" class="anchor" href="#primitive-sample" aria-hidden="true">
				</a>
			Primitive Sample
		</h6>
		<p>
			Unlike previous versions of OpenAPI, Schema definitions can be used to describe primitive and arrays as well.
		</p>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
    <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>string<span class="pl-pds">"</span></span>,
    <span class="pl-s"><span class="pl-pds">"</span>format<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>email<span class="pl-pds">"</span></span>
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">string</span></span>
<span class="pl-s"><span class="pl-ent">format:</span> <span class="pl-s">email</span></span></pre>
		</div>
		<h6>
			<a id="simple-model" class="anchor" href="#simple-model" aria-hidden="true">
				</a>
			Simple Model
		</h6>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
  <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>object<span class="pl-pds">"</span></span>,
  <span class="pl-s"><span class="pl-pds">"</span>required<span class="pl-pds">"</span></span><span class="pl-k">:</span> [
    <span class="pl-s"><span class="pl-pds">"</span>name<span class="pl-pds">"</span></span>
  ],
  <span class="pl-s"><span class="pl-pds">"</span>properties<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
    <span class="pl-s"><span class="pl-pds">"</span>name<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
      <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>string<span class="pl-pds">"</span></span>
    },
    <span class="pl-s"><span class="pl-pds">"</span>address<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
      <span class="pl-s"><span class="pl-pds">"</span>$ref<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>#/definitions/Address<span class="pl-pds">"</span></span>
    },
    <span class="pl-s"><span class="pl-pds">"</span>age<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
      <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>integer<span class="pl-pds">"</span></span>,
      <span class="pl-s"><span class="pl-pds">"</span>format<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>int32<span class="pl-pds">"</span></span>,
      <span class="pl-s"><span class="pl-pds">"</span>minimum<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-c1">0</span>
    }
  }
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">object</span></span>
<span class="pl-s"><span class="pl-ent">required:</span></span>
<span class="pl-s">- <span class="pl-s">name</span></span>
<span class="pl-s"><span class="pl-ent">properties:</span></span>
  <span class="pl-s"><span class="pl-ent">name:</span></span>
    <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">string</span></span>
  <span class="pl-s"><span class="pl-ent">address:</span></span>
    <span class="pl-s"><span class="pl-ent">$ref:</span> <span class="pl-s"><span class="pl-pds">'</span>#/definitions/Address<span class="pl-pds">'</span></span></span>
  <span class="pl-s"><span class="pl-ent">age:</span></span>
    <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">integer</span></span>
    <span class="pl-s"><span class="pl-ent">format:</span> <span class="pl-s">int32</span></span>
    <span class="pl-c1"><span class="pl-ent">minimum:</span> 0</span></pre>
		</div>
		<h6>
			<a id="model-with-mapdictionary-properties" class="anchor" href="#model-with-mapdictionary-properties" aria-hidden="true">
				</a>
			Model with Map/Dictionary Properties
		</h6>
		<p>
			For a simple string to string mapping:
		</p>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
  <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>object<span class="pl-pds">"</span></span>,
  <span class="pl-s"><span class="pl-pds">"</span>additionalProperties<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
    <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>string<span class="pl-pds">"</span></span>
  }
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">object</span></span>
<span class="pl-s"><span class="pl-ent">additionalProperties:</span></span>
  <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">string</span></span></pre>
		</div>
		<p>
			For a string to model mapping:
		</p>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
  <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>object<span class="pl-pds">"</span></span>,
  <span class="pl-s"><span class="pl-pds">"</span>additionalProperties<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
    <span class="pl-s"><span class="pl-pds">"</span>$ref<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>#/definitions/ComplexModel<span class="pl-pds">"</span></span>
  }
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">object</span></span>
<span class="pl-s"><span class="pl-ent">additionalProperties:</span></span>
  <span class="pl-s"><span class="pl-ent">$ref:</span> <span class="pl-s"><span class="pl-pds">'</span>#/definitions/ComplexModel<span class="pl-pds">'</span></span></span></pre>
		</div>
		<h6>
			<a id="model-with-example" class="anchor" href="#model-with-example" aria-hidden="true">
				</a>
			Model with Example
		</h6>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
  <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>object<span class="pl-pds">"</span></span>,
  <span class="pl-s"><span class="pl-pds">"</span>properties<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
    <span class="pl-s"><span class="pl-pds">"</span>id<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
      <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>integer<span class="pl-pds">"</span></span>,
      <span class="pl-s"><span class="pl-pds">"</span>format<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>int64<span class="pl-pds">"</span></span>
    },
    <span class="pl-s"><span class="pl-pds">"</span>name<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
      <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>string<span class="pl-pds">"</span></span>
    }
  },
  <span class="pl-s"><span class="pl-pds">"</span>required<span class="pl-pds">"</span></span><span class="pl-k">:</span> [
    <span class="pl-s"><span class="pl-pds">"</span>name<span class="pl-pds">"</span></span>
  ],
  <span class="pl-s"><span class="pl-pds">"</span>example<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
    <span class="pl-s"><span class="pl-pds">"</span>name<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>Puma<span class="pl-pds">"</span></span>,
    <span class="pl-s"><span class="pl-pds">"</span>id<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-c1">1</span>
  }
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">object</span></span>
<span class="pl-s"><span class="pl-ent">properties:</span></span>
  <span class="pl-s"><span class="pl-ent">id:</span></span>
    <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">integer</span></span>
    <span class="pl-s"><span class="pl-ent">format:</span> <span class="pl-s">int64</span></span>
  <span class="pl-s"><span class="pl-ent">name:</span></span>
    <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">string</span></span>
<span class="pl-s"><span class="pl-ent">required:</span></span>
<span class="pl-s">- <span class="pl-s">name</span></span>
<span class="pl-s"><span class="pl-ent">example:</span></span>
  <span class="pl-s"><span class="pl-ent">name:</span> <span class="pl-s">Puma</span></span>
  <span class="pl-c1"><span class="pl-ent">id:</span> 1</span></pre>
		</div>
		<h6>
			<a id="models-with-composition" class="anchor" href="#models-with-composition" aria-hidden="true">
				</a>
			Models with Composition
		</h6>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
  <span class="pl-s"><span class="pl-pds">"</span>definitions<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
    <span class="pl-s"><span class="pl-pds">"</span>ErrorModel<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
      <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>object<span class="pl-pds">"</span></span>,
      <span class="pl-s"><span class="pl-pds">"</span>required<span class="pl-pds">"</span></span><span class="pl-k">:</span> [
        <span class="pl-s"><span class="pl-pds">"</span>message<span class="pl-pds">"</span></span>,
        <span class="pl-s"><span class="pl-pds">"</span>code<span class="pl-pds">"</span></span>
      ],
      <span class="pl-s"><span class="pl-pds">"</span>properties<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
        <span class="pl-s"><span class="pl-pds">"</span>message<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
          <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>string<span class="pl-pds">"</span></span>
        },
        <span class="pl-s"><span class="pl-pds">"</span>code<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
          <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>integer<span class="pl-pds">"</span></span>,
          <span class="pl-s"><span class="pl-pds">"</span>minimum<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-c1">100</span>,
          <span class="pl-s"><span class="pl-pds">"</span>maximum<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-c1">600</span>
        }
      }
    },
    <span class="pl-s"><span class="pl-pds">"</span>ExtendedErrorModel<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
      <span class="pl-s"><span class="pl-pds">"</span>allOf<span class="pl-pds">"</span></span><span class="pl-k">:</span> [
        {
          <span class="pl-s"><span class="pl-pds">"</span>$ref<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>#/definitions/ErrorModel<span class="pl-pds">"</span></span>
        },
        {
          <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>object<span class="pl-pds">"</span></span>,
          <span class="pl-s"><span class="pl-pds">"</span>required<span class="pl-pds">"</span></span><span class="pl-k">:</span> [
            <span class="pl-s"><span class="pl-pds">"</span>rootCause<span class="pl-pds">"</span></span>
          ],
          <span class="pl-s"><span class="pl-pds">"</span>properties<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
            <span class="pl-s"><span class="pl-pds">"</span>rootCause<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
              <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>string<span class="pl-pds">"</span></span>
            }
          }
        }
      ]
    }
  }
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">definitions:</span></span>
  <span class="pl-s"><span class="pl-ent">ErrorModel:</span></span>
    <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">object</span></span>
    <span class="pl-s"><span class="pl-ent">required:</span></span>
    <span class="pl-s">- <span class="pl-s">message</span></span>
    <span class="pl-s">- <span class="pl-s">code</span></span>
    <span class="pl-s"><span class="pl-ent">properties:</span></span>
      <span class="pl-s"><span class="pl-ent">message:</span></span>
        <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">string</span></span>
      <span class="pl-s"><span class="pl-ent">code:</span></span>
        <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">integer</span></span>
        <span class="pl-c1"><span class="pl-ent">minimum:</span> 100</span>
        <span class="pl-c1"><span class="pl-ent">maximum:</span> 600</span>
  <span class="pl-s"><span class="pl-ent">ExtendedErrorModel:</span></span>
    <span class="pl-s"><span class="pl-ent">allOf:</span></span>
    <span class="pl-s">- <span class="pl-ent">$ref:</span> <span class="pl-s"><span class="pl-pds">'</span>#/definitions/ErrorModel<span class="pl-pds">'</span></span></span>
    <span class="pl-s">- <span class="pl-ent">type:</span> <span class="pl-s">object</span></span>
      <span class="pl-s"><span class="pl-ent">required:</span></span>
      <span class="pl-s">- <span class="pl-s">rootCause</span></span>
      <span class="pl-s"><span class="pl-ent">properties:</span></span>
        <span class="pl-s"><span class="pl-ent">rootCause:</span></span>
          <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">string</span></span></pre>
		</div>
		<h6>
			<a id="models-with-polymorphism-support" class="anchor" href="#models-with-polymorphism-support" aria-hidden="true">
				</a>
			Models with Polymorphism Support
		</h6>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
  <span class="pl-s"><span class="pl-pds">"</span>definitions<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
    <span class="pl-s"><span class="pl-pds">"</span>Pet<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
      <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>object<span class="pl-pds">"</span></span>,
      <span class="pl-s"><span class="pl-pds">"</span>discriminator<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>petType<span class="pl-pds">"</span></span>,
      <span class="pl-s"><span class="pl-pds">"</span>properties<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
        <span class="pl-s"><span class="pl-pds">"</span>name<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
          <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>string<span class="pl-pds">"</span></span>
        },
        <span class="pl-s"><span class="pl-pds">"</span>petType<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
          <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>string<span class="pl-pds">"</span></span>
        }
      },
      <span class="pl-s"><span class="pl-pds">"</span>required<span class="pl-pds">"</span></span><span class="pl-k">:</span> [
        <span class="pl-s"><span class="pl-pds">"</span>name<span class="pl-pds">"</span></span>,
        <span class="pl-s"><span class="pl-pds">"</span>petType<span class="pl-pds">"</span></span>
      ]
    },
    <span class="pl-s"><span class="pl-pds">"</span>Cat<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
      <span class="pl-s"><span class="pl-pds">"</span>description<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>A representation of a cat<span class="pl-pds">"</span></span>,
      <span class="pl-s"><span class="pl-pds">"</span>allOf<span class="pl-pds">"</span></span><span class="pl-k">:</span> [
        {
          <span class="pl-s"><span class="pl-pds">"</span>$ref<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>#/definitions/Pet<span class="pl-pds">"</span></span>
        },
        {
          <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>object<span class="pl-pds">"</span></span>,
          <span class="pl-s"><span class="pl-pds">"</span>properties<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
            <span class="pl-s"><span class="pl-pds">"</span>huntingSkill<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
              <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>string<span class="pl-pds">"</span></span>,
              <span class="pl-s"><span class="pl-pds">"</span>description<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>The measured skill for hunting<span class="pl-pds">"</span></span>,
              <span class="pl-s"><span class="pl-pds">"</span>default<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>lazy<span class="pl-pds">"</span></span>,
              <span class="pl-s"><span class="pl-pds">"</span>enum<span class="pl-pds">"</span></span><span class="pl-k">:</span> [
                <span class="pl-s"><span class="pl-pds">"</span>clueless<span class="pl-pds">"</span></span>,
                <span class="pl-s"><span class="pl-pds">"</span>lazy<span class="pl-pds">"</span></span>,
                <span class="pl-s"><span class="pl-pds">"</span>adventurous<span class="pl-pds">"</span></span>,
                <span class="pl-s"><span class="pl-pds">"</span>aggressive<span class="pl-pds">"</span></span>
              ]
            }
          },
          <span class="pl-s"><span class="pl-pds">"</span>required<span class="pl-pds">"</span></span><span class="pl-k">:</span> [
            <span class="pl-s"><span class="pl-pds">"</span>huntingSkill<span class="pl-pds">"</span></span>
          ]
        }
      ]
    },
    <span class="pl-s"><span class="pl-pds">"</span>Dog<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
      <span class="pl-s"><span class="pl-pds">"</span>description<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>A representation of a dog<span class="pl-pds">"</span></span>,
      <span class="pl-s"><span class="pl-pds">"</span>allOf<span class="pl-pds">"</span></span><span class="pl-k">:</span> [
        {
          <span class="pl-s"><span class="pl-pds">"</span>$ref<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>#/definitions/Pet<span class="pl-pds">"</span></span>
        },
        {
          <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>object<span class="pl-pds">"</span></span>,
          <span class="pl-s"><span class="pl-pds">"</span>properties<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
            <span class="pl-s"><span class="pl-pds">"</span>packSize<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
              <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>integer<span class="pl-pds">"</span></span>,
              <span class="pl-s"><span class="pl-pds">"</span>format<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>int32<span class="pl-pds">"</span></span>,
              <span class="pl-s"><span class="pl-pds">"</span>description<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>the size of the pack the dog is from<span class="pl-pds">"</span></span>,
              <span class="pl-s"><span class="pl-pds">"</span>default<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-c1">0</span>,
              <span class="pl-s"><span class="pl-pds">"</span>minimum<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-c1">0</span>
            }
          },
          <span class="pl-s"><span class="pl-pds">"</span>required<span class="pl-pds">"</span></span><span class="pl-k">:</span> [
            <span class="pl-s"><span class="pl-pds">"</span>packSize<span class="pl-pds">"</span></span>
          ]
        }
      ]
    }
  }
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">definitions:</span></span>
  <span class="pl-s"><span class="pl-ent">Pet:</span></span>
    <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">object</span></span>
    <span class="pl-s"><span class="pl-ent">discriminator:</span> <span class="pl-s">petType</span></span>
    <span class="pl-s"><span class="pl-ent">properties:</span></span>
      <span class="pl-s"><span class="pl-ent">name:</span></span>
        <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">string</span></span>
      <span class="pl-s"><span class="pl-ent">petType:</span></span>
        <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">string</span></span>
    <span class="pl-s"><span class="pl-ent">required:</span></span>
    <span class="pl-s">- <span class="pl-s">name</span></span>
    <span class="pl-s">- <span class="pl-s">petType</span></span>
  <span class="pl-s"><span class="pl-ent">Cat:</span></span>
    <span class="pl-s"><span class="pl-ent">description:</span> <span class="pl-s">A representation of a cat</span></span>
    <span class="pl-s"><span class="pl-ent">allOf:</span></span>
    <span class="pl-s">- <span class="pl-ent">$ref:</span> <span class="pl-s"><span class="pl-pds">'</span>#/definitions/Pet<span class="pl-pds">'</span></span></span>
    <span class="pl-s">- <span class="pl-ent">type:</span> <span class="pl-s">object</span></span>
      <span class="pl-s"><span class="pl-ent">properties:</span></span>
        <span class="pl-s"><span class="pl-ent">huntingSkill:</span></span>
          <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">string</span></span>
          <span class="pl-s"><span class="pl-ent">description:</span> <span class="pl-s">The measured skill for hunting</span></span>
          <span class="pl-s"><span class="pl-ent">default:</span> <span class="pl-s">lazy</span></span>
          <span class="pl-s"><span class="pl-ent">enum:</span></span>
          <span class="pl-s">- <span class="pl-s">clueless</span></span>
          <span class="pl-s">- <span class="pl-s">lazy</span></span>
          <span class="pl-s">- <span class="pl-s">adventurous</span></span>
          <span class="pl-s">- <span class="pl-s">aggressive</span></span>
      <span class="pl-s"><span class="pl-ent">required:</span></span>
      <span class="pl-s">- <span class="pl-s">huntingSkill</span></span>
  <span class="pl-s"><span class="pl-ent">Dog:</span></span>
    <span class="pl-s"><span class="pl-ent">description:</span> <span class="pl-s">A representation of a dog</span></span>
    <span class="pl-s"><span class="pl-ent">allOf:</span></span>
    <span class="pl-s">- <span class="pl-ent">$ref:</span> <span class="pl-s"><span class="pl-pds">'</span>#/definitions/Pet<span class="pl-pds">'</span></span></span>
    <span class="pl-s">- <span class="pl-ent">type:</span> <span class="pl-s">object</span></span>
      <span class="pl-s"><span class="pl-ent">properties:</span></span>
        <span class="pl-s"><span class="pl-ent">packSize:</span></span>
          <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">integer</span></span>
          <span class="pl-s"><span class="pl-ent">format:</span> <span class="pl-s">int32</span></span>
          <span class="pl-s"><span class="pl-ent">description:</span> <span class="pl-s">the size of the pack the dog is from</span></span>
          <span class="pl-c1"><span class="pl-ent">default:</span> 0</span>
          <span class="pl-c1"><span class="pl-ent">minimum:</span> 0</span>
      <span class="pl-s"><span class="pl-ent">required:</span></span>
      <span class="pl-s">- <span class="pl-s">packSize</span></span></pre>
		</div>
		<h4>
			<a id="xml-object" class="anchor" href="#xml-object" aria-hidden="true">
				</a>
			<a name="xmlObject">
			</a>
			XML Object
		</h4>
		<p>
			A metadata object that allows for more fine-tuned XML model definitions.
		</p>
		<p>
			When using arrays, XML element names are 
			<em>
				not
			</em>
			inferred (for singular/plural forms) and the 
			<code>
				name
			</code>
			property should be used to add that information. See examples for expected behavior.
		</p>
		<h5>
			<a id="fixed-fields-14" class="anchor" href="#fixed-fields-14" aria-hidden="true">
				</a>
			Fixed Fields
		</h5>
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>
						Field Name
					</th>
					<th align="center">
						Type
					</th>
					<th>
						Description
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<a name="xmlName">
						</a>
						name
					</td>
					<td align="center">
						<code>
							string
						</code>
					</td>
					<td>
						Replaces the name of the element/attribute used for the described schema property. When defined within the Items Object (
						<code>
							items
						</code>
						), it will affect the name of the individual XML elements within the list. When defined alongside 
						<code>
							type
						</code>
						being 
						<code>
							array
						</code>
						(outside the 
						<code>
							items
						</code>
						), it will affect the wrapping element and only if 
						<code>
							wrapped
						</code>
						is 
						<code>
							true
						</code>
						. If 
						<code>
							wrapped
						</code>
						is 
						<code>
							false
						</code>
						, it will be ignored.
					</td>
				</tr>
				<tr>
					<td>
						<a name="xmlNamespace">
						</a>
						namespace
					</td>
					<td align="center">
						<code>
							string
						</code>
					</td>
					<td>
						The URL of the namespace definition. Value SHOULD be in the form of a URL.
					</td>
				</tr>
				<tr>
					<td>
						<a name="xmlPrefix">
						</a>
						prefix
					</td>
					<td align="center">
						<code>
							string
						</code>
					</td>
					<td>
						The prefix to be used for the 
						<a href="/relax/home/OpenAPIDocs#xmlName">
							name
						</a>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="xmlAttribute">
						</a>
						attribute
					</td>
					<td align="center">
						<code>
							boolean
						</code>
					</td>
					<td>
						Declares whether the property definition translates to an attribute instead of an element. Default value is 
						<code>
							false
						</code>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="xmlWrapped">
						</a>
						wrapped
					</td>
					<td align="center">
						<code>
							boolean
						</code>
					</td>
					<td>
						MAY be used only for an array definition. Signifies whether the array is wrapped (for example, 
						<code>
							&lt;books&gt;&lt;book/&gt;&lt;book/&gt;&lt;/books&gt;
						</code>
						) or unwrapped (
						<code>
							&lt;book/&gt;&lt;book/&gt;
						</code>
						). Default value is 
						<code>
							false
						</code>
						. The definition takes effect only when defined alongside 
						<code>
							type
						</code>
						being 
						<code>
							array
						</code>
						(outside the 
						<code>
							items
						</code>
						).
					</td>
				</tr>
			</tbody>
		</table>
		<h5>
			<a id="patterned-objects-10" class="anchor" href="#patterned-objects-10" aria-hidden="true">
				</a>
			Patterned Objects
		</h5>
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>
						Field Pattern
					</th>
					<th align="center">
						Type
					</th>
					<th>
						Description
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<a name="xmlExtensions">
						</a>
						^x-
					</td>
					<td align="center">
						Any
					</td>
					<td>
						Allows extensions to the OpenAPI Schema. The field name MUST begin with 
						<code>
							x-
						</code>
						, for example, 
						<code>
							x-internal-id
						</code>
						. The value can be 
						<code>
							null
						</code>
						, a primitive, an array or an object. See 
						<a href="/relax/home/OpenAPIDocs#vendorExtensions">
							Vendor Extensions
						</a>
						for further details.
					</td>
				</tr>
			</tbody>
		</table>
		<h5>
			<a id="xml-object-examples" class="anchor" href="#xml-object-examples" aria-hidden="true">
				</a>
			XML Object Examples
		</h5>
		<p>
			The examples of the XML object definitions are included inside a property definition of a 
			<a href="/relax/home/OpenAPIDocs#schemaObject">
				Schema Object
			</a>
			with a sample of the XML representation of it.
		</p>
		<h6>
			<a id="no-xml-element" class="anchor" href="#no-xml-element" aria-hidden="true">
				</a>
			No XML Element
		</h6>
		<p>
			Basic string property:
		</p>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
    <span class="pl-s"><span class="pl-pds">"</span>animals<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
        <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>string<span class="pl-pds">"</span></span>
    }
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">animals:</span></span>
  <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">string</span></span></pre>
		</div>
		<div class="highlight highlight-text-xml">
			<pre class="language-bash">&lt;<span class="pl-ent">animals</span>&gt;...&lt;/<span class="pl-ent">animals</span>&gt;</pre>
		</div>
		<p>
			Basic string array property (
			<a href="/relax/home/OpenAPIDocs#xmlWrapped">
				<code>
					wrapped
				</code>
			</a>
			is 
			<code>
				false
			</code>
			by default):
		</p>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
    <span class="pl-s"><span class="pl-pds">"</span>animals<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
        <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>array<span class="pl-pds">"</span></span>,
        <span class="pl-s"><span class="pl-pds">"</span>items<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
            <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>string<span class="pl-pds">"</span></span>
        }
    }
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">animals:</span></span>
  <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">array</span></span>
  <span class="pl-s"><span class="pl-ent">items:</span></span>
    <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">string</span></span></pre>
		</div>
		<div class="highlight highlight-text-xml">
			<pre class="language-bash">&lt;<span class="pl-ent">animals</span>&gt;...&lt;/<span class="pl-ent">animals</span>&gt;
&lt;<span class="pl-ent">animals</span>&gt;...&lt;/<span class="pl-ent">animals</span>&gt;
&lt;<span class="pl-ent">animals</span>&gt;...&lt;/<span class="pl-ent">animals</span>&gt;</pre>
		</div>
		<h6>
			<a id="xml-name-replacement" class="anchor" href="#xml-name-replacement" aria-hidden="true">
				</a>
			XML Name Replacement
		</h6>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
  <span class="pl-s"><span class="pl-pds">"</span>animals<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
    <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>string<span class="pl-pds">"</span></span>,
    <span class="pl-s"><span class="pl-pds">"</span>xml<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
      <span class="pl-s"><span class="pl-pds">"</span>name<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>animal<span class="pl-pds">"</span></span>
    }
  }
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">animals:</span></span>
  <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">string</span></span>
  <span class="pl-s"><span class="pl-ent">xml:</span></span>
    <span class="pl-s"><span class="pl-ent">name:</span> <span class="pl-s">animal</span></span></pre>
		</div>
		<div class="highlight highlight-text-xml">
			<pre class="language-bash">&lt;<span class="pl-ent">animal</span>&gt;...&lt;/<span class="pl-ent">animal</span>&gt;</pre>
		</div>
		<h6>
			<a id="xml-attribute-prefix-and-namespace" class="anchor" href="#xml-attribute-prefix-and-namespace" aria-hidden="true">
				</a>
			XML Attribute, Prefix and Namespace
		</h6>
		<p>
			In this example, a full model definition is shown.
		</p>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
  <span class="pl-s"><span class="pl-pds">"</span>Person<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
    <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>object<span class="pl-pds">"</span></span>,
    <span class="pl-s"><span class="pl-pds">"</span>properties<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
      <span class="pl-s"><span class="pl-pds">"</span>id<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
        <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>integer<span class="pl-pds">"</span></span>,
        <span class="pl-s"><span class="pl-pds">"</span>format<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>int32<span class="pl-pds">"</span></span>,
        <span class="pl-s"><span class="pl-pds">"</span>xml<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
          <span class="pl-s"><span class="pl-pds">"</span>attribute<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-c1">true</span>
        },
        <span class="pl-s"><span class="pl-pds">"</span>name<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
          <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>string<span class="pl-pds">"</span></span>,
          <span class="pl-s"><span class="pl-pds">"</span>xml<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
            <span class="pl-s"><span class="pl-pds">"</span>namespace<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>http://OpenAPI.io/schema/sample<span class="pl-pds">"</span></span>,
            <span class="pl-s"><span class="pl-pds">"</span>prefix<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>sample<span class="pl-pds">"</span></span>
          }
        }
      }
    }
  }
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">Person:</span></span>
  <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">object</span></span>
  <span class="pl-s"><span class="pl-ent">properties:</span></span>
    <span class="pl-s"><span class="pl-ent">id:</span></span>
      <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">integer</span></span>
      <span class="pl-s"><span class="pl-ent">format:</span> <span class="pl-s">int32</span></span>
      <span class="pl-s"><span class="pl-ent">xml:</span></span>
        <span class="pl-s"><span class="pl-ent">attribute:</span> <span class="pl-s">true</span></span>
    <span class="pl-s"><span class="pl-ent">name:</span></span>
      <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">string</span></span>
      <span class="pl-s"><span class="pl-ent">xml:</span></span>
        <span class="pl-s"><span class="pl-ent">namespace:</span> <span class="pl-s">http://OpenAPI.io/schema/sample</span></span>
        <span class="pl-s"><span class="pl-ent">prefix:</span> <span class="pl-s">sample</span></span></pre>
		</div>
		<div class="highlight highlight-text-xml">
			<pre class="language-bash">&lt;<span class="pl-ent">Person</span> <span class="pl-e">id</span>=<span class="pl-s"><span class="pl-pds">"</span>123<span class="pl-pds">"</span></span>&gt;
    &lt;<span class="pl-ent">sample</span><span class="pl-ent">:</span><span class="pl-ent">name</span> <span class="pl-e">xmlns</span><span class="pl-e">:</span><span class="pl-e">sample</span>=<span class="pl-s"><span class="pl-pds">"</span>http://OpenAPI.io/schema/sample<span class="pl-pds">"</span></span>&gt;example&lt;/<span class="pl-ent">sample</span><span class="pl-ent">:</span><span class="pl-ent">name</span>&gt;
&lt;/<span class="pl-ent">Person</span>&gt;</pre>
		</div>
		<h6>
			<a id="xml-arrays" class="anchor" href="#xml-arrays" aria-hidden="true">
				</a>
			XML Arrays
		</h6>
		<p>
			Changing the element names:
		</p>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
  <span class="pl-s"><span class="pl-pds">"</span>animals<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
    <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>array<span class="pl-pds">"</span></span>,
    <span class="pl-s"><span class="pl-pds">"</span>items<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
      <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>string<span class="pl-pds">"</span></span>,
      <span class="pl-s"><span class="pl-pds">"</span>xml<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
        <span class="pl-s"><span class="pl-pds">"</span>name<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>animal<span class="pl-pds">"</span></span>
      }
    }
  }
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">animals:</span></span>
  <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">array</span></span>
  <span class="pl-s"><span class="pl-ent">items:</span></span>
    <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">string</span></span>
    <span class="pl-s"><span class="pl-ent">xml:</span></span>
      <span class="pl-s"><span class="pl-ent">name:</span> <span class="pl-s">animal</span></span></pre>
		</div>
		<div class="highlight highlight-text-xml">
			<pre class="language-bash">&lt;<span class="pl-ent">animal</span>&gt;value&lt;/<span class="pl-ent">animal</span>&gt;
&lt;<span class="pl-ent">animal</span>&gt;value&lt;/<span class="pl-ent">animal</span>&gt;</pre>
		</div>
		<p>
			The external 
			<code>
				name
			</code>
			property has no effect on the XML:
		</p>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
  <span class="pl-s"><span class="pl-pds">"</span>animals<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
    <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>array<span class="pl-pds">"</span></span>,
    <span class="pl-s"><span class="pl-pds">"</span>items<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
      <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>string<span class="pl-pds">"</span></span>,
      <span class="pl-s"><span class="pl-pds">"</span>xml<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
        <span class="pl-s"><span class="pl-pds">"</span>name<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>animal<span class="pl-pds">"</span></span>
      }
    },
    <span class="pl-s"><span class="pl-pds">"</span>xml<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
      <span class="pl-s"><span class="pl-pds">"</span>name<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>aliens<span class="pl-pds">"</span></span>
    }
  }
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">animals:</span></span>
  <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">array</span></span>
  <span class="pl-s"><span class="pl-ent">items:</span></span>
    <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">string</span></span>
    <span class="pl-s"><span class="pl-ent">xml:</span></span>
      <span class="pl-s"><span class="pl-ent">name:</span> <span class="pl-s">animal</span></span>
  <span class="pl-s"><span class="pl-ent">xml:</span></span>
    <span class="pl-s"><span class="pl-ent">name:</span> <span class="pl-s">aliens</span></span></pre>
		</div>
		<div class="highlight highlight-text-xml">
			<pre class="language-bash">&lt;<span class="pl-ent">animal</span>&gt;value&lt;/<span class="pl-ent">animal</span>&gt;
&lt;<span class="pl-ent">animal</span>&gt;value&lt;/<span class="pl-ent">animal</span>&gt;</pre>
		</div>
		<p>
			Even when the array is wrapped, if no name is explicitly defined, the same name will be used both internally and externally:
		</p>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
  <span class="pl-s"><span class="pl-pds">"</span>animals<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
    <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>array<span class="pl-pds">"</span></span>,
    <span class="pl-s"><span class="pl-pds">"</span>items<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
      <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>string<span class="pl-pds">"</span></span>
    },
    <span class="pl-s"><span class="pl-pds">"</span>xml<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
      <span class="pl-s"><span class="pl-pds">"</span>wrapped<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-c1">true</span>
    }
  }
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">animals:</span></span>
  <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">array</span></span>
  <span class="pl-s"><span class="pl-ent">items:</span></span>
    <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">string</span></span>
  <span class="pl-s"><span class="pl-ent">xml:</span></span>
    <span class="pl-s"><span class="pl-ent">wrapped:</span> <span class="pl-s">true</span></span></pre>
		</div>
		<div class="highlight highlight-text-xml">
			<pre class="language-bash">&lt;<span class="pl-ent">animals</span>&gt;
  &lt;<span class="pl-ent">animals</span>&gt;value&lt;/<span class="pl-ent">animals</span>&gt;
  &lt;<span class="pl-ent">animals</span>&gt;value&lt;/<span class="pl-ent">animals</span>&gt;
&lt;/<span class="pl-ent">animals</span>&gt;</pre>
		</div>
		<p>
			To overcome the above example, the following definition can be used:
		</p>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
  <span class="pl-s"><span class="pl-pds">"</span>animals<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
    <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>array<span class="pl-pds">"</span></span>,
    <span class="pl-s"><span class="pl-pds">"</span>items<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
      <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>string<span class="pl-pds">"</span></span>,
      <span class="pl-s"><span class="pl-pds">"</span>xml<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
        <span class="pl-s"><span class="pl-pds">"</span>name<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>animal<span class="pl-pds">"</span></span>
      }
    },
    <span class="pl-s"><span class="pl-pds">"</span>xml<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
      <span class="pl-s"><span class="pl-pds">"</span>wrapped<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-c1">true</span>
    }
  }
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">animals:</span></span>
  <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">array</span></span>
  <span class="pl-s"><span class="pl-ent">items:</span></span>
    <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">string</span></span>
    <span class="pl-s"><span class="pl-ent">xml:</span></span>
      <span class="pl-s"><span class="pl-ent">name:</span> <span class="pl-s">animal</span></span>
  <span class="pl-s"><span class="pl-ent">xml:</span></span>
    <span class="pl-s"><span class="pl-ent">wrapped:</span> <span class="pl-s">true</span></span></pre>
		</div>
		<div class="highlight highlight-text-xml">
			<pre class="language-bash">&lt;<span class="pl-ent">animals</span>&gt;
  &lt;<span class="pl-ent">animal</span>&gt;value&lt;/<span class="pl-ent">animal</span>&gt;
  &lt;<span class="pl-ent">animal</span>&gt;value&lt;/<span class="pl-ent">animal</span>&gt;
&lt;/<span class="pl-ent">animals</span>&gt;</pre>
		</div>
		<p>
			Affecting both internal and external names:
		</p>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
  <span class="pl-s"><span class="pl-pds">"</span>animals<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
    <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>array<span class="pl-pds">"</span></span>,
    <span class="pl-s"><span class="pl-pds">"</span>items<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
      <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>string<span class="pl-pds">"</span></span>,
      <span class="pl-s"><span class="pl-pds">"</span>xml<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
        <span class="pl-s"><span class="pl-pds">"</span>name<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>animal<span class="pl-pds">"</span></span>
      }
    },
    <span class="pl-s"><span class="pl-pds">"</span>xml<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
      <span class="pl-s"><span class="pl-pds">"</span>name<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>aliens<span class="pl-pds">"</span></span>,
      <span class="pl-s"><span class="pl-pds">"</span>wrapped<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-c1">false</span>
    }
  }
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">animals:</span></span>
  <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">array</span></span>
  <span class="pl-s"><span class="pl-ent">items:</span></span>
    <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">string</span></span>
    <span class="pl-s"><span class="pl-ent">xml:</span></span>
      <span class="pl-s"><span class="pl-ent">name:</span> <span class="pl-s">animal</span></span>
  <span class="pl-s"><span class="pl-ent">xml:</span></span>
    <span class="pl-s"><span class="pl-ent">name:</span> <span class="pl-s">aliens</span></span>
    <span class="pl-s"><span class="pl-ent">wrapped:</span> <span class="pl-s">false</span></span></pre>
		</div>
		<div class="highlight highlight-text-xml">
			<pre class="language-bash">&lt;<span class="pl-ent">aliens</span>&gt;
  &lt;<span class="pl-ent">animal</span>&gt;value&lt;/<span class="pl-ent">animal</span>&gt;
  &lt;<span class="pl-ent">animal</span>&gt;value&lt;/<span class="pl-ent">animal</span>&gt;
&lt;/<span class="pl-ent">aliens</span>&gt;</pre>
		</div>
		<p>
			If we change the external element but not the internal ones:
		</p>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
  <span class="pl-s"><span class="pl-pds">"</span>animals<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
    <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>array<span class="pl-pds">"</span></span>,
    <span class="pl-s"><span class="pl-pds">"</span>items<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
      <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>string<span class="pl-pds">"</span></span>
    },
    <span class="pl-s"><span class="pl-pds">"</span>xml<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
      <span class="pl-s"><span class="pl-pds">"</span>name<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>aliens<span class="pl-pds">"</span></span>,
      <span class="pl-s"><span class="pl-pds">"</span>wrapped<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-c1">true</span>
    }
  }
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">animals:</span></span>
  <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">array</span></span>
  <span class="pl-s"><span class="pl-ent">items:</span></span>
    <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">string</span></span>
  <span class="pl-s"><span class="pl-ent">xml:</span></span>
    <span class="pl-s"><span class="pl-ent">name:</span> <span class="pl-s">aliens</span></span>
    <span class="pl-s"><span class="pl-ent">wrapped:</span> <span class="pl-s">true</span></span></pre>
		</div>
		<div class="highlight highlight-text-xml">
			<pre class="language-bash">&lt;<span class="pl-ent">aliens</span>&gt;
  &lt;<span class="pl-ent">aliens</span>&gt;value&lt;/<span class="pl-ent">aliens</span>&gt;
  &lt;<span class="pl-ent">aliens</span>&gt;value&lt;/<span class="pl-ent">aliens</span>&gt;
&lt;/<span class="pl-ent">aliens</span>&gt;</pre>
		</div>
		<h4>
			<a id="definitions-object" class="anchor" href="#definitions-object" aria-hidden="true">
				</a>
			<a name="definitionsObject">
			</a>
			Definitions Object
		</h4>
		<p>
			An object to hold data types that can be consumed and produced by operations. These data types can be primitives, arrays or models.
		</p>
		<h5>
			<a id="patterned-fields-7" class="anchor" href="#patterned-fields-7" aria-hidden="true">
				</a>
			Patterned Fields
		</h5>
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>
						Field Pattern
					</th>
					<th align="center">
						Type
					</th>
					<th>
						Description
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<a name="definitionsName">
						</a>
						{name}
					</td>
					<td align="center">
						<a href="/relax/home/OpenAPIDocs#schemaObject">
							Schema Object
						</a>
					</td>
					<td>
						A single definition, mapping a "name" to the schema it defines.
					</td>
				</tr>
			</tbody>
		</table>
		<h5>
			<a id="definitions-object-example" class="anchor" href="#definitions-object-example" aria-hidden="true">
				</a>
			Definitions Object Example
		</h5>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
  <span class="pl-s"><span class="pl-pds">"</span>Category<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
    <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>object<span class="pl-pds">"</span></span>,
    <span class="pl-s"><span class="pl-pds">"</span>properties<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
      <span class="pl-s"><span class="pl-pds">"</span>id<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
        <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>integer<span class="pl-pds">"</span></span>,
        <span class="pl-s"><span class="pl-pds">"</span>format<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>int64<span class="pl-pds">"</span></span>
      },
      <span class="pl-s"><span class="pl-pds">"</span>name<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
        <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>string<span class="pl-pds">"</span></span>
      }
    }
  },
  <span class="pl-s"><span class="pl-pds">"</span>Tag<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
    <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>object<span class="pl-pds">"</span></span>,
    <span class="pl-s"><span class="pl-pds">"</span>properties<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
      <span class="pl-s"><span class="pl-pds">"</span>id<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
        <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>integer<span class="pl-pds">"</span></span>,
        <span class="pl-s"><span class="pl-pds">"</span>format<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>int64<span class="pl-pds">"</span></span>
      },
      <span class="pl-s"><span class="pl-pds">"</span>name<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
        <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>string<span class="pl-pds">"</span></span>
      }
    }
  }
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">Category:</span></span>
  <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">object</span></span>
  <span class="pl-s"><span class="pl-ent">properties:</span></span>
    <span class="pl-s"><span class="pl-ent">id:</span></span>
      <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">integer</span></span>
      <span class="pl-s"><span class="pl-ent">format:</span> <span class="pl-s">int64</span></span>
    <span class="pl-s"><span class="pl-ent">name:</span></span>
      <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">string</span></span>
<span class="pl-s"><span class="pl-ent">Tag:</span></span>
  <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">object</span></span>
  <span class="pl-s"><span class="pl-ent">properties:</span></span>
    <span class="pl-s"><span class="pl-ent">id:</span></span>
      <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">integer</span></span>
      <span class="pl-s"><span class="pl-ent">format:</span> <span class="pl-s">int64</span></span>
    <span class="pl-s"><span class="pl-ent">name:</span></span>
      <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">string</span></span></pre>
		</div>
		<h4>
			<a id="parameters-definitions-object" class="anchor" href="#parameters-definitions-object" aria-hidden="true">
				</a>
			<a name="parametersDefinitionsObject">
			</a>
			Parameters Definitions Object
		</h4>
		<p>
			An object to hold parameters to be reused across operations. Parameter definitions can be referenced to the ones defined here.
		</p>
		<p>
			This does 
			<em>
				not
			</em>
			define global operation parameters.
		</p>
		<h5>
			<a id="patterned-fields-8" class="anchor" href="#patterned-fields-8" aria-hidden="true">
				</a>
			Patterned Fields
		</h5>
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>
						Field Pattern
					</th>
					<th align="center">
						Type
					</th>
					<th>
						Description
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<a name="pdName">
						</a>
						{name}
					</td>
					<td align="center">
						<a href="/relax/home/OpenAPIDocs#parameterObject">
							Parameter Object
						</a>
					</td>
					<td>
						A single parameter definition, mapping a "name" to the parameter it defines.
					</td>
				</tr>
			</tbody>
		</table>
		<h5>
			<a id="parameters-definition-object-example" class="anchor" href="#parameters-definition-object-example" aria-hidden="true">
				</a>
			Parameters Definition Object Example
		</h5>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
  <span class="pl-s"><span class="pl-pds">"</span>skipParam<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
    <span class="pl-s"><span class="pl-pds">"</span>name<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>skip<span class="pl-pds">"</span></span>,
    <span class="pl-s"><span class="pl-pds">"</span>in<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>query<span class="pl-pds">"</span></span>,
    <span class="pl-s"><span class="pl-pds">"</span>description<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>number of items to skip<span class="pl-pds">"</span></span>,
    <span class="pl-s"><span class="pl-pds">"</span>required<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-c1">true</span>,
    <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>integer<span class="pl-pds">"</span></span>,
    <span class="pl-s"><span class="pl-pds">"</span>format<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>int32<span class="pl-pds">"</span></span>
  },
  <span class="pl-s"><span class="pl-pds">"</span>limitParam<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
    <span class="pl-s"><span class="pl-pds">"</span>name<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>limit<span class="pl-pds">"</span></span>,
    <span class="pl-s"><span class="pl-pds">"</span>in<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>query<span class="pl-pds">"</span></span>,
    <span class="pl-s"><span class="pl-pds">"</span>description<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>max records to return<span class="pl-pds">"</span></span>,
    <span class="pl-s"><span class="pl-pds">"</span>required<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-c1">true</span>,
    <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>integer<span class="pl-pds">"</span></span>,
    <span class="pl-s"><span class="pl-pds">"</span>format<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>int32<span class="pl-pds">"</span></span>
  }
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">skipParam:</span></span>
  <span class="pl-s"><span class="pl-ent">name:</span> <span class="pl-s">skip</span></span>
  <span class="pl-s"><span class="pl-ent">in:</span> <span class="pl-s">query</span></span>
  <span class="pl-s"><span class="pl-ent">description:</span> <span class="pl-s">number of items to skip</span></span>
  <span class="pl-s"><span class="pl-ent">required:</span> <span class="pl-s">true</span></span>
  <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">integer</span></span>
  <span class="pl-s"><span class="pl-ent">format:</span> <span class="pl-s">int32</span></span>
<span class="pl-s"><span class="pl-ent">limitParam:</span></span>
  <span class="pl-s"><span class="pl-ent">name:</span> <span class="pl-s">limit</span></span>
  <span class="pl-s"><span class="pl-ent">in:</span> <span class="pl-s">query</span></span>
  <span class="pl-s"><span class="pl-ent">description:</span> <span class="pl-s">max records to return</span></span>
  <span class="pl-s"><span class="pl-ent">required:</span> <span class="pl-s">true</span></span>
  <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">integer</span></span>
  <span class="pl-s"><span class="pl-ent">format:</span> <span class="pl-s">int32</span></span></pre>
		</div>
		<h4>
			<a id="responses-definitions-object" class="anchor" href="#responses-definitions-object" aria-hidden="true">
				</a>
			<a name="responsesDefinitionsObject">
			</a>
			Responses Definitions Object
		</h4>
		<p>
			An object to hold responses to be reused across operations. Response definitions can be referenced to the ones defined here.
		</p>
		<p>
			This does 
			<em>
				not
			</em>
			define global operation responses.
		</p>
		<h5>
			<a id="patterned-fields-9" class="anchor" href="#patterned-fields-9" aria-hidden="true">
				</a>
			Patterned Fields
		</h5>
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>
						Field Pattern
					</th>
					<th align="center">
						Type
					</th>
					<th>
						Description
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<a name="rdName">
						</a>
						{name}
					</td>
					<td align="center">
						<a href="/relax/home/OpenAPIDocs#responseObject">
							Response Object
						</a>
					</td>
					<td>
						A single response definition, mapping a "name" to the response it defines.
					</td>
				</tr>
			</tbody>
		</table>
		<h5>
			<a id="responses-definitions-object-example" class="anchor" href="#responses-definitions-object-example" aria-hidden="true">
				</a>
			Responses Definitions Object Example
		</h5>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
  <span class="pl-s"><span class="pl-pds">"</span>NotFound<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
    <span class="pl-s"><span class="pl-pds">"</span>description<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>Entity not found.<span class="pl-pds">"</span></span>
  },
  <span class="pl-s"><span class="pl-pds">"</span>IllegalInput<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
    <span class="pl-s"><span class="pl-pds">"</span>description<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>Illegal input for operation.<span class="pl-pds">"</span></span>
  },
  <span class="pl-s"><span class="pl-pds">"</span>GeneralError<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
    <span class="pl-s"><span class="pl-pds">"</span>description<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>General Error<span class="pl-pds">"</span></span>,
    <span class="pl-s"><span class="pl-pds">"</span>schema<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
        <span class="pl-s"><span class="pl-pds">"</span>$ref<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>#/definitions/GeneralError<span class="pl-pds">"</span></span>
    }
  }
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">NotFound:</span></span>
  <span class="pl-s"><span class="pl-ent">description:</span> <span class="pl-s">Entity not found.</span></span>
<span class="pl-s"><span class="pl-ent">IllegalInput:</span></span>
  <span class="pl-s"><span class="pl-ent">description:</span> <span class="pl-s">Illegal input for operation.</span></span>
<span class="pl-s"><span class="pl-ent">GeneralError:</span></span>
  <span class="pl-s"><span class="pl-ent">description:</span> <span class="pl-s">General Error</span></span>
  <span class="pl-s"><span class="pl-ent">schema:</span></span>
    <span class="pl-s"><span class="pl-ent">$ref:</span> <span class="pl-s"><span class="pl-pds">'</span>#/definitions/GeneralError<span class="pl-pds">'</span></span></span></pre>
		</div>
		<h4>
			<a id="security-definitions-object" class="anchor" href="#security-definitions-object" aria-hidden="true">
				</a>
			<a name="securityDefinitionsObject">
			</a>
			Security Definitions Object
		</h4>
		<p>
			A declaration of the security schemes available to be used in the specification. This does not enforce the security schemes on the operations and only serves to provide the relevant details for each scheme.
		</p>
		<h5>
			<a id="patterned-fields-10" class="anchor" href="#patterned-fields-10" aria-hidden="true">
				</a>
			Patterned Fields
		</h5>
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>
						Field Pattern
					</th>
					<th align="center">
						Type
					</th>
					<th>
						Description
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<a name="sdName">
						</a>
						{name}
					</td>
					<td align="center">
						<a href="/relax/home/OpenAPIDocs#securitySchemeObject">
							Security Scheme Object
						</a>
					</td>
					<td>
						A single security scheme definition, mapping a "name" to the scheme it defines.
					</td>
				</tr>
			</tbody>
		</table>
		<h5>
			<a id="security-definitions-object-example" class="anchor" href="#security-definitions-object-example" aria-hidden="true">
				</a>
			Security Definitions Object Example
		</h5>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
  <span class="pl-s"><span class="pl-pds">"</span>api_key<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
    <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>apiKey<span class="pl-pds">"</span></span>,
    <span class="pl-s"><span class="pl-pds">"</span>name<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>api_key<span class="pl-pds">"</span></span>,
    <span class="pl-s"><span class="pl-pds">"</span>in<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>header<span class="pl-pds">"</span></span>
  },
  <span class="pl-s"><span class="pl-pds">"</span>petstore_auth<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
    <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>oauth2<span class="pl-pds">"</span></span>,
    <span class="pl-s"><span class="pl-pds">"</span>authorizationUrl<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>http://OpenAPI.io/api/oauth/dialog<span class="pl-pds">"</span></span>,
    <span class="pl-s"><span class="pl-pds">"</span>flow<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>implicit<span class="pl-pds">"</span></span>,
    <span class="pl-s"><span class="pl-pds">"</span>scopes<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
      <span class="pl-s"><span class="pl-pds">"</span>write:pets<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>modify pets in your account<span class="pl-pds">"</span></span>,
      <span class="pl-s"><span class="pl-pds">"</span>read:pets<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>read your pets<span class="pl-pds">"</span></span>
    }
  }
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">api_key:</span></span>
  <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">apiKey</span></span>
  <span class="pl-s"><span class="pl-ent">name:</span> <span class="pl-s">api_key</span></span>
  <span class="pl-s"><span class="pl-ent">in:</span> <span class="pl-s">header</span></span>
<span class="pl-s"><span class="pl-ent">petstore_auth:</span></span>
  <span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">oauth2</span></span>
  <span class="pl-s"><span class="pl-ent">authorizationUrl:</span> <span class="pl-s">http://OpenAPI.io/api/oauth/dialog</span></span>
  <span class="pl-s"><span class="pl-ent">flow:</span> <span class="pl-s">implicit</span></span>
  <span class="pl-s"><span class="pl-ent">scopes:</span></span>
    <span class="pl-s"><span class="pl-ent">write:pets:</span> <span class="pl-s">modify pets in your account</span></span>
    <span class="pl-s"><span class="pl-ent">read:pets:</span> <span class="pl-s">read your pets</span></span></pre>
		</div>
		<h4>
			<a id="security-scheme-object" class="anchor" href="#security-scheme-object" aria-hidden="true">
				</a>
			<a name="securitySchemeObject">
			</a>
			Security Scheme Object
		</h4>
		<p>
			Allows the definition of a security scheme that can be used by the operations. Supported schemes are basic authentication, an API key (either as a header or as a query parameter) and OAuth2's common flows (implicit, password, application and access code).
		</p>
		<h5>
			<a id="fixed-fields-15" class="anchor" href="#fixed-fields-15" aria-hidden="true">
				</a>
			Fixed Fields
		</h5>
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>
						Field Name
					</th>
					<th align="center">
						Type
					</th>
					<th>
						Validity
					</th>
					<th>
						Description
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<a name="securitySchemeType">
						</a>
						type
					</td>
					<td align="center">
						<code>
							string
						</code>
					</td>
					<td>
						Any
					</td>
					<td>
						<strong>
							Required.
						</strong>
						The type of the security scheme. Valid values are 
						<code>
							"basic"
						</code>
						, 
						<code>
							"apiKey"
						</code>
						or 
						<code>
							"oauth2"
						</code>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="securitySchemeDescription">
						</a>
						description
					</td>
					<td align="center">
						<code>
							string
						</code>
					</td>
					<td>
						Any
					</td>
					<td>
						A short description for security scheme.
					</td>
				</tr>
				<tr>
					<td>
						<a name="securitySchemeName">
						</a>
						name
					</td>
					<td align="center">
						<code>
							string
						</code>
					</td>
					<td>
						<code>
							apiKey
						</code>
					</td>
					<td>
						<strong>
							Required.
						</strong>
						The name of the header or query parameter to be used.
					</td>
				</tr>
				<tr>
					<td>
						<a name="securitySchemeIn">
						</a>
						in
					</td>
					<td align="center">
						<code>
							string
						</code>
					</td>
					<td>
						<code>
							apiKey
						</code>
					</td>
					<td>
						<strong>
							Required
						</strong>
						The location of the API key. Valid values are 
						<code>
							"query"
						</code>
						or 
						<code>
							"header"
						</code>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="securitySchemeFlow">
						</a>
						flow
					</td>
					<td align="center">
						<code>
							string
						</code>
					</td>
					<td>
						<code>
							oauth2
						</code>
					</td>
					<td>
						<strong>
							Required.
						</strong>
						The flow used by the OAuth2 security scheme. Valid values are 
						<code>
							"implicit"
						</code>
						, 
						<code>
							"password"
						</code>
						, 
						<code>
							"application"
						</code>
						or 
						<code>
							"accessCode"
						</code>
						.
					</td>
				</tr>
				<tr>
					<td>
						<a name="securitySchemeAuthorizationUrl">
						</a>
						authorizationUrl
					</td>
					<td align="center">
						<code>
							string
						</code>
					</td>
					<td>
						<code>
							oauth2
						</code>
						(
						<code>
							"implicit"
						</code>
						, 
						<code>
							"accessCode"
						</code>
						)
					</td>
					<td>
						<strong>
							Required.
						</strong>
						The authorization URL to be used for this flow. This SHOULD be in the form of a URL.
					</td>
				</tr>
				<tr>
					<td>
						<a name="securitySchemeTokenUrl">
						</a>
						tokenUrl
					</td>
					<td align="center">
						<code>
							string
						</code>
					</td>
					<td>
						<code>
							oauth2
						</code>
						(
						<code>
							"password"
						</code>
						, 
						<code>
							"application"
						</code>
						, 
						<code>
							"accessCode"
						</code>
						)
					</td>
					<td>
						<strong>
							Required.
						</strong>
						The token URL to be used for this flow. This SHOULD be in the form of a URL.
					</td>
				</tr>
				<tr>
					<td>
						<a name="securitySchemeScopes">
						</a>
						scopes
					</td>
					<td align="center">
						<a href="/relax/home/OpenAPIDocs#scopesObject">
							Scopes Object
						</a>
					</td>
					<td>
						<code>
							oauth2
						</code>
					</td>
					<td>
						<strong>
							Required.
						</strong>
						The available scopes for the OAuth2 security scheme.
					</td>
				</tr>
			</tbody>
		</table>
		<h5>
			<a id="patterned-fields-11" class="anchor" href="#patterned-fields-11" aria-hidden="true">
				</a>
			Patterned Fields
		</h5>
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>
						Field Name
					</th>
					<th align="center">
						Type
					</th>
					<th>
						Description
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<a name="securitySchemeExtensions">
						</a>
						^x-
					</td>
					<td align="center">
						Any
					</td>
					<td>
						Allows extensions to the OpenAPI Schema. The field name MUST begin with 
						<code>
							x-
						</code>
						, for example, 
						<code>
							x-internal-id
						</code>
						. The value can be 
						<code>
							null
						</code>
						, a primitive, an array or an object. See 
						<a href="/relax/home/OpenAPIDocs#vendorExtensions">
							Vendor Extensions
						</a>
						for further details.
					</td>
				</tr>
			</tbody>
		</table>
		<h5>
			<a id="security-scheme-object-example" class="anchor" href="#security-scheme-object-example" aria-hidden="true">
				</a>
			Security Scheme Object Example
		</h5>
		<h6>
			<a id="basic-authentication-sample" class="anchor" href="#basic-authentication-sample" aria-hidden="true">
				</a>
			Basic Authentication Sample
		</h6>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
  <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>basic<span class="pl-pds">"</span></span>
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">basic</span></span></pre>
		</div>
		<h6>
			<a id="api-key-sample" class="anchor" href="#api-key-sample" aria-hidden="true">
				</a>
			API Key Sample
		</h6>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
  <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>apiKey<span class="pl-pds">"</span></span>,
  <span class="pl-s"><span class="pl-pds">"</span>name<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>api_key<span class="pl-pds">"</span></span>,
  <span class="pl-s"><span class="pl-pds">"</span>in<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>header<span class="pl-pds">"</span></span>
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">apiKey</span></span>
<span class="pl-s"><span class="pl-ent">name:</span> <span class="pl-s">api_key</span></span>
<span class="pl-s"><span class="pl-ent">in:</span> <span class="pl-s">header</span></span></pre>
		</div>
		<h6>
			<a id="implicit-oauth2-sample" class="anchor" href="#implicit-oauth2-sample" aria-hidden="true">
				</a>
			Implicit OAuth2 Sample
		</h6>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
  <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>oauth2<span class="pl-pds">"</span></span>,
  <span class="pl-s"><span class="pl-pds">"</span>authorizationUrl<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>http://OpenAPI.io/api/oauth/dialog<span class="pl-pds">"</span></span>,
  <span class="pl-s"><span class="pl-pds">"</span>flow<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>implicit<span class="pl-pds">"</span></span>,
  <span class="pl-s"><span class="pl-pds">"</span>scopes<span class="pl-pds">"</span></span><span class="pl-k">:</span> {
    <span class="pl-s"><span class="pl-pds">"</span>write:pets<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>modify pets in your account<span class="pl-pds">"</span></span>,
    <span class="pl-s"><span class="pl-pds">"</span>read:pets<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>read your pets<span class="pl-pds">"</span></span>
  }
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">type:</span> <span class="pl-s">oauth2</span></span>
<span class="pl-s"><span class="pl-ent">authorizationUrl:</span> <span class="pl-s">http://OpenAPI.io/api/oauth/dialog</span></span>
<span class="pl-s"><span class="pl-ent">flow:</span> <span class="pl-s">implicit</span></span>
<span class="pl-s"><span class="pl-ent">scopes:</span></span>
  <span class="pl-s"><span class="pl-ent">write:pets:</span> <span class="pl-s">modify pets in your account</span></span>
  <span class="pl-s"><span class="pl-ent">read:pets:</span> <span class="pl-s">read your pets</span></span></pre>
		</div>
		<h4>
			<a id="scopes-object" class="anchor" href="#scopes-object" aria-hidden="true">
				</a>
			<a name="scopesObject">
			</a>
			Scopes Object
		</h4>
		<p>
			Lists the available scopes for an OAuth2 security scheme.
		</p>
		<h5>
			<a id="patterned-fields-12" class="anchor" href="#patterned-fields-12" aria-hidden="true">
				</a>
			Patterned Fields
		</h5>
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>
						Field Pattern
					</th>
					<th align="center">
						Type
					</th>
					<th>
						Description
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<a name="scopesName">
						</a>
						{name}
					</td>
					<td align="center">
						<code>
							string
						</code>
					</td>
					<td>
						Maps between a name of a scope to a short description of it (as the value of the property).
					</td>
				</tr>
			</tbody>
		</table>
		<h5>
			<a id="patterned-objects-11" class="anchor" href="#patterned-objects-11" aria-hidden="true">
				</a>
			Patterned Objects
		</h5>
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>
						Field Pattern
					</th>
					<th align="center">
						Type
					</th>
					<th>
						Description
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<a name="scopesExtensions">
						</a>
						^x-
					</td>
					<td align="center">
						Any
					</td>
					<td>
						Allows extensions to the OpenAPI Schema. The field name MUST begin with 
						<code>
							x-
						</code>
						, for example, 
						<code>
							x-internal-id
						</code>
						. The value can be 
						<code>
							null
						</code>
						, a primitive, an array or an object. See 
						<a href="/relax/home/OpenAPIDocs#vendorExtensions">
							Vendor Extensions
						</a>
						for further details.
					</td>
				</tr>
			</tbody>
		</table>
		<h5>
			<a id="scopes-object-example" class="anchor" href="#scopes-object-example" aria-hidden="true">
				</a>
			Scopes Object Example
		</h5>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
  <span class="pl-s"><span class="pl-pds">"</span>write:pets<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>modify pets in your account<span class="pl-pds">"</span></span>,
  <span class="pl-s"><span class="pl-pds">"</span>read:pets<span class="pl-pds">"</span></span><span class="pl-k">:</span> <span class="pl-s"><span class="pl-pds">"</span>read your pets<span class="pl-pds">"</span></span>
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">write:pets:</span> <span class="pl-s">modify pets in your account</span></span>
<span class="pl-s"><span class="pl-ent">read:pets:</span> <span class="pl-s">read your pets</span></span></pre>
		</div>
		<h4>
			<a id="security-requirement-object" class="anchor" href="#security-requirement-object" aria-hidden="true">
				</a>
			<a name="securityRequirementObject">
			</a>
			Security Requirement Object
		</h4>
		<p>
			Lists the required security schemes to execute this operation. The object can have multiple security schemes declared in it which are all required (that is, there is a logical AND between the schemes).
		</p>
		<p>
			The name used for each property MUST correspond to a security scheme declared in the 
			<a href="/relax/home/OpenAPIDocs#securityDefinitionsObject">
				Security Definitions
			</a>
			.
		</p>
		<h5>
			<a id="patterned-fields-13" class="anchor" href="#patterned-fields-13" aria-hidden="true">
				</a>
			Patterned Fields
		</h5>
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>
						Field Pattern
					</th>
					<th align="center">
						Type
					</th>
					<th>
						Description
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<a name="securityRequirementsName">
						</a>
						{name}
					</td>
					<td align="center">
						[
						<code>
							string
						</code>
						]
					</td>
					<td>
						Each name must correspond to a security scheme which is declared in the 
						<a href="/relax/home/OpenAPIDocs#securityDefinitions">
							Security Definitions
						</a>
						. If the security scheme is of type 
						<code>
							"oauth2"
						</code>
						, then the value is a list of scope names required for the execution. For other security scheme types, the array MUST be empty.
					</td>
				</tr>
			</tbody>
		</table>
		<h5>
			<a id="security-requirement-object-examples" class="anchor" href="#security-requirement-object-examples" aria-hidden="true">
				</a>
			Security Requirement Object Examples
		</h5>
		<h6>
			<a id="non-oauth2-security-requirement" class="anchor" href="#non-oauth2-security-requirement" aria-hidden="true">
				</a>
			Non-OAuth2 Security Requirement
		</h6>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
  <span class="pl-s"><span class="pl-pds">"</span>api_key<span class="pl-pds">"</span></span><span class="pl-k">:</span> []
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">api_key:</span> <span class="pl-s">[]</span></span></pre>
		</div>
		<h6>
			<a id="oauth2-security-requirement" class="anchor" href="#oauth2-security-requirement" aria-hidden="true">
				</a>
			OAuth2 Security Requirement
		</h6>
		<div class="highlight highlight-source-js">
			<pre class="language-bash">{
  <span class="pl-s"><span class="pl-pds">"</span>petstore_auth<span class="pl-pds">"</span></span><span class="pl-k">:</span> [
    <span class="pl-s"><span class="pl-pds">"</span>write:pets<span class="pl-pds">"</span></span>,
    <span class="pl-s"><span class="pl-pds">"</span>read:pets<span class="pl-pds">"</span></span>
  ]
}</pre>
		</div>
		<div class="highlight highlight-source-yaml">
			<pre class="language-bash"><span class="pl-s"><span class="pl-ent">petstore_auth:</span></span>
<span class="pl-s">- <span class="pl-s">write:pets</span></span>
<span class="pl-s">- <span class="pl-s">read:pets</span></span></pre>
		</div>
		<h3>
			<a id="specification-extensions" class="anchor" href="#specification-extensions" aria-hidden="true">
				</a>
			<a name="vendorExtensions">
			</a>
			Specification Extensions
		</h3>
		<p>
			While the OpenAPI Specification tries to accommodate most use cases, additional data can be added to extend the specification at certain points.
		</p>
		<p>
			The extensions properties are always prefixed by 
			<code>
				"x-"
			</code>
			and can have any valid JSON format value.
		</p>
		<p>
			The extensions may or may not be supported by the available tooling, but those may be extended as well to add requested support (if tools are internal or open-sourced).
		</p>
		<h3>
			<a id="security-filtering" class="anchor" href="#security-filtering" aria-hidden="true">
				</a>
			<a name="securityFiltering">
			</a>
			Security Filtering
		</h3>
		<p>
			Some objects in the OpenAPI specification may be declared and remain empty, or completely be removed, even though they are inherently the core of the API documentation. 
		</p>
		<p>
			The reasoning behind it is to allow an additional layer of access control over the documentation itself. While not part of the specification itself, certain libraries may choose to allow access to parts of the documentation based on some form of authentication/authorization.
		</p>
		<p>
			Two examples for this:
		</p>
		<ol>
			<li>
				The 
				<a href="/relax/home/OpenAPIDocs#pathsObject">
					Paths Object
				</a>
				may be empty. It may be counterintuitive, but this may tell the viewer that they got to the right place, but can't access any documentation. They'd still have access to the 
				<a href="/relax/home/OpenAPIDocs#infoObject">
					Info Object
				</a>
				which may contain additional information regarding authentication.
			</li>
			<li>
				The 
				<a href="/relax/home/OpenAPIDocs#pathItemObject">
					Path Item Object
				</a>
				may be empty. In this case, the viewer will be aware that the path exists, but will not be able to see any of its operations or parameters. This is different than hiding the path itself from the 
				<a href="/relax/home/OpenAPIDocs#pathsObject">
					Paths Object
				</a>
				so the user will not be aware of its existence. This allows the documentation provider a finer control over what the viewer can see.
			</li>
		</ol>
	</article>
</div>
