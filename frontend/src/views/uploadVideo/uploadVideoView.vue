<template>
  <div class="uploadVideoMain">
    <VideoFiles></VideoFiles>

    <UploadController></UploadController>
  </div>
</template>

<script>
import VideoFiles from '@/components/system/uploadVideo/VideoFiles.vue'
import UploadController from '@/components/system/control/uploadVideo/UploadController'
export default {
    components: { VideoFiles, UploadController }

}
</script>

<style>
.uploadVideoMain {
  display: flex;
  background-color: var(--main-color1);
  padding: 20px 20px;
}
</style>