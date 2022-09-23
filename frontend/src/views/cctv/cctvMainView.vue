<template>
  <div class="cctvMain">
    
    <kakaoMap></kakaoMap>
    <Controller></Controller>
  </div>
</template>

<script>
import kakaoMap from '@/components/system/realtime/kakaoMap'
import Controller from '@/components/system/control/ControllerBox'
export default {
    components: { kakaoMap, Controller }

}
</script>

<style>
.cctvMain {
  display: flex;
  background-color: var(--main-color1);
  padding: 20px 28px;
}

</style>