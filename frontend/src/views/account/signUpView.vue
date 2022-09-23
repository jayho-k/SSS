<template>
  <div class="modal" id="email-modal">
    <div class="modal-content">
      <div class="modal-content-left">
        <!-- <img  id="modal-img" src="@/assets/test.png" alt="모달이미지"> -->
      </div>
      <div class="modal-content-right">
        <form id="form" @submit.prevent="signup.signup(credential)" class="modal-form">
          <h1 class="font-weight-bold">회원가입</h1>
          <div class="form-validation">
            <input v-model="credential.username" type="text" class="modal-input" name="userId" id="userId" placeholder="아이디" required>
          </div>
          <div class="form-validation">
            <input v-model="credential.password" type="text" class="modal-input" name="userPassword" id="userPassword" placeholder="비밀번호" required>
          </div>
          <div class="form-validation">
            <input v-model="credential.department" type="text" class="modal-input" name="corpName" id="corpName" placeholder="기관/소속명" required>
          </div>
          <div class="form-validation">
            <input v-model="credential.phone_number" type="tel" class="modal-input" id="telNumber" name="telNumber" placeholder="전화번호">
            <p class="tel-check">Tel-Number Valid Error</p>
          </div>
          <div class="form-validation">
            <input v-model="credential.email" @keyup="emailValid" type="email" class="modal-input" id="email" name="email" placeholder="이메일">
            <p class="email-check">Email Valid Error</p>
          </div>
          <div class="form-validation">
            <input v-model="credential.name" type="text" class="modal-input" id="managerName" name="managerName" placeholder="관리자명">
          </div>
          <input type="submit" class="modal-input-btn" value="Sign up">
          <!-- <div @click="[$emit('showLogin'), $emit('signupClose')]" style="border: none; cursor: pointer;" class="my-2">로그인</div> -->
        </form>
        <button @click="()=>$router.push('login')" >Cancel</button>
      </div>
    </div>
  </div> 
</template>

<script>
import { useAccounts } from '@/stores/accounts'
import { ref } from 'vue'
export default {
  setup() {
    const credential = ref({
      username: '',
      password: '',
      name: '',
      phone_number: '',
      email: '',
      department: ''
    })
    const signup = useAccounts()
    return {
      signup,
      credential,
    }
  },
  methods: {},
};
</script>

<style>
    body {
    background-image: url("@/assets/account/background.png");
    background-size: cover;
  }
</style>