import { defineStore } from 'pinia'
import axios from "axios";
import SGSS from '@/api/SGSS';
import router from '@/router';

export const manageAccounts = defineStore({
    id: 'accounts',
    state: () => ({
      token: localStorage.getItem('token') || '' ,
      
      currentUser: {},
      profile: {},
      authError: null,
      user_list_mode: 1, //activate, deactivate, serah 순으로 123
      activate_users: [],
      deactivate_users: [],
      search_users: [],
    }),
    getters: {
      isLoggedIn: state => !!state.token,
      authHeader: state => ({ Authorization: `Bearer ${state.token}`}),
    },
    actions: {
      refreshToken(){
        const refresh = localStorage.getItem('refresh')
        // console.log(refresh)
        axios.post(SGSS.accounts.reissuance(), 
        {
             refresh: refresh 
        }) .then ((res) => {
            // console.log(res.data.access)
            localStorage.setItem('token', res.data.access)
        }) .catch ((err) => {
            console.log(err)
        })

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
      logout(){
        const token = localStorage.getItem('token')
        axios.post(
          SGSS.accounts.logout(),
          {headers: {Authorization : 'Bearer ' + token}}
        ) .then((res) => {
          localStorage.removeItem('token')
          localStorage.removeItem('refresh')
          this.currentUser = {}
          console.log(res)}
        ) .then(
            router.push({name : 'login'})
        ) .catch((err) => {
          console.log(err)}
        )
        router.push({name : 'login'})
      },
      activateList(){
        axios.get(
          SGSS.managerLogin.activateList(), {headers: this.authHeader}
          ).then(res => {
          this.activate_users = res.data 
          console.log(this.activate_users)
        })
        .catch(err => {
          if(err.response.status === 500){
            this.refreshToken()
        }
        })
      },
      deactivateList(){
        axios.get(
          SGSS.managerLogin.deactivateList(), {headers: this.authHeader}
          ).then(res => {
          this.deactivate_users = res.data
          }).catch((err) => {
            if(err.response.status === 500){
                this.refreshToken()
            }
          })
      },
      searchUser(name){
        const token = localStorage.getItem('token')
        axios.post(
          SGSS.managerLogin.searchUser(),
          {search: name}, 
          {headers: { Authorization: `Bearer ${token}`}}
        ) .then((res) => {
          this.search_users = res.data
        }) .catch((err) => {
            if(err.response.status === 500){
                this.refreshToken()
            }
        }) 
          
      },
      changePassword(){
        
        const token = localStorage.getItem('token')
        axios.put(SGSS.managerLogin.passwordChange(), 
        {headers: {Authorization : 'Bearer ' + token}}
        ).catch((err) => {
            if(err.response.status === 500){
                this.refreshToken()
            }
        }) 

      },
      deleteAccount(uid){
        const userId = uid
        const token = localStorage.getItem('token')
        axios.delete(SGSS.accounts.deleteAccount(), 
        {
            headers: {Authorization : 'Bearer ' + token},
            data:userId
        }).catch((err) => {
            if(err.response.status === 500){
                this.refreshToken()
            }
        }) 
      },
      userActviate(uid){
        const userId = uid
        const token = localStorage.getItem('token')
        // console.log(userId)
        axios.patch(SGSS.managerLogin.approveSignup(), 
        
            {'uid': userId},
            {headers: {Authorization : 'Bearer ' + token}}
        ).catch((err) => {
            if(err.response.status === 500){
                this.refreshToken()
            }
        }) 
      }

      
    }
})