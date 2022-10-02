<template>
	<div>
    <div v-for="(C_item, C_i) in cctv_list"
		:key="C_i">
		<img :src="`${URL}/api/cctvs/streaming/`">
    </div>
	</div>
</template>

<script>
export default {
	setup() {
		const URL = process.env.VUE_APP_VIDEO_API2

		return {
		URL
	}
	}
}
</script>

<style>

</style>