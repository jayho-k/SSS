import { defineStore } from "pinia";

// 예제
export const useIndexStore = defineStore("counter", {
    state: () => {
        return { count:3 }
    },
    actions: {
        increment(val = 1) {
            this.count += val;
        },
        async waitAndAdd() {
            setTimeout(() => {
                this.count++ 
            }, 2000)
        },
    }
})