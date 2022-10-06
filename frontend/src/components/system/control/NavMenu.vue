<template>
  <div class="NavMenuBox navMetal">
    <div class="mia_modal" v-if="miaStore.is_mia_img_modal"><img class="mia_modal_img"  :src="`${serverURL}${miaStore.modal_mia_img}`"><span @click="toggle_modal" class="material-symbols-outlined closeButton">
close
</span></div>
    <router-link class="cursor navItem" to="/cctv"><span class="material-symbols-outlined">photo_camera</span></router-link>
    <router-link class="cursor navItem" to="/upload"><span class="material-symbols-outlined">drive_folder_upload</span></router-link>
    <a class="cursor navItem" @click="isModalViewed=true"><span class="material-symbols-outlined">badge</span></a>
    <div class="cursor navItem" @click="accountStore.logout"><span class="material-symbols-outlined">logout</span></div>
  </div>
  <ModalView v-if="isModalViewed" @close-modal="isModalViewed=false">
    <myPage />
  </ModalView>

</template>

<script>
import ModalView from '@/views/account/components/ModalView.vue'
import myPage from '@/views/account/components/myPage.vue'
import { useAccounts } from '@/stores/accounts'
import { useMiaStore } from '@/stores/mia'
import { ref } from 'vue'
export default {
  components: {
    ModalView,
    myPage
  },
  setup() {
    const serverURL = process.env.VUE_APP_VIDEO_API

    const isModalViewed = ref(false)
    const accountStore = useAccounts()
    const miaStore = useMiaStore()
    const account = useAccounts()

    account.fetchCurrentUser()
    miaStore.modal_mia_img
    function toggle_modal () {
      miaStore.is_mia_img_modal =false
    }
    return {
      serverURL,
      accountStore,
      account,
      isModalViewed,
      miaStore,
      toggle_modal,

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
    inset rgba(0, 0, 0, 0.8) 0 -1px 5px 4px, /* soft SD */
    inset rgba(0, 0, 0, 0.25) 0 -1px 0px 7px, /* bottom SD */
    inset hsla(0,0%,100%,.7) 0  2px 1px 7px, /* top HL */
    
    hsla(0,0%, 0%,.15) 0 -2px 4px 4px, /* outer SD */
    hsla(0,0%,100%,.5) 0  1px 4px 4px; /* outer HL */ 
  
  transition: color .2s;
}

.cursor:hover {
  cursor: pointer;
}
.mia_modal {
  position: absolute;
  border: 5px inset red;
  width: 276px;
  right:10px;
  top: 20px;
  height: 360px;
  background: #FFF;
  z-index: 150;
}
.mia_modal_img {
  width: 100%;
  height: 100%;
  background-size: cover;
}
.closeButton {
  position: absolute;
  right: 20px;
  top: 20px;
  color: black;
}
.closeButton:hover {
  color: var(--sweet-red);
}
</style>