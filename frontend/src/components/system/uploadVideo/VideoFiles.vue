<template>
    <div class="VideoFilesView">
        <!-- <video controls=1 class="videoMainBox" id="video">
        <source :src="`${URL}media/track/exp/eca944b5a9fe46b281315cfd2e833bfa.mp4`" type="video/mp4" muted >
        
        <source src="https://j7b302.p.ssafy.io/media/track/exp/eca944b5a9fe46b281315cfd2e833bfa.mp4" type="video/mp4">
            해당 브라우저는 video 태그를 지원하지 않습니다.
        </video>
        <img :src="`${URL}media/image/20220929/446d7e3a7d9943a797e4efd018b3588b.png`" style="width:300px; height:300px;" alt="">
        <a :href="`${URL}media/track/exp/eca944b5a9fe46b281315cfd2e833bfa.mp4`">asdfasdf</a> -->
    </div>
    
</template>

<script>
// import { useUploadVideoStore } from '@/stores/uploadVideo';
export default {
    components: { },
    setup() {
        // const uploadStore = useUploadVideoStore()
        const URL = process.env.VUE_APP_VIDEO_API
        return {
            URL
            // showTextFile
        }
    }
}
</script>

<style>
.VideoFilesView {
    width:1620px;
    height:1040px;

    background-color: var(--main-color2);
}
.videoMainBox {
  width:800px;
  height:800px;

}


</style>