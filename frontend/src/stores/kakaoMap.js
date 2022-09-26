
import axios from "axios";
import SGSS from '@/api/SGSS';
import { defineStore } from "pinia";

export const useKakaoStore = defineStore("Kakao", {
	state: () => {
		return { mode : 0,
			saved_markers_info: [],
			saved_markers:[],
			saved_overlay:[],
			is_move: false,
			drag_index: -1,
			map_center: [33.450705, 126.570677] 
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
			this.map_center = [this.saved_markers_info[D_i][1],this.saved_markers_info[D_i][2]]
		},
		createCctv(Data) {
			const token = localStorage.getItem('token')
			axios.post(
				SGSS.realtime.setCctv(),
				Data,
				{headers: {Authorization : 'Bearer ' + token}}
			) .then (() => {
				// 다시 리스트 세팅
				this.getCctvList()

			}) .catch(err => {
				console.log(err)

			})
		},
		getCctvList() {
			const token = localStorage.getItem('token')
			axios.get(
				SGSS.realtime.getCctvList(),
				{headers: {Authorization : 'Bearer ' + token}}
			) .then (res => {
				this.saved_markers_info = []
				res.data.forEach((item) => {this.saved_markers_info.push([item.name, item.latitude, item.longitude, item.video, item.id, false])})
				console.log(res.data)

			}) .catch(err => {
				console.log(err)
			})
		},
		deleteCctv(id) {
			const payload = {
				'id':id
			}
			const token = localStorage.getItem('token')
			axios.delete(
				SGSS.realtime.cctv(),
				{ 
					data:payload,
					headers: {Authorization : 'Bearer ' + token}
				}
				) .then (() => {
					this.getCctvList()
				

				}) .catch(err => {
					console.log(err)
				}
			)
		}
	}
})