<template>
	<div id="overview" class="service-summary">
		<h4 v-if="api.info.version && !isNaN( api.info.version )">Version: <span class="label label-primary">{{ api.info.version }}</span></h4>

		<h2 v-if="api.info.description">Introduction</h2>
		<p v-if="api.info.description" v-html="api.info.description.HTMLBreakLines()"></p>

		<dl>

			<dt v-if="api.info.contact && Object.keys( api.info.contact ).length" class="text-info">Contact:</dt>
			<dd v-if="api.info.contact && Object.keys( api.info.contact ).length" class="address">
				<ul class="list-unstyled">
					<li
						v-for="contactKey in Object.keys( api.info.contact )"
						:key="`apicontact_${contactKey}`"
					>
						<strong>{{ contactKey.toTitleCase() }}:</strong>

						<a
							v-if="isURL( api.info.contact[ contactKey ] )"
							:href="api.info.contact[ contactKey ]"
							target="_blank"
						>
							{{ api.info.contact[ contactKey ] }}
						</a>
						<span v-else>{{ api.info.contact[ contactKey ] }}</span>
					</li>
				</ul>
			</dd>

			<dt v-if="api.info.license && api.info.license.url" class="text-info">License:
				<a :href="api.info.license.url">
					{{ api.info.license.name && api.info.license.name.length > 0 ? api.info.license.name : api.info.license.url}}
					<i class="fa fa-link"></i>
				</a>
			</dt>
			<dt v-if="isURL( api.info.termsOfService )" class="text-info">
				Terms of Service: <a :href="api.info.termsOfService">{{ api.info.termsOfService }}</a>
			</dt>
			<span v-else-if="api.info.termsOfService">
				<dt class="text-info">Terms of Service:</dt>
				<dd v-html="api.info.termsOfService.HTMLBreakLines()"></dd>
			</span>

			<dt v-if="api.externalDocs && api.externalDocs.url" class="text-info">External Docs:
				<a :href="api.externalDocs.url">
					{{
						api.externalDocs.description && api.externalDocs.description.length > 0
							? api.externalDocs.description
							: api.externalDocs.url
					}}
					<i class="fa fa-globe"></i>
				</a>
			</dt>
		</dl>

		<h2 v-if="api.servers">Servers</h2>
		<ul v-if="api.servers" class="list-unstyled">
			<li
				v-for="server in api.servers"
				:key="`server_${server.description}`"
			>
				<strong>
					<a :href="server.url">{{ server.url }}</a>
				</strong> - {{ server.description }}
		</li>
		</ul>

		<h3>Service Entry Points</h3>
		<ul v-if="api['x-entryPoint']" class="list-unstyled">
			<li
				v-for="tierName in Object.keys( api['x-entryPoint'] )"
				:key="`entry_point_${tierName}`"
			>
				<em>{{tierName.toTitleCase()}}:</em>
				<a :href="api[ 'x-entryPoint' ][ tierName ] + api.basePath">{{api[ "x-entryPoint" ][ tierName ]  + api.basePath }}</a>
			</li>
		</ul>
		<ul v-else class="list-unstyled">
			<li>
				<em>Default:</em>
				<a :href="api.scheme ? api.scheme + '://' : windowProtocol + '//' + api.host + api.basePath">
					{{ api.scheme ? api.scheme + '://' : windowProtocol + "//" + api.host + api.basePath }}
				</a>
			</li>
		</ul>

		<!--- Paths --->
		<h3>Service Available Paths</h3>

		<nav class="nav">
			<a
				v-for="key in pathKeys"
				:key="`path_link_${key}`"
				class="nav-link btn btn-sm btn-primary"
				style="margin-right:10px; margin-bottom: 10px"
				:href="`#${api.paths[ key ]}`"
			>{{ key }}</a>
		</nav>

		<h3>MIME Types Consumed</h3>
		<p v-if="api.consumes">
			<nav class="nav">
				<span
					v-for="type in api.consumes"
					:key="`consumes_${type}`"
					class="nav-item"
					style="margin-right:15px"
					data-mimetype="type"
				>
				<code>{{ type }}</code>
				</span>
			</nav>
		</p>
		<p v-else><nav class="nav"><span class="nav-item"><code>application/json</code></span></nav></p>
		<!--- API Return Formats --->
		<h3>MIME Types Returned</h3>
		<p v-if="api.produces">
			<nav class="nav">
				<span
					v-for="type in api.produces"
					:key="`produces_${type}`"
					class="nav-item"
					style="margin-right:15px"
					data-mimetype="type"
				>
					<code>{{ type }}</code>
				</span>
			</nav>
		</p>
		<p v-else><nav class="nav"><span class="nav-item"><code>application/json</code></span></nav></p>

		<h3 v-if="api[ 'x-extensionDetection' ]">Extension Detection:  {{ api[ "x-extensionDetection"] ? 'Yes' : 'No' }}</h3>

		<h3 v-if="api[ 'x-throwOnInvalidExtension' ]">Throws on Invalid Extension:  {{ api[ "x-throwOnInvalidExtension"] ? 'Yes' : 'No' }}</h3>

		<div v-if="api.securityDefinitions">
			<h3>Security Definitions</h3>
			<security-definitions :definitions="api.securityDefinitions"></security-definitions>
		</div>

		<div v-if="api.parameters">
			<h3>Global Parameters</h3>
			<api-parameters :entity="api"></api-parameters>
		</div>

		<x-attributes :entity="api"></x-attributes>

		<div class="clearfix"></div>

	</div>

</template>
<script>
import SecurityDefinitions from "@/components/api/security-definitions";
import ApiParameters from "@/components/api/path/parameters";
import XAttributes from "@/components/api/x-attributes";

export default {
	components : {
		SecurityDefinitions,
		ApiParameters,
		XAttributes
	},
	props : {
		api : {
			type : Object,
			required: true
		}
	},
	computed : {
		pathKeys(){ return Object.keys( this.api.paths ).sort( this.pathLengthSort ); },
		isPrintStyled(){ return $( "body" ).hasClass( "print" ) },
		windowProtocol : () => window.location.protocol
	},
	methods : {
		isURL : ( item ) => item ? item.indexOf( "http" ) === 0 : false,
		pathLengthSort : ( a, b ) => {
			let A = a.toUpperCase();
			let B = b.toUpperCase();
			if (A < B) {
				return -1;
			} else if (A > B) {
				return 1;
			} else {
				return 0;
			}
		}
	}
}
</script>