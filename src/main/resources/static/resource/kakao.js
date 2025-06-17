/*
var mapContainer = document.getElementById('map'), // 지도를 표시할 div Add commentMore actions
	mapOption = {
		center: new kakao.maps.LatLng(33.452613, 126.570888), // 지도의 중심좌표
		level: 3
		// 지도의 확대 레벨
	};*/
//================위에가 기본적으로 호출하는것




// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다

const mapContainer = document.getElementById('map');
const defaultPosition = new kakao.maps.LatLng(37.5665, 126.9780); // 기본 서울 좌표

const mapOption = {
	center: defaultPosition,
	level: 4
};



const map = new kakao.maps.Map(mapContainer, mapOption);
const ps = new kakao.maps.services.Places();
// 카카오 서비스 라이브러리 불러오기


if (navigator.geolocation) {
	navigator.geolocation.getCurrentPosition(function(position) {
		const lat = position.coords.latitude;
		const lon = position.coords.longitude;
		const userPosition = new kakao.maps.LatLng(lat, lon);

		// 마커 표시
		const marker = new kakao.maps.Marker({
			position: userPosition,
			map: map,
			image: new kakao.maps.MarkerImage(
				'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_green.png', // 원하는 마커 이미지 URL
				new kakao.maps.Size(40, 42), // 마커 이미지 크기
				{ offset: new kakao.maps.Point(20, 42) } // 기준점 위치
			)
		});

		// 지도 중심 이동
		map.setCenter(userPosition);

		ps.keywordSearch('정형외과', function(data, status) {
			if (status === kakao.maps.services.Status.OK) {
				for (let i = 0; i < data.length; i++) {
					displayMarker(data[i]);
				}
			}
		}, {
			location: userPosition,
			radius: 5000 // 5km 반경 내에서 검색
		});


	}, function(error) {
		alert("위치 정보를 가져올 수 없습니다. 기본 위치로 표시됩니다.");
	});
} else {
	alert("이 브라우저는 위치 기능을 지원하지 않습니다.");
}


function displayMarker(place) {
	const marker = new kakao.maps.Marker({
		map: map,
		position: new kakao.maps.LatLng(place.y, place.x)
	});
	const infowindow = new kakao.maps.InfoWindow({
		content: `<div style="padding:5px;font-size:14px;">${place.place_name}</div>`
	});

	kakao.maps.event.addListener(marker, 'click', function() {
		infowindow.open(map, marker);
	});
}

function setCenter() {
	// 이동할 위도 경도 위치를 생성합니다 
	var moveLatLon = new kakao.maps.LatLng(33.452613, 126.570888);

	// 지도 중심을 이동 시킵니다
	map.setCenter(moveLatLon);
}

function panTo() {
	// 이동할 위도 경도 위치를 생성합니다 
	var moveLatLon = new kakao.maps.LatLng(lat, lon);

	// 지도 중심을 부드럽게 이동시킵니다
	// 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
	map.panTo(moveLatLon);
}