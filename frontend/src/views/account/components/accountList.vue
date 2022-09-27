<template>
<div class="header">
  <h1>회원관리</h1>
  <div class="search">
            <div>
                <input type="text" placeholder=" 이름 또는 아이디로 검색 " v-model="search">
                <button type="button" @click="searchUser" class="searchButton" id="searchButton">
                    검색
                </button>
            </div>
        </div>
  <button @click="logOutClick" class="logOut" id="logOut">로그아웃</button>
  <button @click="refresh" class="refresh" id="refresh">토큰재발급</button>
</div>

  <div class="table">
    
    <table>
      <tr>
        <th>이름</th>
        <th>기관/기업명</th>
        <th>담당자 번호</th>
        <th>이메일</th>
        <th>아이디</th>
        <th colspan="2">
          <label class="toggle">
            <span class="toggle-label">활성화ID</span>
            &nbsp;
            <input v-model="toggle_box" @change="changeList" class="toggle-checkbox" type="checkbox" id="toggle_box">
            <div class="toggle-switch"></div>
          </label>
        </th>
        <!-- <th>dfdf</th> -->
      </tr>
      <tr v-for="(user, index) in userData"
      :key="user.id">
        <td>{{user.name}}</td>
        <!-- <td>asdf</td> -->
        <td>{{user.department}}</td>
        <td>{{user.phone_number}}</td>
        <td>{{user.email}}</td>
        <td>{{user.id}}</td>
        <td>
          <button @click="resetPassword" class="resetPassword" id="resetPassword">비밀번호 변경</button>
        </td>
        <td>
          <button @click="deleteAccount(index)" class="deleteAccount" id="deleteAccount">삭제</button>
        </td>
      </tr>
    </table>

  </div>

</template>



<script>
import { manageAccounts } from "@/stores/accountManage";
import { ref } from "vue"
import axios from "axios"
import SGSS from '@/api/SGSS';
  export default {
    name:'manageTable',
    async setup () {
      const store = manageAccounts()
      const currentUser = axios.get(SGSS.accounts.userManage, {headers: store.authHeader})
      await axios.get(SGSS.managerLogin.activateList(), {headers: store.authHeader})
        .then(res => {
          store.activate_user = res.data 
          console.log(this.activate_user)
        })
        .catch(() => {
        })
      store.deactivateList()
      const userData = ref(store.activate_user)
      const toggle_box = ref(true)
      function changeList () {
        if (toggle_box.value === true){
          userData.value = store.activate_user
        } else {
          userData.value = store.deactivate_user
        }
      }
      function logOutClick(){
        store.logout()
      }
      const search = ref('')
      function searchUser(){
        store.searchUser(search.value)
        userData.value = store.search_users
        console.log(store.search_users)
      }
      function deleteAccount(idx){
        if(userData.value.length > 0 ){
           console.log(userData.value[idx]['id'])
          userData.value.splice(idx, 1)
         
          store.deleteAccount(userData.value[idx]['id'])
        }else{
          console.log(userData.value)
        }
      }
      function refresh(){
        store.refreshToken()
      }
      return {
        store,
        currentUser,
        userData,
        toggle_box,
        search,
        changeList,
        logOutClick,
        searchUser,
        deleteAccount,
        refresh,
      }
    }
  }

</script>

<style>
/* table style */
  table {
    border-collapse: collapse;
    width: 100%;
  }

  th, td {
    text-align: center;
    padding: 8px;
  }

  tr:nth-child(even){background-color: #cccccc}

  th {
    background-color: #696969;
    color: white;
  }

/* toggle button style */
  *,
  *:before,
  *:after {
    box-sizing: border-box;
  }

  body {
    font-family: -apple-system, ".SFNSText-Regular", "Helvetica Neue", "Roboto", "Segoe UI", sans-serif;
  }

  .toggle {
    cursor: pointer;
    display: inline-block;
  }

  .toggle-switch {
    display: inline-block;
    background: #ccc;
    border-radius: 16px;
    width: 58px;
    height: 32px;
    position: relative;
    vertical-align: middle;
    transition: background 0.25s;
  }
  .toggle-switch:before, .toggle-switch:after {
    content: "";
  }
  .toggle-switch:before {
    display: block;
    background: linear-gradient(to bottom, #fff 0%, #eee 100%);
    border-radius: 50%;
    box-shadow: 0 0 0 1px rgba(0, 0, 0, 0.25);
    width: 24px;
    height: 24px;
    position: absolute;
    top: 4px;
    left: 4px;
    transition: left 0.25s;
  }
  .toggle:hover .toggle-switch:before {
    background: linear-gradient(to bottom, #fff 0%, #fff 100%);
    box-shadow: 0 0 0 1px rgba(0, 0, 0, 0.5);
  }
  .toggle-checkbox:checked + .toggle-switch {
    background: #2c2c2c;
  }
  .toggle-checkbox:checked + .toggle-switch:before {
    left: 30px;
  }

  .toggle-checkbox {
    position: absolute;
    visibility: hidden;
  }

  .toggle-label {
    margin-left: 5px;
    position: relative;
    top: 2px;
  }

  /* search bar style */
    .search input[type=text]{
        width:300px;
        height:25px;
        border-radius:25px;
        border: none;
    }
         
    .search{
        float:right;
        margin:7px;
    }
         
    .searchButton{
        background-color: #0074D9;
        color: #f2f2f2;
        float: right;
        padding: 5px 10px;
        margin-right: 16px;
        font-size: 12px;
        border: none;
        cursor: pointer;
    }

</style>
