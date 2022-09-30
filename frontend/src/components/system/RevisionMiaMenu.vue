<template>
  <div class="RevisionMenuBox">
    <div class="metalBtn hoverY linearBtn" @click="add_mia"><span class="material-symbols-outlined">
person_add
</span></div>
    <div class="metalBtn hoverR linearBtn" @click="del"><span class="material-symbols-outlined">
delete
</span></div>
  </div>
</template>

<script>
import { useMiaStore } from '@/stores/mia';
export default {
  setup() {
    const miaStore = useMiaStore()
    function add_mia () { 
        miaStore.is_add_mia = !miaStore.is_add_mia
      }
    return {
      add_mia
    }
  }
}

</script>

<style>
.metalBtn {
  display: flex;
  justify-content: center;
  align-items: center;
  text-align: center;
  color: #fff;
  background-color: #000;
  transition: color .2s;
}

/* Linear ------------------------- */

.metalBtn.linearBtn {
  width: 28px;
  font-size: 0.2em;
  height: 28px;
  border-radius: 1em;

}


/* active ------------------------- */

.hoverB:hover {
  color: hsl(210, 100%, 40%);
  text-shadow: hsla(210,100%,20%,.3) 0 -1px 0, hsl(210,100%,85%) 0 2px 1px, hsla(42,100%,80%,1) 0 0 5px, hsla(210,100%,50%,.6) 0 0 20px;
  box-shadow: 
    inset hsla(210,100%,30%,  1) 0  0px 0px 2px, /* border */
    inset hsla(210,100%,100%,.7) 0  2px 1px 12px, /* top HL */
    
    hsla(210,100%,75%, .8) 0  0px 1px 1px, /* outer SD */
    hsla(210,80%,95%,   1) 0  5px 6px 4px; /* outer HL */
}
.hoverY:hover {
  color: hsl(43, 100%, 40%);
  text-shadow: hsla(43,100%,20%,.3) 0 -1px 0, hsl(43,100%,85%) 0 2px 1px, hsla(42,100%,80%,1) 0 0 5px, hsla(43,100%,50%,.6) 0 0 20px;
  box-shadow: 
    inset hsla(43,100%,30%,  1) 0  0px 0px 2px, /* border */
    inset hsla(43,100%,100%,.7) 0  2px 1px 12px, /* top HL */
    
    hsla(43,100%,75%, .8) 0  0px 1px 1px, /* outer SD */
    hsla(43,80%,95%,   1) 0  5px 6px 4px; /* outer HL */
}
.hoverR:hover {
  color: hsl(0, 100%, 40%);
  text-shadow: hsla(0,100%,20%,.3) 0 -1px 0, hsl(0,100%,85%) 0 2px 1px, hsla(42,100%,80%,1) 0 0 5px, hsla(0,100%,50%,.6) 0 0 20px;
  box-shadow: 
    inset hsla(0,100%,30%,  1) 0  0px 0px 2px, /* border */
    inset hsla(0,100%,100%,.7) 0  2px 1px 14px, /* top HL */
    
    hsla(0,100%,75%, .8) 0  0px 1px 1px, /* outer SD */
    hsla(0,80%,95%,   1) 0  5px 6px 4px; /* outer HL */
}

.clickB {
  color: hsl(210, 100%, 40%);

  box-shadow: 
    inset hsla(210,100%,30%,  1) 0  0px 0px 2px, /* border */
    inset hsla(210,100%,100%,.7) 0  2px 1px 12px, /* top HL */
    
    hsla(210 ,100%,55%, .8) 0  0px 1px 1px, /* outer SD */
    hsla(210 ,80%,95%, 1) 0  2px 2px 2px; /* outer HL */
}
.clickY {
  color: hsl(43, 80%, 70%);

  box-shadow: 
    inset hsla(43,100%,30%,  1) 0  0px 0px 2px, /* border */
    inset hsla(43,100%,100%,.7) 0  2px 1px 12px, /* top HL */
    
    hsla(43,100%,75%, .8) 0  0px 1px 1px, /* outer SD */
    hsla(43,80%,95%,   1) 0  2px 2px 2px; /* outer HL */
}
.clickR {
  color: hsla(0,100%,30%,  1);

  box-shadow: 
    inset hsla(0,100%,30%,  1) 0  0px 0px 2px, /* border */
    inset hsla(0,100%,100%,.7) 0  2px 1px 12px, /* top HL */
    
    hsla(0,100%,75%, .8) 0  0px 1px 1px, /* outer SD */
    hsla(0,80%,95%,   1) 0  2px 2px 2px; /* outer HL */
}
</style>