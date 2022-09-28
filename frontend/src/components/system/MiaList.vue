<template>
<div class="miaListBox">

  <MiaMenu></MiaMenu>
  <div class="miaListItem" v-show="initData.is_show_mia">
    <div v-for="(D_item, D_i) in DataSet"
    :key="D_i"
    :D_item = D_item
    @click="getMiaDetail(7)"
    class="miaItemBox"
    >{{D_item['name']}} + {{D_item['age']}}</div>
  </div>
  <MiaAddForm v-show="!initData.is_show_mia"></MiaAddForm>  

</div>
</template>

<script>
import { useMiaStore } from '@/stores/mia.js'
import { ref, computed } from 'vue'
import MiaAddForm from '@/components/system/MiaAddForm.vue'
import MiaMenu from '@/components/system/MiaMenu.vue'
export default {
  components: {
    MiaAddForm,
    MiaMenu,
},
  setup() {
    const miaStore = useMiaStore()
    const initData = {
      is_show_mia: true,
    }
    miaStore.getMiaList()
    const DataSet = ref(computed(() => miaStore.mia_list))
    
    function getMiaDetail(id) {
      miaStore.getMiaDetail(id)
    }
    return {
      initData,
      DataSet,
      getMiaDetail,
    }
  }
}
</script>

<style>
.miaItemBox {
  display: flex;
  justify-content: center;
  align-items: center;
  width: var(--controller-width);
  height: 40px;
  background-color: var(--main-color2);
}

.miaListBox {
  position: relative;
  width: var(--controller-width);
  height: 440px;
  background-color: var(--main-color2);
  padding: 4px;
  margin-top: 20px;

}


/* 영역 설정*/
.miaListItem{
  padding: 0px 4px;
  width:244px;
  height:405px;
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
    background-color: rgba(255,255,255,1);
    /* 스크롤바 둥글게 설정    */
    border-radius: 10px;    
}

/* 스크롤바 뒷 배경 설정*/
.miaListItem::-webkit-scrollbar-track{
    background-color: rgba(0,0,0,0.5);
}

</style>