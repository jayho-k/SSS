<template>
  <div class="ObjectItemBox">{{items.name}}</div>
</template>

<script>
import { ref, computed } from '@vue/reactivity'
export default {
  props: {
    D_item: {
      
    }
  },
  setup (props) {
    const items = ref(computed(() => props.D_item))
    return {
      items
    }
  }
}
</script>

<style>
.ObjectItemBox {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 320px;
    height: 60px;
}
</style>