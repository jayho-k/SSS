<template>
  <div>
    <router-view></router-view>
    <router-link to="/cctv">sadfsdfdasf</router-link>
    <div>{{store.count}}</div>
  </div>
</template>

<script>
import { useIndexStore } from "@/stores/index"
export default {
  name: 'App',
  components: {
},
  setup () {
    const store = useIndexStore()
    store.count ++
    return {
      store
    }
  }
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
