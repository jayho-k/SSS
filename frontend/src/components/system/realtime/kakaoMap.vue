<template>

  <div v-show="store.is_kakao_view" id="map" class="mapView"  style="min-height: 680px;"></div>
  <Streaming v-if="!store.is_kakao_view" class="mapView"></Streaming>

</template>

<script>
import { onMounted, watch } from 'vue'
import { useKakaoStore } from '@/stores/kakaoMap'
import Swal from 'sweetalert2'
import markerImg from '@/assets/marker.png'
import Streaming from '@/components/system/control/realtime/CctvStreaming.vue'
export default {
  components: {Streaming},
	setup() {
		const store = useKakaoStore()
    store.getCctvList()
		/* global kakao */
    const save_markers = []
    const save_overlay = []
    store.cctv_mode = 0
    var save_drag_index = null
    store.saved_markers = save_markers
		store.saved_overlay = save_overlay
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
      if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function(position) {
          var moveLatLng = new kakao.maps.LatLng(position.coords.latitude, position.coords.longitude);   
          initMap.map.panTo(moveLatLng);
      })}
			//지도 객체를 등록합니다.
			//지도 객체는 반응형 관리 대상이 아니므로 initMap에서 선언합니다.
			initMap.map = new kakao.maps.Map(container, options)
			// 마커 이미지의 이미지 주소입니다
			var imageSrc = markerImg; 
      //
//1. 저장된 마커 각 가져오기 및 생성
      for (var s_m_i = 0; s_m_i < store.saved_markers_info.length; s_m_i ++) {
        savedMarker(s_m_i)
      }

//2. 맵 클릭 이벤트 등록
			kakao.maps.event.addListener(initMap.map, 'click', function(mouseEvent) {        
				// 클릭시 조건
				if (store.cctv_mode === 1) {
          addMarker(mouseEvent.latLng) 
				}
			});
//3. 저장된 마커 가져오기 및 저장 함수
			function savedMarker(i) {
				var imageSize = new kakao.maps.Size(32, 44)
				var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize)

        // 마커를 생성
        var title = store.saved_markers_info[i]['name']
        var position = new kakao.maps.LatLng(store.saved_markers_info[i]['latitude'], store.saved_markers_info[i]['longitude'])
				var marker = new kakao.maps.Marker({
					position: position,
					title : title,
					image : markerImage 
				});
				marker.setClickable(true)
        marker.setMap(initMap.map)
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
					if (store.cctv_mode == 1) {
          //수정
            click_update_Marker(marker)
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
        confirmButtonColor: '#3fc3ee',
        showLoaderOnConfirm: true,
        cancelButtonText: '취소',
        cancelButtonColor: '#f27474',
        preConfirm: (title) => {
          if (title === '') {
            Swal.showValidationMessage(
            `장소를 입력하세요 `
            ) 
          } else {
            for (var s_m_i = 0; s_m_i < store.saved_markers_info.length; s_m_i ++) {
              if (title === store.saved_markers_info[s_m_i]['name']){
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
            // 커스텀 오버레이를 생성합니다
            var content = '<div class="customOverlay">'+ title +'</div>';
            var customOverlay = new kakao.maps.CustomOverlay({
              position: position,
              content: content   
            })
            save_overlay.push(customOverlay)
            save_markers.push(marker);
            createCctv(title, position.Ma, position.La)

            customOverlay.setMap(initMap.map, marker)

            

             // add 클릭 이벤트
            kakao.maps.event.addListener(marker, 'click', function() {
              if (store.cctv_mode === 1) {
                click_update_Marker(marker)
              } 
              else if (store.cctv_mode === 2 ) {
                click_delete_marker_and_overlay(marker)
              }  
            })

            // saved 드래그 이벤트
            kakao.maps.event.addListener(marker, 'dragstart', function() {
              drag_start_move_marker(marker)
            })
            kakao.maps.event.addListener(marker, 'dragend', function() {
              drag_end_move_marker(marker)
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


            //책갈피
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
        confirmButtonColor: '#a5dc86',
        showLoaderOnConfirm: true,
        cancelButtonText: '취소',
        cancelButtonColor:'#f27474',
        preConfirm: (title) => {
          if (title === '') {
            Swal.showValidationMessage(
            `title을 입력하세요 `
            ) 
          } else {
            for (var s_m_i = 0; s_m_i < store.saved_markers_info.length; s_m_i ++) {
              if (marker.getTitle() === store.saved_markers_info[s_m_i]['name']){
                s_index = s_m_i
                break
              }
            }
            for (var s_m_i_2 = 0; s_m_i_2 < store.saved_markers_info.length; s_m_i_2 ++) {
              if (title === store.saved_markers_info[s_m_i_2]['name']){
                unique = false
                break
              }
            }
            if (unique) {
              save_markers[s_index].setTitle(title)
              store.saved_markers_info[s_index]['name'] = title
              save_overlay[s_index].setContent('<div class="customOverlay ">'+ title +'</div>')
              save_overlay[s_index].setMap(initMap.map, marker)
              store.updateCctv(store.saved_markers_info[s_index])
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
      for(var i = 0; i < store.saved_markers_info.length; i++) {
        if (marker.getTitle() === store.saved_markers_info[i]['name']) {
					s_index = i
				}}
			Swal.fire({
				title: '삭제하시겠습니까?',
				
				icon: 'warning',
				showCancelButton: true,
				confirmButtonText: '삭제',
				cancelButtonText: '취소',
        confirmButtonColor: '#f8bb86',
        cancelButtonColor: '#f27474',
				// reverseButtons: true
			}).then((result) => {
				if (result.isConfirmed) {
					Swal.fire(
						'삭제',
						'삭제되었습니다.',
						'success'
					)
					save_markers[s_index].setMap(null)
					save_overlay[s_index].setMap(null)
					save_markers.splice(s_index,1)
					save_overlay.splice(s_index,1)
          store.deleteCctv(store.saved_markers_info[s_index]['id'])
					store.saved_markers_info.splice(s_index,1)
				} else if (
					/* Read more about handling dismissals below */
					result.dismiss === Swal.DismissReason.cancel
				) {
					Swal.fire(
						'취소',
						'취소되었습니다.',
						'error'
					)
				}
			})
		}

    function drag_start_move_marker(marker) {
      for (var d_m_m_i = 0; d_m_m_i < store.saved_markers_info.length;  d_m_m_i ++) {
        if (marker.getTitle() === store.saved_markers_info[d_m_m_i]['name']) {
          save_overlay[d_m_m_i].setMap(null)
          
          save_drag_index = d_m_m_i
          break
        }
      }
    }
    function drag_end_move_marker(marker) {
      store.saved_markers_info[save_drag_index]['latitude'] = marker.getPosition().getLat()
      store.saved_markers_info[save_drag_index]['longitude'] = marker.getPosition().getLng()
      var title = store.saved_markers_info[save_drag_index]['name']
      var position = new kakao.maps.LatLng(store.saved_markers_info[save_drag_index]['latitude'],  store.saved_markers_info[save_drag_index]['longitude'])
      var content = '<div class="customOverlay">'+ title +'</div>';
      // 커스텀 오버레이를 생성합니다
      var customOverlay = new kakao.maps.CustomOverlay({
        position: position,
        content: content   
      })
      save_overlay[save_drag_index] = customOverlay
      customOverlay.setMap(initMap.map, marker)
      // store.saved_markers_info[save_drag_index] = marker
      store.updateCctv(store.saved_markers_info[save_drag_index])
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
      store,
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
.mapView {
  width:1620px;
  height:calc(100vh - 40px);
}
.btn-success {
	font-size: 20px;
}
</style>