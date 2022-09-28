<template>
  <div>
    <div class="CctvMenuBox"> &nbsp;
      <div class="name">CCTV</div>
      <CctvMenuVue></CctvMenuVue>
    </div>

    <div style="height:30px;"></div>
  </div>
</template>
  
<script>
import CctvMenuVue from '@/components/system/control/realtime/RevisionCctvMenu.vue'
  export default {
    components: {
      CctvMenuVue,
    }

  }
</script>
  
<style>
  .name {
    display: flex;
    justify-content: center;
    align-items: center;
  }
  .CctvMenuBox {
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