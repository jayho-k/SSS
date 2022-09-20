<template>
  <div class="uploadVideoMain">
    <VideoFiles></VideoFiles>
    <Controller></Controller>
  </div>
</template>

<script>
import VideoFiles from '@/components/system/uploadVideo/VideoFiles.vue'
import Controller from '@/components/system/control/ControllerBox'
export default {
    components: { VideoFiles, Controller }

}
</script>

<style>
.uploadVideoMain {
  display: flex;
  background-color: var(--main-color1);
  padding: 20px 28px;
}
</style>