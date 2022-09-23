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
          }) .then(res => {
              this.currentUser = res.data
          }) .catch(err => {
              if (err.response.status === 401) {
                this.removeToken()
              }
          })
        }
      },
      // asdfsdf
      login(credential) {

        // axios({
        //   url:SGSS.accounts.login(),
        //   method: 'post',
        //   data: credential
        // })

        axios.post(SGSS.accounts.login(), credential)
        .then(res => {
          localStorage.setItem('token', res.data.access)
          this.token = res.data.access
          this.fetchCurrentUser()
          if (res.data.is_admin) {
            // 관리자 페이지
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
    }
  })