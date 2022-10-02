<template>
	<div class="watchBox ">
		<div class="watchTop" id="top"></div>
		<div class="watchBottom" id="bottom"><div id="hours"></div><div style="font-size:20px; line-height:100px">:</div>  <div  id="minutes"> </div> : <div id="seconds"></div></div>
		
	</div>
</template>

<script>
export default {
	setup() {
		function getTime() {
			// var time_now = new Date()
		
			// const timeData = {
			// 	year: time_now.getFullYear(),
			// 	month: time_now.getMonth() + 1,
			// 	date: time_now.getDate(),
			// 	day: time_now.getDay(),
			// 	hours: String(time_now.getHours()).padStart(2, "0"),
			// 	minutes: String(time_now.getMinutes()).padStart(2, "0"),
			// 	seconds: String(time_now.getSeconds()).padStart(2, "0"),
			// 	week: ["Sun", "Mon", "Tue", "Wed", "Thr", "Fri", "Sat"]
			// }
			
			// var top = timeData.week[timeData.day] +" " + String(timeData.year) +'.'+  String(timeData.month).padStart(2, "0") + '.'+  String(timeData.date).padStart(2, "0")
			
			// document.getElementById("top").innerText = top
			// document.getElementById("hours").innerText = timeData.hours
			// document.getElementById("minutes").innerText = timeData.minutes
			// document.getElementById("seconds").innerText = timeData.seconds
		}

		// getTime()

		setInterval(getTime, 1000);

		return {

		}
	}

}
</script>

<style>
.watchBox {
	width: 260px;
	height: 60px;
	border-radius: 5px;
	font-family: 'crystal';
	color: white;
	font-size: 50px;
}
.watchTop {
	height: 20px;
	font-size: 20px;
}
.watchBottom{
	display: flex;
	height: 40px;
	font-size: 40px;
	justify-self: center;
	align-items: center;
}
@font-face {
  font-family: 'crystal';
  src: url("@/assets/LiquidCrystal-ExBold.otf") format('opentype');

}

</style>