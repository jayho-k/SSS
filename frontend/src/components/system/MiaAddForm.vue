<template>
  <form @submit.prevent="miaStore.setMiaData(miaData)" method="POST">
    <fieldset style="width:150px;">
      이름: <input type="text" name="name" v-model="miaData.name" required><br>
      이미지: <input type="file" id="img" name="child_img" @change="fileUpload()" required> <br>
      나이: <input type="number" name="age" v-model="miaData.age" required>

    </fieldset>
  <button type="submit"></button>
  </form>

</template>

<script>
import { useMiaStore } from '@/stores/mia.js'
import { ref } from 'vue'
export default {
  setup() {

    const miaStore = useMiaStore()
    const miaData = ref({
      name:'',
      child_img: null,
      age: 0,
    })
    const fileUpload = () =>{
      miaData.value.child_img = ref(document.getElementById('img').files[0])

    }
  
  return {
    miaStore,
    fileUpload,
    miaData
  }
    
  }
}
</script>

<style>

</style>