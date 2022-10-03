<template>
  <form @submit.prevent="add_or_update" method="POST" class="MiaAddform">
    <div class="addInfo"><div>이름</div> <div>나이</div></div>
    <div class="addInfo">
      <div></div>
      <input type="text" name="name" class="inputBox" v-model="miaStore.miaData.name" required><br>

      <input type="number" name="age" class="inputBox" v-model="miaStore.miaData.age" required>
      <div></div>
    </div>
    <br>
     <div class="addImgBox" id="add_img">
      <label class="imgLabel" for="img">
        <img src="@/assets/add_img.png" style="width:120px; height:120px;  opacity:50%; " alt="">
        <input type="file" id="img" name="child_img" @change="fileUpload()"  accept=".png" required>
        </label>
      </div>
      <br>
    <div id="miafile">{{miaStore.miaData.child_img['name']}}</div>
  <button type="submit"><div v-if="miaStore.mia_update_id === -1">미아등록</div> <div v-if="miaStore.mia_update_id !== -1">수정</div></button>

  </form>

</template>

<script>
import { useMiaStore } from '@/stores/mia.js'
import { ref } from 'vue'
export default {
  setup() {

    const miaStore = useMiaStore()
    const fileUpload = () =>{
      miaStore.miaData.child_img = ref(document.getElementById('img').files[0])
      document.getElementById('add_img').style.backgroundImage= "url(" +URL.createObjectURL(miaStore.miaData.child_img) +")"
    }
    function add_or_update () {
      if (miaStore.mia_update_id === -1) {
        miaStore.setMiaData()
      } else {
        miaStore.updateMia()
      }
      miaStore.is_add_mia = !miaStore.is_add_mia
    }
  
  return {
    miaStore,
    fileUpload,
    add_or_update,
  }
    
  }
}
</script>

<style>
.MiaAddform {
  position: relative;
  width: var(--controller-width);
  height: 400px;
  background-color: var(--main-color2);
  padding: 4px;

}
.addImgBox {
  display: flex;
  margin-left: 20px;
  justify-content: center;
  align-items: center;
  width: 200px;
  height: 240px;
  border: 3px solid #aaa;
  border-radius: 10px;
  box-shadow: 2px 2px 1px 1px;
  background-color: #ffffff;
  background-size:contain;
  background-repeat: no-repeat;
  background-position: center;
}
.imgLabel:hover {
  cursor: pointer;

}
.addInfo {
  display: flex;
  justify-content: space-around;
  align-items: center;
}
.inputBox {
  width: 80px;
  height: 20px;
}
input[type="file"] {
    position: absolute;
    width: 0;
    height: 0;
    padding: 0;
    overflow: hidden;
    border: 0;
}
</style>