<template>
  <div class="RevisionMenuBox">

    <button class="metal1 hoverB linear" @click="add">추가</button>
    <button class="metal hoverY linear" @click="move">이동</button>
    <button class="metal hoverR linear" @click="del">삭제</button>
  </div>
</template>

<script>
import { useKakaoStore } from '@/stores/kakaoMap';
export default {
  setup() {
    const store = useKakaoStore()
    function add () {
      if (store.mode === 1) {
        
      store.mode = 0}
      else {
        store.mode = 1
      }
    }
    function move () {
      store.setDrag()
    }
    function del () {
      if (store.mode === 3) {
      store.mode = 0}
      else {
        store.mode = 3
      }
    }
    function save () {
      store.saveMarkers()
    }
    return {
      add,
      move,
      del,
      save
    }
  }
}
</script>

<style>

.RevisionMenuBox {
    display: flex;
    width: 320px;
    height: 100px;
    border-radius: 5px;
    justify-content: space-between;
    align-items: center;
}



.metal1 {
  text-align: center;
  color: hsla(0,0%,20%,1);
  text-shadow: hsla(0,0%,40%,.5) 0 -1px 0, hsla(0,0%,100%,.6) 0 2px 1px;
  
  background-color: hsl(0,0%,90%);
  box-shadow: inset hsla(0,0%,15%,  1) 0  0px 0px 4px, /* border */
    inset hsla(0,0%,15%, .8) 0 -1px 5px 4px, /* soft SD */
    inset hsla(0,0%,0%, .25) 0 -1px 0px 7px, /* bottom SD */
    inset hsla(0,0%,100%,.7) 1px  1px 1px 7px, /* top HL */
    
    hsla(0,0%, 0%,.15) 0 -5px 6px 4px, /* outer SD */
    hsla(0,0%,100%,.5) 0  1px 4px 4px; /* outer HL */ 
  
  transition: color .2s;
}

/* Linear ------------------------- */

.metal1.linear {
  width: 100px;
  font-size: 1em;
  height: 80px;
  border-radius: .5em;

}


/* active ------------------------- */

.hoverB:active {
  color: hsl(210, 100%, 40%);
  text-shadow: hsla(210,100%,20%,.3) 0 -1px 0, hsl(210,100%,85%) 0 2px 1px, hsla(200,100%,80%,1) 0 0 5px, hsla(210,100%,50%,.6) 0 0 20px;
  box-shadow: 
    inset hsla(210,100%,30%,  1) 0  0px 0px 4px, /* border */
    inset hsla(210,100%,15%, .4) 0 -1px 5px 4px, /* soft SD */
    inset hsla(210,100%,20%,.25) 0 -1px 0px 7px, /* bottom SD */
    inset hsla(210,100%,100%,.7) 0  2px 1px 7px, /* top HL */
    
    hsla(210,100%,75%, .8) 0  0px 3px 2px, /* outer SD */
    hsla(210,50%,40%, .25) 0 -5px 6px 4px, /* outer SD */
    hsla(210,80%,95%,   1) 0  5px 6px 4px; /* outer HL */
}
.hoverY:active {
  color: hsl(43, 100%, 40%);
  text-shadow: hsla(43,100%,20%,.3) 0 -1px 0, hsl(43,100%,85%) 0 2px 1px, hsla(42,100%,80%,1) 0 0 5px, hsla(43,100%,50%,.6) 0 0 20px;
  box-shadow: 
    inset hsla(43,100%,30%,  1) 0  0px 0px 4px, /* border */
    inset hsla(43,100%,15%, .4) 0 -1px 5px 4px, /* soft SD */
    inset hsla(43,100%,20%,.25) 0 -1px 0px 7px, /* bottom SD */
    inset hsla(43,100%,100%,.7) 0  2px 1px 7px, /* top HL */
    
    hsla(43,100%,75%, .8) 0  0px 3px 2px, /* outer SD */
    hsla(43,50%,40%, .25) 0 -5px 6px 4px, /* outer SD */
    hsla(43,80%,95%,   1) 0  5px 6px 4px; /* outer HL */
}
.hoverR:active {
  color: hsl(0, 100%, 40%);
  text-shadow: hsla(0,100%,20%,.3) 0 -1px 0, hsl(0,100%,85%) 0 2px 1px, hsla(0,100%,80%,1) 0 0 5px, hsla(0,100%,50%,.6) 0 0 20px;
  box-shadow: 
    inset hsla(0,100%,30%,  1) 0  0px 0px 4px, /* border */
    inset hsla(0,100%,15%, .4) 0 -1px 5px 4px, /* soft SD */
    inset hsla(0,100%,20%,.25) 0 -1px 0px 7px, /* bottom SD */
    inset hsla(0,100%,100%,.7) 0  2px 1px 7px, /* top HL */
    
    hsla(0,100%,75%, .8) 0  0px 3px 2px, /* outer SD */
    hsla(0,50%,40%, .25) 0 -5px 6px 4px, /* outer SD */
    hsla(0,80%,95%,   1) 0  5px 6px 4px; /* outer HL */
}
</style>