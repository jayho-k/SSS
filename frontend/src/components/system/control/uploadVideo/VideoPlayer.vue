<template>
    <div class="VideoFilesView">
        <video controls=1 class="videoMainBox" id="video">
        <source :src="`${process.env.VUE_APP_VIDEO_API}media/track/exp/e492c3864351431e9f1555fb346b41d7.mp4`" type="video/mp4" >
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

<style scoped>
.videoMainBox {
    width: 300px;
    height: 300px;
}
</style>