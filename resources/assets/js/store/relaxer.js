import VuexPersist from 'vuex-persist';
import localForage from "localforage";
import relaxAPI from "@/api/relax";
import { cloneDeep } from "lodash";

const vuexPersist = new VuexPersist({
	key: 'relaxer',
	storage: localForage,
	reducer : ( state ) => { return {
		history : state.relaxer.history
	} }
})

export default {
		namespaced: true,
		plugins: [ vuexPersist.plugin ],
		state : {
			currentRequest : {
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

					var responseObjct = {
						"status": 500,
						"statusText": "Application Error",
						"responseText": responseEcho.errordetail ? responseEcho.errordetail : responseEcho.error,
						"error" : true,
                        getAllResponseHeaders: function(){return {}},
                        getResponseHeader: function( headerName ){return null}
					}

                } else {

                    //reformat our echo to emulate a jqXHR object
                    var responseObject = {
						"error" : false,
                        "status": responseEcho.status_code,
                        "statusText": responseEcho.status_text,
                        "responseText": responseEcho.filecontent,
                        getAllResponseHeaders: function(){
                            return responseEcho.responseheader;
                        },
                        getResponseHeader: function( headerName ){
                            return responseEcho.responseheader[ headerName ];
                        }
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
				relaxAPI.post.relaxer( payload )
						.then( ( xhr ) => {
							context.commit( "appendReponse", xhr )
						} );
			}
		}
};