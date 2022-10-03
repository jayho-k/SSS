<template>
  <div class="NavMenuBox navMetal">
    <router-link class="cursor navItem" to="/cctv" v-if="accountStore.is_nav_mode">CCTV</router-link>
    <router-link class="cursor navItem" to="/upload" v-if="accountStore.is_nav_mode">UPLOAD</router-link>
    <router-link class="cursor navItem" to="/upload" v-if="!accountStore.is_nav_mode">MY</router-link>
    <div class="cursor navItem" @click="accountStore.logout" v-if="!accountStore.is_nav_mode">LOGOUT</div>
    <!-- <img class="navMenu cursor" src="@/assets/optionIcon.png" alt="옵션" @click="toggle_mode"> -->
    <span v-if="accountStore.is_nav_mode" @click="toggle_mode" class=" navMenu cursor material-symbols-outlined">arrow_back_ios</span>
    <span  v-if="!accountStore.is_nav_mode" @click="toggle_mode" class="navMenu cursor material-symbols-outlined">
arrow_forward_ios
</span>
  </div>
</template>

<script>
import { useAccounts } from '@/stores/accounts'
export default {
  setup() {
    const accountStore = useAccounts()
    function toggle_mode() {
      accountStore.is_nav_mode = !accountStore.is_nav_mode 

    }

    return {
      accountStore,
      toggle_mode,
    }
  }
}
</script>

<style scoped>
.NavMenuBox {
  display: flex;
  width: 260px;
  height: 60px;
  background-color: var(--main-color2);
  border-radius: 5px;
  align-items: center;
}
.navItem {
  width: 100px;
}
.navMenu {
  margin-left: 12px;
  width: 28px;
  height: 28px;
}


.navMetal {

  text-align: center;
  color: hsla(0,0%,20%,1);
  text-shadow: hsla(0,0%,40%,.5) 0 -1px 0, hsla(0,0%,100%,.6) 0 2px 1px;
  
  background-color: hsl(0,0%,90%);
  box-shadow: inset hsla(0,0%,15%,  1) 0  0px 0px 4px, /* border */
    inset hsla(0,0%,15%, .8) 0 -1px 5px 4px, /* soft SD */
    inset hsla(0,0%,0%, .25) 0 -1px 0px 7px, /* bottom SD */
    inset hsla(0,0%,100%,.7) 0  2px 1px 7px, /* top HL */
    
    hsla(0,0%, 0%,.15) 0 -2px 4px 4px, /* outer SD */
    hsla(0,0%,100%,.5) 0  1px 4px 4px; /* outer HL */ 
  
  transition: color .2s;
}

.cursor:hover {
  cursor: pointer;
}
</style>