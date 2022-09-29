<template>
  <div class="RevisionMenuBox">
    <div class="metalBtn hoverY linearBtn" @click="add_mia"><span class="material-symbols-outlined">
person_add
</span></div>
    <div class="metalBtn hoverR linearBtn" @click="del"><span class="material-symbols-outlined">
delete
</span></div>
  </div>
</template>

<script>
import { useMiaStore } from '@/stores/mia';
export default {
  setup() {
    const miaStore = useMiaStore()
    function add_mia () { 
        miaStore.is_add_mia = !miaStore.is_add_mia
      }
    return {
      add_mia
    }
  }
}

</script>

<style>

</style>