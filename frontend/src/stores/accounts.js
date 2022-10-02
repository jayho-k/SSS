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


      is_nav_mode: true,
    
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
          '',
          {headers: {Authorization : 'Bearer ' + token}}
        ) .then((res) => {
          localStorage.removeItem('token')
          localStorage.removeItem('refresh')
          this.currentUser = {}
          console.log(res)
          router.push({name : 'login'})
        }
        ) .catch((err) => {
          console.log(err)
          console.log(token)
        }
        )

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

      refreshToken(){
        const refresh = localStorage.getItem('refresh')

        axios.post(SGSS.accounts.reissuance(), 
        {
             refresh: refresh 
        }) .then ((res) => {

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
      activateList () {
        const token = localStorage.getItem('token')
        axios.get(
          SGSS.managerLogin.activateList(), {headers: {Authorization : 'Bearer ' + token}}
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
        const token = localStorage.getItem('token')
        axios.get(
          SGSS.managerLogin.deactivateList(), {headers: {Authorization : 'Bearer ' + token}}
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
      },
      currentUser() {
        const token = localStorage.getItem('token')
        axios.get(SGSS.accounts.userManage(), {headers: {Authorization : 'Bearer ' + token}})
      },
      findId(data) {
        axios.post(SGSS.accounts.findId(),
        data
        ) . then ((res) => {
          console.log(res)
        })
        .catch ((err) => {
          console.log(err)
        })
      }
    }
})