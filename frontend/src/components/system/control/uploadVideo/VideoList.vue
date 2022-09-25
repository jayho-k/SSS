<template>
  <div class="VideoListBox">
      <VideoMenu></VideoMenu>
    <div class="VideoItem">
    <VideoItem v-for="(D_item, D_i) in DataSet"
    :key="D_i"
    :D_item = D_item
    @click="selectVideo(D_item)"></VideoItem>
    </div>
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

.VideoListBox {
  position: relative;
  width: var(--controller-width);
  height: 400px;
  background-color: var(--main-color2);
  padding: 4px;

}


/* 영역 설정*/
.VideoItem{
  padding: 0px 4px;
  width:244px;
  height:365px;
	overflow-y: scroll;
  overflow-x: hidden;
}


/* 스크롤바 설정*/
.VideoItem::-webkit-scrollbar{
	/*  스크롤바 막대 너비 설정 */
    width: 4px;
    z-index: -10;
}

/* 스크롤바 막대 설정*/
.VideoItem::-webkit-scrollbar-thumb{
    /* 스크롤바 막대 높이 설정    */
    height: 17%;
    background-color: rgba(255,255,255,1);
    /* 스크롤바 둥글게 설정    */
    border-radius: 10px;    
}

/* 스크롤바 뒷 배경 설정*/
.VideoItem::-webkit-scrollbar-track{
    background-color: rgba(0,0,0,0.5);
}

</style>