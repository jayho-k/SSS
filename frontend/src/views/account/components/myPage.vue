<template>
  <div class="profile">
    <div>아이디 : {{ account.profile.username }}</div>
    <div>이름 : {{ account.profile.name }}</div>
    <div>이메일 : {{ account.profile.email }}</div>
    <div>전화번호 : {{ account.profile.phone_number }}</div>
    <div>소속 : {{ account.profile.department }}</div>
  </div>
  <router-link to="/cctv">back</router-link>
</template>

<script>
import { useAccounts } from "@/stores/accounts";
import {  ref } from "vue"
export default {
  setup() {
    const account = ref(useAccounts())
    account.value.fetchCurrentUser()

    return {
      account,
    }
  }
}
</script>

<style>
.profile {
  
}
</style>