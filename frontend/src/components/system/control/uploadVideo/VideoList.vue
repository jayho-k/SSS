<template>
  <div class="VideoListBox metalList">
      <VideoMenu></VideoMenu>
      <VideoForm></VideoForm>
    <div class="VideoItem" v-if="!uploadStore.is_analysis_video">
    <div v-for="(D_item, D_i) in DataSet"
    :key="D_i"
    :D_item = D_item
    @click="deleteVideo(D_i)"
    class="VideoItemBox">
    <div style="width: 28px;">
    <img v-if="D_i === uploadStore.loding_idx" :src="lodingImg" alt="">
    <span  @click="show_analysis(D_i, D_item)" v-if="uploadStore.loding_idx === false" class="material-symbols-outlined" style="display:flex;"><div style="width:10px;"></div>image_search</span>
  </div>
  <div class="videoSort">
  <div @click="show_local(D_i, D_item)" style="display:flex;"><div style="width:10px;"></div>{{D_item.name.slice(-9)}}</div>
  <div style="display:flex;">
  <div style="width: 28px;"><span v-if="uploadStore.analysis_url_list[D_i]['fire']" @click="loading_video(D_i, 'fire')" class="material-symbols-outlined hoverR">local_fire_department</span></div>
    
  <div style="width: 28px;"><span v-if="uploadStore.analysis_url_list[D_i]['mia']" @click="loading_video(D_i, 'mia')" class="material-symbols-outlined hoverY">face</span></div>
  <div style="width: 28px;"><span v-if="uploadStore.analysis_url_list[D_i]['safety']" @click="loading_video(D_i, 'safety')" class="material-symbols-outlined hoverR">sports_kabaddi</span></div>
    </div>
  </div>
  </div>
    </div>
  </div>
</template>

<script>
import { useUploadVideoStore } from '@/stores/uploadVideo'
import VideoMenu from '@/components/system/control/uploadVideo/VideoMenu'
import VideoForm from '@/components/system/control/uploadVideo/VideoAnalysisForm.vue'
import lodingImg from '@/assets/upload_loading.gif'
export default {
  components: {
    VideoMenu,
    VideoForm
  },
  setup () {
    const uploadStore = useUploadVideoStore()
    const DataSet = uploadStore.video_list
    function deleteVideo(idx) {
      if (uploadStore.video_list_mode === false) {
      uploadStore.video_list.splice(idx,1)
      uploadStore.analysis_url_list.splice(idx,1)
      }
    }
    function show_analysis (idx, video) {
      uploadStore.analysis_video_idx = idx
      uploadStore.selectVideo(video)
      uploadStore.is_analysis_video = !uploadStore.is_analysis_video
    }
    function show_local (idx, video) {
      uploadStore.is_local_view = false
      uploadStore.analysis_video_idx = idx
      uploadStore.selectVideo(video)
      uploadStore.is_local_view
      setTimeout(()=>{ uploadStore.is_local_view = true}, 1)
    }
    
    function loading_video (id, video_case) {
      uploadStore.analysis_video =  uploadStore.analysis_url_list[id][video_case]
      uploadStore.is_local_view = false
    }
    return {
      uploadStore,
      DataSet,
      deleteVideo,
      show_analysis,
      show_local,
      loading_video,
      lodingImg
  
    }
  }
}
</script>

<style scoped>

.VideoListBox {
  position: relative;
  width: var(--controller-width);
  height: calc((100vh - 720px) / 360 * 260 + 180px);
  min-height: 180px;
  background-color: var(--main-color2);
  padding: 4px;
  

}
.VideoItemBox {
  position: relative;
  display: flex;
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

.VideoItemBox:hover {
  background: rgb(255,255,255); /* Old browsers */
  background: -moz-linear-gradient(top, rgba(255,255,255,1) 0%, rgba(241,241,241,1) 6%, rgba(241,241,241,1) 6%, rgba(225,225,225,1) 7%, rgba(246,246,246,1) 96%, rgba(241,241,241,1) 98%); /* FF3.6-15 */
  background: -webkit-linear-gradient(top, rgba(255,255,255,1) 0%,rgba(241,241,241,1) 6%,rgba(241,241,241,1) 6%,rgba(225,225,225,1) 7%,rgba(246,246,246,1) 96%,rgba(241,241,241,1) 98%); /* Chrome10-25,Safari5.1-6 */
  background: linear-gradient(to bottom, rgba(255,255,255,1) 0%,rgba(241,241,241,1) 6%,rgba(241,241,241,1) 6%,rgba(225,225,225,1) 7%,rgba(246,246,246,1) 96%,rgba(241,241,241,1) 98%); /* W3C, IE10+, FF16+, Chrome26+, Opera12+, Safari7+ */
  filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#ffffff', endColorstr='#f1f1f1',GradientType=0 ); /* IE6-9 */
}

/* 영역 설정*/
.VideoItem{
  padding: 0px 4px;
  width:244px;
  height:calc(100% - 34px);
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
    background-color: rgba(0,0,0,0.5);
    /* 스크롤바 둥글게 설정    */
    border-radius: 10px;    
}

/* 스크롤바 뒷 배경 설정*/
.VideoItem::-webkit-scrollbar-track{
    background-color: rgba(255,255,255,1);
}
.metalList {
    text-align: center;
    color: hsla(0,0%,20%,1);
    text-shadow: hsl(0deg 0% 40% / 50%) 0 -1px 0, hsl(0deg 0% 100% / 60%) 0 1px 1px;
    background-color: hsl(0,0%,90%);
    box-shadow: inset hsla(0,0%,15%, 1) 0 0px 0px 4px, /* border */ inset hsla(0,0%,15%, .8) 0 -1px 5px 4px, /* soft SD */ inset hsla(0,0%,0%, .25) 0 -1px 0px 7px, /* bottom SD */ inset hsla(0,0%,100%,.7) 0 2px 1px 7px, /* top HL */ hsla(0,0%, 0%,.15) 0 -5px 6px 4px, /* outer SD */ hsla(0,0%,100%,.5) 0 1px 4px 3px;
    transition: color .2s;
}
.hoverR:hover {
  color: var(--sweet-red);
}
.hoverY:hover {

  color: var(--sweet-orange);
}
.hoverB:hover {
  color: var(--sweet-blue);
}

.metalList {
  text-align: center;
  color: hsla(0,0%,20%,1);
  text-shadow: hsla(0,0%,40%,.5) 0 -1px 0, hsla(0,0%,100%,.6) 0 1px 1px;
  
  background-color: hsl(0,0%,90%);
  box-shadow: inset rgb(0, 0, 0) 0  0px 0px 4px, /* border */
    inset rgba(0, 0, 0, 0.8) 0 -1px 5px 4px, /* soft SD */
    inset hsla(0,0%,0%, .25) 0 -1px 0px 7px, /* bottom SD */
    inset hsla(0,0%,100%,.7) 0  2px 1px 7px, /* top HL */
    
    hsla(0,0%, 0%,.15) 0 -5px 6px 4px, /* outer SD */
    hsla(0,0%,100%,.5) 0  1px 4px 3px; /* outer HL */ 
}
.videoSort {
  width: 100%;
  display: flex;
  justify-content: space-between;
}
</style>