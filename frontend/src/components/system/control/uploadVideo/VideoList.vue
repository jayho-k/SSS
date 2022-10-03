<template>
  <div class="VideoListBox">
      <VideoMenu></VideoMenu>
    <div class="VideoItem">
    <VideoItem v-for="(D_item, D_i) in DataSet"
    :key="D_i"
    :D_item = D_item
    @click="deleteVideo(D_i)"
    class="VideoItemBox"><span class="material-symbols-outlined">
image_search
</span><div @click="selectVideo(D_item)">{{D_item.name}}</div></VideoItem>
    </div>
  </div>
</template>

<script>
import { useUploadVideoStore } from '@/stores/uploadVideo';
import VideoMenu from '@/components/system/control/uploadVideo/VideoMenu'
export default {
  components: {
    VideoMenu,
  },
  setup () {
    const uploadStore = useUploadVideoStore()
    const DataSet = uploadStore.video_list

    function selectVideo(video) {
      uploadStore.selectVideo(video)

    }
    function deleteVideo(idx) {
      if (uploadStore.video_list_mode === false) {
      uploadStore.video_list.splice(idx,1)
      }
    }
    return {
      DataSet,
      selectVideo,
      deleteVideo
    }
  }
  

}
</script>

<style scoped>

.VideoListBox {
  position: relative;
  width: var(--controller-width);
  height: calc((100vh - 220px)/2);
  min-height: 220px;
  background-color: var(--main-color2);
  padding: 4px;
  

}
.VideoItemBox {
  position: relative;
  display: flex;
  justify-content: space-between;
  align-items: center;
  background-color: hsl(0,0%,95%);
  width: 244px;
  height: 40px;
  margin-bottom: 1px;

  background: rgb(245,246,246); 
background: -moz-linear-gradient(top, rgba(245,246,246,1) 0%, rgba(219,220,226,1) 10%, rgba(219,220,226,1) 85%, rgba(184,186,198,1) 96%, rgba(221,223,227,1) 99%, rgba(245,246,246,1) 100%); 
background: -webkit-linear-gradient(top, rgba(245,246,246,1) 0%,rgba(219,220,226,1) 10%,rgba(219,220,226,1) 85%,rgba(184,186,198,1) 96%,rgba(221,223,227,1) 99%,rgba(245,246,246,1) 100%); 
background: linear-gradient(to bottom, rgba(245,246,246,1) 0%,rgba(219,220,226,1) 10%,rgba(219,220,226,1) 85%,rgba(184,186,198,1) 96%,rgba(221,223,227,1) 99%,rgba(245,246,246,1) 100%); 

filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#f5f6f6', endColorstr='#f5f6f6',GradientType=0 ); 
}

/* 영역 설정*/
.VideoItem{
  padding: 0px 4px;
  width:244px;
  height:calc(100% - 35px);
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