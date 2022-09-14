<template>
	<div id="map" style="width:1512px;height:1040px;"></div>
</template>

<script>
import { onMounted, watch } from 'vue';
import { useKakoStore } from '@/stores/kakaoMap';
import Swal from 'sweetalert2'

export default {
	setup() {
		const store = useKakoStore()
		/* global kakao */
		const saved_markers = []
		const saved_overlay = []
		const add_markers = []
		const add_overlay = []
		onMounted(() => {
			if (window.kakao && window.kakao.maps) {
				initMap();
			} else {
				const script = document.createElement("script")
				script.onload = () => kakao.maps.load(initMap)
				script.src ="//dapi.kakao.com/v2/maps/sdk.js?autoload=false&appkey=44e203a985e2bc845fbbde8390a4fc5b&";
				document.head.appendChild(script)

			}
		})
		
		const initMap = () => {
			const container = document.getElementById("map");
			const options = {
				center: new kakao.maps.LatLng(33.450701, 126.570667),
				level: 5,
			};
			//지도 객체를 등록합니다.
			//지도 객체는 반응형 관리 대상이 아니므로 initMap에서 선언합니다.
			initMap.map = new kakao.maps.Map(container, options);
	
			// 마커 이미지의 이미지 주소입니다
			var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 

//1. 저장된 마커 각 가져오기 및 생성
		
			for (var s_m_i = 0; s_m_i < store.saved_markers.length; s_m_i ++) {
				savedMarker(s_m_i)
			}

//2. 맵 클릭 이벤트 등록
			kakao.maps.event.addListener(initMap.map, 'click', function(mouseEvent) {        
				// 클릭시 조건
				if (store.mode === 1) {
					addMarker(mouseEvent.latLng) 
				}
			});

			function savedMarker(i) {
				// 마커 이미지의 이미지 크기 입니다
				var imageSize = new kakao.maps.Size(24, 35); 
			
				// 마커 이미지를 생성합니다    
				var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
			
				// 마커를 생성합니다
				var marker = new kakao.maps.Marker({
					position: new kakao.maps.LatLng(store.saved_markers[i][1], store.saved_markers[i][2]), // 마커를 표시할 위치
					title : store.saved_markers[i][0], // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
					image : markerImage // 마커 이미지 
				});
				// 마커 클릭가능
				marker.setClickable(true)
				// 마커 저장
				saved_markers.push(marker)
				// 맵에 부착
				marker.setMap(initMap.map);

				// 오버레이 생성 함수
				make_overlay (store.saved_markers[i][0], new kakao.maps.LatLng(store.saved_markers[i][1], store.saved_markers[i][2]), saved_overlay, marker)
				// saved  클릭 이벤트
				kakao.maps.event.addListener(marker, 'click', function() {
					if (store.mode === 1) {click_update_savedMarker(marker)
					} else if (store.mode === 3) {
						click_delete_marker_and_overlay(marker, saved_markers, saved_overlay, true)
					}


				})}
			
			// add일 시 마커를 생성하고 지도위에 표시하는 함수입니다
			function addMarker(position) {
				store.add_position(position['Ma'], position['La'])
				// 마커를 생성합니다
				var cnt = 0
				var title = prompt('title')
				// 장소가 빈값이면 오류 반환
				if ( title === null || title === '') {
						alert('내용을 입력하세요')
				} else {
					store.saved_markers.forEach(function(item) {
						if ( title === item[0]) {
							cnt += 1
						}
					})
					add_markers.forEach(function(item) {
						if ( title === item.Gb) {
							cnt += 1
						}
					})
					if ( cnt === 0) {
					var marker = new kakao.maps.Marker({
						position: position,
						title : title
					});

					marker.setClickable(true)
					// 마커가 지도 위에 표시되도록 설정합니다
					marker.setMap(initMap.map);
					
					// 생성된 마커를 배열에 추가합니다
					add_markers.push(marker);
					make_overlay (title, position, add_overlay, marker)

					// 클릭 이벤트
					kakao.maps.event.addListener(marker, 'click', function() {
						if (store.mode === 1) {
							click_update_addMarker(marker, position)
						} 
						else if (store.mode === 3 ) {
							click_delete_marker_and_overlay(marker, add_markers, add_overlay, false)
						}
						
					})
					// 드래그 이벤트
					kakao.maps.event.addListener(marker, 'dragstart', function() {
							// do something
					})

					} else {
						alert('이미 존재하는 장소입니다')
					}}


			}

// ############################## 부분 함수 파트 ##############################
//3. move 시 드래그 가능
			watch(() => store.is_move, () => {
				if (store.is_move) {
					saved_markers.forEach(function(item) {item.setDraggable(true)})
					add_markers.forEach(function(item) {item.setDraggable(true)})
				} else {
					add_markers.forEach(function(item) {item.setDraggable(false)})
					saved_markers.forEach(function(item) {item.setDraggable(false)})
				}
			}) 
		}
		function make_overlay(title, position, overlay_arr, marker) {
			var content = '<div class="customOverlay">'+ title +'</div>';

			// 커스텀 오버레이를 생성합니다
			var customOverlay = new kakao.maps.CustomOverlay({
				position: position,
				content: content   
			})
			overlay_arr.push(customOverlay)
			// 커스텀 오버레이를 지도에 표시합니다
			customOverlay.setMap(initMap.map, marker);
		}
		function click_update_addMarker(marker, position) {
			var title = prompt('title')
			var cnt = 0
			var s_index = 0
			if ( title === null || title === '') {
				alert('내용을 입력하세요')
			} else {
				store.saved_markers.forEach(function(item) {
					if ( title === item[0]) {
						cnt += 1
					}
				})
				add_markers.forEach(function(item, index) {
					if ( marker.Gb === item.Gb) {
						s_index = index
					} else if ( title === item.Gb) {
						cnt += 1
					}
				})
				if ( cnt === 0) {
					add_overlay[s_index].setMap(null);
					add_markers[s_index].Gb = title
					var customOverlay = new kakao.maps.CustomOverlay({
						position: position,
						content: '<div class="customOverlay ">'+ title +'</div>'
					});
					add_overlay[s_index] = customOverlay
					customOverlay.setMap(initMap.map, marker);
				} else {
					console.log(alert('이미 존재하는 장소입니다'))
				}
			}
		}
		function click_update_savedMarker(marker) {
			var title = sweet_update_info(title)
			var cnt = 0
			var s_index = 0
			if ( title === null || title === '') {
				alert('내용을 입력하세요')
			} else {
				store.saved_markers.forEach(function(item, index) {
					if ( marker.Gb === item[0]) {
						s_index = index
					} else if ( title === item[0]) {
						cnt += 1
					}
				})
				if ( cnt === 0) {
					saved_overlay[s_index].setMap(null);
					saved_markers[s_index].Gb = title
					store.saved_markers[s_index][0] = title
					var customOverlay = new kakao.maps.CustomOverlay({
						position: new kakao.maps.LatLng(store.saved_markers[s_index][1], store.saved_markers[s_index][2]),
						content: '<div class="customOverlay">'+ title +'</div>'
					});
					saved_overlay[s_index] = customOverlay
					customOverlay.setMap(initMap.map, marker);
					console.log(marker)
					console.log(saved_overlay[s_index])
				} else {
					alert('이미 존재하는 장소입니다')
				}
			}
		}
		function click_delete_marker_and_overlay(marker, marker_arr, overlay_arr, is_saved) {
			var s_index = 0
			marker_arr.forEach(function(item, index) {
				if (marker === item) {
					s_index = index
				} 
			})
			const swalWithBootstrapButtons = Swal.mixin({
				customClass: {
					confirmButton: 'btn btn-success',
					cancelButton: 'btn btn-danger'
				},
				buttonsStyling: false
			})
			swalWithBootstrapButtons.fire({
				title: 'Are you sure?',
				text: "You won't be able to revert this!",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonText: 'Yes, delete it!',
				cancelButtonText: 'No, cancel!',
				reverseButtons: true
			}).then((result) => {
				if (result.isConfirmed) {
					swalWithBootstrapButtons.fire(
						'Deleted!',
						'Your file has been deleted.',
						'success'
					)
					marker_arr[s_index].setMap(null)
					overlay_arr[s_index].setMap(null)
					marker_arr.splice(s_index,1)
					overlay_arr.splice(s_index,1)
					if (is_saved) {
						store.saved_markers.splice(s_index,1)
					}
				} else if (
					/* Read more about handling dismissals below */
					result.dismiss === Swal.DismissReason.cancel
				) {
					swalWithBootstrapButtons.fire(
						'Cancelled',
						'Your imaginary file is safe :)',
						'error'
					)
				}
			})
		}
		function sweet_update_info() {
			Swal.fire({
				title: 'Submit your Github username',
				input: 'text',
				inputAttributes: {
					autocapitalize: 'off'
				},
				showCancelButton: true,
				confirmButtonText: 'Look up',
				showLoaderOnConfirm: true,
				preConfirm: (login) => {
					return fetch(`//api.github.com/users/${login}`)
						.then(response => {
							if (!response.ok) {
								throw new Error(response.statusText)
							}
							return response.json()
						})
						.catch(error => {
							Swal.showValidationMessage(
								`Request failed: ${error}`
							)
						})
				},
				allowOutsideClick: () => !Swal.isLoading()
			}).then((result) => {
				if (result.isConfirmed) {
					Swal.fire({
						title: `${result.value.login}'s avatar`,
						imageUrl: result.value.avatar_url
					})
				}
			})
		}
		return {
			initMap,
			make_overlay,
			click_update_addMarker,
			click_update_savedMarker,
			sweet_update_info
		}
	}
}
</script>

<style>
.customOverlay  {
	background-color: #FFFFFF;
	border: 1px solid #eee;
	border-radius: 5px;
	width: auto;
	height: auto;
}
.btn-success {
	font-size: 20px;
}
</style>