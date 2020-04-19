<template>

	<!-- security definitions -->
	<div class="definition-list list-group">
		<div class="col-xs-12 bg-primary">
			<div class="definition-column key col-sm-3 col-xs-8">
				Name
			</div>

			<div class="definition column type col-sm-2 col-xs-4">
				Type
			</div>

			<div class="definition column description col-sm-7 col-xs-12">
				Description
			</div>

		</div>
		<div
			v-for="( definition, definitionKey ) in definitions"
			:key="`security_definition_${definitionKey}`"
			class="list-group-item definition optional col-xs-12"
		>

			<div class="definition-column key col-sm-3 col-xs-8">
				<code>{{ definition.name || definitionKey }}</code>
			</div>

			<div class="definition column type col-sm-2 col-xs-4">
				<code v-if="definition.type">{{ definition.type }}</code>
				<span v-else >N/A</span>
			</div>

			<div class="definition column description col-sm-7 col-xs-12">

				<a v-if="definition.type === 'oauth2'" :href="`#definition_${definition.type}`" class="pull-right" data-toggle="collapse" aria-expanded="false" :aria-controls="`definition_${definition.type}`">
					<small><i class="fa fa-chevron-down"></i></small>
				</a>
				<p v-if="definition.in">Provided in the <code>{{definition.in}}</code> of the request</p>
				<p v-if="definition.description" v-html="definition.description.HTMLBreakLines()"></p>
				<p v-else>Definition description unavailable.</p>

			</div>

			<div v-if="definition.type === 'oauth'" class="clearfix"></div>
			<div v-if="definition.type === 'oauth'" :id="`definition_${definition.type}`" class="collapse panel panel-solid-default">
				<ul class="list-unstyled">
					<li>
						<strong>Authorization URL:</strong>
						<a :href="definition.authorizationUrl">{{definition.authorizationUrl}}</a>
					</li>

					<li v-if="definition.tokenUrl">
						<strong>Token URL</strong> <a :href="definition.tokenUrl">{{definition.tokenUrl}}</a><br>
					</li>

					<li>
						<strong>OAuth Flow</strong> <code>{{definition.flow}}</code><br>
					</li>
					<li>
						<strong>Scopes:</strong><br>
						<pre class="language-json">{{ formatJSONRaw( JSON.stringify( definition.scopes ) ).trim() }}</pre>
					</li>
				</ul>
			</div>
		</div>
	</div>
	<!-- /security definitions -->
</template>
<script>
export default{
	props : {
		definitions : {
			type : Object,
			required : true
		}
	}

}
</script>