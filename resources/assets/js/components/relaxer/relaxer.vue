<template>

</template>
<script>
export default{

	methods : {
		/**
        * Renders the Relaxer resources container
        **/
		renderRelaxerResources:function(){
			var _this = this;
			var resourceTemplate = _.template( $( "#relaxer-resources-template" ).html() );
			$( ".relaxer-resources", _this.$el ).html( resourceTemplate( {
				"api":_this.ViewModel.attributes
			} ) )

		}

		/**
		* Initializes the relaxer history model
		**/
		,initializeRelaxerHistory:function(){
			var _this = this;

			if( _.isUndefined( _this.View.HistoryModel ) ){

				_this.View.HistoryModel = new HistoryModel();

			}

			//when the relaxer history changes, re-render in the sidebar
			_this.View.HistoryModel.on( 'change:history', function(){
				_this.renderRelaxerHistory();
			});
		}

		/**
		* Renders the Relaxer history
		**/
		,renderRelaxerHistory:function(){
			var _this = this;

			var historyTemplate = _.template( $( "#relaxer-resources-template" ).html() );
			var $historyContainer = $( ".relaxer-history", _this.el );

			$historyContainer.empty().html( historyTemplate( {
				"history":_this.HistoryModel.attributes.history
			} ) );
		}
	}
}
</script>