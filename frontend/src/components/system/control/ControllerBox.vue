<template>
  <div class="controllerBox">
    <NavMenu></NavMenu>
    <RevisionMenu></RevisionMenu>
    <ObjectList></ObjectList>
    
  </div>  
</template>

<script>
import NavMenu from '@/components/system/control/NavMenu.vue'
import RevisionMenu from '@/components/system/control/RevisionMenu.vue'
import ObjectList from '@/components/system/control/ObjectList.vue'
export default {
  components: {
    NavMenu,
    RevisionMenu,
    ObjectList
  }
}
</script>

<style>
.controllerBox {
  width: 320px;
  margin-left: 32px;
}
</style>