<template>
	<div class="CctvListBox">
    <CctvMenu></CctvMenu>
    <div class="CctvItem">
		<div v-for="(D_item, D_i) in DataSet"
    :key="D_i"
    :D_item = D_item
    @click="mapCenter(D_i)">
      <div class="CctvItemBox">{{D_item[0]}}</div>
    </div>
    </div>
	</div>
</template>

<script>
import { useKakaoStore } from '@/stores/kakaoMap';
import { ref, computed } from 'vue'
import CctvMenu from '@/components/system/control/realtime/CctvMenu'
export default {
    components: {
        CctvMenu,
    },
    setup () {
      const kakaostore = useKakaoStore()
      const DataSet = ref(computed(() => kakaostore.saved_markers_info))
      function mapCenter (D_i) {
        kakaostore.setMapCenter(D_i)
      }
      return {
        DataSet,
        mapCenter
      }
    }
}
</script>

<style>
.CctvListBox {
  position: relative;
  width: var(--controller-width);
  height: 400px;
  background-color: var(--main-color2);
  padding: 4px;

}


/* 영역 설정*/
.CctvItem{
  padding: 0px 4px;
  width:244px;
  height:365px;
	overflow-y: scroll;
  overflow-x: hidden;
}

.CctvItemBox {
  position: relative;
  display: flex;
  justify-content: center;
  align-items: center;
  background-color: hsl(0,0%,95%);
  width: 244px;
  height: 40px;
  margin-bottom: 1px;
}

/* 스크롤바 설정*/
.CctvItem::-webkit-scrollbar{
	/*  스크롤바 막대 너비 설정 */
    width: 4px;
    z-index: -10;
}

/* 스크롤바 막대 설정*/
.CctvItem::-webkit-scrollbar-thumb{
    /* 스크롤바 막대 높이 설정    */
    height: 17%;
    background-color: rgba(255,255,255,1);
    /* 스크롤바 둥글게 설정    */
    border-radius: 10px;    
}

/* 스크롤바 뒷 배경 설정*/
.CctvItem::-webkit-scrollbar-track{
    background-color: rgba(0,0,0,0.5);
}

</style>