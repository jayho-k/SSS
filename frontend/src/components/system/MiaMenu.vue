<template>
  <div>
    <div class="MiaMenuBox">
      <div class="ListMenuName">&nbsp; MIA </div>
      <MiaMenu></MiaMenu>
    </div>
    <div style="height:30px;"></div>
  </div>
</template>
  
<script>
import MiaMenu from '@/components/system/RevisionMiaMenu.vue'
  export default {
    components: {MiaMenu}

  }
</script>
  
<style>
  .ListMenuName {
    display: flex;
    justify-content: center;
    align-items: center;
  }
  .MiaMenuBox {
    position: absolute;
    display: flex;
    align-items: center;
    color: #eee;
    background-color: hsla(0,0%,20%,1);
    width: 252px;
    height: 30px;
  }


</style>