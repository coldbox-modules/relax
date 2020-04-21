<template>
	<div class="api-content container-fluid">
		<div v-if="api" class="content-header container-fluid">
			<div class="container-fluid">
				<h1 class="m-0 text-dark">API Documentation: {{ api.info.title }}</h1>
			</div>
		</div>
		<section v-if="api" class="content container-fluid">
			<div class="container-fluid">
				<div class="card card-secondary card-outline card-tabs">
					<div id="api-content-tabs" class="card-body row">
						<b-tabs :fill="true" v-model="tabIndex" class="container-fluid" nav-wrapper-class="text-secondary">
							<b-tab title="Service Overview" title-link-class="text-secondary box-title">
								<api-info :api="api"></api-info>
							</b-tab>
							<b-tab title="API Path Reference" title-link-class="text-secondary box-title" id="paths">
								<api-paths v-on:hash-present="onHashChange" :api="api"></api-paths>
							</b-tab>
							<b-tab v-if="!isPrintStyled" title="HTTP Response Reference" title-link-class="text-secondary box-title" id="httpcodes">
								<http-codes></http-codes>
							</b-tab>
						</b-tabs>
					</div>
				</div>
			</div>
		</section>
	</div>
</template>
<script>
import ApiInfo from "@/components/api/api-info";
import HttpCodes from "@/components/api/httpcodes";
import ApiPaths from "@/components/api/api-paths";
import { mapState } from "vuex";
export default{
	components : {
		ApiInfo,
		HttpCodes,
		ApiPaths
	},
	data(){
		return {
			tabIndex : 0
		}
	},
	computed : {
		...mapState({
			api : state => state.APIDoc,
			activeAPI : state => state.activeAPI
		}),
		isPrintStyled(){ return $( "body" ).hasClass( "print" ) }
	},
	mounted(){
		window.addEventListener( 'hashchange', this.onHashChange, false);
	},
	methods : {
		onHashChange( e ){
			let $resource = $( window.location.hash );
			if( $resource.length ){
				this.ensureHashTargetVisibility( $resource ).then(
					() => {
						if( $resource.is( '.card' ) && $resource.find( '.in' ).length === 0 ){
							$resource.find( '[data-toggle="collapse"]' ).click();
						}
					}
				)
			}
		},
		ensureHashTargetVisibility( $resource ){
			var self = this;

			var promise = new Promise( function( resolve, reject ){

				if( $resource.is(":visible") ) return resolve();

				//recurse up to the top level container
				var $domParents = $resource.parentsUntil( "#api-content-tabs" );

				var totalParents = $domParents.length;
				var i = 1;
				$domParents.each( function(){
					var $parent = $( this );
					if( $parent.not( "#api-content-tabs" ) && $parent.not( ":visible" ) && ( $parent.is( ".collapse:not(.in)" ) || $parent.is( '.tab-pane:not(.active)' ) ) ){
						if( $parent.is( '.tab-pane' ) ){
							Vue.set( self, "tabIndex", $( '.tab-pane', "#api-content-tabs" ).index( $parent ) );
						} else {
							$( '[aria-controls="' + $parent.attr( 'id' ) + '"]' ).click();
						}
					} else if( $parent.not( ":visible" ) ) {
						$parent.css( 'display', 'block' );
					}

					i++;

					if( i === totalParents ){
						resolve();
					}
				});

			});

			return promise;
		}
	}

}
</script>