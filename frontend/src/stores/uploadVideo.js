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
      this.video_list.push(video)
    },
    selectVideo (video) {
      this.show_video = URL.createObjectURL(video)
    }
  }
})