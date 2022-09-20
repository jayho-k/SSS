<template>
  <div>
    <router-link to="/login"> account</router-link>
    <br>
    <router-link to="/cctv">sadfsdfdasf</router-link>
    <br>
    <router-view></router-view>
  </div>
</template>

<script>

export default {
  name: 'App',
  components: {
},
}
</script>

<style>
:root {
  --main-color1: #000000;
  --main-color2: #eee;
  --main-color3: #FFFFFF;

}
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}
</style>
