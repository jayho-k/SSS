<template>
  <router-link to="/VideoPlayer" class="ObjectItemBox">{{items.name}}</router-link>

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
    width: var(--controller-width);
    height: 60px;
}
</style>