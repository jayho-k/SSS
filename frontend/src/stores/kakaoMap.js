
import { defineStore } from "pinia";

export const useKakoStore = defineStore("Kakao", {
    state: () => {
        return { mode : 0,
            saved_markers: [['카카오', 33.450705, 126.570677], ['생태연못', 33.450936, 126.569477], ['텃밭', 33.450879, 126.569940]],
            add_positions:[],
            markers: [],
            markers_position: [],
            is_move: false,
            }
    },
    actions: {
        add_position(x, y) {
            this.add_positions.push([x, y])
            },
    }
})