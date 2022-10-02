<template>
	<div class="VideoFilesView">
		<!-- <video v-if="idx" controls=1 class="videoMainBox" id="video">
		
		<source :src="uploadStore.show_video" type="video/mp4">
				해당 브라우저는 video 태그를 지원하지 않습니다.
		</video>
		<button type="button" @click="idxtoggle()"></button>

		<select id="select" @change="select_case" name="job">
			<option value="">직업선택</option>
			<option value="fire">화재감지</option>
			<option value="mia">미아탐색</option>
			<option value="safety">야생동물보호</option>
		</select>
		<button type="button" @click="uploadStore.uploadVideo">이거 누르면 분석</button> -->
		<img :src="`${URL}/api/cctvs/streaming/`" width="400" height="300"/>
		
		<!-- <video controls=1 class="videoMainBox" id="video">
		<source :src="`${URL}media/track/exp/eca944b5a9fe46b281315cfd2e833bfa.mp4`" type="video/mp4" muted >
		
		<source src="https://j7b302.p.ssafy.io/media/track/exp/eca944b5a9fe46b281315cfd2e833bfa.mp4" type="video/mp4">
				해당 브라우저는 video 태그를 지원하지 않습니다.
		</video> -->
	</div>
    
</template>

<script>
import { useUploadVideoStore } from '@/stores/uploadVideo';
import {ref} from 'vue'
export default {
    components: { },
    setup() {
        const uploadStore = useUploadVideoStore()
        var idx = ref(false)
        const URL = process.env.VUE_APP_VIDEO_API2
        function idxtoggle () {
            if (idx.value === true) {
                idx.value = false
            } else {
                idx.value = true
            }
        }
				function select_case (event) {
					console.log(event)
					uploadStore.analysis_case = event.target.value

				}
        return {
            uploadStore,
            idx,
            URL,
						select_case,
            idxtoggle,
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