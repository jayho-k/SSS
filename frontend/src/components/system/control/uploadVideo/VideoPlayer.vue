<template>
    <div class="VideoFilesView">
        <video controls=1 class="videoMainBox" id="video">
        <source :src="show_video" type="video/mp4" >
            해당 브라우저는 video 태그를 지원하지 않습니다.
        </video>
    </div>
    
</template>

<script>
import { useUploadVideoStore } from '@/stores/uploadVideo';
export default {
    components: { },
    setup() {
        const uploadStore = useUploadVideoStore()
        const show_video = uploadStore.show_video
        return {
            show_video
        }
    }
}
</script>

<style>
.videoMainBox {
    width: 300px;
    height: 300px;
}
</style>