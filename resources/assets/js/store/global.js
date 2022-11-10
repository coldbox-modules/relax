import relaxAPI from "@/api/relax";
import { parseRequestParams } from "@/util/udf";

import Vuex from "vuex";
Vue.use(Vuex);

import RelaxerStore from "@/store/relaxer";

import VuexPersistence from 'vuex-persist';
import localForage from "localforage";

//first define a plugin that emits when the state has been persisted
const vuexPersistEmitter = () => {
    return store => {
        store.subscribe(mutation => {
            if (mutation.type === 'RESTORE_MUTATION') {
                store._vm.$root.$emit( 'storageReady' );
            }
        });
    }
};

const relaxerStorage = new VuexPersistence({
	key: 'relax',
	strictMode : true,
	asyncStorage : true,
	storage: localForage,
	modules: [ 'relaxer' ]
})


export default new Vuex.Store(
	{
		modules : {
			relaxer : RelaxerStore
		},
		plugins : [
			relaxerStorage.plugin,
			vuexPersistEmitter()
		],
		state : {
			globalData : window.relaxGlobalData,
			availableAPIs : null,
			defaultAPI : null,
			APIDoc : null,
			activeAPI : null
		},
		getters : {
			relaxAPI : () => relaxAPI,
			requestedAPI : () => parseRequestParams().api
		},
		mutations: {
			RESTORE_MUTATION: relaxerStorage.RESTORE_MUTATION,
			updateState(state, payload) {
				Vue.set(state, payload.key, payload.value);
			},
			removeFromState( state, payload ) {
				Vue.delete( state, payload.key );
			}
		},
		actions : {
			fetchAvailableAPIs : ( context ) => new Promise( ( resolve, reject) => {
				relaxAPI.get.listAPIs()
					.then( ( response ) => {
						context.commit( "updateState", { key : "availableAPIs", value : response.data.apis } );
						context.commit( "updateState", { key : "defaultAPI", value : response.data.default } );
						resolve( response.data );
					} )
					.catch( ( error ) => {

					} )
			} ),
			selectAPI: ( context, key ) => {
				context.commit( "updateState", { key : "APIDoc", value: null } );
				context.dispatch( "fetchAPI", key ).then( result => {
					context.commit( "updateState", { key : "activeAPI", value : key } )
					context.commit( "updateState", { key : "APIDoc", value : result.data } )
					if( window.location.href.indexOf( '/api/' + key ) === -1 ){
						window.history.pushState( key , result.data.info.title, context.state.globalData.url.moduleRoot + '/api/' + key );
					}
				} )
			},
			fetchAPI : ( context, key ) => relaxAPI.get.fetchAPI( key )
		}
	}
);