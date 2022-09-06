<template>
  <div>
    <kakaoMap></kakaoMap>
    <div>{{store.count}}</div>
  </div>
</template>

<script>
import { useIndexStore } from "@/stores/index"
import kakaoMap from '@/components/kakaoMap'
export default {
  name: 'App',
  components: {
    kakaoMap,
  },
  setup () {
    const store = useIndexStore()
    store.count++ 
    return {
      store
    }
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
