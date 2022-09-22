<template>
  <div class="NavMenuBox">
    <router-link to="/cctv" @click="change_view(0)">cctv</router-link>
    <router-link to="/upload" @click="change_view(2)">upload</router-link>
    <img class="navMenu" src="@/assets/optionIcon.png" alt="옵션">
  </div>
</template>

<script>
import { useIndexStore } from '@/stores/index'
export default {
  setup() {
    const IndexStore = useIndexStore()
    function change_view (inx) {
      IndexStore.view_case = inx
      console.log(IndexStore.view_case)
    }
    return {
      IndexStore,
      change_view
    }
  }
}
</script>

<style>
.NavMenuBox {
  display: flex;
  width: var(--controller-width);
  height: 60px;
  background-color: var(--main-color2);
  border-radius: 5px;
  justify-content: space-around;
  align-items: center;
}
.navMenu {
  width: 33px;
  height: 33px;
}
</style>