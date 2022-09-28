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
      search_users: [],
    }),
    getters: {
      isLoggedIn: state => !!state.token,
      authHeader: state => ({ Authorization: `Bearer ${state.token}`}),
    },
    actions: {
      refreshToken(){

      },
      fetchCurrentUser() {
        if (this.isLoggedIn) {
          axios.get(SGSS.accounts.userManage(), {
            headers: this.authHeader
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
        axios.post(
          SGSS.accounts.login(), 
          credential
        ).then(res => {
          console.log(res.data)
          localStorage.setItem('token', res.data.access)
          localStorage.setItem('refresh', res.data.refresh)
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
      logout(){
        const token = localStorage.getItem('token')
        axios.post(
          SGSS.accounts.logout(),
          {headers: {Authorization : 'Bearer ' + token}}
        ) .then((res) => {
          localStorage.removeItem('token')
          this.currentUser = {}
          console.log(res)}
        ) .catch((err) => {
          console.log(err)}
        )
        router.push({name : 'login'})
      },
      signup(credential) {
        console.log(credential)
        axios.post(
          SGSS.accounts.signup(), credential
          ).then(res => {
            console.log(res);
          })
          .catch(err => {
            console.error(err.data)
          })
      },
      
    }
})