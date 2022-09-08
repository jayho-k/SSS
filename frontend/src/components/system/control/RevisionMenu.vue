<template>
  <div class="RevisionMenuBox">
    <div class="Revisionbutton">추가</div>
    <div class="Revisionbutton">이동</div>
    <div class="Revisionbutton">삭제</div>
  </div>
</template>

<script>
export default {

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