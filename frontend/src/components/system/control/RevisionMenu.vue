<template>
  <div class="RevisionMenuBox">
    <div class="Revisionbutton" @click="add">추가</div>
    <div class="Revisionbutton" @click="move">이동</div>
    <div class="Revisionbutton" @click="del">삭제</div>
  </div>
</template>

<script>
import { useKakoStore } from '@/stores/kakaoMap';
export default {
  setup() {
    const store = useKakoStore()
    function add () {
      if (store.mode === 1) {
      store.mode = 0}
      else {
        store.mode = 1
      }
    }
    function move () {
      store.is_move = !store.is_move
    }
    function del () {
      if (store.mode === 3) {
      store.mode = 0}
      else {
        store.mode = 3
      }
    }

    return {
      add,
      move,
      del
    }
  }
}
</script>

<style>

.RevisionMenuBox {
    display: flex;
    width: 320px;
    height: 90px;
    border-radius: 5px;
    justify-content: space-between;
    align-items: center;
}
.Revisionbutton {
    display: flex;
    width: 100px;
    height: 72px;
    background-color: var(--main-color2);
    border-radius: 5px;
    align-items: center;
    justify-content: center;
}
</style>