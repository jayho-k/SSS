<template>
	<div class="watchBox ">
		
		<div class="watchTop" id="top">
			<div id="day"></div>
			&nbsp;
			&nbsp;
			<div id="top-in"></div>
			&nbsp;
		</div>
		
		<div class="watchBottom" id="bottom">
			<div id="am_pm"></div>
			&nbsp;

			<div id="hours"></div>
			<div class="watch_d">|</div>
			<div  id="minutes"></div>
			<div class="watch_d">|</div>
			<div id="seconds"></div>
		</div>
	</div>
</template>

<script>
import { onMounted } from 'vue'

export default {
	setup() {
		function getTime() {
			var time_now = new Date()
		
			const timeData = {
				year: time_now.getFullYear(),
				month: time_now.getMonth() + 1,
				date: time_now.getDate(),
				day: time_now.getDay(),
				hours: String(time_now.getHours()).padStart(2, "0"),
				minutes: String(time_now.getMinutes()).padStart(2, "0"),
				seconds: String(time_now.getSeconds()).padStart(2, "0"),
				week: ["Sun", "Mon", "Tue", "Wed", "Thr", "Fri", "Sat"]
			}
			var am_pm =''
			var top = String(timeData.year) +'.'+  String(timeData.month).padStart(2, "0") + '.'+  String(timeData.date).padStart(2, "0")
			document.getElementById("top-in").innerText = top
			if (time_now.getHours() < 12) {
				am_pm = 'AM'
			} else {
				am_pm = 'PM'
			}
			document.getElementById("day").innerText = timeData.week[timeData.day]
			document.getElementById("am_pm").innerText = am_pm
			document.getElementById("hours").innerText = timeData.hours
			document.getElementById("minutes").innerText = timeData.minutes
			document.getElementById("seconds").innerText = timeData.seconds
		}
		onMounted(() => {
			getTime()
			
		}),
		

		setInterval(getTime, 1000);

		return {

		}
	}

}
</script>

<style scoped>
.watchBox {
	
	width: 260px;
	height: 80px;
	border-radius: 5px;
	font-family: 'crystal';
	color: white;
	font-size: 50px;
}
.watchTop {
	display: flex;
	justify-content: space-around;
	padding: 4px 0px 4px 0px;
	height: 24px;
	font-size: 28px;
}
.watchBottom{
	display: flex;
	height: 40px;
	font-size: 40px;
	justify-content: space-around;
	align-items: center;
}
.watch_d {
	font-size:28px;
	color:rgb(247, 216, 216);
}
@font-face {
  font-family: 'crystal';
  src: url("@/assets/LiquidCrystal-ExBold.otf") format('opentype');

}

</style>