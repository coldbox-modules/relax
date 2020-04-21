import { mapState }  from "vuex";
import { formatJSONRaw } from "@/util/udf";
import { cloneDeep } from "lodash";
export default {
	data(){
		return {
			alertDismiss: '<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>'
		}
	},
	computed : {
		...mapState({
			activeAPI : state => state.activeAPI
		})
	},
	methods: {

		/**
		* Exporter event methods
		**/

		/**
		* Fires when Exporting JSON
		* @param e      The event object
		**/
		onExportAPIJSON: function( e ){
			var $modal = $( "#api-export-modal" );
			$modal.modal("show");
		}

		/**
		* Fires when showing the import modal
		* @param e      The event object
		**/
		,onShowImportAPI: function( e ){
			var $modal = $( "#api-import-modal" );
			$modal.modal("show");
		}


		/**
		* Confirmation function placeholder for future implementation of API overwrites
		* @param e      The event object
		**/
		,onConfirmImportAPI: function( e ){
			var self = this;
			self.onProcessImportAPI( e );
		}

		/**
		* Fires when the api import name is changed
		* @param e      The event object
		**/
		,onValidateAPIName: function( e ){
			var self = this;
			var $apiName = $( e.currentTarget );
			$apiName.parent().find( '.alert' ).remove();
			var enteredName = $apiName.val();
			var $apiSelect = $( '[name="myAPI"]' );
			var exists = false;

			$apiSelect.find( 'option' ).each( function( ){

				if( $( this ).attr( 'value' ).toLowerCase() === enteredName.trim().toLowerCase() ) exists = true;
			} );

			if( exists ){
				$apiName.after( '<p class="alert alert-danger" style="margin-top: 10px">The API Name entered already exists.  You may not import an API that overwrites an existing one at this time.</p>' );
				$apiName.closest( '.modal-content' ).find('.modal-footer').find( '.btnProcessImport' ).prop( 'disabled', true );
			} else {
				$apiName.closest( '.modal-content' ).find('.modal-footer').find( '.btnProcessImport' ).prop( 'disabled', false );
			}
		}

		/**
		* Fires when an API import is confirmed
		* @param e      The event object
		**/
		,onProcessImportAPI: function( e ){
			var self = this;
			var $btn = $( e.currentTarget );
			$btn.append( '<i class="fa fa-spin fa-spinner fa-xs"></>' );
			var $modal = $( "#api-import-modal" );
			var formData = {};
			$( 'input,textarea', $modal ).each( function(){
				formData[ $( this ).attr( 'name' ) ]=$( this ).val();
			});
			$.post(
				moduleAPIRoot + "apidoc",
				formData
			).done( function( data){
				$btn.find( 'i.fa-spin' ).remove();
				if( data.name && data.document ){
					$modal.modal("hide");
					self.$store.dispatch( "fetchAvailableAPIs" ).then( response => self.$store.dispatch( "selectAPI", formData.apiName ) )
				} else {

					$form.append( '<p class="alert alert-danger alert-dismissable" style="margin-top:10px">' + self.alertDismiss + 'The API could not be reported due to the following reason: <strong><em>' + data.message + '</em></strong>. Please correct your errors and try again.' );

				}
			}).fail( function( data ){
				$btn.find( 'i.fa-spin' ).remove();
				if( !_.isUndefined( data.message ) ){
					$form.append( '<p class="alert alert-danger alert-dismissable">The API could not be reported due to the following reason: <strong><em>' + data.message + '</em></strong>. Please correct your errors and try again.' );
				} else {
					$form.append( '<p class="alert alert-danger alert-dismissable">An unexpected error occurred while attempting to create the API. Please check the logs for additional information.' );
				}
			});
		}

		/**
		* Fires when exporting a specific format
		* @param e      The event object
		**/
		,onExportFormat: function( e ){
			var $btn = $( e.currentTarget );
			var location = $btn.data( 'link' );
			window.open( location + "/" + this.$store.state.activeAPI );
		}

		,onExportPDF: function( e ){
			var self = this;
			var $btn = $( e.currentTarget );
			var location = $btn.data( 'link' );
			this.$dialog.confirm(
				'<p>In previous versions of Relax a PDF was generated directly from the server.</p><p>Due to poor HTML5 support in PDF generation, the most reliable way to generate a PDF is to open the HTML version and then print the contents to a PDF.</p><p>Do you wish to proceed?</p>',
				{
					html: true,
					okText: 'Proceed',
					cancelText: 'Cancel',
					animation: 'zoom' // Available: "zoom", "bounce", "fade"
				}
			)
			.then(function(dialog) {
				window.open( location + "/" + self.$store.state.activeAPI );
			});
		}

		/**
		* Fires when a Relaxer resource is clicked
		* @param e      The event object
		**/
		,onRelaxerResourceSelect: function( e ){
			var self = this;
			var $resourceSelector = $( e.currentTarget );
			var resource = $resourceSelector.val().split( ";" );
			var methodName = resource[ 0 ];

			if( methodName === 'null' ){

				$( '[name="httpResource"]' ).val( '' );

			} else {

				var pathName = resource[ 1 ];
				var apiPath = self.ViewModel.attributes.paths[ pathName ];
				var apiMethod = apiPath[ methodName ];
				var tierEntry = $( '[name="resourceTier"]' ).val();
				//populate our URL and set the method
				$( '[name="httpResource"]' ).val( tierEntry + pathName );
				var $methodSelect = $( '[name="httpMethod"]' );
				$( 'option', $methodSelect ).each( function(){
					var $option = $( this );
					if( methodName.toUpperCase() === $option.val() ) $option.prop( 'selected', true );
				});

				//handle any advanced options or headers specified in the path

			}

		}

		/**
		* ----------------------------------------------
		* Utility Methods
		* ----------------------------------------------
		*/

		/**
		* Returns a textarea with the raw export data
		* @param exportContent      The export content string
		**/
		,exportWrapper: function( exportContent ){
			return '<textarea id="exportContent" class="form-control" rows="20">' + exportContent + '</textarea>';
		}


	}
} ;