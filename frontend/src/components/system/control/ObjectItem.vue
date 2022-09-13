<template>
  <div class="ObjectItemBox">{{items[0]}}</div>
</template>

<script>
import { ref } from '@vue/reactivity'
export default {
  props: {
    D_item: {
      
    }
  },
  setup (props) {
    const items = ref(props.D_item)
    return {
      items
    }
  }
}
</script>

<style>
.ObjectItemBox {
    width: 320px;
    height: 60px;
}
</style>