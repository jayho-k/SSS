import { defineStore } from "pinia";

// 예제
export const useUploadVideoStore = defineStore("upload", {
  state: () => {
    return { 
        VideoList: [],
    }
  },
  actions: {
    uploadVideo (video_arr) {
      this.VideoList.push(video_arr)
    }
  }
})