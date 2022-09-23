<template>
  <div class="NavMenuBox metal">
    <router-link to="/cctv" @click="change_view(0)">cctv</router-link>
    <router-link to="/upload" @click="change_view(2)">upload</router-link>
    <img class="navMenu" src="@/assets/optionIcon.png" alt="옵션">
  </div>
</template>

<script>
import { useIndexStore } from '@/stores/index'
export default {
  setup() {
    const IndexStore = useIndexStore()
    function change_view (inx) {
      IndexStore.view_case = inx
      console.log(IndexStore.view_case)
    }
    return {
      IndexStore,
      change_view
    }
  }
}
</script>

<style>
.NavMenuBox {
  display: flex;
  width: var(--controller-width);
  height: 60px;
  background-color: var(--main-color2);
  border-radius: 5px;
  justify-content: space-around;
  align-items: center;
}
.navMenu {
  width: 33px;
  height: 33px;
}

.metal {

  text-align: center;
  color: hsla(0,0%,20%,1);
  text-shadow: hsla(0,0%,40%,.5) 0 -1px 0, hsla(0,0%,100%,.6) 0 2px 1px;
  
  background-color: hsl(0,0%,90%);
  box-shadow: inset hsla(0,0%,15%,  1) 0  0px 0px 4px, /* border */
    inset hsla(0,0%,15%, .8) 0 -1px 5px 4px, /* soft SD */
    inset hsla(0,0%,0%, .25) 0 -1px 0px 7px, /* bottom SD */
    inset hsla(0,0%,100%,.7) 0  2px 1px 7px, /* top HL */
    
    hsla(0,0%, 0%,.15) 0 -5px 6px 4px, /* outer SD */
    hsla(0,0%,100%,.5) 0  5px 6px 4px; /* outer HL */ 
  
  transition: color .2s;
}
.metal.linear {
  width: 100px;
  font-size: 0.5em;
  height: 80px;
  border-radius: .5em;

}
</style>