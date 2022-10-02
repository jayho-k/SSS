<template>
  <div>
    <div class="header">
      <h1>회원관리</h1>
      <div class="search">
                <div>
                    <input type="text" placeholder=" 이름으로 검색 " v-model="search" @keypress.enter="searchUser">
                </div>
            </div>
      <button @click="myPage" class="myPage" id="myPage">마이페이지</button>
      
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

          </tr>
          <!-- acti -->

            <tr v-for="(user, index) in store.activate_users"
            :key="user.id">

              <td v-show="store.user_list_mode === 1">{{user.name}}</td>

              <td v-show="store.user_list_mode === 1">{{user.department}}</td>
              <td v-show="store.user_list_mode === 1">{{user.phone_number}}</td>
              <td v-show="store.user_list_mode === 1">{{user.email}}</td>
              <td v-show="store.user_list_mode === 1">{{user.id}}</td>
              <div class="button_td">
                <td  v-show="store.user_list_mode === 1">
                  <!-- <button @click="changePassword(index)" class="changePassword" id="changePassword">비밀번호 변경</button> -->
                  <button @click="ismModalViewed = true" class="changePassword" id="changePassword">비밀번호 변경</button>
                </td>
                <td v-show="store.user_list_mode === 1">
                  <button @click="deleteAccount(index)" class="deleteAccount" id="deleteAccount">삭제</button>
                </td>
              </div>
            </tr>

          <!-- deacti -->

            <tr v-for="(user, index) in store.deactivate_users"
            :key="user.id">
              <td v-show="store.user_list_mode === 2">{{user.name}}</td>
              <!-- <td>asdf</td> -->
              <td v-show="store.user_list_mode === 2">{{user.department}}</td>
              <td v-show="store.user_list_mode === 2">{{user.phone_number}}</td>
              <td v-show="store.user_list_mode === 2">{{user.email}}</td>
              <td v-show="store.user_list_mode === 2">{{user.id}}</td>
              <div class="button_td">
                <td v-show="store.user_list_mode === 2">
                  <button @click="activate(index)" class="activate" id="activate">사용자 활성화</button>
                </td>
                <td v-show="store.user_list_mode === 2">
                  <button @click="deleteAccount(index)" class="deleteAccount" id="deleteAccount">삭제</button>
                </td>
              </div>
              <div>

              </div>
            </tr>
          
          <tr v-for="(user, index) in store.search_users"
          :key="user.id">
            <td v-show="store.user_list_mode === 3">{{user.name}}</td>
            <!-- <td>asdf</td> -->
            <td v-show="store.user_list_mode === 3">{{user.department}}</td>
            <td v-show="store.user_list_mode === 3">{{user.phone_number}}</td>
            <td v-show="store.user_list_mode === 3">{{user.email}}</td>
            <td v-show="store.user_list_mode === 3">{{user.id}}</td>
            <div class="button_td">
              <td v-show="store.user_list_mode === 3">
                <!-- <button @click="changePassword(index)" class="changePassword" id="changePassword">비밀번호 변경</button> -->
                <button @click="ismModalViewed = true" class="changePassword" id="changePassword">비밀번호 변경</button>
              </td>
              <td v-show="store.user_list_mode === 3">
                <button @click="deleteAccount(index)" class="deleteAccount" id="deleteAccount">삭제</button>
              </td>
            </div>
          </tr>


        </table>
      </div>
    </div>
</template>


<script>
import { useAccounts } from "@/stores/accounts";
import { ref } from "vue"
import router from '@/router';
  export default {
    name:'manageTable',
    components: {},
    setup () {
      const store = useAccounts()
      console.log(store)
      
        store.activateList(),
        store.deactivateList()
      



      const toggle_box = ref(true)
      function changeList () {
        if (toggle_box.value === true){
          store.user_list_mode = 1
        } else {
          store.user_list_mode = 2
        }
      }
      const search = ref('')
      function searchUser(){
        store.user_list_mode = 3
        store.searchUser(search.value)
      }
      
      // function deleteAccount(idx){
      //   if(userData.value.length > 0 ){
      //      console.log(userData.value[idx]['id'])
      //     userData.value.splice(idx, 1)
         
      //     store.deleteAccount(userData.value[idx]['id'])
      //   }else{
      //     console.log(userData.value)
      //   }
      // }
      // function activate(idx){
      //   console.log(userData.value[idx]['id'])
      //   store.userActviate(userData.value[idx]['id'])
      // }
      // function changePassword(idx){
      //   router
      //   store.changePassword(userData.value[idx]['id'])
      // }
      function myPage(){
        router.push({name : 'myPage'})
      }

      
      
      return {
        store,
        toggle_box,
        search,
        changeList,
        searchUser,
        myPage,
      }
    }
  }

</script>

<style>
/* table style */
  table {
    border-collapse: collapse;
    width: 100%;
    min-width: 1280px;
  }

  th, td {
    text-align: center;
    padding: 8px;
  }

  tr:nth-child(even){background-color: #cccccc}

  tr:nth-child(odd){background-color: #fff}

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
  .button_td {
    display: flex;
    justify-content: center;
  }
  .toggle-switch {
    display: inline-block;
    background: #ccc;
    border-radius: 16px;
    width: 54px;
    height: 28px;
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
    width: 20px;
    height: 20px;
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
        width:200px;
        height:25px;
        border-radius:25px;
        border: 2px solid #000;
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
    body {
    background-color: #000000;
    background-image: url("@/assets/account/background.png");
    background-size: cover;
  }


</style>
