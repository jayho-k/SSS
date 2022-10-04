<template>
	<div class="VideoFilesView">
		<video v-if="idx" controls=1 class="videoMainBox" id="video">
		
		<source :src="uploadStore.show_video" type="video/mp4">
				해당 브라우저는 video 태그를 지원하지 않습니다.
		</video>
		<button type="button" @click="idxtoggle()">토글버튼</button>
	</div>
    
</template>

<script>
import { useUploadVideoStore } from '@/stores/uploadVideo';
import {ref} from 'vue'
export default {
	components: { },
	setup() {
		const uploadStore = useUploadVideoStore()
		var idx = ref(false)
		const URL = process.env.VUE_APP_VIDEO_API
		function idxtoggle () {
			if (idx.value === true) {
					idx.value = false
			} else {
					idx.value = true
			}
		}
		return {
			uploadStore,
			idx,
			URL,
			idxtoggle,
		}
	}
}
</script>

<style>
.VideoFilesView {
	width: 1620px;
	height: calc(100vh - 40px);
	background-color: var(--main-color2);
}
.videoMainBox {
  width:100%;
  height:100%;

}


</style>