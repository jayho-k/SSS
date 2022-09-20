<template>
    <div class="VideoFilesView">
        <video controls=1 class="videoMainBox" id="video">
        <source src="@/assets/movie.mp4" type="video/mp4" >
            해당 브라우저는 video 태그를 지원하지 않습니다.
        </video>
        <input type="file" id="contract_file" multiple @change="showTextFile"  accept=".mp4, .mkv">
        <button type="button" @click="showTextFile">asdfsdf</button>
    </div>
    
</template>

<script>
import { ref } from 'vue'
export default {
    components: { },
    setup() {
        function showTextFile(e) {
            const input = ref(e.target.files)
            console.log(input)
            
            const video = document.getElementById("video");

            // const selectedFiles = input.files
            const videourl = URL.createObjectURL(input.value[0])
            video.setAttribute("src", videourl);
            video.play();
            console.log(videourl)
            // console.log(selectedFiles)}
        }
        return {
            showTextFile
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
    width: 300px;
    height: 300px;
}
</style>