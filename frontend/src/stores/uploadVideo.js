import { defineStore } from "pinia";

// 예제
export const useUploadVideoStore = defineStore("upload", {
  state: () => {
    return { 
        VideoList: [],
    }
  },
  actions: {
  }
})