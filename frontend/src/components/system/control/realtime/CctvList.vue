<template>
	<div class="CctvListBox">
    
    <CctvMenu></CctvMenu>
    <div class="CctvItem">
    <CctvItem></CctvItem>
		<CctvItem v-for="(D_item, D_i) in DataSet"
    :key="D_i"
    :D_item = D_item
    @click="mapCenter(D_i)"></CctvItem>
    
    </div>
	</div>
</template>

<script>
import { useKakaoStore } from '@/stores/kakaoMap';
import CctvMenu from '@/components/system/control/realtime/CctvMenu'
import CctvItem from '@/components/system/control/realtime/CctvItem'
export default {
    components: {
        CctvMenu,
        CctvItem
    },
    setup () {
      const kakaostore = useKakaoStore()
      const DataSet = kakaostore.saved_markers_info
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