<template>
  <div>
    <router-link to="/login"> 로그인/회원가입</router-link>
    <br>
    <router-link to="/cctv">sadfsdfdasf</router-link>
    <br>
    <router-link to="/accountManage">회원관리</router-link>
    <br>
    <router-view></router-view>
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
a {
  text-decoration:none !important
}
body::-webkit-scrollbar {
    display: none; /* Chrome, Safari, Opera*/
}
body {
  -webkit-user-select:none;
  -moz-user-select:none;
  -ms-user-select:none;
  user-select:none
}
</style>
