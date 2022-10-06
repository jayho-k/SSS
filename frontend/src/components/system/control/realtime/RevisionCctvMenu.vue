<template>
  <div class="RevisionMenuBox">
    
    <div @click="toggle_view" class="flex"><span class="material-symbols-outlined">live_tv</span></div>
      <div class="menuIcons">
        <span id="C_blue" @click="add" class="material-symbols-outlined metalBtn linearBtn">add_location_alt</span>
        <span id="C_Red" @click="del" class="material-symbols-outlined metalBtn linearBtn">delete</span>
    </div>
  </div>
</template>

<script>
import { useKakaoStore } from '@/stores/kakaoMap';
export default {
  setup() {
    const store = useKakaoStore()
    function add (e) {
      e.target.classList.toggle('clickB')
      document.getElementById('C_Red').classList.remove('clickR')
      if (store.cctv_mode === 1) {
        store.cctv_mode = 0
      } else {
        store.cctv_mode = 1
      }   
    }
    function del (e) {
      e.target.classList.toggle('clickR')
      document.getElementById('C_blue').classList.remove('clickB')
      if (store.cctv_mode === 2) {
        store.cctv_mode = 0}
      else {
        store.cctv_mode = 2
      }
    }
    function toggle_view () {
      store.is_kakao_view = !store.is_kakao_view
    
    }
    return {
      add,
      del,
      toggle_view
    }
  }
}
</script>

<style scoped>

.RevisionMenuBox {
  justify-content: space-between;
  text-align: center;
  display: flex;
  width: 200px;
  height: 28px;
  border-radius: 5px;
  align-items: center;
}
.metalBtn {
  display: flex;
  justify-content: center;
  align-items: center;
  text-align: center;
  color: #eee;
  background-color: hsla(0,0%,20%,1);
  border: none;
}

/* Linear ------------------------- */

.metalBtn.linearBtn {
  width: 28px;
  font-size: 1.5em;
  height: 28px;

}

.menuIcons {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

/* active ------------------------- */


.clickB {
  color: hsl(210, 100%, 40%);

  box-shadow: 
    inset hsla(210,100%,30%,  1) 0  0px 0px 2px, /* border */
    inset rgba(255, 255, 255, 0.862) 0  2px 1px 14px, /* top HL */
    
    hsla(210 ,100%,55%, .8) 0  0px 1px 1px, /* outer SD */
    hsla(210 ,80%,95%, 1) 0px  0px 0px 0px; /* outer HL */
}
.clickY {
  color: hsl(43, 80%, 70%);

  box-shadow: 
    inset rgb(212, 176, 84) 0  0px 0px 2px, /* border */
    inset rgba(255, 255, 255, 0.7) 0  2px 1px 14px, /* top HL */
    
    hsla(43,100%,75%, .8) 0  0px 1px 1px, /* outer SD */
    hsla(210 ,80%,95%, 1) 0px  0px 0px 0px; /* outer HL */
}
.clickR {
  color: hsla(0,100%,30%,  1);

  box-shadow: 
    inset hsla(0,100%,30%,  1) 0  0px 0px 2px, /* border */
    inset rgba(255, 255, 255, 0.862) 0  2px 1px 14px, /* top HL */
    
    hsla(0,100%,75%, .8) 0  0px 1px 1px, /* outer SD */
    hsla(210 ,80%,95%, 1) 0px  0px 0px 0px; /* outer HL */
}
.flex {
  display: flex;
  align-items: center;
}
</style>