<template>

  <div v-show="store.is_kakao_view" id="map" class="mapView"  style="min-height: 680px;">
    <div class="pen" >
      <span @click="toggle_pen" class="material-symbols-outlined">rebase_edit</span>
    </div>
  </div>

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
    store.is_pen_draw = false
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
      // 지도타입 컨트롤의 지도 또는 스카이뷰 버튼을 클릭하면 호출되어 지도타입을 바꾸는 함수입니다
      var mapTypeControl = new kakao.maps.MapTypeControl();

      // 지도에 컨트롤을 추가해야 지도위에 표시됩니다
      // kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
      initMap.map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

      // 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
      var zoomControl = new kakao.maps.ZoomControl();
      initMap.map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
      
// 그리기 도구
      var drawingFlag = false; // 선이 그려지고 있는 상태를 가지고 있을 변수입니다
      var moveLine; // 선이 그려지고 있을때 마우스 움직임에 따라 그려질 선 객체 입니다
      var clickLine // 마우스로 클릭한 좌표로 그려질 선 객체입니다
      var distanceOverlay; // 선의 거리정보를 표시할 커스텀오버레이 입니다
      var dots = {}; // 선이 그려지고 있을때 클릭할 때마다 클릭 지점과 거리를 표시하는 커스텀 오버레이 배열입니다.

// 클릭으로 그려진 선을 지도에서 제거하는 함수입니다
      function deleteClickLine() {
          if (clickLine) {
              clickLine.setMap(null);    
              clickLine = null;        
          }
      }

      // 마우스 드래그로 그려지고 있는 선의 총거리 정보를 표시하거
      // 마우스 오른쪽 클릭으로 선 그리가 종료됐을 때 선의 정보를 표시하는 커스텀 오버레이를 생성하고 지도에 표시하는 함수입니다
      function showDistance(content, position) {
          
          if (distanceOverlay) { // 커스텀오버레이가 생성된 상태이면
              
              // 커스텀 오버레이의 위치와 표시할 내용을 설정합니다
              distanceOverlay.setPosition(position);
              distanceOverlay.setContent(content);
              
          } else { // 커스텀 오버레이가 생성되지 않은 상태이면
              
              // 커스텀 오버레이를 생성하고 지도에 표시합니다
              distanceOverlay = new kakao.maps.CustomOverlay({
                  map: initMap.map, // 커스텀오버레이를 표시할 지도입니다
                  content: content,  // 커스텀오버레이에 표시할 내용입니다
                  position: position, // 커스텀오버레이를 표시할 위치입니다.
                  xAnchor: 0,
                  yAnchor: 0,
                  zIndex: 3  
              });      
          }
      }

      // 그려지고 있는 선의 총거리 정보와 
      // 선 그리가 종료됐을 때 선의 정보를 표시하는 커스텀 오버레이를 삭제하는 함수입니다
      function deleteDistnce () {
          if (distanceOverlay) {
              distanceOverlay.setMap(null);
              distanceOverlay = null;
          }
      }

      // 선이 그려지고 있는 상태일 때 지도를 클릭하면 호출하여 
      // 클릭 지점에 대한 정보 (동그라미와 클릭 지점까지의 총거리)를 표출하는 함수입니다
      function displayCircleDot(position, distance) {

          // 클릭 지점을 표시할 빨간 동그라미 커스텀오버레이를 생성합니다
          var circleOverlay = new kakao.maps.CustomOverlay({
              content: '<span class="dot"></span>',
              position: position,
              zIndex: 1
          });

          // 지도에 표시합니다
          circleOverlay.setMap(initMap.map);

          if (distance > 0) {
              // 클릭한 지점까지의 그려진 선의 총 거리를 표시할 커스텀 오버레이를 생성합니다
              var distanceOverlay = new kakao.maps.CustomOverlay({
                  content: '<div class="dotOverlay">거리 <span class="number">' + distance + '</span>m</div>',
                  position: position,
                  yAnchor: 1,
                  zIndex: 2
              });

              // 지도에 표시합니다
              distanceOverlay.setMap(initMap.map);
          }

          // 배열에 추가합니다
          dots.push({circle:circleOverlay, distance: distanceOverlay});
      }

      // 클릭 지점에 대한 정보 (동그라미와 클릭 지점까지의 총거리)를 지도에서 모두 제거하는 함수입니다
      function deleteCircleDot() {
          var i;

          for ( i = 0; i < dots.length; i++ ){
              if (dots[i].circle) { 
                  dots[i].circle.setMap(null);
              }

              if (dots[i].distance) {
                  dots[i].distance.setMap(null);
              }
          }

          dots = [];
      }

      // 마우스 우클릭 하여 선 그리기가 종료됐을 때 호출하여 
      // 그려진 선의 총거리 정보와 거리에 대한 도보, 자전거 시간을 계산하여
      // HTML Content를 만들어 리턴하는 함수입니다
      function getTimeHTML(distance) {

          // 도보의 시속은 평균 4km/h 이고 도보의 분속은 67m/min입니다
          var walkkTime = distance / 67 | 0;
          var walkHour = '', walkMin = '';

          // 계산한 도보 시간이 60분 보다 크면 시간으로 표시합니다
          if (walkkTime > 60) {
              walkHour = '<span class="number">' + Math.floor(walkkTime / 60) + '</span>시간 '
          }
          walkMin = '<span class="number">' + walkkTime % 60 + '</span>분'

          // 자전거의 평균 시속은 16km/h 이고 이것을 기준으로 자전거의 분속은 267m/min입니다
          var bycicleTime = distance / 227 | 0;
          var bycicleHour = '', bycicleMin = '';

          // 계산한 자전거 시간이 60분 보다 크면 시간으로 표출합니다
          if (bycicleTime > 60) {
              bycicleHour = '<span class="number">' + Math.floor(bycicleTime / 60) + '</span>시간 '
          }
          bycicleMin = '<span class="number">' + bycicleTime % 60 + '</span>분'

          // 거리와 도보 시간, 자전거 시간을 가지고 HTML Content를 만들어 리턴합니다
          var content = '<ul class="dotOverlay distanceInfo">';
          content += '    <li>';
          content += '        <span class="label">총거리</span><span class="number">' + distance + '</span>m';
          content += '    </li>';
          content += '    <li>';
          content += '        <span class="label">도보</span>' + walkHour + walkMin;
          content += '    </li>';
          content += '    <li>';
          content += '        <span class="label">자전거</span>' + bycicleHour + bycicleMin;
          content += '    </li>';
          content += '</ul>'

          return content;
      }


      //2. 맵 클릭 이벤트 등록
			kakao.maps.event.addListener(initMap.map, 'click', function(mouseEvent) {        
				// 클릭시 조건
				if (store.cctv_mode === 1) {
          addMarker(mouseEvent.latLng) 
				} else if (store.is_pen_draw) {
          var clickPosition = mouseEvent.latLng;

          // 지도 클릭이벤트가 발생했는데 선을 그리고있는 상태가 아니면
          if (!drawingFlag) {

              // 상태를 true로, 선이 그리고있는 상태로 변경합니다
              drawingFlag = true;
              
              // 지도 위에 선이 표시되고 있다면 지도에서 제거합니다
              deleteClickLine();
              
              // 지도 위에 커스텀오버레이가 표시되고 있다면 지도에서 제거합니다
              deleteDistnce();

              // 지도 위에 선을 그리기 위해 클릭한 지점과 해당 지점의 거리정보가 표시되고 있다면 지도에서 제거합니다
              deleteCircleDot();
          
              // 클릭한 위치를 기준으로 선을 생성하고 지도위에 표시합니다
              clickLine = new kakao.maps.Polyline({
                  map: initMap.map, // 선을 표시할 지도입니다 
                  path: [clickPosition], // 선을 구성하는 좌표 배열입니다 클릭한 위치를 넣어줍니다
                  strokeWeight: 3, // 선의 두께입니다 
                  strokeColor: '#db4040', // 선의 색깔입니다
                  strokeOpacity: 1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
                  strokeStyle: 'solid' // 선의 스타일입니다
              });
              
              // 선이 그려지고 있을 때 마우스 움직임에 따라 선이 그려질 위치를 표시할 선을 생성합니다
              moveLine = new kakao.maps.Polyline({
                  strokeWeight: 3, // 선의 두께입니다 
                  strokeColor: '#db4040', // 선의 색깔입니다
                  strokeOpacity: 0.5, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
                  strokeStyle: 'solid' // 선의 스타일입니다    
              });
          
              // 클릭한 지점에 대한 정보를 지도에 표시합니다
              displayCircleDot(clickPosition, 0);

                  
          } else { // 선이 그려지고 있는 상태이면

              // 그려지고 있는 선의 좌표 배열을 얻어옵니다
              var path = clickLine.getPath();

              // 좌표 배열에 클릭한 위치를 추가합니다
              path.push(clickPosition);
              
              // 다시 선에 좌표 배열을 설정하여 클릭 위치까지 선을 그리도록 설정합니다
              clickLine.setPath(path);

              var distance = Math.round(clickLine.getLength());
              displayCircleDot(clickPosition, distance);
          }
        }
			})
// 마우스 오버 이벤트
      kakao.maps.event.addListener(initMap.map, 'mousemove', function (mouseEvent) {
        if (store.is_pen_draw) {
                  // 지도 마우스무브 이벤트가 발생했는데 선을 그리고있는 상태이면
          if (drawingFlag ){
              
              // 마우스 커서의 현재 위치를 얻어옵니다 
              var mousePosition = mouseEvent.latLng; 

              // 마우스 클릭으로 그려진 선의 좌표 배열을 얻어옵니다
              var path = clickLine.getPath();
              
              // 마우스 클릭으로 그려진 마지막 좌표와 마우스 커서 위치의 좌표로 선을 표시합니다
              var movepath = [path[path.length-1], mousePosition];
              moveLine.setPath(movepath);    
              moveLine.setMap(initMap.map);
              
              var distance = Math.round(clickLine.getLength() + moveLine.getLength()), // 선의 총 거리를 계산합니다
                  content = '<div class="dotOverlay distanceInfo">총거리 <span class="number">' + distance + '</span>m</div>'; // 커스텀오버레이에 추가될 내용입니다
              
              // 거리정보를 지도에 표시합니다
              showDistance(content, mousePosition);   
          }            
        }
 
        })
      kakao.maps.event.addListener(initMap.map, 'rightclick', function () {
        if (store.is_pen_draw) {
          if (drawingFlag) {
            
            // 마우스무브로 그려진 선은 지도에서 제거합니다
            moveLine.setMap(null);
            moveLine = null;  
            
            // 마우스 클릭으로 그린 선의 좌표 배열을 얻어옵니다
            var path = clickLine.getPath();

            // 선을 구성하는 좌표의 개수가 2개 이상이면
            if (path.length > 1) {

                // 마지막 클릭 지점에 대한 거리 정보 커스텀 오버레이를 지웁니다
                if (dots[dots.length-1].distance) {
                    dots[dots.length-1].distance.setMap(null);
                    dots[dots.length-1].distance = null;    
                }

                var distance = Math.round(clickLine.getLength()), // 선의 총 거리를 계산합니다
                    content = getTimeHTML(distance); // 커스텀오버레이에 추가될 내용입니다
                    
                // 그려진 선의 거리정보를 지도에 표시합니다
                showDistance(content, path[path.length-1]);  
                
            } else {

                // 선을 구성하는 좌표의 개수가 1개 이하이면 
                // 지도에 표시되고 있는 선과 정보들을 지도에서 제거합니다.
                deleteClickLine();
                deleteCircleDot(); 
                deleteDistnce();

            }
            
            // 상태를 false로, 그리지 않고 있는 상태로 변경합니다
            drawingFlag = false;          
        }  
        }
        // 지도 오른쪽 클릭 이벤트가 발생했는데 선을 그리고있는 상태이면
       
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
          autocapitalize: 'off',
          video:''
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
    function toggle_pen (e) {
      e.target.classList.toggle("pen_click")
      store.is_pen_draw = !store.is_pen_draw
    }
    
		return {
      store,
      save_markers,
      save_overlay,
			initMap,
      drag_start_move_marker,
      drag_end_move_marker,
			click_update_Marker,
      toggle_pen,
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
.pen {
  position: absolute;
  display: flex;
  justify-content: center;
  align-items: center;
  cursor: pointer;
  right: 120px;
  top: 4px;
  width: 36px;
  height: 36px;
  border-radius: 5px;
  color: #000;
  border: none;
  background: white;
  color: black;
  z-index: 100;
  box-shadow: 0px 2px #aaa;
}
.pen_click {
  color: red;
}
.pen:hover {
  color: red
}
.dot {overflow:hidden;float:left;width:12px;height:12px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/mini_circle.png');}    
.dotOverlay {position:relative;bottom:10px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:left;font-size:12px;padding:5px;background:#fff;}
.dotOverlay:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}    
.number {font-weight:bold;color:#ee6152;}
.dotOverlay:after {content:'';position:absolute;margin-left:-6px;left:50%;bottom:-8px;width:11px;height:8px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white_small.png')}
.distanceInfo {position:relative;top:5px;left:5px;list-style:none;margin:0;}
.distanceInfo .label {display:inline-block;width:50px;}
.distanceInfo:after {content:none;}
</style>