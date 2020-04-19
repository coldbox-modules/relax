
// Prototype extension imports
import '@/extensions/String';
import 'bootstrap';
import "icheck";
require( 'admin-lte' );
const store = require( "@/store/global" ).default;
import App from "@/components/app";
import { TabsPlugin } from 'bootstrap-vue';

Vue.mixin( require('@/components/mixins/commons').default );
Vue.use( TabsPlugin );

const relax = new Vue( {
	el        : "#app",
	store,
	components: { App }
} );
export default relax;


