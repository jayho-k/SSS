import axios from "axios";
import SGSS from '@/api/SGSS';
import { defineStore } from "pinia";

// 예제
export const useUploadVideoStore = defineStore("upload", {
  state: () => {
    return { 
        video_list: [],
        show_video: '',
        show_add_mia: 0,    
    }
  },
  actions: {
    uploadVideo (video) {
      console.log(video)
      const formData = new FormData()
      formData.append("video", video)
      const token = localStorage.getItem('token')
      axios.post(
        SGSS.upload.upload(),
        formData,
        {headers: {Authorization : 'Bearer ' + token}}
      ) .then ((res) => {
        this.video_list.push(video)
        console.log(res)
        console.log(res.value)

      }).catch ((err) => {
        console.log(err)
      })
    },
    selectVideo (video) {
      this.show_video = URL.createObjectURL(video)
    }
  }
})