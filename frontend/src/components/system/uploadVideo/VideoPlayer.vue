<template>
  <div class="VideoPlayerBox">
    <video v-if="uploadStore.is_result_view" controls=1 class="videoMainBox" id="video">
    <source :src="URL + uploadStore.analysis_url_list[uploadStore.analysis_video_idx]['video_file']" type="video/mp4" >
        해당 브라우저는 video 태그를 지원하지 않습니다.
    </video>
    <a :src="show_video">asdfdsf</a>
    <div @click="sw">토글버튼 2</div>
  </div>
    
</template>

<script>
import { useUploadVideoStore } from '@/stores/uploadVideo';
export default {
  components: { },
  setup() {
    const uploadStore = useUploadVideoStore()
    const URL = process.env.VUE_APP_VIDEO_API
    function sw () {
      console.log(URL + uploadStore.analysis_url_list[uploadStore.analysis_video_idx]['video_file'])
      uploadStore.is_result_view = !uploadStore.is_result_view
    }
    return {
      uploadStore,
      sw,
      URL,
      
    }
  }
}
</script>

<style>
.VideoPlayerBox {
width: calc(100vw - 280px);
height: calc(100vh - 40px);
}
.videoMainBox {
  width: calc(100vw - 280px);
height: calc(100vh - 40px);

}
</style>