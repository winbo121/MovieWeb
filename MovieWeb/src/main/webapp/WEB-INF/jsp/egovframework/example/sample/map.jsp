<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>좌표로 주소를 얻어내기</title>
<style>
#centerAddr {
	display: block;
	margin-top: 2px;
	font-weight: normal;
}

.bAddr {
	padding: 5px;
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
}
</style>
</head>
<body>
	<div class="Site-content">
		<div id="map"></div>
		<div class="hAddr">
			<span class="title">지도중심기준 행정동 주소정보</span> <span id="centerAddr"></span>
		</div>

		<script type="text/javascript"
			src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f3e1b7156e65df896b6e836e9252e216&libraries=services"></script>
		<script>
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
			mapOption = {
				center : new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
				level : 3
			// 지도의 확대 레벨
			};

			// 지도를 생성합니다    
			var map = new kakao.maps.Map(mapContainer, mapOption);

			// 주소-좌표 변환 객체를 생성합니다
			var geocoder = new kakao.maps.services.Geocoder();

			var marker = new kakao.maps.Marker(), // 클릭한 위치를 표시할 마커입니다
			infowindow = new kakao.maps.InfoWindow({
				zindex : 1
			}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다

			// 현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시합니다
			searchAddrFromCoords(map.getCenter(), displayCenterInfo);

			// 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
			kakao.maps.event
					.addListener(
							map,
							'click',
							function(mouseEvent) {

								searchDetailAddrFromCoords(
										mouseEvent.latLng,
										function(result, status) {
											if (status === kakao.maps.services.Status.OK) {
												var detailAddr = !!result[0].road_address ? '<div>도로명주소 : '
														+ result[0].road_address.address_name
														+ '</div>'
														: '';
												detailAddr += '<div>지번 주소 : '
														+ result[0].address.address_name
														+ '</div>';

												var content = '<div class="bAddr">'
														+ '<span class="title">법정동 주소정보</span>'
														+ detailAddr + '</div>';
												// 마커를 클릭한 위치에 표시합니다 
												marker
														.setPosition(mouseEvent.latLng);
												marker.setMap(map);

												// 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
												infowindow.setContent(content);
												infowindow.open(map, marker);

												var ps = new kakao.maps.services.Places();

												// 키워드로 장소를 검색합니다
												ps
														.keywordSearch(
																result[0].address.address_name
																		+ ' 영화관',
																placesSearchCB);

												// 키워드 검색 완료 시 호출되는 콜백함수 입니다
												function placesSearchCB(data,
														status, pagination) {
													if (status === kakao.maps.services.Status.OK) {

														// 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
														// LatLngBounds 객체에 좌표를 추가합니다
														var bounds = new kakao.maps.LatLngBounds();

														for (var i = 0; i < data.length; i++) {
															displayMarker(data[i]);
															bounds
																	.extend(new kakao.maps.LatLng(
																			data[i].y,
																			data[i].x));
														}

														// 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
														map.setBounds(bounds);
													}
												}

												// 지도에 마커를 표시하는 함수입니다
												function displayMarker(place) {

													// 마커를 생성하고 지도에 표시합니다
													var marker = new kakao.maps.Marker(
															{
																map : map,
																position : new kakao.maps.LatLng(
																		place.y,
																		place.x)
															});

													// 마커에 클릭이벤트를 등록합니다
													kakao.maps.event
															.addListener(
																	marker,
																	'click',
																	function() {
																		// 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
																		infowindow
																				.setContent('<div style="padding:5px;font-size:12px;">'
																						+ place.place_name
																						+ '</div>');
																		infowindow
																				.open(
																						map,
																						marker);
																	});
												}
											}
										});
							});

			// 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
			kakao.maps.event.addListener(map, 'idle', function() {
				searchAddrFromCoords(map.getCenter(), displayCenterInfo);
			});

			function searchAddrFromCoords(coords, callback) {
				// 좌표로 행정동 주소 정보를 요청합니다
				geocoder.coord2RegionCode(coords.getLng(), coords.getLat(),
						callback);
			}

			function searchDetailAddrFromCoords(coords, callback) {
				// 좌표로 법정동 상세 주소 정보를 요청합니다
				geocoder.coord2Address(coords.getLng(), coords.getLat(),
						callback);
			}

			// 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
			function displayCenterInfo(result, status) {
				if (status === kakao.maps.services.Status.OK) {
					var infoDiv = document.getElementById('centerAddr');

					for (var i = 0; i < result.length; i++) {
						// 행정동의 region_type 값은 'H' 이므로
						if (result[i].region_type === 'H') {
							infoDiv.innerHTML = result[i].address_name;
							break;
						}
					}
				}
			}

			function getLocation() {
				// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
				if (navigator.geolocation) {

					// GeoLocation을 이용해서 접속 위치를 얻어옵니다
					navigator.geolocation
							.getCurrentPosition(function(position) {

								var lat = position.coords.latitude, // 위도
								lon = position.coords.longitude; // 경도

								var locPosition = new kakao.maps.LatLng(lat,
										lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
								message = '<div style="padding:5px;">여기에 계신가요?!</div>'; // 인포윈도우에 표시될 내용입니다

								// 마커와 인포윈도우를 표시합니다
								displayMarker(locPosition, message);

							});

				} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다

					message = 'geolocation을 사용할수 없어요..'

					displayMarker(message);
				}

				// 지도에 마커와 인포윈도우를 표시하는 함수입니다
				function displayMarker(locPosition, message) {

					// 마커를 생성합니다
					var marker = new kakao.maps.Marker({
						map : map,
						position : locPosition
					});

					var iwContent = message, // 인포윈도우에 표시할 내용
					iwRemoveable = true;

					// 인포윈도우를 생성합니다
					var infowindow = new kakao.maps.InfoWindow({
						content : iwContent,
						removable : iwRemoveable
					});

					// 인포윈도우를 마커위에 표시합니다 
					infowindow.open(map, marker);

					// 지도 중심좌표를 접속위치로 변경합니다
					map.setCenter(locPosition);
				}
			}
			function zoomIn() {
				map.setLevel(map.getLevel() - 1);
			}

			// 지도 확대, 축소 컨트롤에서 축소 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
			function zoomOut() {
				map.setLevel(map.getLevel() + 1);
			}
			//지도타입 컨트롤의 지도 또는 스카이뷰 버튼을 클릭하면 호출되어 지도타입을 바꾸는 함수입니다
			function setMapType(maptype) {
				var roadmapControl = document.getElementById('btnRoadmap');
				var skyviewControl = document.getElementById('btnSkyview');
				if (maptype === 'roadmap') {
					map.setMapTypeId(daum.maps.MapTypeId.ROADMAP);
					roadmapControl.className = 'selected_btn';
					skyviewControl.className = 'btn';
				} else {
					map.setMapTypeId(daum.maps.MapTypeId.HYBRID);
					skyviewControl.className = 'selected_btn';
					roadmapControl.className = 'btn';
				}
			}
		</script>

		<!-- 지도타입 컨트롤 div 입니다 -->
		<div class="custom_typecontrol radius_border">
			<span id="btnRoadmap" class="selected_btn"
				onclick="setMapType('roadmap')">지도</span> <span id="btnSkyview"
				class="btn" onclick="setMapType('skyview')">스카이뷰</span>
		</div>
		<div class="Set_Map Control_Map">
			<button type="button" class="btn_control mctr_nowpos"
				onclick="getLocation()">
				<span class="ico_comm ico_now">현위치</span>
				<div class="nowpos_spinner_wrap">
					<div class="spinner_wrapper">
						<div class="spinner_main">
							<div class="spinner_left">
								<div class="half_circle"></div>
							</div>
							<div class="spinner_right">
								<div class="half_circle"></div>
							</div>
						</div>
					</div>
				</div>
			</button>
			<button type="button" class="btn_control btn_zoomin mctr_zoomin"
				onclick="zoomIn()">
				<span class="ico_comm ico_zoomin">확대</span>
			</button>
			<button type="button" class="btn_control btn_zoomout mctr_zoomout"
				onclick="zoomOut()">
				<span class="ico_comm ico_zoomout">축소</span>
			</button>
		</div>
	</div>