<template>
<div class="miaListBox">
  <div class="miaItemBox"> Mia List</div>
  <MiaAddForm></MiaAddForm>
  <MiaItem></MiaItem>
</div>
</template>

<script>
import { useMiaStore } from '@/stores/mia.js'
import MiaAddForm from '@/components/system/MiaAddForm.vue'
import MiaItem from '@/components/system/MiaItem.vue'
export default {
  components: {
    MiaAddForm,
    MiaItem,
    },
  setup() {
    const miaStore = useMiaStore()
    miaStore.getMiaList()
    
  }
}
</script>

<style>
.miaListBox {
    margin-top: 16px;
    width: var(--controller-width);
    height: 360px;
    background-color: var(--main-color2);
}
.miaItemBox {
  display: flex;
  justify-content: center;
  align-items: center;
  width: var(--controller-width);
  height: 60px;
  background-color: var(--main-color2);
}
</style>