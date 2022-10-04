<template>
    <div v-if="uploadStore.is_analysis_video">
			<select id="select" @change="select_case" name="job">
				<option value="">직업선택</option>
				<option value="fire">화재감지</option>
				<option value="mia">미아탐색</option>
				<option value="safety">야생동물보호</option>
			</select>
			<div @click="start_detecting">이거누르면 알지?</div>
			<div @click="toggle_form">취소</div>
    </div>
</template>

<script>
import { useUploadVideoStore } from '@/stores/uploadVideo'
export default {
	setup() {
		const uploadStore = useUploadVideoStore()
		function select_case (event) {
			uploadStore.analysis_case = event.target.value
		}
		function start_detecting () {
			uploadStore.uploadVideo()
		}
		function toggle_form() {
			uploadStore.is_analysis_video = !uploadStore.is_analysis_video
		}
		
		return {
				uploadStore,
				select_case,
				start_detecting,
				toggle_form,
		}


	}

}
</script>

<style>

</style>