
// Prototype extension imports
import '@/extensions/String';
import 'bootstrap';
import "icheck";

// Theme
require( 'admin-lte' );

// Global
import App from "@/components/app";
import Relaxer from "@/components/relaxer/relaxer";
import { TabsPlugin } from 'bootstrap-vue';
import VuejsDialog from "vuejs-dialog";
const store = require( "@/store/global" ).default;

Vue.mixin( require('@/components/mixins/commons').default );
Vue.use( TabsPlugin );
Vue.use( VuejsDialog );

const relax = new Vue( {
	el        : "#app",
	store,
	components: { App, Relaxer }
} );
export default relax;


