<template>
  <div class="modal" id="login-modal">
    <div class="modal-content">
      <!-- 아이디 찾기 -->
      <div class="findIdBox centerBox">
        <div>
          <input type="text" v-model="findIdData.name">
        </div>
        <div>
          <input type="email" v-model="findIdData.email">
        </div>
        <div class="findIdBotton">아이디 찾기</div>
      </div>

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
            <div v-if="isError">{{ errorMsg }}</div>
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
            <div v-if="isPwError">{{errorPwMsg}}</div>
          </div>
          <input type="submit" class="modal-input-btn" value="로그인" />
          <div @click="findId">아이디 찾기</div>
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
      isPwError,
      errorPwMsg,
      errorMsg,
      findIdData,
      checklogin,
      checkPassword,
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
  input { 

-webkit-appearance : none;

-moz-appearance:none;

appearance:none;

}


</style>