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
  --sweet-red: #f27474;
  --sweet-green:#a5dc86;
  --sweet-orange:#f8bb86;
  --sweet-blue:#3fc3ee;
  --sweet-blue-bg:#9de0f6;
  --sweet-gray:#87adbd;
  --sweet-gray-bg:#c9dae1;


}
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}
</style>
