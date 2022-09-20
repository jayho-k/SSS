<template>
  <div class="controllerBox">
    <NavMenu></NavMenu>
    <!-- 실시간 -->
    <div v-if="view_case === 1">
      <RevisionMenu></RevisionMenu>
      <ObjectList></ObjectList>
      <AlarmList></AlarmList>
    </div>
    <!-- 업로드 -->
    <div v-if="view_case === 2">
      <RevisionVideoMenu></RevisionVideoMenu>
      <VideoList></VideoList>
      
      
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
export default {
  components: {
    NavMenu,
    RevisionMenu,
    ObjectList,
    AlarmList,

    RevisionVideoMenu,
    VideoList,
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
  width: 320px;
  margin-left: 32px;
}
</style>