<template>
  <div class="NavMenuBox">
    <div>cctv</div>
    <div>분석</div>
    <img class="navMenu" src="@/assets/optionIcon.png" alt="">
  </div>
</template>

<script>
export default {

}
</script>

<style>
.NavMenuBox {
  display: flex;
  width: 320px;
  height: 90px;
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