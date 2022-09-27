import axios from "axios";
import SGSS from '@/api/SGSS';
import { defineStore } from "pinia";

export const useMiaStore = defineStore("MiaStore", {
  state: () => {
    return {
      mia_list: [],
    }

  },
  actions: {
    getMiaList () {
      const token = localStorage.getItem('token')
      console.log('asdf')
      axios.get(
        SGSS.mia.getMiaList(),
        {headers: {Authorization : 'Bearer ' + token}}
      ) .then ((res) => {
        console.log(res.data)

      }
       ) .catch ((err) => {
        console.log(err)

       })
    },
    setMiaData (Data) {
      const formData = new FormData()
      formData.append("name", Data.name)
      formData.append("child_img", Data.child_img)
      formData.append("age", Data.age)
      const token = localStorage.getItem('token')
      axios.post(
        SGSS.mia.setMia(),
        formData,
        {headers: {Authorization : 'Bearer ' + token}}
      ) .then ((res) => {
        console.log(res.data)
      }).catch ((err) => {
        console.log(err)
      })
    },
    getMiaDetail (id) {
      const token = localStorage.getItem('token')
      axios.get(
        SGSS.mia.mia(),
        {
          data:{'id':id},headers: {Authorization : 'Bearer ' + token}
        }
      ) .then ((res) => {
        console.log(res.data)
      }).catch ((err) => {
        console.log(err)
      })// 버그
    },
    deleteMia (id) {
      const token = localStorage.getItem('token')
      axios.delete(
        SGSS.mia.mia(),
        {
          data:{'id':id}, headers: {Authorization : 'Bearer ' + token}
        }
      ) .then ((res) => {
        console.log(res.data)
      }).catch ((err) => {
        console.log(err)
      })
      
    }


  },
})