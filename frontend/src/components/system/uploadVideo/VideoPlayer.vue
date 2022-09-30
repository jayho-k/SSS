<template>
  <div class="VideoPlayerBox">
    <video controls=1 class="videoMainBox" id="video">
    <source :src="show_video" type="video/mp4" >
        해당 브라우저는 video 태그를 지원하지 않습니다.
    </video>
    <a :src="show_video">asdfdsf</a>
  </div>
    
</template>

<script>
import { useUploadVideoStore } from '@/stores/uploadVideo';
export default {
  components: { },
  setup() {
    const uploadStore = useUploadVideoStore()
    const show_video = uploadStore.show_video
    return {
      show_video
    }
  }
}
</script>

<style>
.VideoPlayerBox {
  width:800px;
  height:1040px;
}
.videoMainBox {
  width:800px;
  height:800px;

}
</style>