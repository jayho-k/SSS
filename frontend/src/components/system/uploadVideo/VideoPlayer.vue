<template>
  <div v-if="!uploadStore.is_local_view" class="VideoPlayerBox">
    <video  controls=1 class="videoMainBox" id="video">
    <source :src="URL + uploadStore.analysis_video" type="video/mp4" >
        해당 브라우저는 video 태그를 지원하지 않습니다.
    </video>
  </div>
    
</template>

<script>
import { useUploadVideoStore } from '@/stores/uploadVideo';
export default {
  components: { },
  setup() {
    const uploadStore = useUploadVideoStore()
    const URL = process.env.VUE_APP_VIDEO_API
    return {
      uploadStore,
      URL,
      
    }
  }
}
</script>

<style>
.VideoPlayerBox {
width: 100%;
height: 100%;
}
.videoMainBox {
  width: 100%;
  height: 100%;
}
</style>