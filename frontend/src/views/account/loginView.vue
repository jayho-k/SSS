<template>
  <div class="modal" id="login-modal">
    <div class="modal-content">
      <div class="modal-content-left"></div>
      <div class="modal-content-right">
        <div @click="$emit('loginClose')" class="close-btn">&times;</div>
        <form
          @submit.prevent="checklogin()"
          class="modal-form"
          id="form"
        >
          <h1 class="font-weight-bold">로그인</h1>
          <div class="form-validation">
            <input
              v-model="credential.username"
              type="text"
              class="modal-input"
              id="name"
              name="name"
              placeholder="아이디를 입력하세요"
            />
            <p v-if="isError">{{ errorMsg }}</p>
          </div>
          <div class="form-validation">
            <input
              v-model="credential.password"
              type="password"
              class="modal-input"
              id="password1"
              name="password"
              placeholder="비밀번호를 입력하세요"
            />
            <p v-if="isPwError">{{errorMsg}}</p>
          </div>
          <input type="submit" class="modal-input-btn" value="로그인" />
          <button @click="login.logout()">로그아웃</button>
          <!-- <div
            @click="login.login(credential)"
            style="border: none; cursor: pointer"
            class="my-2"
          >
            회원가입
          </div> -->
          <!-- <router-link></router-link> -->
          <!-- <div class="modal-findIdPwBtn">
            <div class="overlay" @click="$emit('close-modal')"></div>
            <div class="modal-card">
              <slot name="body">
                관리자에게 문의 부탁드립니다.<br>
                Tel : 042-123-4567
              </slot>
            </div>
            <footer class="modal-footer">
              <slot name="footer">
                <button @click="$emit('close')">Close</button>
              </slot>
            </footer>
          </div> -->
        </form>
        <router-link to="/signup">회원가입</router-link>
      </div>
    </div>
  </div>
</template>

<script>
import { useAccounts } from "@/stores/accounts";
import { ref } from "vue"
export default {
  name: "LoginView",
  components: {},

  setup() {
    const login = useAccounts();
    const isError = ref(false)
    const errorMsg = ref('')
    const credential = ref({
      username: "",
      password: "",
    })

    function checklogin () {
      if(credential.value.username === "") {
        isError.value = true
        errorMsg.value = "아이디를 입력해주세요"
      } else if (credential.value.password === "") {
        isError.value = true
        errorMsg.value = "비밀번호를 입력해주세요"
      } else {
        console.log(credential)
        login.login(credential.value)
      }
    }
    function checkPassword(){
      // 특수문자, 몇글자 등등
    }
    return {
      login,
      credential,
      isError,
      errorMsg,
      checklogin,
      checkPassword
    }
  },
  methods: {},
};
</script>

<style>
  /* .modal{
    background-image: url("@/assets/account/background.png");
    background-size: cover;
  } */
  body {
    background-image: url("@/assets/account/background.png");
    background-size: cover;
  }
  /* Modal */
  .modal-findIdPwBtn,
  .overlay{
    width : 100%;
    height: 100%;
    position: fixed;
    left: 0;
    top: 0;
  }
  .overlay{
    opacity: 0.5;
    background-color: black;
  }
  .modal-card{
    position: relative;
    max-width: 30%;
    margin: auto;
    padding: 20px;
    background-color: white;
    z-index: 10;
    opacity: 1;
  }
</style>