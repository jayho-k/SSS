<template>
  <div>
    <div class="AlarmMenuBox"> &nbsp;&nbsp;
      <div style="text-align:left; width:200px;">Alarm</div>
      <AlarmMenu></AlarmMenu>
    </div>

    <div style="height:30px;"></div>
  </div>
</template>
  
<script>
import AlarmMenu from '@/components/system/control/realtime/RevisionAlarmMenu.vue'
  export default {
    components: {
      AlarmMenu,
    }

  }
</script>
  
<style scoped>

  .AlarmMenuBox {
    position: absolute;
    display: flex;
    align-items: center;
    color: #eee;
    background-color: hsla(0,0%,20%,1);
    width: 252px;
    height: 30px;
  }


</style>