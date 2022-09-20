
import { defineStore } from "pinia";

export const useKakaoStore = defineStore("Kakao", {
    state: () => {
        return { mode : 0,
            saved_markers_info: [['카카오', 33.450705, 126.570677], ['생태연못', 33.450936, 126.569477], ['텃밭', 35.450879, 126.569940]],
            saved_markers:[],
            saved_overlay:[],
            is_move: false,
            drag_index: -1,
            mapCenter: [33.450705, 126.570677] 
            }
    },
    actions: {
        dragUpdate(idx) {
            this.drag_index = idx
        },
        setDrag() {
            if (this.is_move) {
                this.saved_markers.forEach(function(item) {item.setDraggable(true)})
            } else {
                this.saved_markers.forEach(function(item) {item.setDraggable(false)})
            }
            this.is_move = !this.is_move
        },
        setMapCenter(D_i) {
            this.mapCenter = [this.saved_markers_info[D_i][1],this.saved_markers_info[D_i][2]]
        }
    }
})