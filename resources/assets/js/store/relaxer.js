
import relaxAPI from "@/api/relax";
import { cloneDeep } from "lodash";

export default {
		namespaced: true,
		state : {
			currentRequest : {
				resource: "",
				tierURL: "",
				method : "GET",
				headers : [],
				params : []
			},
			blankRequest : {
				resource: "",
				tierURL: "",
				method : "GET",
				headers : [],
				params : []
			},
			lastResponse : null,
			maxHistoryItems : 20,
			history : []
		},
		getters : {},
		mutations: {
			updateState(state, payload) {
				Vue.set(state, payload.key, payload.value);
			},
			removeFromState( state, payload ) {
				Vue.delete( state, payload.key );
			},
			appendReponse( state, result ){
				var responseEcho = result.data;

                if( typeof( responseEcho.status_code ) === 'undefined' ){

					var responseObject = {
						"request" : cloneDeep( state.currentRequest ),
						"status": 500,
						"statusText": "Application Error",
						"responseText": responseEcho.errordetail ? responseEcho.errordetail : responseEcho.error,
						"error" : true,
						"response" : responseEcho
					}

                } else {

                    //reformat our echo to emulate a jqXHR object
                    var responseObject = {
						"request" : cloneDeep( state.currentRequest ),
						"error" : false,
                        "status": responseEcho.status_code,
                        "statusText": responseEcho.status_text,
						"responseText": responseEcho.filecontent,
						"response" : responseEcho
					}
				}

				Vue.set( state, "lastResponse", responseObject );

				if( !responseObject.error ){
					state.history.unshift( responseObject );
				}

			},
			newDynamicField( state, type ){
				if( !state.currentRequest[ type ] ){
					state.currentRequest[ type ] = []
				}
				state.currentRequest[ type ].push( { name : "", value : "" } );
			},
			updateDynamicField( state, params ){
				state.currentRequest[ params.type ].splice( params.index, 1, { name : params.name, value : params.value } );
			},
			removeDynamicField( state, type, index ){
				state.currentRequest[ type ].splice( index, 1 );
			},
			clearHistory( state ){
				state.history.splice( 0, state.history.length );
			},
			removeHistoryItem( state, index ){
				state.history.splice( index, 1 );
			}
		},
		actions : {
			sendRelaxerRequest( context ){
				let payload = cloneDeep( context.state.currentRequest );
				if( !payload.tierURL ){
					payload.tierURL = window.location.protocol + '//' + window.location.hostname;
				}
				if( payload.resource.indexOf( "/" ) === 0 ){
					payload.resource = payload.tierURL + payload.resource;
				}
				return relaxAPI.post.relaxer( payload )
						.then( ( response ) => {
							context.commit( "appendReponse", response );
						} )
						.catch( ( err ) => {
							context.commit( "appendReponse", err );
						} );
			}
		}
};