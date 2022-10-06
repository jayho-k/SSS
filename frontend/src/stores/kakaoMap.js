
import axios from "axios";
import SGSS from '@/api/SGSS';
import { defineStore } from "pinia";

export const useKakaoStore = defineStore("Kakao", {
	state: () => {
		return { mode : 0,
			saved_markers_info: [],
			saved_markers:[],
			saved_overlay:[],
			cctv_mode: 0,
			is_pen_draw: false,
			drag_index: -1,
			map_center: [33.450705, 126.570677],

			is_kakao_view: true,
			cctv_list: [],
			selete_cctv:'',
			}
	},
	actions: {
		dragUpdate(idx) {
			this.drag_index = idx
		},
		setDrag() {
			if (this.is_move) {
				this.is_marker_add = true
			} else {
				this.is_marker_add = false
			}
			this.is_move = !this.is_move
		},
		setMapCenter(D_i) {
			this.map_center = [this.saved_markers_info[D_i]['latitude'], this.saved_markers_info[D_i]['longitude']]
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
				if (err.response.status === 401) {
					this.removeToken()
				}
			})
		},
		getCctvList() {
			const token = localStorage.getItem('token')
			axios.get(
				SGSS.realtime.getCctvList(),
				{headers: {Authorization : 'Bearer ' + token}}
			) .then (res => {
				this.saved_markers_info = Object.assign([], res.data)
				if (this.saved_markers_info.length > 0) {
				this.map_center = [this.saved_markers_info[0]['latitude'], this.saved_markers_info[0]['longitude']]
				}

			}) .catch(err => {
				console.log(err)
				if (err.response.status === 401) {
					this.removeToken()
				}
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
					if (err.response.status === 401) {
						this.removeToken()
					}
				}
			)
		},
		updateCctv(data) {
			console.log(data)
			const token = localStorage.getItem('token')
			axios.put(
				SGSS.realtime.cctv(),
				data,
				{headers: {Authorization : 'Bearer ' + token}}
				) .then (() => {
					this.getCctvList()
				}) .catch(err => {
					console.log(err)
					if (err.response.status === 401) {
						this.removeToken()
					}
				}
			)
		}
	}
})