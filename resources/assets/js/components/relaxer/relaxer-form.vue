<template>
	<form id="relaxer-form" class="relaxerForm form-block container-fluid" action="javascript:void(0)">

		<div class="input-group input-group-lg mb-3">
			<div class="input-group-prepend">
				<div class="input-group-prepend">
					<button type="button" style="min-width:100px" class="btn btn-info btn-flat dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
						{{relaxer.method}}
					</button>
					<ul class="dropdown-menu">
						<li
							v-for="option in methodOptions"
							:key="`http_method_${option.value}`"
							class="dropdown-item"
							@click="setRelaxerMethod( option.value )"
						><strong>{{option.text}}</strong></li>
					</ul>
				</div>
			</div>
			<input title="The resource to hit" type="text" name="httpResource" class="httpResource form-control" v-model="relaxer.resource" />
			<div class="input-group-append">
				<button type="button" class="btn btn-success btn-flat btnSendRequest" @click="onRelaxerSend" title="Send Request">Send <i v-if="isSending" class="fa fa-spin fa-spinner"></i></i><i v-else class="fa fa-paper-plane"></i></button>
			</div>
		</div>

		<div v-if="relaxer.extensionDetection" class="col-xs-12">
			<!--- Format --->
			<select name="httpFormat" title="The resource format extension (if available)" class="httpFormat form-control input-sm" v-model="relaxer.httpFormat">
				<option value="">none</option>
				<option>xml</option>
				<option>json</option>
				<option>jsont</option>
				<option>rss</option>
			</select>
		</div>

		<div class="card card-dark">
			<div class="card-header d-flex p-0">
				<h3 class="card-title p-3 container text-center">
					<a title="Advanced Settings" data-toggle="collapse" :href="`#${advancedSettingsUID}`" aria-expanded="false" :aria-controls="advancedSettingsUID">
						<i class="fa fa-gears"></i> Show Advanced Options
					</a>
				</h3>
			</div>
			<div :id="advancedSettingsUID" class="collapse card-body  advancedSettings">
				<!--- HTTP Headers --->
				<div class="method-card card card-gray">
					<div class="card-header d-flex p-0">
						<h3 class="card-title p-3 container text-center">
							<a data-toggle="collapse" :href="`#${headersUID}`" aria-expanded="false" :aria-controls="headersUID">
								Request Headers
								<i class="pull-right fa fa-caret-down"></i>
							</a>
						</h3>
					</div>

					<div :id="headersUID" class="httpHeaders collapse card-body">
						<dynamic-field
							v-for="( item, index ) in currentHeaders"
							:key="`dynamic_headers_${index}`"
							:index="index"
							field-type="headers"
						></dynamic-field>
						<!--- Add Header --->
						<div class="clearfix" style="margin-top:15px"></div>
						<button type="button" class="btn btn-info btn-sm dynamicAdd" data-type="headers" title="Add Header" id="addHeaderButton" @click="addDynamicItem"><i class="fa fa-plus"></i></button>
					</div>
				</div>

				<div class="method-card card card-gray">
					<div class="card-header d-flex p-0">
						<h3 class="card-title p-3 container text-center">
							<a data-toggle="collapse" :href="`#${paramsUID}`" aria-expanded="false" :aria-controls="paramsUID">
								Request Parameters
								<i class="pull-right fa fa-caret-down"></i>
							</a>
						</h3>
					</div>

					<div :id="paramsUID" class="httpParameters collapse card-body">
						<dynamic-field
							v-for="( item, index ) in currentParameters"
							:key="`dynamic_params_${index}`"
							:index="index"
							field-type="params"
						></dynamic-field>
						<!--- Add Header --->
						<div class="clearfix" style="margin-top:15px"></div>
						<button type="button" class="btn btn-info btn-sm dynamicAdd" data-type="params" title="Add Parameter" id="addParameterButton" @click="addDynamicItem"><i class="fa fa-plus"></i></button>
					</div>
				</div>

				<div class="method-card card card-gray">
					<div class="card-header d-flex p-0">
						<h3 class="card-title p-3 container text-center">
							<a data-toggle="collapse" :href="`#${proxyUID}`" aria-expanded="false" :aria-controls="proxyUID">
								HTTP Proxy Settings
								<i class="pull-right fa fa-caret-down"></i>
							</a>
						</h3>
					</div>

					<div class="collapse card-body" :id="proxyUID">
						Host:
						<input title="HTTP Proxy"  type="text" class="form-control" name="httpProxy" id="httpProxy"  size="30" :value="relaxer.httpProxy" />
						Port:
						<input title="HTTP Proxy Port"  type="text" class="form-control" name="httpProxyPort" id="httpProxyPort" size="30" :value="relaxer.httpProxyPort" />
					</div>
				</div>

				<div class="method-card card card-gray">
					<div class="card-header d-flex p-0">
						<h3 class="card-title p-3 container text-center">
							<a data-toggle="collapse" :href="`#${authUID}`" aria-expanded="false" :aria-controls="authUID">
								HTTP Authentication Settings
								<i class="pull-right fa fa-caret-down"></i>
							</a>
						</h3>
					</div>

					<div class="collapse card-body" :id="authUID">
						Username:
						<input title="Username"  type="text" class="form-control" name="username" id="username" size="30" :value="relaxer.authUsername" />
						Password:
						<input title="Password"  type="text" class="form-control" name="password" id="password" size="30" :value="relaxer.authPassword" />
					</div>
				</div>
			</div>
		</div>
	</form>
</template>
<script>
import { BFormSelect } from 'bootstrap-vue';
import { uniqueId } from "lodash";
import { mapState } from "vuex";
import DynamicField from "@/components/relaxer/dynamic-field";
export default{
	components: {
		BFormSelect,
		DynamicField
	},
	props : {
		request : {
			type : Object
		}
	},
	data(){
		return {
			isSending : false,
			headersUID : uniqueId( "headers" ),
			paramsUID : uniqueId( "params" ),
			proxyUID : uniqueId( "proxy" ),
			authUID : uniqueId( "auth" ),
			advancedSettingsUID : uniqueId( "advancedSettings" ),
			httpMethodKeys : [ 'get','put','post','patch','delete','options','head' ]
		}
	},
	computed : {
		...mapState({
			relaxer : state => state.relaxer.currentRequest,
			currentParameters : state => state.relaxer.currentRequest.params || [],
			currentHeaders : state => state.relaxer.currentRequest.headers || [],
		}),
		methodOptions(){
			return this.httpMethodKeys.map( method => {
				return {
					value : method.toUpperCase(),
					text : method.toUpperCase()
				}
			} );
		}
	},
	methods: {
		onRelaxerSend: function( e ){
			var self = this;

			Vue.set( self, "isSending", true );

			this.$store.dispatch( "relaxer/sendRelaxerRequest" ).then( () => Vue.set( self, "isSending", false ) );

		},
		marshallRelaxerRequest: function(){
			var self = this;
			var request = {
				resource : $( '[name="httpResource"]', self.$relaxerForm ).val(),
				method : $( '[name="httpMethod"]', self.$relaxerForm ).val(),
				headers : {},
				data : {}
			}

			if( $( '[name="httpAccept"]', self.$relaxerForm ).length > 0 ){
				request.accepts = $( '[name="httpAccept"]', self.$relaxerForm ).val();
			}

			if( $( '[name="httpProxy"]', self.$relaxerForm ).val().length > 0 ){
				request.httpProxy = $( '[name="httpProxy"]', self.$relaxerForm ).val();
			}

			if( $( '[name="username"]', self.$relaxerForm ).val().length > 0 ){
				request.authUsername = $( '[name="username"]', self.$relaxerForm ).val();
			}

			if( $( '[name="password"]', self.$relaxerForm ).val().length > 0 ){
				request.authPassword = $( '[name="password"]', self.$relaxerForm ).val();
			}

			$( ".requestHeaders", self.$relaxerForm ).find(".dynamicField").each( function(){
				var $headerContainer = $( this );
				request.headers[ $headerContainer.find( '[name="headerName"]' ).val() ] = $headerContainer.find( '[name="headerValue"]' ).val();
			});

			$( ".requestParams", self.$relaxerForm ).find(".dynamicField").each( function(){
				var $paramContainer = $( this );
				request.data[ $paramContainer.find( '[name="parameterName"]' ).val() ] = $paramContainer.find( '[name="parameterValue"]' ).val();
			});

			return request;
		},
		addDynamicItem: function( e ){
			let $trigger = $( e.currentTarget );
			var fieldType = $trigger.data( "type" );
			this.$store.commit( "relaxer/newDynamicField", fieldType )
		},
		setRelaxerMethod( method ){
			Vue.set( this.$store.state.relaxer.currentRequest, "method", method );
		}

	}
}
</script>