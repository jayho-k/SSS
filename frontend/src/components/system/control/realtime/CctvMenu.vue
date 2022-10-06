<template>
  <div>
    <div class="CctvMenuBox"> &nbsp;&nbsp;
      <div style="text-align:left; width:60px;">CCTV</div>
      <CctvMenu></CctvMenu>
    </div>
    <div style="height:30px;"></div>

  </div>
</template>
  
<script>
import CctvMenu from '@/components/system/control/realtime/RevisionCctvMenu.vue'
  export default {
    components: {
      CctvMenu,
    }

  }
</script>
  
<style scoped>

  .CctvMenuBox {
    position: absolute;
    display: flex;
    align-items: center;
    color: #eee;
    background-color: hsla(0,0%,20%,1);
    width: 254px;
    height: 30px;
  }


</style>