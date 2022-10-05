<template>
	<div class="CctvListBox">
    <CctvMenu></CctvMenu>
    <div class="CctvItem">
      <div v-for="(D_item, D_i) in DataSet"
      :key="D_i"
      :D_item = D_item
      @click="mapCenter(D_i)"
      class="CctvItemBox">&nbsp;&nbsp;
      {{D_item['name']}} 
      <span class="material-symbols-outlined" @click="unlock($event, D_i)">lock</span>
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
      const kakaoStore = useKakaoStore()
      const DataSet = ref(computed(() => kakaoStore.saved_markers_info))
      function mapCenter (D_i) {

        kakaoStore.setMapCenter(D_i)
      }
      function unlock (e, m_i) {
        e.target.classList.toggle('toggle_color')
        if (kakaoStore.saved_markers[m_i].getDraggable() === true) {
          e.target.innerText = 'lock'
          kakaoStore.saved_markers[m_i].setDraggable(false)
        } else {
          e.target.innerText = 'lock_open'
          kakaoStore.saved_markers[m_i].setDraggable(true)
        }
      }

      return {
        kakaoStore,
        DataSet,
        mapCenter,
        unlock,
      }
    }
}
</script>

<style scoped>
.CctvListBox {
  position: relative;
  width: var(--controller-width);
  height: calc((100vh - 720px) / 360 * 260 + 180px);
  background-color: var(--main-color2);
  padding: 4px;
  

}
.toggle_color {
  color: var(--sweet-red);

}

/* 영역 설정*/
.CctvItem{
  padding: 0px 4px;
  width:244px;
  height:calc(100% - 35px);
	overflow-y: scroll;
  overflow-x: hidden;
}

.CctvItemBox {
  position: relative;
  display: flex;
  justify-content: space-between;
  align-items: center;
  background-color: hsl(0,0%,95%);
  width: 244px;
  height: 40px;
  margin-bottom: 1px;

  background: rgb(245,246,246); 
background: -moz-linear-gradient(top, rgba(245,246,246,1) 0%, rgba(219,220,226,1) 10%, rgba(219,220,226,1) 85%, rgba(184,186,198,1) 96%, rgba(221,223,227,1) 99%, rgba(245,246,246,1) 100%); 
background: -webkit-linear-gradient(top, rgba(245,246,246,1) 0%,rgba(219,220,226,1) 10%,rgba(219,220,226,1) 85%,rgba(184,186,198,1) 96%,rgba(221,223,227,1) 99%,rgba(245,246,246,1) 100%); 
background: linear-gradient(to bottom, rgba(245,246,246,1) 0%,rgba(219,220,226,1) 10%,rgba(219,220,226,1) 85%,rgba(184,186,198,1) 96%,rgba(221,223,227,1) 99%,rgba(245,246,246,1) 100%); 

filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#f5f6f6', endColorstr='#f5f6f6',GradientType=0 ); 


}
.CctvItemBox:hover {
  background: rgb(255,255,255); /* Old browsers */
  background: -moz-linear-gradient(top, rgba(255,255,255,1) 0%, rgba(241,241,241,1) 6%, rgba(241,241,241,1) 6%, rgba(225,225,225,1) 7%, rgba(246,246,246,1) 96%, rgba(241,241,241,1) 98%); /* FF3.6-15 */
  background: -webkit-linear-gradient(top, rgba(255,255,255,1) 0%,rgba(241,241,241,1) 6%,rgba(241,241,241,1) 6%,rgba(225,225,225,1) 7%,rgba(246,246,246,1) 96%,rgba(241,241,241,1) 98%); /* Chrome10-25,Safari5.1-6 */
  background: linear-gradient(to bottom, rgba(255,255,255,1) 0%,rgba(241,241,241,1) 6%,rgba(241,241,241,1) 6%,rgba(225,225,225,1) 7%,rgba(246,246,246,1) 96%,rgba(241,241,241,1) 98%); /* W3C, IE10+, FF16+, Chrome26+, Opera12+, Safari7+ */
  filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#ffffff', endColorstr='#f1f1f1',GradientType=0 ); /* IE6-9 */
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