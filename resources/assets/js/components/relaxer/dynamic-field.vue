<template>
	<div class="dynamicField box" style="margin-top: 10px">
		<div class="col-xs-12 clearfix">
			<div class="col-xs-12 col-sm-1 col-xs-1 pull-right" style="vertical-align:middle">
				<button class="pull-right btn btn-danger btn-flat dynamicRemove" @click="onRemoveField"><i class="fa fa-remove"></i></button>
			</div>
			<div class="col-xs-12 col-sm-5 col-md-4 input-group pull-left">
				<span class="input-group-prepend btn btn-default btn-flat" id="sizing-addon1">Name:</span>
				<input type="text" :data-title="`${fieldType} name`"  :name="`${fieldType}Name`"  class="form-control" size="30" :v-model="field.name" @change="onFieldUpdate" />
			</div>
			<div class="col-xs-12 col-sm-6 col-md-7 input-group pull-right">
				<span class="input-group-prepend btn btn-default btn-flat" id="sizing-addon1">Value:</span>
				<input type="text" :data-title="`${fieldType} value`" :name="`${fieldType}Value`" class="form-control" size="50" :v-model="field.value" @change="onFieldUpdate"/>
			</div>
		</div>
	</div>
</template>
<script>
	export default{
		data(){
			return {
				field : {
					name : "",
					value : ""
				}
			}
		},
		props : {
			fieldType : {
				type : String,
				required: true
			},
			index : {
				type : Number,
				default : 0
			}
		},
		methods : {
			onFieldUpdate(){
				this.$store.commit(
					"relaxer/updateDynamicField",
					{
						index : this.index,
						type : this.fieldType,
						name : this.field.name,
						value : this.field.value
					}
				)
			},
			onRemoveField(){
				this.$store.commit( "relaxer/removeDynamicField", this.fieldType, this.index );
			}
		}
	}
</script>