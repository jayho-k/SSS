<template>
  <div>
    <div class="MiaMenuBox">&nbsp;&nbsp;
      <div style="text-align:left; width:60px;">MIA</div>
      <MiaMenu></MiaMenu>
    </div>
    <div style="height:30px;"></div>
  </div>
</template>
  
<script>
import MiaMenu from '@/components/system/RevisionMiaMenu.vue'
  export default {
    components: {MiaMenu},


  }
</script>
  
<style>
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