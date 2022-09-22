<template>
  <div class="ObjectListBox">
      <div class=""></div>
      <VideoMenu></VideoMenu>
    <VideoItem v-for="(D_item, D_i) in DataSet"
    :key="D_i"
    :D_item = D_item
    @click="selectVideo(D_item)"></VideoItem>
  </div>
</template>

<script>
import { useUploadVideoStore } from '@/stores/uploadVideo';
import VideoMenu from '@/components/system/control/uploadVideo/VideoMenu'
import VideoItem from '@/components/system/control/uploadVideo/VideoItem'
export default {
  components: {
    VideoMenu,
    VideoItem
  },
  setup () {
    const uploadStore = useUploadVideoStore()
    const DataSet = uploadStore.video_list

    function selectVideo(video) {
      uploadStore.selectVideo(video)

    }
    return {
      DataSet,
      selectVideo
    }
  }
  

}
</script>

<style>
.ObjectListBox {
    width: var(--controller-width);
    height: 480px;
    background-color: var(--main-color2);
}

</style>