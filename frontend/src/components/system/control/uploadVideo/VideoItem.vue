<template>
  <router-link to="/VideoPlayer" class="VideoItemBox">{{items.name}}</router-link>
  <!-- <div class="CctvItemBox">test</div>
  <div class="CctvItemBox">test</div>
  <div class="CctvItemBox">test</div>
  <div class="CctvItemBox">test</div>
  <div class="CctvItemBox">test</div>
  <div class="CctvItemBox">test</div>
  <div class="CctvItemBox">test</div>
  <div class="CctvItemBox">test</div>
  <div class="CctvItemBox">test</div>
  <div class="CctvItemBox">test</div>
  <div class="CctvItemBox">test</div>
  <div class="CctvItemBox">test</div> -->
  

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
.VideoItemBox {
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