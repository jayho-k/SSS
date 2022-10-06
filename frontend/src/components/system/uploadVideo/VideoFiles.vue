<template>
	<div class="VideoFilesView">
		<video v-if="uploadStore.is_local_view" controls=1 class="videoMainBox" id="video">
		
		<source :src="uploadStore.show_video" type="video/mp4">
				해당 브라우저는 video 태그를 지원하지 않습니다.
		</video>
		<VideoPlayer></VideoPlayer>
	</div>
</template>

<script>
import { useUploadVideoStore } from '@/stores/uploadVideo';
import VideoPlayer from '@/components/system/uploadVideo/VideoPlayer.vue'
export default {
	components: { VideoPlayer },
	setup() {
		const uploadStore = useUploadVideoStore()
		const URL = process.env.VUE_APP_VIDEO_API
		uploadStore.is_local_view = true
		return {
			uploadStore,
			URL,
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