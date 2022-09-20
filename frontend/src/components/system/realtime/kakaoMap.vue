<template>
	<div id="map" style="width:1512px;height:1040px;"></div>
</template>

<script>
import { onMounted } from 'vue';
export default {
	setup() {
		onMounted(() => {
			if (window.kakao && window.kakao.maps) {
				initMap();
			} else {
				const script = document.createElement("script");
				/* global kakao */
				script.onload = () => kakao.maps.load(initMap);
				script.src =
						"//dapi.kakao.com/v2/maps/sdk.js?autoload=false&appkey=44e203a985e2bc845fbbde8390a4fc5b&libraries=services,clusterer,drawing";
				document.head.appendChild(script);
			}
		})
		const initMap = () => {
			const container = document.getElementById("map");
			const options = {
				center: new kakao.maps.LatLng(33.450701, 126.570667),
				level: 5,
                // drawing manager로 제공할 그리기 요소 모드입니다
                // drawingMode: [ 
                // kakao.maps.drawing.OverlayType.MARKER,
                // kakao.maps.drawing.OverlayType.POLYGON
                // ],
                
                // // 사용자에게 제공할 그리기 가이드 툴팁입니다
                // // 사용자에게 도형을 그릴때, 드래그할때, 수정할때 가이드 툴팁을 표시하도록 설정합니다
                // guideTooltip: ['draw', 'drag', 'edit'], 
                // markerOptions: { // 마커 옵션입니다 
                //     draggable: true, // 마커를 그리고 나서 드래그 가능하게 합니다 
                //     removable: true // 마커를 삭제 할 수 있도록 x 버튼이 표시됩니다  
                // },
                // polygonOptions: {
                //     draggable: true,
                //     removable: true,
                //     editable: true,
                //     strokeColor: '#39f',
                //     fillColor: '#39f',
                //     fillOpacity: 0.5,
                //     hintStrokeStyle: 'dash',
                //     hintStrokeOpacity: 0.5
                // }
			};
		

			//지도 객체를 등록합니다.
			//지도 객체는 반응형 관리 대상이 아니므로 initMap에서 선언합니다.
			initMap.map = new kakao.maps.Map(container, options);
		}		
		return {
			initMap
		}
	}
}
</script>

<style>

</style>