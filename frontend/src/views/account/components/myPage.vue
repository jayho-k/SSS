<template>
  <div class="profile">
    <!-- <div>아이디 : {{ account.profile.username }}</div> -->
    <div class="name" >이름 : {{ account.profile.name }}</div>
    <div class="my_info">소속 : {{ account.profile.department }}</div>
    <div class="my_info">이메일 : {{ account.profile.email }}</div>
    <div class="my_info">전화번호 : {{ account.profile.phone_number }}</div>

  </div>
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
.name {
  margin:auto;
  margin-top: 12px;
  margin-bottom: 20px;
}
.my_info {
  position: relative;
  margin-right: auto;
  margin: 10px;
  text-align: left;
}
.profile {
  display: block;
  
}
</style>