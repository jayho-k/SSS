import axios from "axios";
import SGSS from '@/api/SGSS';
import { defineStore } from "pinia";
import router from "@/router";

// 예제
export const useUploadVideoStore = defineStore("upload", {
  state: () => {
    return { 
        video_list: [],
        show_video: '',
        show_add_mia: 0,

        analysis_case:null,
        analysis_url_list: [],
        analysis_video_idx: null,
        analysis_video: null,
        is_analysis_video: false,
        is_local_view:false,
        video_list_mode: true, //false 는 del
        loding_idx: false,
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
    uploadVideo () {
      console.log('분석 시작')
      const formData = new FormData()
      const idx = this.analysis_video_idx
      formData.append("video", this.video_list[idx])
      formData.append("class", this.analysis_case)
      const token = localStorage.getItem('token')
      this.loding_idx = idx
      axios.post(
        SGSS.upload.upload(),
        formData,
        {headers: {Authorization : 'Bearer ' + token}}
      ) .then ((res) => {
        var url =  res.data.video_file.split('.')
        this.analysis_url_list[idx][this.analysis_case] = this.analysis_video = url[0] + '.mp4'
        this.analysis_video = url[0] + '.mp4'

        this.analysis_video_idx = idx
        console.log('분석끝')
        this.loding_idx = false
      }) .then (() => {
        this.is_local_view = false
        this.refreshToken()
        this.analysis_case = null
        router.push('upload')
      }) .catch ((err) => {
        
        if (err.response.status === 401) {
					this.refreshToken()
          alert('다시 로그인 해주세요')
				} else {
          alert('실패했습니다')
          this.$router.go();
        }
        console.log(err)
      })
    },
    selectVideo (video) {
      this.show_video = URL.createObjectURL(video)
    }
  }
})