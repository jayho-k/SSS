<template>
  <!-- <div class="CctvItemBox">{{tems[0]}}</div> -->
  <div class="CctvItemBox">asdf</div>
  <div class="CctvItemBox">asdf</div>
  <div class="CctvItemBox">asdf</div>
  <div class="CctvItemBox">asdf</div>
  <div class="CctvItemBox">asdf</div>
  <div class="CctvItemBox">asdf</div>
  <div class="CctvItemBox">asdf</div>
  <div class="CctvItemBox">asdf</div>
  <div class="CctvItemBox">asdf</div>
  <div class="CctvItemBox">asdf</div>
  <div class="CctvItemBox">asdf</div>
  <div class="CctvItemBox">asdf</div>
  <div class="CctvItemBox">asdf</div>
  <div class="CctvItemBox">asdf</div>
  <div class="CctvItemBox">asdf</div>
  <div class="CctvItemBox">asdf</div>
  <div class="CctvItemBox">asdf</div>
  <div class="CctvItemBox">asdf</div>
  <div class="CctvItemBox">asdf</div>

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
.CctvItemBox {
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