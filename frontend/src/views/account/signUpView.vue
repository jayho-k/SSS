<template>
  <div class="modal" id="email-modal">
    <div class="sign-content">
      <div class="modal-content-right">
        <form id="form" @submit.prevent="signup.signup(credential)" class="modal-form">
          <h1 class="font-weight-bold">회원가입</h1>
          <div >
            <input v-model="credential.username" type="text" class="modal-input-sign form-validation" name="userId" id="userId" placeholder="아이디" required>
          </div>
          <div >
            <input v-model="credential.password" type="text" class="modal-input-sign form-validation" name="userPassword" id="userPassword" placeholder="비밀번호" required>
          </div>
          <div >
            <input v-model="credential.department" type="text" class="modal-input-sign form-validation" name="corpName" id="corpName" placeholder="기관/소속명" required>
          </div>
          <div >
            <input v-model="credential.phone_number" type="tel" class="modal-input-sign form-validation" id="telNumber" name="telNumber" placeholder="전화번호">
          </div>
          <div >
            <input v-model="credential.email" @keyup="emailValid" type="email" class="modal-input-sign form-validation" id="email" name="email" placeholder="이메일">
          </div>
          <div >
            <input v-model="credential.name" type="text" class="modal-input-sign form-validation" id="managerName" name="managerName" placeholder="관리자명">
          </div>
          <input type="submit" class="back-btn" value="Sign up">
        </form>
        <button class="back-btn" @click="()=>$router.push({name:'login'})" >Cancel</button>
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
};
</script>

<style>
  .font-weight-bold{
    color: #000000;
  }
  body {
    background-color: #000000;
    background-image: url("@/assets/account/background.png");
    background-size: cover;
  }
  .form-validation {
    border: 3px solid rgba(87, 55, 18, 0.6);
    font-size: 16px;
  }
  .sign-content {
    position: absolute;
    width: 600px;
    height: 660px;
    top: calc(50% - 330px);
    left: calc(50% - 300px);
    border: 3px;
    background-color: rgba( 255, 255, 255, 0.2 );
    border-radius: 15px;
    transition: all 1s;
  }
  .modal-input-sign { 
    margin: 15px 30px;
    border-radius: 5px;
    height: 30px;
    width: 300px;
  }
  .modal-input-sign::placeholder {
    text-align: center;
  }
  .back-btn{
    margin: 15px;
    width: 300px;
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
</style>