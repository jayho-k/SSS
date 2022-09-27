<template>
	<div id="map" style="width:1620px;height:1040px;"></div>
</template>

<script>
import { onMounted, watch } from 'vue'
import { useKakaoStore } from '@/stores/kakaoMap'
import Swal from 'sweetalert2'

export default {
	setup() {
		const store = useKakaoStore()
    store.getCctvList()
		/* global kakao */
    const save_markers = []
    const save_overlay = []
    var save_drag_index = null
    var save_marker_info = []
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
			const container = document.getElementById("map")
			const options = {
				center: new kakao.maps.LatLng(33.450701, 126.570667),
				level: 5,
			}
			//지도 객체를 등록합니다.
			//지도 객체는 반응형 관리 대상이 아니므로 initMap에서 선언합니다.
			initMap.map = new kakao.maps.Map(container, options)
			// 마커 이미지의 이미지 주소입니다
			var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
      //
//1. 저장된 마커 각 가져오기 및 생성
      save_marker_info = Object.assign([], store.saved_markers_info)
      for (var s_m_i = 0; s_m_i < save_marker_info.length; s_m_i ++) {
        savedMarker(s_m_i)
      }
      store.saved_markers = Object.assign([], save_markers)
      store.saved_overlay = Object.assign([], save_overlay)

//2. 맵 클릭 이벤트 등록
			kakao.maps.event.addListener(initMap.map, 'click', function(mouseEvent) {        
				// 클릭시 조건
				if (store.cctv_mode === 1) {
          addMarker(mouseEvent.latLng) 
				}
			});
//3. 저장된 마커 가져오기 및 저장 함수
			function savedMarker(i) {
				var imageSize = new kakao.maps.Size(28, 40)
				var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize)

        // 마커를 생성
        var title = save_marker_info[i]['name']
        var position = new kakao.maps.LatLng(save_marker_info[i]['latitude'], save_marker_info[i]['longitude'])
				var marker = new kakao.maps.Marker({
					position: position,
					title : title,
					image : markerImage 
				});
				marker.setClickable(true)
        marker.setMap(initMap.map)
        marker.setDraggable(true)
				save_markers.push(marker)
        var content = '<div class="customOverlay">'+ title +'</div>';

        // 커스텀 오버레이를 생성합니다
        var customOverlay = new kakao.maps.CustomOverlay({
          position: position,
          content: content   
        })
        save_overlay.push(customOverlay)
        customOverlay.setMap(initMap.map, marker)
        // 클릭 이벤트


				kakao.maps.event.addListener(marker, 'click', function() {
					if (store.Cctv_mode == 1) {
          //수정
            click_update_Marker(marker, store.saved_markers, store.saved_overlay)
					} else if (store.cctv_mode === 2) {
						click_delete_marker_and_overlay(marker)
					}
				})
        
        // saved  드래그 이벤트
        kakao.maps.event.addListener(marker, 'dragstart', function() {
          drag_start_move_marker(marker)
        })
        
        kakao.maps.event.addListener(marker, 'dragend', function() {
          drag_end_move_marker(marker, store.saved_overlay)
        });
      }

			//책갈피
			// 새로 만들 시 마커를 생성하고 지도위에 표시하는 함수입니다
			function addMarker(position) {
				// 마커를 생성합니다
				var unique = true
        Swal.fire({
        title: '장소를 설정해주세요',
        input: 'text',
        inputAttributes: {
          autocapitalize: 'off'
        },
        showCancelButton: true,
        confirmButtonText: '생성',
        confirmButtonColor: '#3085d6',
        showLoaderOnConfirm: true,
        cancelButtonText: '취소',
        preConfirm: (title) => {
          if (title === '') {
            Swal.showValidationMessage(
            `장소를 입력하세요 `
            ) 
          } else {
            for (var s_m_i = 0; s_m_i < save_marker_info.length; s_m_i ++) {
              if (title === save_marker_info[s_m_i]['id']){
                unique = false
                break
              }
            }
            if (unique) {
              var imageSize = new kakao.maps.Size(25, 40); 
              var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
              var marker = new kakao.maps.Marker({
                position: position,
                title : title,
                image : markerImage // 마커 이미지 
            });

            marker.setClickable(true)
            // 마커가 지도 위에 표시되도록 설정합니다
            marker.setMap(initMap.map)
            
            createCctv(title, position.Ma, position.La)
            
            
            // 생성된 마커를 배열에 추가합니다
            store.saved_markers.push(marker);
            save_marker_info.push([marker.getTitle(), marker.getPosition().getLat(), marker.getPosition().getLng()])
            // make_overlay (title, position, store.saved_overlay, marker)

             // add 클릭 이벤트
            kakao.maps.event.addListener(marker, 'click', function() {
              if (store.cctv_mode === 1) {
                click_update_Marker(marker, store.saved_markers, store.saved_overlay)
              } 
              else if (store.cctv_mode === 3 ) {
                click_delete_marker_and_overlay(marker, store.saved_markers, store.saved_overlay)
              }  
            })
            // saved 드래그 이벤트
            kakao.maps.event.addListener(marker, 'dragstart', function() {
              drag_start_move_marker(marker, store.saved_markers, store.saved_overlay)
            })
            kakao.maps.event.addListener(marker, 'dragend', function() {
              drag_end_move_marker(marker, store.saved_overlay)
            });

            } else {
              unique = true
              Swal.showValidationMessage(
                '이미 존재하는 장소입니다'
              ) 
            }
          }
        }
      }).then((title) => {
        if (title.isConfirmed) {
          Swal.fire(
          '',
          title.value + ' CCTV가 생성되었습니다',
          'success'
          )
        } else {
          Swal.fire(
          '',
          '취소되었습니다',
          'error',
          )
        }
      })
  } 



// ############################## 부분 함수 파트 ##############################
//3. move 시 드래그 가능
      watch(() => store.map_center, (after) => {
        var moveLatLng = new kakao.maps.LatLng(after[0], after[1]);   
        initMap.map.panTo(moveLatLng)
      }) 
		}
    
		function click_update_Marker(marker) {
      var unique = true
      var s_index = null
      Swal.fire({
        title: '장소를 변경하시겠습니까?',
        input: 'text',
        inputAttributes: {
          autocapitalize: 'off'
        },
        showCancelButton: true,
        confirmButtonText: '수정',
        confirmButtonColor: '#3085d6',
        showLoaderOnConfirm: true,
        cancelButtonText: '취소',
        preConfirm: (title) => {
          if (title === '') {
            Swal.showValidationMessage(
            `title을 입력하세요 `
            ) 
          } else {
            for (var s_m_i = 0; s_m_i < save_marker_info.length; s_m_i ++) {
              if (marker.getTitle() === store.saved_markers[s_m_i].getTitle()){
                s_index = s_m_i
                break
              }
            }
            if (unique) {
              // save_markers[s_index].setMap(null);
              save_overlay[s_index].setTitle(title)
              save_marker_info[s_index][0] = title
              save_overlay[s_index].setContent('<div class="customOverlay ">'+ title +'</div>')
              // save_overlay[s_index].setMap(initMap.map, marker)
            } else {
              unique = true
              Swal.showValidationMessage(
                '이미 존재하는 장소입니다'
              ) 
            }
          }
        }
      }).then((title) => {
        if (title.isConfirmed) {
          Swal.fire(
          '',
          '장소가 '+ title.value + '로 수정되었습니다',
          'success'

          )
        } else {
          Swal.fire(
          '',
          '취소되었습니다',
          'error',
          )
        }
      })
    }
		function click_delete_marker_and_overlay(marker) {
			var s_index = null
      for(var i = 0; i < save_marker_info.length; i++) {
        if (marker.getTitle() === save_marker_info[i]['name']) {
					s_index = i
				}}
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
					save_markers[s_index].setMap(null)
					save_overlay[s_index].setMap(null)
					save_markers.splice(s_index,1)
					save_overlay.splice(s_index,1)
          store.deleteCctv(save_marker_info[s_index]['id'])
					save_marker_info.splice(s_index,1)
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

    function drag_start_move_marker(marker) {
      for (var d_m_m_i = 0; d_m_m_i < save_marker_info.length;  d_m_m_i ++) {
        if (marker.getTitle() === save_marker_info[d_m_m_i]['name']) {
          save_overlay[d_m_m_i].setMap(null)
          
          save_drag_index = d_m_m_i
          break
        }
      }
    }
    function drag_end_move_marker(marker) {
      save_marker_info[save_drag_index]['latitude'] = marker.getPosition().getLat()
      save_marker_info[save_drag_index]['longitude'] = marker.getPosition().getLng()
      store.updateCctv(save_marker_info[save_drag_index])
      save_overlay[save_drag_index].setMap(initMap.map, marker)
      //수정 api 작동안됨
    }
    function createCctv(title, lat, lon) {
      const cctv_Data = {
        name: title,
        video : 'asdf',
        latitude : lat,
        longitude : lon,
      }
      store.createCctv(cctv_Data)
    }
		return {
      save_marker_info,
      save_markers,
      save_overlay,
			initMap,
      drag_start_move_marker,
      drag_end_move_marker,
			click_update_Marker,
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
	height: 20px;
  opacity: 70%;
  font-size: 16px
}
.customOverlay:hover {
  opacity: 100%;
}

.btn-success {
	font-size: 20px;
}
</style>