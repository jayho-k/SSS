<template>
    <div id="map" style="width:500px;height:400px;"></div>
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
                    "//dapi.kakao.com/v2/maps/sdk.js?autoload=false&appkey=44e203a985e2bc845fbbde8390a4fc5b";
                document.head.appendChild(script);
            }
        })
        const initMap = () => {
            const container = document.getElementById("map");
            const options = {
                center: new kakao.maps.LatLng(33.450701, 126.570667),
                level: 5,
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