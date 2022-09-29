<template>
  <div class="RevisionMenuBox">

    <button class="metalBtn hoverB linearBtn" @click="add"><span class="material-symbols-outlined">add_location_alt</span></button>
    <button class="metalBtn hoverR linearBtn" @click="del"><span class="material-symbols-outlined">delete</span></button>
  </div>
</template>

<script>
import { useKakaoStore } from '@/stores/kakaoMap';
export default {
  setup() {
    const store = useKakaoStore()
    function add (e) {
      e.target.classList.toggle('activeB')
      e.target.classList.toggle('clickB')
      store.cctv_mode = 1
    
    }
    function del (e) {
      e.target.classList.toggle('activeR')
      e.target.classList.toggle('clickR')
      if (store.mode === 3) {
        store.cctv_mode = 2}
      else {
        store.cctv_mode = 2
      }
    }
    function save () {
      store.saveMarkers()
    }
    return {
      add,
      del,
      save
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
    inset hsla(0,100%,100%,.7) 0  2px 1px 12px, /* top HL */
    
    hsla(0,100%,75%, .8) 0  0px 1px 1px, /* outer SD */
    hsla(0,80%,95%,   1) 0  5px 6px 4px; /* outer HL */
}

.clickB {
  color: hsl(210, 100%, 40%);
  text-shadow: hsla(210,100%,20%,.3) 0 -1px 0, hsl(210,100%,85%) 0 2px 1px, hsla(200,100%,80%,1) 0 0 5px, hsla(210,100%,50%,.6) 0 0 20px;

}
.clickY {
  color: hsl(43, 100%, 40%);
  text-shadow: hsla(43,100%,20%,.3) 0 -1px 0, hsl(43,100%,85%) 0 2px 1px, hsla(42,100%,80%,1) 0 0 5px, hsla(43,100%,50%,.6) 0 0 20px;
  box-shadow: 
    inset hsla(43,100%,30%,  1) 0  0px 0px 4px, /* border */
    inset hsla(43,100%,100%,.7) 0  2px 1px 7px, /* top HL */
    
    hsla(43,100%,75%, .8) 0  0px 3px 2px, /* outer SD */
    hsla(43,80%,95%,   1) 0  5px 6px 4px; /* outer HL */
}
.clickR {
  color: hsl(0, 61%, 71%);

  box-shadow: 
    inset rgb(247, 185, 185) 0  0px 0px 4px, /* border */
    inset hsla(0,100%,100%,.7) 0  2px 1px 12px, /* top HL */
    
    hsla(0,100%,75%, .8) 0  0px 3px 2px, /* outer SD */
    hsla(0,80%,95%,   1) 0  5px 6px 4px; /* outer HL */
}
</style>