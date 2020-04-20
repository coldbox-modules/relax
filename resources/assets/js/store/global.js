const relaxAPI = require( "@/api/relax" ).default;
import Vuex from 'vuex';
import { parseRequestParams } from "@/util/udf";
Vue.use(Vuex);

export default new Vuex.Store(
	{
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
			selectAPI: ( context, key ) => context.dispatch( "fetchAPI", key ).then( result => {
				context.commit( "updateState", { key : "activeAPI", value : key } )
				context.commit( "updateState", { key : "APIDoc", value : result.data } )
			} ),
			fetchAPI : ( context, key ) => relaxAPI.get.fetchAPI( key )
		}
	}
);