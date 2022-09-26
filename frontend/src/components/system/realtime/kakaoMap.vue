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
    const save_marker_info = store.saved_markers_info
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

      for (var s_m_i = 0; s_m_i < save_marker_info.length; s_m_i ++) {
        savedMarker(s_m_i)
      }
      store.saved_markers = Object.assign([], save_markers)
      console.log(save_markers)
      store.saved_overlay = Object.assign([], save_overlay)



//2. 맵 클릭 이벤트 등록
			kakao.maps.event.addListener(initMap.map, 'click', function(mouseEvent) {        
				// 클릭시 조건
				if (store.mode === 1) {
          addMarker(mouseEvent.latLng) 
				}
			});
//3. 저장된 마커 가져오기 및 저장 함수
			function savedMarker(i) {
				var imageSize = new kakao.maps.Size(24, 35)     // 마커 이미지의 이미지 크기
				var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize)     // 마커 이미지를 생성

        // 마커를 생성
				var marker = new kakao.maps.Marker({
					position: new kakao.maps.LatLng(save_marker_info[i][1], save_marker_info[i][2]),     // 마커를 표시할 위치
					title : save_marker_info[i][0],     // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
					image : markerImage      // 마커 이미지 
				});
				marker.setClickable(true)      // 마커 클릭가능
        marker.setMap(initMap.map)     //맵에 부착
				save_markers.push(marker)     // 마커 저장
				make_overlay (save_marker_info[i][0], new kakao.maps.LatLng(save_marker_info[i][1], save_marker_info[i][2]), save_overlay, marker)     // 오버레이 생성 함수
				// saved  클릭 이벤트
				kakao.maps.event.addListener(marker, 'click', function() {
					if (store.mode === 1) {
            click_update_Marker(marker, store.saved_markers, store.saved_overlay)
					} else if (store.mode === 3) {
						click_delete_marker_and_overlay(marker, store.saved_markers, store.saved_overlay)
					}
				})
        
        // saved  드래그 이벤트
        kakao.maps.event.addListener(marker, 'dragstart', function() {
          dragstart_move_marker(marker, store.saved_markers, store.saved_overlay)
        })
        
        kakao.maps.event.addListener(marker, 'dragend', function() {
          dragend_move_marker(marker, store.saved_overlay)
        });
      }
			
			// 새로 만들 시 마커를 생성하고 지도위에 표시하는 함수입니다
			function addMarker(position) {
				// 마커를 생성합니다
				var cnt = 0
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
            for (var s_m_i = 0; s_m_i < store.saved_markers.length; s_m_i ++) {
              if (title === store.saved_markers[s_m_i].getTitle()){
                cnt ++
              }
              if (cnt != 0) {
                break
              }
            }
            for (var a_m_i = 0; a_m_i < store.saved_markers.length; a_m_i ++){
              if (title === store.saved_markers[a_m_i].getTitle()){
                cnt ++
              }
              if (cnt != 0) {
                break
              }
            }
            if (cnt < 1) {
              var imageSize = new kakao.maps.Size(24, 35); 
              var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
              var marker = new kakao.maps.Marker({
                position: position,
                title : title,
                image : markerImage // 마커 이미지 
            });

            marker.setClickable(true)
            // 마커가 지도 위에 표시되도록 설정합니다
            marker.setMap(initMap.map)
            createCctv(marker, title)

            // 생성된 마커를 배열에 추가합니다
            store.saved_markers.push(marker);
            save_marker_info.push([marker.getTitle(), marker.getPosition().getLat(), marker.getPosition().getLng()])
            make_overlay (title, position, store.saved_overlay, marker)

             // add 클릭 이벤트
            kakao.maps.event.addListener(marker, 'click', function() {
              if (store.mode === 1) {
                click_update_Marker(marker, store.saved_markers, store.saved_overlay)
              } 
              else if (store.mode === 3 ) {
                click_delete_marker_and_overlay(marker, store.saved_markers, store.saved_overlay)
              }  
            })
            // saved 드래그 이벤트
            kakao.maps.event.addListener(marker, 'dragstart', function() {
              dragstart_move_marker(marker, store.saved_markers, store.saved_overlay)
            })
            kakao.maps.event.addListener(marker, 'dragend', function() {
              dragend_move_marker(marker, store.saved_overlay)
            });

            } else {
              cnt = 0
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
		function make_overlay(title, position, overlay_arr, marker) {
			var content = '<div class="customOverlay">'+ title +'</div>';

			// 커스텀 오버레이를 생성합니다
			var customOverlay = new kakao.maps.CustomOverlay({
				position: position,
				content: content   
			})
			overlay_arr.push(customOverlay)
			// 커스텀 오버레이를 지도에 표시합니다
			customOverlay.setMap(initMap.map, marker)
		}
    
		function click_update_Marker(marker, marker_arr, overlay_arr) {
      var cnt = 0
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
            for (var s_m_i = 0; s_m_i < store.saved_markers.length; s_m_i ++) {
              if (marker.getTitle() === store.saved_markers[s_m_i].getTitle()){
                s_index = s_m_i
                
              } else if (title === store.saved_markers[s_m_i].getTitle()) {
                cnt ++
              }
              if (cnt != 0) {
                break
              }
            }
            for (var a_m_i = 0; a_m_i < store.saved_markers.length; a_m_i ++){
              if (marker.getTitle() === store.saved_markers[a_m_i].getTitle()){
                s_index = a_m_i
              } else if (title === store.saved_markers[a_m_i].getTitle()) {
                cnt ++
              }
              if (cnt != 0) {
                break
              }
            }
            marker_arr.forEach(function(item, index) {
              if (marker.getTitle() === item.getTitle()) {
                s_index = index
              } else if ( title === item.getTitle()) {
                cnt += 1
              }
            })
            if (cnt < 1) {
              overlay_arr[s_index].setMap(null);
              marker_arr[s_index].setTitle(title)
                save_marker_info[s_index][0] = title
              overlay_arr[s_index].setContent('<div class="customOverlay ">'+ title +'</div>')
              overlay_arr[s_index].setMap(initMap.map, marker)
            } else {
              cnt = 0
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
		function click_delete_marker_and_overlay(marker, marker_arr, overlay_arr) {
			var s_index = null

			marker_arr.forEach(function(item, index) {
				if (marker.getTitle() === item.getTitle()) {
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
          store.deleteCctv(save_marker_info[s_index][4])
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

    function dragstart_move_marker(marker, marker_arr, overlay_arr) {
      for (var d_m_m_i = 0; d_m_m_i < marker_arr.length;  d_m_m_i ++) {
        if (marker.getTitle() === marker_arr[d_m_m_i].getTitle()) {
          overlay_arr[d_m_m_i].setMap(null)
          
          store.dragUpdate(d_m_m_i)
          break
        }
      }
    }
    function dragend_move_marker(marker, overlay_arr) {
      save_marker_info[store.drag_index] = [marker.getTitle(), marker.getPosition().getLat(), marker.getPosition().getLng()]
      overlay_arr[store.drag_index].setPosition(marker.getPosition())
      overlay_arr[store.drag_index].setMap(initMap.map, marker)
    }
    function createCctv(marker, title) {
      const cctv_Data = {
        name: title,
        video : 'asdf',
        latitude : marker.getPosition().getLat(),
        longitude : marker.getPosition().getLng(),
      }
      store.createCctv(cctv_Data)
    }
		return {
			initMap,
			make_overlay,
      dragstart_move_marker,
      dragend_move_marker,
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