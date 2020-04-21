<template>
	<!--- Request History --->
	<div class="box box-primary container-fluid">
		<div class="box-header">
			<h3 class="box-title">
				Request History

				<a @click="onClearHistory" class="btnClearHistory pull-right" data-toggle="tooltip" title="Clear the request history">
					<i class="fa fa-recycle"></i>
				</a>

			</h3>
		</div>
		<div class="box-body">
			<history-item
				v-for="(historyItem, index) in history"
				:key="`history_item_${index}`"
				:historyItem="historyItem"
				:itemIndex="index"
			></history-item>
		</div>
	</div> <!--- box history --->
</template>
<script>
import HistoryItem from "@/components/relaxer/history-item";
import { mapState } from "vuex";
export default{
	components : {
		HistoryItem
	},
	computed : {
		...mapState( {
			history : state => state.relaxer.history
		} )
	},
	methods : {
		onClearHistory(){
			this.$store.commit( "relaxer/clearHistory" );
		}
	}

}
</script>