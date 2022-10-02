<template>
  <div class="RevisionMenuBox">
    
    <div @click="toggle_view"><span class="material-symbols-outlined">live_tv</span></div>
      <div class="menuIcons">
      <button class="metalBtn linearBtn" @click="add"><span class="material-symbols-outlined">add_location_alt</span></button>
      <button class="metalBtn linearBtn" @click="del"><span class="material-symbols-outlined">delete</span></button>
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
      store.cctv_mode = 1
    
    }
    function del (e) {
      e.target.classList.toggle('clickR')
      if (store.mode === 3) {
        store.cctv_mode = 2}
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

<style>

.RevisionMenuBox {
  justify-content: center;
  text-align: center;
  display: flex;
  width: 120px;
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
  font-size: 0.2em;
  height: 28px;
  border-radius: 1em;

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
    inset rgba(255, 255, 255, 0.7) 0  2px 1px 12px, /* top HL */
    
    hsla(210 ,100%,55%, .8) 0  0px 1px 1px, /* outer SD */
    hsla(210 ,80%,95%, 1) 0px  0px 0px 0px; /* outer HL */
}
.clickY {
  color: hsl(43, 80%, 70%);

  box-shadow: 
    inset rgb(212, 176, 84) 0  0px 0px 2px, /* border */
    inset rgba(255, 255, 255, 0.7) 0  2px 1px 12px, /* top HL */
    
    hsla(43,100%,75%, .8) 0  0px 1px 1px, /* outer SD */
    hsla(210 ,80%,95%, 1) 0px  0px 0px 0px; /* outer HL */
}
.clickR {
  color: hsla(0,100%,30%,  1);

  box-shadow: 
    inset hsla(0,100%,30%,  1) 0  0px 0px 2px, /* border */
    inset rgba(255, 255, 255, 0.7) 0  2px 1px 12px, /* top HL */
    
    hsla(0,100%,75%, .8) 0  0px 1px 1px, /* outer SD */
    hsla(210 ,80%,95%, 1) 0px  0px 0px 0px; /* outer HL */
}
</style>