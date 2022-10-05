<template>
  <div class="modal">
    <div class="overlay"></div>
    <div class="modal-card">
      <div @click="$emit('close-modal')" id="close"><span class="material-symbols-outlined">close</span></div>
      <slot />
    </div>
  </div>
</template>

<script>
export default {

}
</script>

<style scoped>

#close {
  text-align: end;
  float: right;
  border-radius: 5px;
}
#close:hover {
  transform: scale(1.2);
}
.modal {
  z-index: 100;
}
.modal,
.overlay {
  width: 100%;
  height: 100%;
  position: fixed;
  left: 0;
  top: 0;
}
.overlay {
  opacity: 0.3;
  background-color: #000;
}
.modal-card {
  position: relative;
  width: 200px;
  margin-right: 304px;
  margin-top: 24px;
  margin-left: auto;
  background-color: #eee;
  min-height: 200px;
  z-index: 10;
  opacity: 1;
  border: 6px double #000;
}
</style>