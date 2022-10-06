<template>
  <form @submit.prevent="add_or_update" method="POST" class="MiaAddform">
    <div class="addInfo"><div>이름</div> <div>나이</div></div>
    <div class="addInfo">
      <div></div>
      <input type="text" name="name" class="inputBox" v-model="miaStore.miaData.name" required><br>

      <input type="number" name="age" class="inputBox" v-model="miaStore.miaData.age" required>
      <div></div>
    </div>
     <div class="addImgBox" id="add_img">
      <label class="imgLabel" for="img">
        <img src="@/assets/add_img.png"  class="add_imgIcon" alt="">
        <input type="file" id="img" name="child_img" @change="fileUpload()"  accept=".png, .JPG" required>
        </label>
      </div>
    <div id="miafile" style="margin-top:10px;">{{miaStore.miaData.child_img['name'].slice(0,13)}}</div>
    <div class="light-button button-wrapper">
    <button type="submit" class="button">
      <span class="span" v-if="miaStore.mia_update_id === -1"><span class="material-symbols-outlined">face</span> 미아등록</span>
      <span  class="span" v-if="miaStore.mia_update_id !== -1"><span class="material-symbols-outlined">face</span>정보수정</span>
      </button>  
    </div>

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

<style scoped>
.MiaAddform {
  position: relative;
  width: var(--controller-width);
  height: calc(100% - 36px);
  background-color: var(--main-color2);
  padding: 4px;

}
.addImgBox {
  margin-top: 10px;
  display: flex;
  margin-left: 20px;
  justify-content: center;
  align-items: center;
  width: 200px;
  height: 50%;
  min-height: 80px;
  border: 3px solid #aaa;
  0: 2px 2px 1px 1px;
  background-color: #ffffff;
  background-size:contain;
  background-repeat: no-repeat;
  background-position: center;
}
.imgLabel:hover {
  cursor: pointer;
}
.add_imgIcon {
  width:40%; 
  height:40%;  
  opacity:50%;
}
.addInfo {
  display: flex;
  justify-content: space-around;
  align-items: center;
  font-size: 12px;
}
.inputBox {
  width: 80px;
  height: 20px;
  border: 3px solid #aaa;
  0: 2px 1px;
}
input[type="file"] {
    position: absolute;
    width: 0;
    height: 0;
    padding: 0;
    overflow: hidden;
    border: 0;
}


.button {
    background: #fff;
    border: none;
    padding: 4px;
    cursor: pointer;
    display: block;
    position: relative;
    overflow: hidden;
    transition: all .2s ease-in-out .2s;
    margin: 0 auto;
    width: 200px;
    height: 40px;
    text-align: center;

    0: 2px 1px;
  }
  .span {
    display: flex;
    justify-items: center;
    justify-content: center;
    padding: 4px 4px 4px 4px;
    background: #fff;
    z-index: 100;
    height: 24px;
    width: 184px;
    position: relative;
    transition: all .2s ease-in-out .2s;
    font-size: 16px;
  }
.button-wrapper {
    display: inline-block;
  }
  .button:hover span {
    background: var(--sweet-blue);
    color: #fff;
    transition: all .2s ease-in-out .2s;
  }
  .button:after {
    bottom: -100%;
    right: -100%;
    content: "";
    width: 100%;
    height: 100%;
    position: absolute;
    background: var(--sweet-blue);
    transition: all .2s ease-in-out .5s;
  }
  .button:hover:after {
    right: 0;
    bottom: 0;
    transition: all ease-in-out .2s;
  }
  .button:before {
    top: -100%;
    left: -100%;
    content: "";
    width: 100%;
    height: 100%;
    position: absolute;
    background: var(--sweet-blue);
    transition: all .2s ease-in-out .5s;
  }
  .button:hover:before {
    left: 0;
    top: 0;
    transition: all ease-in-out .2s;
  }

.button {
    background: #fff;
    border: none;
    padding: 4px;
    cursor: pointer;
    display: block;
    position: relative;
    overflow: hidden;
    transition: all .2s ease-in-out .2s;
    margin: 0 auto;
    width: 204px;
    height: 40px;
    text-align: center;

    0: 2px 1px;
  }
  .span {
    display: flex;
    justify-items: center;
    justify-content: center;
    padding: 4px 4px 4px 4px;
    background: #fff;
    z-index: 100;
    height: 24px;
    width: 188px;
    position: relative;
    transition: all .2s ease-in-out .2s;
    font-size: 16px;
  }
.button-wrapper {
    display: inline-block;
  }
  .button:hover span {
    background: var(--sweet-blue);
    color: #fff;
    transition: all .2s ease-in-out .2s;
  }
  .button:after {
    bottom: -100%;
    right: -100%;
    content: "";
    width: 100%;
    height: 100%;
    position: absolute;
    background: var(--sweet-blue);
    transition: all .2s ease-in-out .5s;
  }
  .button:hover:after {
    right: 0;
    bottom: 0;
    transition: all ease-in-out .2s;
  }
  .button:before {
    top: -100%;
    left: -100%;
    content: "";
    width: 100%;
    height: 100%;
    position: absolute;
    background: var(--sweet-blue);
    transition: all .2s ease-in-out .5s;
  }
  .button:hover:before {
    left: 0;
    top: 0;
    transition: all ease-in-out .2s;
  }






  
</style>