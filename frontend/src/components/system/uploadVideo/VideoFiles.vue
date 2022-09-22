<template>
    <div class="VideoFilesView">
        <video controls=1 class="videoMainBox" id="video">
        <source src="" type="video/mp4" >
            해당 브라우저는 video 태그를 지원하지 않습니다.
        </video>

        <img src="https://j7b302.p.ssafy.io/api/cctvs/streaming/" style="width: 400px; height:400px;" alt="">
    </div>
    
</template>

<script>
export default {
    components: { },
    setup() {
        // const uploadStore = useUploadVideoStore()

        return {
            // showTextFile
        }
    }
}
</script>

<style>
.VideoFilesView {
    width:1512px;
    height:1040px;
    background-color: var(--main-color2);
}
.videoMainBox {
  width:800px;
  height:800px;

}


</style>