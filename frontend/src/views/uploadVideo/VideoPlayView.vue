<template>
  <div class="uploadVideoMain">
    <VideoPlayer></VideoPlayer>
    <UploadController></UploadController>
  </div>
</template>

<script>
import VideoPlayer from '@/components/system/uploadVideo/VideoPlayer.vue'
import UploadController from '@/components/system/control/uploadVideo/UploadController'
export default {
    components: { VideoPlayer, UploadController }

}
</script>

<style>
.uploadVideoMain {
  display: flex;
  background-color: var(--main-color1);
  padding: 20px 20px;
}

</style>