/*
var mapContainer = document.getElementById('map'), // 지도를 표시할 div Add commentMore actions
	mapOption = {
		center: new kakao.maps.LatLng(33.452613, 126.570888), // 지도의 중심좌표
		level: 3
		// 지도의 확대 레벨
	};*/
//================위에가 기본적으로 호출하는것




// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
/*
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

		// ✅ 기본 마커로 표시
		const marker = new kakao.maps.Marker({
			position: userPosition,
			map: map
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
*/


$(function() {
	let map, userMarker;
	let markers = [];
	let hospitalsData = [];
	const mapContainer = document.getElementById('map');
	const hospitalList = document.getElementById('hospitalList');
	const ps = new kakao.maps.services.Places();

	// 1. 내 위치 받아서 지도 초기화 및 검색
	function initializeMap() {
		if (navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(position => {
				const lat = position.coords.latitude;
				const lon = position.coords.longitude;
				const userPos = new kakao.maps.LatLng(lat, lon);

				createMap(userPos);
				searchHospitals(userPos);

			}, () => {
				fallbackToSeoul();
			});
		} else {
			fallbackToSeoul();
		}
	}

	// 서울 기본 위치로 지도 초기화
	function fallbackToSeoul() {
		const seoul = new kakao.maps.LatLng(37.5665, 126.9780);
		createMap(seoul);
		searchHospitals(seoul);
	}

	// 지도 생성 및 내 위치 마커
	function createMap(position) {
		map = new kakao.maps.Map(mapContainer, {
			center: position,
			level: 4
		});

		if (userMarker) userMarker.setMap(null);

		userMarker = new kakao.maps.Marker({
			position: position,
			map: map,
			title: '내 위치'
		});
	}

	// 정형외과 검색 및 마커 생성, 리스트 표시
	function searchHospitals(position) {
		ps.keywordSearch('정형외과', (data, status) => {
			if (status === kakao.maps.services.Status.OK) {
				clearMarkers();
				hospitalsData = data; 
				hospitalsData.forEach(place => {
					createMarker(place);
				});
				displayHospitalList(hospitalsData);
			}
		}, {
			location: position,
			radius: 5000
		});
	}

	// 마커 제거 함수
	function clearMarkers() {
		markers.forEach(marker => marker.setMap(null));
		markers = [];
	}

	// 개별 마커 생성
	function createMarker(place) {
		const position = new kakao.maps.LatLng(place.y, place.x);
		const marker = new kakao.maps.Marker({
			map: map,
			position: position,
			title: place.place_name
		});

		kakao.maps.event.addListener(marker, 'click', () => {
			window.open(place.place_url, '_blank');
		});

		const infoWindow = new kakao.maps.InfoWindow({
			content: `<div style="padding:5px;">${place.place_name}</div>`
		});

		kakao.maps.event.addListener(marker, 'mouseover', () => infoWindow.open(map, marker));
		kakao.maps.event.addListener(marker, 'mouseout', () => infoWindow.close());

		markers.push(marker);
	}

	// 병원 리스트 출력 및 호버시 마커 효과
	function displayHospitalList(hospitals) {
		hospitalList.innerHTML = '';

		hospitals.forEach((place, idx) => {
			const li = document.createElement('li');
			li.innerHTML = `
        <strong>${place.place_name}</strong><br>
        📍 ${place.road_address_name || place.address_name}<br>
        🔗 <a href="${place.place_url}" target="_blank" rel="noopener noreferrer">상세보기</a>
      `;


			// 클릭시 상세 페이지 새탭 열기 (a태그 클릭과 중복될 수 있으니 옵션)
			li.addEventListener('click', () => {
				window.open(hospitals[idx].place_url, '_blank');
			});

			hospitalList.appendChild(li);
		});
	}

	// 내 위치 버튼 클릭 시 현재 위치로 이동
	$('#myLocationBtn').on('click', () => {
		if (navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(position => {
				const lat = position.coords.latitude;
				const lon = position.coords.longitude;
				const userPos = new kakao.maps.LatLng(lat, lon);

				if (userMarker) userMarker.setMap(null);

				userMarker = new kakao.maps.Marker({
					position: userPos,
					map: map,
					title: '내 위치'
				});

				map.setCenter(userPos);

				// 다시 검색해서 마커/리스트 갱신
				searchHospitals(userPos);

			}, () => {
				alert('위치 정보를 가져올 수 없습니다.');
			});
		} else {
			alert('이 브라우저는 위치 기능을 지원하지 않습니다.');
		}
	});

	// 초기 실행
	initializeMap();
});