import { defineStore } from "pinia";

// 예제
export const useUploadVideoStore = defineStore("upload", {
  state: () => {
    return { 
        video_list: [],
        show_video: '',
        
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