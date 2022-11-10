<template>
<div class="relaxer-resources mb-0">
	<h5 class="mb-1">Select a tier &amp; path:</h5>
	<div class="mb-1">
		<div class="form-group">
			<label class="text-muted">
				Entry Points:
			</label>
				<b-form-select
					v-if="api['x-entryPoint']"
					name="resourceTier"
					v-model="relaxer.tierURL"
					:options="entryPoints"
				></b-form-select>
				<input
					v-else
					name="resourceTier"
					class="form-control input-sm"
					type="text"
					v-model="relaxer.tierURL"
				/>
		</div><!-- /.form-group -->
		<div class="form-group">
			<label class="text-muted">Paths:</label>
			<!-- Accordion Items-->
			<div
				v-for="( path, pathName ) in api.paths"
				:key="`relaxer_resource_path_${pathName}`"
				class="box box-default"
			>
				<div class="box-header" role="tab" :id="`heading-${pathName}`">
					<h4 class="box-title">
						<a
							data-toggle="collapse"
							:href="`#tab-${pathName}`"
							aria-expanded="true"
							:aria-controls="`tab-${pathName}`"
						>{{pathName}}</a>
					</h4>
				</div>
				<div :id="`tab-${pathName}`" class="box-collapse collapse" role="tabbox" :aria-labelledby="`tab-${pathName}`">
					<div class="box-body">
						<!--- My Resources --->
						<b-form-select
							name="resourceMethod"
							v-model="relaxer.method"
							@change="setEndpoint( pathName )"
							:options="methodOptions( pathName )"
						></b-form-select>
					</div>
				</div>
			</div>
		</div><!-- /.form-group -->
	</div>
</div>
</template>
<script>
import { mapState } from "vuex";
import { BFormSelect } from 'bootstrap-vue';
export default{
	components:{
		BFormSelect
	},
	data(){
		return {
			httpMethodKeys : [ 'get','put','post','patch','delete','options','head' ]
		}
	},
	computed : {
		...mapState({
			api : state => state.APIDoc,
			entryPoints: state =>  state.APIDoc && state.APIDoc[ 'x-entryPoint' ] ? Object.keys( state.APIDoc[ 'x-entryPoint' ] ).map( ( key, index ) => {
					return {
						value : state.APIDoc[ 'x-entryPoint' ][ key ],
						text : `${key}  ( ${state.APIDoc[ 'x-entryPoint' ][ key ]} )`
					}
				} ) : [],
			relaxer : state => state.relaxer.currentRequest
		})
	},
	methods : {
		methodOptions( pathName ){
			let methods = this.httpMethodKeys.map(
				method => {
					return {
						value : method.toUpperCase(),
						text : '( ' + method.toUpperCase() + ' ) ' + pathName
					}
				}
			);
			methods.unshift( { value: null, text : 'Pick One To Test' } );
			return methods;
		},
		setEndpoint( pathName ){
			Vue.set( this.$store.state.relaxer.currentRequest, "resource", pathName );
		}
	},
	created(){
		let api = this.api;
		if( !api['x-entryPoint'] ){
			Vue.set( this.$store.state.relaxer.currentRequest, "tierURL", ( api.scheme ? api.scheme + '://' : window.location.protocol ) + '//' + api.host + api.basePath );
		} else {
			Vue.set( this.$store.state.relaxer.currentRequest, "tierURL", api['x-entryPoint'][ Object.keys( api['x-entryPoint'] )[ 0 ] ] )
		}
	}

}
</script>