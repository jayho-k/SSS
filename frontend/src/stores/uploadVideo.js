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
        analysis_case:'',
        video_list_mode: true //false 는 del
    }
  },
  actions: {
    uploadVideo () {
      const formData = new FormData()
      formData.append("video", this.video_list[0])
      formData.append("class", this.analysis_case)
      const token = localStorage.getItem('token')
      axios.post(
        SGSS.upload.upload(),
        formData,
        {headers: {Authorization : 'Bearer ' + token}}
      ) .then ((res) => {
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