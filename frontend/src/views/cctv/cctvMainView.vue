<template>
  <div class="cctvMain">
    
    <kakaoMap></kakaoMap>
    <CctvController></CctvController>
  </div>
</template>

<script>
import kakaoMap from '@/components/system/realtime/kakaoMap'
import CctvController from '@/components/system/control/realtime/CctvController'
export default {
    components: { kakaoMap, CctvController }

}
</script>

<style>
.cctvMain {
  display: flex;
  background-color: var(--main-color1);
  padding: 20px 20px;
}

</style>