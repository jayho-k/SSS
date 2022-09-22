<template>
    <div class="VideoFilesView">
        <video controls=1 class="videoMainBox" id="video">
        <source src="@/assets/movie.mp4" type="video/mp4" >
            해당 브라우저는 video 태그를 지원하지 않습니다.
        </video>
        <button type="button" @click="showTextFile">asdfsdf</button>
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