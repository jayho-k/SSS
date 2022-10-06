<template>
	<div>
    <select class="real_select" id="select" @change="streaming_case" name="job">
			<option value="normal">default</option>
			<option value="fire"><span class="material-symbols-outlined">fire</span></option>
			<option value="mia"><span class="material-symbols-outlined">mia</span></option>
			<option value="safety"><span class="material-symbols-outlined">safety</span></option>
		</select>

		<img class="real_img" :src="`${serverURL}/api/cctvs/${userStore.streaming_id}/${kakaoStore.streaming_cctv}/streaming/${kakaoStore.streaming_case}/`" 	@error="replaceDefault">

	</div>
</template>

<script>
import { useAccounts } from '@/stores/accounts'
import { useKakaoStore } from '@/stores/kakaoMap'
import defaultImg from  '@/assets/loading.gif'
export default {
	setup() {
		const serverURL = process.env.VUE_APP_VIDEO_API
		const userStore = useAccounts()
		const kakaoStore = useKakaoStore ()
		userStore.streaming_id = localStorage.getItem('streamingId')
		

		function get_alarmList () {
			kakaoStore.getAlarmList()
		}
		function streaming_case (event) {
			
			kakaoStore.streaming_case =  event.target.value
			kakaoStore.is_kakao_view = null
			setTimeout(()=> {kakaoStore.is_kakao_view === false}, 1)
		}
		function replaceDefault(e) {
      e.target.src = defaultImg
    }

		setInterval(get_alarmList(), 3000)
		return {
			serverURL,
			userStore,
			kakaoStore,
			get_alarmList,
			streaming_case,
			replaceDefault,
		}
	}
}
</script>

<style>

.real_select {
	position: absolute;
	right: 360px;
	top:40px;
	width: 80px;
	height: 40px;
}

.real_img {
	width: calc(100% - 4px);
	height: calc(100% - 4px);
	border: 2px solid red;
	border-style: inset;
}
</style>