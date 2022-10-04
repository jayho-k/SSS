<template>
  <div>
    <div class="VideoMenuBox">&nbsp;&nbsp;
      <div style="text-align:left; width:200px;">VIDEO</div>
      <RevisionVideoMenu></RevisionVideoMenu>
    </div>
    <div style="height:30px;"></div>
  </div>
</template>
  
<script>
import RevisionVideoMenu from '@/components/system/control/uploadVideo/RevisionVideoMenu.vue'
  export default {
    components: {
      RevisionVideoMenu
    }

  }
</script>
  
<style scoped>
  .VideoMenuBox {
  position: absolute;
  display: flex;
  justify-content: space-between;
  align-items: center;
  color: #eee;
  background-color: hsla(0,0%,20%,1);
  width: 252px;
  height: 30px;
  }

</style>