<template>
  <div class="controllerBox">
    <NavMenu></NavMenu>
    <WatchMenu></WatchMenu>
    <!-- 업로드 -->
  <VideoList></VideoList>
  <MiaList></MiaList>
  </div>  
</template>

<script scoped>
import NavMenu from '@/components/system/control/NavMenu.vue'
import WatchMenu from '@/components/system/control/WatchMenu.vue'

import VideoList from '@/components/system/control/uploadVideo/VideoList.vue'
import MiaList from '@/components/system/MiaList.vue'
export default {
  components: {
    NavMenu,
    WatchMenu,
    
    VideoList,
    MiaList,
  },
  setup () {

    return {
    }

  }
}
</script>

<style>
.controllerBox {
  width: 260px;
  margin-left: 20px;
}

</style>