
import { mapState } from "vuex";

export default {
	mixins: [],
	computed : {
		...mapState({
			globalData : state => state.globalData
		}),
		relaxAPI : () => relaxAPI
	}
} ;