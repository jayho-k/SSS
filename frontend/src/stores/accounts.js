import { defineStore } from 'pinia'
import axios from "axios";
import SGSS from '@/api/SGSS';
import router from '@/router';

export const useAccounts = defineStore({
    id: 'accounts',
    state: () => ({
      token: localStorage.getItem('token') || '' ,
      
      currentUser: {},
      profile: {},
      authError: null,
      activate_user: [],
      deactivate_user: [],

    }),
    getters: {
      isLoggedIn: state => !!state.token,
      authHeader: state => ({ Authorization: `Bearer ${state.token}`}),
    },
    actions: {
      refreshToken(){

      },
      removeToken() {
        localStorage.setItem('token', '')
        this.currentUser = {}
        window.location.reload()
      },
      fetchCurrentUser() {
        if (this.isLoggedIn) {
          axios.get(SGSS.accounts.userManage(), {
            headers: this.authHeader
            // headers: {
            //   Authorization : `Bearer ${this.token}`
            // }
          })
            .then(res => {
              this.currentUser = res.data
            })
            .catch(err => {
              if (err.response.status === 401) {
                this.removeToken()
              }
            })
          }
        },
        login(credential) {
          console.log(credential)
          axios.post(SGSS.accounts.login(), credential)
          .then(res => {
            console.log(res.data)
            localStorage.setItem('token', res.data.access)
            this.token = res.data.access
            this.fetchCurrentUser()
            if (res.data.is_admin) {
              // 관리자 페이지
              router.push({name : 'accountManage'})
            } else {
              // 메인페이지
              router.push({name : 'cctv'})
            }
          })
          .catch(err => {
            console.error(err.data)
          })
      },
      signup(credential) {
        console.log(credential)
        axios.post(SGSS.accounts.signup(), credential)
        // axios({
        //   url:SGSS.accounts.signup(),
        //   method: 'post',
        //   data: credential
        // })
          .then(res => {
            console.log(res);
          })
          .catch(err => {
            console.error(err.data)
          })
      },
      activateList(){
        axios.get(SGSS.managerLogin.activateList(), {headers: this.authHeader})
        .then(res => {
          this.activate_user = res.data 
          console.log(this.activate_user)
        })
        .catch(err => {
          console.error(err.data)
        })
      },
      deactivateList(){
        axios.get(SGSS.managerLogin.deactivateList(), {headers: this.authHeader})
        .then(res => {
          this.deactivate_user = res.data
        })
        .catch(() => {
          console.log('asdf')
          // console.error(err.data)
        })
      },
      searchUser(name){
        const token = localStorage.getItem('token')
        axios.post(
          SGSS.managerLogin.searchUser(),
          {search: name}, 
          {headers: { Authorization: `Bearer ${token}`}}
          ) .then((res) =>
          console.log(res)
          ) .catch((err) => 
          console.log(err))
      }
    }
  })