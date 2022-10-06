<template>
	<div style="">
		<div v-for="(C_item, C_i) in cctv_list"
			:key="C_i">
			<img :src="`${URL}/api/cctvs/${user_id}/${cctv_id}/streaming/${type}/`" alt="">
		</div>
	</div>
</template>

<script>
import { useAccounts } from '@/stores/accounts'
import { useKakaoStore } from '@/stores/kakaoMap'
export default {
	setup() {
		const URL = process.env.VUE_APP_VIDEO_API2
		const userStore = useAccounts()
		const kakaoStore = useKakaoStore ()
		console.log(userStore)
		
		function get_alarmList () {
			kakaoStore.getAlarmList()
		}

		setInterval(get_alarmList(), 3000)
		return {
		URL,
		userStore,
		kakaoStore,
		get_alarmList,
	}
	}
}
</script>

<style>

</style>