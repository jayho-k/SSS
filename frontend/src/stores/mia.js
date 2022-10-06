import axios from "axios";
import SGSS from '@/api/SGSS';
import { defineStore } from "pinia";

export const useMiaStore = defineStore("MiaStore", {
  state: () => {
    const miaData = {
      name:'',
      child_img: {name: '이미지를 추가해 주세요'},
      age: 0,
    }
    return {
      is_alarm_view: false,

      is_add_mia: false,
      mia_list: [],
      mia_update_id: -1,
      miaData,
      mia_list_mode: true //false 는 삭제

    }


  },
  actions: {
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
    getMiaList () {
      const token = localStorage.getItem('token')
      axios.get(
        SGSS.mia.getMiaList(),
        {headers: {Authorization : 'Bearer ' + token}}
      ) .then ((res) => {
        this.mia_list = res.data

      }) .catch ((err) => {
        console.log(err)
				if (err.response.status === 401) {
										this.refreshToken()
          alert('다시 로그인 해주세요')
				}

      })
    },
    setMiaData () {
      const formData = new FormData()
      formData.append("name", this.miaData.name)
      formData.append("child_img", this.miaData.child_img)
      formData.append("age", this.miaData.age)
      const token = localStorage.getItem('token')
      axios.post(
        SGSS.mia.setMia(),
        formData,
        {headers: {Authorization : 'Bearer ' + token}}
      ) .then (() => {
        this.getMiaList ()
      }).catch ((err) => {
				if (err.response.status === 401) {
										this.refreshToken()
          alert('다시 로그인 해주세요')
				}
      })
    },
    deleteMia (id) {
      const token = localStorage.getItem('token')
      axios.delete(
        SGSS.mia.mia(),
        {
          data:{'id':id}, headers: {Authorization : 'Bearer ' + token}
        }
      ) .then (() => {
      }).catch ((err) => {
				if (err.response.status === 401) {
										this.refreshToken()
          alert('다시 로그인 해주세요')
				}
      }) 
    },
    updateMia () {
      const formData = new FormData()
      formData.append("id", this.mia_update_id)
      formData.append("name", this.miaData.name)
      formData.append("child_img", this.miaData.child_img)
      formData.append("age", this.miaData.age)
      const token = localStorage.getItem('token')
      axios.put(
        SGSS.mia.mia(),
        formData,
        {
          headers: {Authorization : 'Bearer ' + token}
        }
      ) .then (() => {
        this.getMiaList ()
      }).catch ((err) => {
				if (err.response.status === 401) {
					this.refreshToken()
          alert('다시 로그인 해주세요')
				}
      }) 
    }
  },
})