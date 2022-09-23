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

</style>