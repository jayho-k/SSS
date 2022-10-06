<template>
  <div class="controllerBox">
    
    <NavMenu></NavMenu>
    <WatchMenu></WatchMenu>
    <!-- 실시간 -->
    <CctvList></CctvList>
    <MiaList></MiaList>


  </div>
</template>

<script>
import NavMenu from '@/components/system/control/NavMenu.vue'
import WatchMenu from '@/components/system/control/WatchMenu.vue'
import CctvList from '@/components/system/control/realtime/CctvList.vue'
import MiaList from '@/components/system/MiaList.vue'
export default {
  components: {
    NavMenu,
    CctvList,
    WatchMenu,
    MiaList,
  },
  setup () {
    return {
    }

  }
}
</script>

<style scoped>
.controllerBox {
  width: 260px;
  margin-left: 20px;
}

</style>