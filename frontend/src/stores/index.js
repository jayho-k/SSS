import { defineStore } from "pinia";

// 예제
export const useIndexStore = defineStore("counter", {
  state: () => {
    return { view_case: 0 }
  },
  actions: {
  }
})