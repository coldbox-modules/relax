<template>
	<div class="panel panel-solid-default">
		<prism language="json" :code="formatJSONRaw( JSON.stringify( schema ) )"></prism>
	</div>
</template>
<script>
import Prism from 'vue-prismjs';
import { formatJSONRaw } from "@/util/udf";
export default{
	components: {
		Prism
	},
	props : {
		schema : {
			required : true
		}
	},
	methods : {
		formatJSONRaw : formatJSONRaw
	}
}
</script>