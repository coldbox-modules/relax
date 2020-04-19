<template>
	<div class="request-body">
		<div
			v-for="( content, contentKey ) in requestBody.content"
			:key="resourceId( contentKey )"
			:id="resourceId( contentKey )"
			class="method-panel panel panel-info"
		>
			<div class="panel-heading">
				<h3 class="panel-title methodHeader">
					<strong>{{contentKey}}</strong>
					<a class="pull-right btToggleMethod" role="button" data-toggle="collapse" :href="`#panel_${resourceId( contentKey )}`" aria-expanded="false" :aria-controls="`panel_${resourceId( contentKey )}`">
						<i class="fa fa-chevron-down"></i>
					</a>
				</h3>
			</div>
			<div :id="`panel_${resourceId( contentKey )}`" class="collapse panel-body">
				<ul v-if="content.schema && content.schema.properties" class="col-xs-12 list-unstyled">
					<li
						v-for="param in Object.keys( content.schema.properties ).sort( ucaseCompare )"
						:key="`${resourceId( contentKey )}_param_${param}`"
					>
						<strong><code>{{ param }}</code></strong>
						<ul class="list-unstyled" padding-left="20px">
							<li><strong>Type:</strong></storng>{{ content.schema.properties[ param ].type || 'N/A' }}</li>
							<li v-if="content.schema.properties[ param ].description">
								<strong>Description:</strong><br>
								<p>{{ content.schema.properties[ param ].description }}</p>
							</li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
	</div>
</template>
<script>
export default{
	props : {
		entity : {
			type : Object,
			required: true
		}
	},
	computed : {
		requestBody(){ return this.entity.requestBody },
	},
	methods : {
		resourceId( contentKey ){
			return this.entity["x-resourceId"] + '-requestBody-' + contentKey.split( '/' ).pop();
		},
		ucaseCompare : ( a, b ) => {
			var A = a.toUpperCase();
			var B = b.toUpperCase();
			if (A < B) {
				return -1;
			} else if (A > B) {
				return 1;
			} else {
				return 0;
			}
		}
	}
}
</script>