<template>
  <div class="controllerBox">
    <NavMenu></NavMenu>
    <!-- 실시간 -->
    <div v-if="view_case === 0">
      <RevisionMenu></RevisionMenu>
      <ObjectList class="metalList"></ObjectList>
      <AlarmList class="metalList"></AlarmList>
    </div>
    <!-- 업로드 -->
    <div v-if="view_case === 2">
      <RevisionVideoMenu></RevisionVideoMenu>
      <VideoList></VideoList>
      <MiaList></MiaList>
      
      
      
    </div>
    
    
  </div>  
</template>

<script>
import { useIndexStore } from '@/stores/index'
import NavMenu from '@/components/system/control/NavMenu.vue'

import RevisionMenu from '@/components/system/control/realtime/RevisionMenu.vue'
import ObjectList from '@/components/system/control/realtime/ObjectList.vue'
import AlarmList from '@/components/system/control/realtime/AlarmList.vue'
import RevisionVideoMenu from '@/components/system/control/uploadVideo/RevisionVideoMenu.vue'

import VideoList from '@/components/system/control/uploadVideo/VideoList.vue'
import MiaList from '@/components/system/MiaList.vue'
export default {
  components: {
    NavMenu,
    RevisionMenu,
    ObjectList,
    AlarmList,

    RevisionVideoMenu,
    VideoList,
    MiaList,
  },
  setup () {
    const IndexStore = useIndexStore()
    const view_case =IndexStore.view_case
    return {
      view_case
    }

  }
}
</script>

<style>
.controllerBox {
  width: var(--controller-width);
  margin-left: 32px;
}

.metalList {
  text-align: center;
  color: hsla(0,0%,20%,1);
  text-shadow: hsla(0,0%,40%,.5) 0 -1px 0, hsla(0,0%,100%,.6) 0 1px 1px;
  
  background-color: hsl(0,0%,90%);
  box-shadow: inset hsla(0,0%,15%,  1) 0  0px 0px 4px, /* border */
    inset hsla(0,0%,15%, .8) 0 -1px 5px 4px, /* soft SD */
    inset hsla(0,0%,0%, .25) 0 -1px 0px 7px, /* bottom SD */
    inset hsla(0,0%,100%,.7) 0  2px 1px 7px, /* top HL */
    
    hsla(0,0%, 0%,.15) 0 -5px 6px 4px, /* outer SD */
    hsla(0,0%,100%,.5) 0  1px 4px 3px; /* outer HL */ 
  
  transition: color .2s;
}
</style>