<template>
  <div class="modal" id="login-modal">
    <div class="modal-content">
      <!-- 아이디 찾기 -->
      <!-- <div class="findIdBox centerBox">
        <div>
          <input type="text" v-model="findIdData.name">
        </div>
        <div>
          <input type="email" v-model="findIdData.email">
        </div>
        <div class="findIdBotton">아이디 찾기</div>
      </div> -->

      <div class="loginBox">
        <form
          @submit.prevent="checklogin()"
          class="modal-form"
          id="form"
        >
          <h1 class="font-weight-bold">로그인</h1>
          <div class="">
            <input
              v-model="credential.username"
              type="text"
              class="modal-input form-validation"
              id="name"
              name="name"
              placeholder="아이디를 입력하세요"
            />
            <div v-if="isError" style="color: red;">{{ errorMsg }}</div>
          </div>
          <div class="">
            <input
              v-model="credential.password"
              type="password"
              class="modal-input form-validation"
              id="password1"
              name="password"
              placeholder="비밀번호를 입력하세요"
            />
            <div v-if="isPwError" style="color: red;">{{errorPwMsg}}</div>
          </div>
          <input type="submit" class="modal-input-btn" value="로그인" />
        </form>
        <button @click="signup()" class="sign-btn">회원가입</button>
      </div>
    </div>
  </div>
</template>

<script>
import { useAccounts } from "@/stores/accounts";
import { ref } from "vue"
import router from '@/router';
export default {
  name: "LoginView",
  components: {},

  setup() {
    const login = useAccounts();
    const isError = ref(false)
    const isPwError = ref(false)
    const errorMsg = ref('')
    const errorPwMsg = ref('')
    const credential = ref({
      username: "",
      password: "",
    })
    const findIdData = {
      name: '',
      email: '',
    }

    function checklogin () {
      if(credential.value.username === "") {
        isError.value = true
        errorMsg.value = "아이디를 입력해주세요"
      } else if (credential.value.password === "") {
        isPwError.value = true
        errorPwMsg.value = "비밀번호를 입력해주세요"
      } else {
        login.login(credential.value)
      }
    }
    function signup() {
      router.push({name:"signup"})
    }
    return {
      login,
      credential,
      isError,
      isPwError,
      errorPwMsg,
      errorMsg,
      findIdData,
      checklogin,
      signup
    }
  },
  methods: {},
};
</script>

<style>
  .centerBox {
    position: absolute;
    width: 400px;
    height: 400px;
    top: calc(50% - 200px);
    left: calc(50% - 200px);
    border: 3px;
    background-color: rgba( 255, 255, 255, 0.2 );
    border-radius: 15px;
    transition: all 1s;
  }
  .modal-input-btn{
    margin: 15px;
    width: 210px;
    height: 30px;
    background: radial-gradient(95% 60% at 50% 75%, #005FD6 0%, #209BFF 100%);
    border: 1px solid #54A1FD;
    box-shadow: 0px 8px 20px -8px #1187FF, inset 0px 1px 8px -4px #FFFFFF;
    border-radius: 10px;
    color: white;
    font-size: 16px;
    line-height: 22px;
    font-weight: 600;
    letter-spacing: .02em;
    transition: all .2s ease;
    -webkit-tap-highlight-color: rgba(255,255,255,0);
  }
  .sign-btn{
    margin: 15px;
    width: 210px;
    height: 30px;
    background: radial-gradient(95% 60% at 50% 75%, #005FD6 0%, #209BFF 100%);
    border: 1px solid #54A1FD;
    box-shadow: 0px 8px 20px -8px #1187FF, inset 0px 1px 8px -4px #FFFFFF;
    border-radius: 10px;
    color: white;
    font-size: 16px;
    line-height: 22px;
    font-weight: 600;
    letter-spacing: .02em;
    transition: all .2s ease;
    -webkit-tap-highlight-color: rgba(255,255,255,0);
  }
  .loginBox {
    position: absolute;
    width: 400px;
    height: 400px;
    top: calc(50% - 200px);
    left: calc(50% - 200px);
    border: 3px;
    background-color: rgba( 255, 255, 255, 0.2 );
    border-radius: 15px;
    transition: all 1s;
  }
  .centerBox:hover {
    width: 400px;
    height: 400px;
    top: calc(50% - 200px);
    left: 50%;
    border: 3px solid white;
    background-color: white;
    border-radius: 15px;

  }

  .form-validation {
    border: 3px solid rgba(87, 55, 18, 0.6);
    font-size: 16px;
  }
  .findIdBox {
    width: 200px;
    height: 400px;
    top: calc(50% - 200px);
    left: calc(50% - 200px);
    border: 3px solid white;
    background-color: white;
    border-radius: 15px;

  }
  .findIdBox:before {
  content: "«";
  color: blue;
  }
  body {
    background-color: #000000;
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
  .modal-input { 
    margin: 15px 30px;
    border-radius: 5px;
    height: 30px;
  }
  .modal-input::placeholder {
    text-align: center;
  }
  .gosign {
    color: black;
  }

  .font-weight-bold {
    color: #000000;
  }
</style>