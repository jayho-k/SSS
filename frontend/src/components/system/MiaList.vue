<template>

  <div v-if="!miaStore.is_alarm_view" class="miaListBox metalList">

    <MiaMenu></MiaMenu>
    <div class="miaListItem" v-show="!miaStore.is_add_mia">
      <div v-for="(D_item, D_i) in DataSet"
      :key="D_i"
      :D_item = D_item
      @click="delete_mia(D_item['id'], D_i)"
      class="miaItemBox"
      ><div class="mia_name"><div style="width:10px;"></div>{{D_item['name'].slice(0, 6)}}</div> <div>{{D_item['age']}}세</div>
      <div @click="updateMia(D_item)">
        <span class="material-symbols-outlined colorO">edit</span>
        </div>
      </div>
    </div>
    <MiaAddForm v-show="miaStore.is_add_mia"></MiaAddForm>  

  </div>
  <AlarmList v-if="miaStore.is_alarm_view" class="metalList"></AlarmList>

</template>

<script>
import { useMiaStore } from '@/stores/mia.js'
import { ref, computed } from 'vue'
import AlarmList from '@/components/system/control/realtime/AlarmList.vue'
import MiaAddForm from '@/components/system/MiaAddForm.vue'
import MiaMenu from '@/components/system/MiaMenu.vue'
export default {
  components: {
    MiaAddForm,
    MiaMenu,
    AlarmList,
},
  setup() {
    const miaStore = useMiaStore()

    
    miaStore.getMiaList()
    const DataSet = ref(computed(() => miaStore.mia_list))
    miaStore.is_add_mia = false
    function delete_mia(id, idx) {
      
      if (!miaStore.mia_list_mode) {
        miaStore.deleteMia(id)
        miaStore.mia_list.splice(idx, 1)
      }
    }
    function updateMia (item) {
      miaStore.is_add_mia = !miaStore.is_add_mia
      miaStore.miaData.name = item['name']
      miaStore.miaDataget = item['get']
      miaStore.mia_update_id = item['id']
    }
    return {
      miaStore,
      DataSet,

      delete_mia,
      updateMia,
    }
  }
}
</script>

<style>
.miaItemBox {
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

.miaItemBox:hover {
  background: rgb(255,255,255); /* Old browsers */
  background: -moz-linear-gradient(top, rgba(255,255,255,1) 0%, rgba(241,241,241,1) 6%, rgba(241,241,241,1) 6%, rgba(225,225,225,1) 7%, rgba(246,246,246,1) 96%, rgba(241,241,241,1) 98%); /* FF3.6-15 */
  background: -webkit-linear-gradient(top, rgba(255,255,255,1) 0%,rgba(241,241,241,1) 6%,rgba(241,241,241,1) 6%,rgba(225,225,225,1) 7%,rgba(246,246,246,1) 96%,rgba(241,241,241,1) 98%); /* Chrome10-25,Safari5.1-6 */
  background: linear-gradient(to bottom, rgba(255,255,255,1) 0%,rgba(241,241,241,1) 6%,rgba(241,241,241,1) 6%,rgba(225,225,225,1) 7%,rgba(246,246,246,1) 96%,rgba(241,241,241,1) 98%); /* W3C, IE10+, FF16+, Chrome26+, Opera12+, Safari7+ */
  filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#ffffff', endColorstr='#f1f1f1',GradientType=0 ); /* IE6-9 */
}

.miaListBox {
  position: relative;
  width: var(--controller-width);
  height: calc((100vh - 720px) / 360 * 96 + 324px);
  min-height: 325px;
  background-color: var(--main-color2);
  padding: 4px;
  margin-top: 20px;

}

/* 영역 설정*/
.miaListItem{
  padding: 0px 4px;
  width:244px;
  height:calc(100% - 34px);
	overflow-y: scroll;
  overflow-x: hidden;
  
}

/* 스크롤바 설정*/
.miaListItem::-webkit-scrollbar{
	/*  스크롤바 막대 너비 설정 */
    width: 4px;
    z-index: -10;
}

/* 스크롤바 막대 설정*/
.miaListItem::-webkit-scrollbar-thumb{
    /* 스크롤바 막대 높이 설정    */
    height: 17%;
    background-color: rgba(0,0,0,0.5);
    /* 스크롤바 둥글게 설정    */
    border-radius: 10px;    
}

/* 스크롤바 뒷 배경 설정*/
.miaListItem::-webkit-scrollbar-track{
    background-color: rgba(255,255,255,1);
}
.colorO:hover {
  color:var(--sweet-orange)
}
.metalList {
    text-align: center;
    color: hsla(0,0%,20%,1);
    text-shadow: hsl(0deg 0% 40% / 50%) 0 -1px 0, hsl(0deg 0% 100% / 60%) 0 1px 1px;
    background-color: hsl(0,0%,90%);
    box-shadow: inset hsla(0,0%,15%, 1) 0 0px 0px 4px, /* border */ inset hsla(0,0%,15%, .8) 0 -1px 5px 4px, /* soft SD */ inset hsla(0,0%,0%, .25) 0 -1px 0px 7px, /* bottom SD */ inset hsla(0,0%,100%,.7) 0 2px 1px 7px, /* top HL */ hsla(0,0%, 0%,.15) 0 -5px 6px 4px, /* outer SD */ hsla(0,0%,100%,.5) 0 1px 4px 3px;
    transition: color .2s;
}
.mia_name {
  display: flex;
  width: 110px;
  text-align: left;
}

</style>