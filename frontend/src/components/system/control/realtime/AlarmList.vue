<template>
  <div class="AlarmListBox">

    <AlarmMenu></AlarmMenu>
    <div class="AlarmListItem" v-show="!is_add_Alarm">
      <div v-for="(D_item, D_i) in DataSet"
      :key="D_i"
      :D_item = D_item
      class="AlarmItemBox"
      >&nbsp;&nbsp;{{D_item[0]}}
      <div >
        </div>
      </div>
    </div>

  </div>
</template>

<script>
import { useKakaoStore } from '@/stores/kakaoMap';
import { ref, computed } from 'vue'
import AlarmMenu from '@/components/system/control/realtime/AlarmMenu.vue'
export default {
  components: {
    AlarmMenu,
},
  setup() {
    const KakaoStore = useKakaoStore()
    const is_add_Alarm = ref(computed(() => KakaoStore.is_add_Alarm))
    KakaoStore.getAlarmList()
    const DataSet = ref(computed(() => KakaoStore.alarm_list.alram))


    return {
      is_add_Alarm,
      DataSet,
    }
  }
}
</script>

<style>
.AlarmItemBox {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: var(--controller-width);
  height: 40px;
  background-color: var(--main-color2);
  background: rgb(245,246,246); /* Old browsers */
background: -moz-linear-gradient(top, rgba(245,246,246,1) 0%, rgba(219,220,226,1) 10%, rgba(219,220,226,1) 85%, rgba(184,186,198,1) 95%, rgba(221,223,227,1) 98%, rgba(221,223,227,1) 98%, rgba(245,246,246,1) 100%); /* FF3.6-15 */
background: -webkit-linear-gradient(top, rgba(245,246,246,1) 0%,rgba(219,220,226,1) 10%,rgba(219,220,226,1) 85%,rgba(184,186,198,1) 95%,rgba(221,223,227,1) 98%,rgba(221,223,227,1) 98%,rgba(245,246,246,1) 100%); /* Chrome10-25,Safari5.1-6 */
background: linear-gradient(to bottom, rgba(245,246,246,1) 0%,rgba(219,220,226,1) 10%,rgba(219,220,226,1) 85%,rgba(184,186,198,1) 95%,rgba(221,223,227,1) 98%,rgba(221,223,227,1) 98%,rgba(245,246,246,1) 100%); /* W3C, IE10+, FF16+, Chrome26+, Opera12+, Safari7+ */
filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#f5f6f6', endColorstr='#f5f6f6',GradientType=0 ); /* IE6-9 */
}

.AlarmItemBox:hover {
  background: rgb(255,255,255); /* Old browsers */
  background: -moz-linear-gradient(top, rgba(255,255,255,1) 0%, rgba(241,241,241,1) 6%, rgba(241,241,241,1) 6%, rgba(225,225,225,1) 7%, rgba(246,246,246,1) 96%, rgba(241,241,241,1) 98%); /* FF3.6-15 */
  background: -webkit-linear-gradient(top, rgba(255,255,255,1) 0%,rgba(241,241,241,1) 6%,rgba(241,241,241,1) 6%,rgba(225,225,225,1) 7%,rgba(246,246,246,1) 96%,rgba(241,241,241,1) 98%); /* Chrome10-25,Safari5.1-6 */
  background: linear-gradient(to bottom, rgba(255,255,255,1) 0%,rgba(241,241,241,1) 6%,rgba(241,241,241,1) 6%,rgba(225,225,225,1) 7%,rgba(246,246,246,1) 96%,rgba(241,241,241,1) 98%); /* W3C, IE10+, FF16+, Chrome26+, Opera12+, Safari7+ */
  filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#ffffff', endColorstr='#f1f1f1',GradientType=0 ); /* IE6-9 */
}

.AlarmListBox {
  position: relative;
  width: var(--controller-width);
  height: calc((100vh - 720px) / 360 * 96 + 324px);
  min-height: 325px;
  background-color: var(--main-color2);
  padding: 4px;
  margin-top: 20px;

}

/* 영역 설정*/
.AlarmListItem{
  padding: 0px 4px;
  width:244px;
  height:calc(100% - 35px);
	overflow-y: scroll;
  overflow-x: hidden;
  
}

/* 스크롤바 설정*/
.AlarmListItem::-webkit-scrollbar{
	/*  스크롤바 막대 너비 설정 */
    width: 4px;
    z-index: -10;
}

/* 스크롤바 막대 설정*/
.AlarmListItem::-webkit-scrollbar-thumb{
    /* 스크롤바 막대 높이 설정    */
    height: 17%;
    background-color: rgba(0,0,0,0.5);
    /* 스크롤바 둥글게 설정    */
    border-radius: 10px;    
}

/* 스크롤바 뒷 배경 설정*/
.AlarmListItem::-webkit-scrollbar-track{
    background-color: rgba(255,255,255,1);
}
.colorO:hover {
  color:var(--sweet-orange)
}
</style>