<template>
  <div class="RevisionMenuBox">
    <div class="metalBtn linearBtn" @click="add_mia"><span class="material-symbols-outlined">
person_add
</span></div>
    <div class="metalBtn linearBtn" @click="del_mia"><span class="material-symbols-outlined">
delete
</span></div>
  </div>
</template>

<script>
import { useMiaStore } from '@/stores/mia';
export default {
  setup() {
    const miaStore = useMiaStore()
    miaStore.mia_list_mode = true
    function add_mia (e) { 
      e.target.classList.toggle('clickB')
        miaStore.is_add_mia = !miaStore.is_add_mia
      }
    function del_mia (e) { 
      e.target.classList.toggle('clickR')
      miaStore.mia_list_mode = !miaStore.mia_list_mode
    }
    return {
      add_mia,
      del_mia
    }
  }
}

</script>

<style scoped>

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
    inset rgba(255, 255, 255, 0.525) 0  2px 1px 12px, /* top HL */
    
    hsla(43,100%,75%, .8) 0  0px 1px 1px, /* outer SD */
    hsla(210 ,80%,95%, 1) 0px  0px 0px 0px; /* outer HL */
}
.clickR {
  color: hsla(0,100%,30%,  1);

  box-shadow: 
    inset hsla(0,100%,30%,  1) 0  0px 0px 2px, /* border */
    inset rgba(255, 255, 255, 0.862) 0  2px 1px 12px, /* top HL */
    
    hsla(0,100%,75%, .8) 0  0px 1px 1px, /* outer SD */
    hsla(210 ,80%,95%, 1) 0px  0px 0px 0px; /* outer HL */
}
</style>