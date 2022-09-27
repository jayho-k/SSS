<template>
<button type="button" @click="getMiaDetail(7)"></button>
</template>

<script>
import { useMiaStore } from '@/stores/mia.js'
export default {
  setup() {
    const miaStore = useMiaStore()

    function getMiaDetail(id) {
      miaStore.getMiaDetail(id)
    }

    return {
      getMiaDetail,
    }

  }

}
</script>

<style>
.MiaItemBox {
  position: relative;
  display: flex;
  justify-content: center;
  align-items: center;
  background-color: hsl(0,0%,95%);
  width: 244px;
  height: 40px;
  margin-bottom: 1px;
}
</style>