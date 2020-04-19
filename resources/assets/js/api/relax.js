import Axios from "axios";

if( typeof( moduleAPIRoot ) === 'undefined' ) moduleAPIRoot = window.relax.baseUrl;

const urlRoot = moduleAPIRoot + 'apidoc';

const defaultAPI = Axios.create({
	baseURL: urlRoot,
	headers : {
	  "Content-Type" : "application/json"
	}
});

export const finalAPI = {
	get: {
		listAPIs : ( params ) => defaultAPI.get( '', { params : params } ),
		fetchAPI :  ( id, params ) => defaultAPI.get( '/' + id, { params : params } )
	}
};

export default finalAPI;