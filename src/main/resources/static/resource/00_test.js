import * as THREE from 'three';
import { GLTFLoader } from 'GLTFLoader';
import { OrbitControls } from 'OrbitControls';

const container = document.getElementById('webgl-container');

// === Scene, Camera, Renderer ===
const scene = new THREE.Scene();
scene.background = new THREE.Color(0xffffff);


const width = container.clientWidth;
const height = container.clientHeight;

const camera = new THREE.PerspectiveCamera(75, width / height, 0.1, 1000);
camera.position.set(5, 1.7, 5);


const renderer = new THREE.WebGLRenderer({ antialias:false });
renderer.setSize(width, height);
container.appendChild(renderer.domElement);

// === Controls ===
const controls = new OrbitControls(camera, renderer.domElement);
controls.enableDamping = true;
controls.enablePan = false; // 이동 비활성화 (고정)
controls.enableRotate = false;
controls.enableZoom = false; //확대축소 막기
controls.update();

// === Lighting ===
const directionalLight = new THREE.DirectionalLight(0x787878, 2);
directionalLight.position.set(-1, 2, 4);
scene.add(directionalLight);

const ambientLight = new THREE.AmbientLight(0xD8D8D8, 0.6);
scene.add(ambientLight);

// === GLTF Model Load ===
const loader = new GLTFLoader();
let model; // 모델을 클릭 이벤트에서 사용하기 위해 전역 변수로

loader.load('/models/QK7.glb', function(gltf) {
	console.log(gltf.scene.scale); // 1,1,1이어야 정상
	console.log(gltf.scene.rotation); // 0,0,0이 기본

	model = gltf.scene;
	model.rotation.set(0, 0.8, 0); // ← 여기!
	model.scale.set(3, 3, 3); // ===========================크기바꾸기 크기 바뀌;ㅣ
	model.position.set(0, -4, 0);
	
	scene.add(model);   // 비동기식 흐름 제어

	model.traverse((child) => {
		if (child.isMesh) {
			console.log('Mesh Loaded:', child.name);
			child.userData.name = child.name;
			child.visible = true;
			child.material = child.material.clone();
			child.material.color.set('#949494');
		}
	});
}, undefined, function(error) {
	console.error('모델 로딩 중 오류 발생:', error);
});


const nameToIdMap = {
	"Head": 1,
	"Neck_Shoulder_B": 2,
	"Neck_Shoulder_F": 3,
	"Arms": 4,
	"Chest_B": 5,
	"Chest_F": 6,
	"Pelvic": 7,
	"Legs_F": 8,
	"Legs_B": 9,
	"Calf": 10
};

// 유튜브
const queryToName = {
  "Head": "편두통+후두하근",
  "Neck_Shoulder_B": "어깨통증+회전근개",
  "Neck_Shoulder_F": "둥근어깨+쇄골통증",
  "Arms": "테니스엘보+골프엘보+손목터널증후군",
  "Chest_B": "척추측만증+강직성척추염+추간판탈출증",
  "Chest_F": "코어운동",
  "Pelvic": "궁둥구멍증후군",
  "Legs_F": "대퇴근통증",
  "Legs_B": "햄스트링통증",
  "Calf": "발목통증+종아리신경병증+족저근막염"
};


// queryToName은 query 문자열 모음 // 문자를 저장해놓은걸 다시 숫자로 호출할 수 있게끔 바꿔놓기
const queryMap = {
	1: queryToName["Head"],
	2: queryToName["Neck_Shoulder_B"],
	3: queryToName["Neck_Shoulder_F"],
	4: queryToName["Arms"],
	5: queryToName["Chest_B"],
	6: queryToName["Chest_F"],
	7: queryToName["Pelvic"],
	8: queryToName["Legs_F"],
	9: queryToName["Legs_B"],
	10: queryToName["Calf"]
};



// === Raycaster ===
const raycaster = new THREE.Raycaster();
const mouse = new THREE.Vector2();

let selectedMesh = null;

window.addEventListener('click', (event) => {
	const rect = renderer.domElement.getBoundingClientRect();
	mouse.x = ((event.clientX - rect.left) / rect.width) * 2 - 1;
	mouse.y = -((event.clientY - rect.top) / rect.height) * 2 + 1;

	
	


	raycaster.setFromCamera(mouse, camera);
	console.log('Mouse NDC:', mouse.x, mouse.y);
	if (model) {
		const intersects = raycaster.intersectObjects(model.children, true);
		console.log('Intersects:', intersects.length);

		if (intersects.length > 0) {
			$('.text').css('display', 'none');
			const clickedPart = intersects[0].object;
			const partName = clickedPart.name;

			const partId = nameToIdMap[partName];
			const query = queryToName[partName];

			let $target = $('.partNo' + partId);

			console.log("$target: " + $target);
			if (selectedMesh === clickedPart) {
				clickedPart.material = clickedPart.material.clone();
				clickedPart.material.color.set('#949494'); // 기본색
				selectedMesh = null;
				$('.show').removeClass('active');
				return;
			}


			model.traverse(child => {
				if (child.isMesh) {
					// 모든 mesh 초기화 (필요 시 clone된 material도 덮어씀)
					if (child.material.isMaterial) {
						child.material = child.material.clone();
						child.material.color.set('#949494'); // 기본색
						child.material.side = THREE.DoubleSide;
						child.material.transparent = false;
						child.material.depthWrite = true;
						child.castShadow = true;
						child.receiveShadow = true;
					}
				}
			});

			// 클릭된 파트만 강조색으로 변경
			if (clickedPart.material.isMaterial) {
				clickedPart.material = clickedPart.material.clone();
				clickedPart.material.color.set('#9A5F61'); // 강조색
				selectedMesh = clickedPart;
			}

			if (partId !== undefined) {
				currentQuery = query;
				currentPartId = partId;

				console.log(partId);
				InfoArticle__get(partId);
//				youtubeList__get(query, partId);
			} else {
				console.warn('Unknown part name:', partName);
			}


			if ($target.hasClass('active')) {
				$target.removeClass('active'); // 이미 활성화되어 있으면 비활성화
			} else {
				$('.show').removeClass('active'); // 다른 것들은 비활성화
				$target.addClass('active');       // 현재 클릭한 것만 활성화
			}
		}
	}
});

let isMouseDown = false;
let previousMousePosition = { x: 0, y: 0 };

renderer.domElement.addEventListener('mousedown', (event) => {
	isMouseDown = true;
	previousMousePosition.x = event.clientX;
	previousMousePosition.y = event.clientY;
});

renderer.domElement.addEventListener('mouseup', () => {
	isMouseDown = false;
});

renderer.domElement.addEventListener('mousemove', (event) => {
	if (!isMouseDown || !model) return;

	const deltaX = event.clientX - previousMousePosition.x;
//	const deltaY = event.clientY - previousMousePosition.y;

	// 수평 회전 (Y축)
	model.rotation.y += deltaX * 0.008;  //이거이거이억잉겅기억회전값 회전값

	// 수직 회전 (X축 기준으로 회전)
//	model.rotation.x += deltaY * 0.008;

	previousMousePosition.x = event.clientX;
	previousMousePosition.y = event.clientY;
});






// === 반응형 ===
window.addEventListener('resize', () => {
	camera.aspect = width / height;
	camera.updateProjectionMatrix();
	renderer.setSize(width, height);
});

// === 애니메이션 루프 ===
function animate() {
	requestAnimationFrame(animate);
	controls.update();
	renderer.render(scene, camera);
}
animate();




//==========================
function InfoArticle__get(partId) {

	console.log(partId);
	$.get('/usr/article/infomainlist', {
		partId: partId,
		ajaxMode: 'Y'
	}, function(data) {
		const articles = data.articles;

		const $listContainer = $('#article-list' + partId); // 결과를 뿌릴 요소 ID
		$listContainer.empty(); // 기존 리스트 비우기


		if (!articles || articles.length === 0) {
			$listContainer.append('<div class="noAr flex" style="text-align:center;">게시글이 없습니다</div>');
		} else {
			articles.forEach(article => {
				console.log(articles);


				//				const dateStr = article.regDate.substring(0, 10); 날짜 포멧 안쓰여서 일단 둠


				const html = `
				<div class="maininfo-con" onclick="location.href='/usr/article/detail?articleId=${article.id}'" role="link" tabindex="0">
				  <div class="maininfo-box">
				    <div class="maininfo-title">
				      <div>
				        <a href="#" tabindex="-1">${article.title}</a>
				      </div>
				    </div>
				    <div class="maininfo-body">
				      <a href="/usr/article/detail?articleId=${article.id}" tabindex="-1">${article.body}</a>
				    </div>
				  </div>
				</div>
	            `;
				$listContainer.append(html);


			});
		}
	}, 'json');
}




let nextPageToken = null;
let isLoading = false;
let currentQuery = null;
let currentPartId = null;


/*
async function youtubeList__getMultiple(queryMap) {
	console.log("유튜브 api응답함");
	// queryMap: { partId: query, ... }
	if (isLoading) return;
	isLoading = true;

	
	const entries = Object.entries(queryMap);

	const requests = entries.map(async ([partId, query]) => {
		try {	
			const safeQuery = String(query).trim(); // 혹은 query.toString()
			console.log(query);
			const res = await fetch(`/youtube/search?q=${encodeURIComponent(safeQuery)}&ajaxMode=Y`);
			const data = await res.json();
			return ({ partId, data });
		} catch (err) {
			console.error(`Error fetching for partId=${partId}`, err);
			return { partId, data: null };
		}
	});

	const results = await Promise.all(requests);

	results.forEach(({ partId, data }) => {
		const $container = $('#youtube-con' + partId);
		$container.empty(); // 기존 비우기

		if (!data || !data.videos || data.videos.length === 0) {
			$container.append('<div class="noAr flex" style="text-align:center;">게시글이 없습니다</div>');
			return;
		}

		data.videos.forEach(video => {
			const html = `
					<div class="video-item">
						<div class="thumbnail">
							<a href="https://www.youtube.com/watch?v=${video.id.videoId}" target="_blank">
								<img src="${video.snippet.thumbnails.medium.url}" alt="${video.snippet.title}" />
							</a>
						</div>
						<div class="video-info">
							<a href="https://www.youtube.com/watch?v=${video.id.videoId}" target="_blank">
								<strong class="video-title">${video.snippet.title}</strong>
							</a>
							<p class="video-description">${video.snippet.description}</p>
						</div>
					</div>`;
			$container.append(html);
		});
	});
}
*/

$('.show').on('scroll', function() {
	const $this = $(this);
	const nearBottom = $this.scrollTop() + $this.innerHeight() + 100 >= $this[0].scrollHeight;

	if (nearBottom && !isLoading && nextPageToken && currentQuery && currentPartId) {
		youtubeList__getMultiple(currentQuery, currentPartId);
	}
});


// youtubeList__getMultiple(queryMap);
/*
const youtubeLoadCache = {}; // { partId: true }

async function youtubeList__getMultiple(queryToName, queryMap) {
	console.log("유튜브 api응답함");

	if (isLoading) return;
	isLoading = true;
	consloe.log(queryMap);
	const entries = Object.entries(queryMap);

	const requests = entries.map(async ([partId, query]) => {
		// 이미 불러온 적 있으면 건너뜀
		if (youtubeLoadCache[partId]) {
			return null;
		}

		try {
			const res = await fetch(`/youtube/search?q=${encodeURIComponent(query)}&ajaxMode=Y`);
			const data = await res.json();

			// 성공적으로 불러오면 캐시에 등록
			youtubeLoadCache[partId] = true;

			return { partId, data };
		} catch (err) {
			console.error(`Error fetching for partId=${partId}`, err);
			return { partId, data: null };
		}
	});

	const results = await Promise.all(requests);

	results.forEach(result => {
		if (!result) return;

		const { partId, data } = result;
		const $container = $('#youtube-con' + partId);
		$container.empty(); // 기존 비우기

		if (!data || !data.videos || data.videos.length === 0) {
			$container.append('<div class="noAr flex" style="text-align:center;">게시글이 없습니다</div>');
			return;
		}

		data.videos.forEach(video => {
			const html = `
				<div class="video-item">
					<div class="thumbnail">
						<a href="https://www.youtube.com/watch?v=${video.id.videoId}" target="_blank">
							<img src="${video.snippet.thumbnails.medium.url}" alt="${video.snippet.title}" />
						</a>
					</div>
					<div class="video-info">
						<a href="https://www.youtube.com/watch?v=${video.id.videoId}" target="_blank">
							<strong class="video-title">${video.snippet.title}</strong>
						</a>
						<p class="video-description">${video.snippet.description}</p>
					</div>
				</div>`;
			$container.append(html);
		});
	});

	isLoading = false;
}







*/










function youtubeList__get(query, partId, isNewSearch = false) {
	if (isLoading) return;
	isLoading = true;

	if (isNewSearch) {
		nextPageToken = null;  // 페이지 초기화
		$('#youtube-con' + partId).empty();  // 기존 리스트 비우기
	}


	$.get('/youtube/search', {
		q: query,
		pageToken: nextPageToken,
		ajaxMode: 'Y'
	}, function(data) {
		const videos = data.videos;
		nextPageToken = data.nextPageToken;

		const $listContainer = $('#youtube-con' + partId); // 결과를 뿌릴 요소 ID
		// 기존 리스트 비우기


		if (!videos || videos.length === 0) {
			$listContainer.append('<div class="noAr flex" style="text-align:center;">게시글이 없습니다</div>');
		} else {
			videos.forEach(video => {

				const html = `
				<div class="video-item">
									<div class="thumbnail">
										<a href="https://www.youtube.com/watch?v=${video.id.videoId}" target="_blank">
											<img src="${video.snippet.thumbnails.medium.url}" alt="${video.snippet.title}" />
										</a>
									</div>
									<div class="video-info">
										<a href="https://www.youtube.com/watch?v=${video.id.videoId}" target="_blank">
											<strong class="video-title">${video.snippet.title}</strong>
										</a>
										<p class="video-description">${video.snippet.description}</p>
									</div>
								</div>

				`;
				$listContainer.append(html);
			});
			isLoading = false;
		}
	}, 'json');
}



//

const web3d_container = document.getElementById('web3d-container');


// === Scene, Camera, Renderer ===
const scene2 = new THREE.Scene();
scene2.background = new THREE.Color(0xffffff);


const width2 = web3d_container.clientWidth;
const height2 = web3d_container.clientHeight;

const camera2 = new THREE.PerspectiveCamera(75, width2 / height2, 0.1, 1000);
camera2.position.set(0, 6, 10);  // 위 + 약간 앞에서 보는 느낌
camera2.lookAt(0, 0, 0);         // 모델 중심


const renderer2 = new THREE.WebGLRenderer({ antialias:false });
renderer2.setSize(width2, height2);
web3d_container.appendChild(renderer2.domElement);
//그림자 설정
renderer2.shadowMap.enabled = true;
renderer2.shadowMap.type = THREE.PCFSoftShadowMap; // 부드러운 그림자 (선택)
// === Controls ===
const controls2 = new OrbitControls(camera2, renderer2.domElement);
controls2.enableDamping = true;
controls2.enablePan = false; // 이동 비활성화 (고정)
controls2.enableRotate = false;
controls2.enableZoom = false; //확대축소 막기
controls2.update();

// === Lighting ===
const directionalLight2 = new THREE.DirectionalLight(0x787878, 2);
directionalLight2.castShadow = true;

directionalLight2.shadow.camera.left = -10;
directionalLight2.shadow.camera.right = 10;
directionalLight2.shadow.camera.top = 10;
directionalLight2.shadow.camera.bottom = -10;
directionalLight2.shadow.camera.near = 1;
directionalLight2.shadow.camera.far = 20;

// 그림자 만들기
directionalLight2.position.set(-1, 5, 4);
scene2.add(directionalLight2);

const ambientLight2 = new THREE.AmbientLight(0xD8D8D8, 0.6);
scene2.add(ambientLight2);

// === GLTF Model Load ===
const loader2 = new GLTFLoader();
let model2; // 모델을 클릭 이벤트에서 사용하기 위해 전역 변수로

loader2.load('/models/QK13.glb', function(gltf) {
	console.log(gltf.scene.scale);
	console.log(gltf.scene.rotation);

	model2 = gltf.scene;
	model2.rotation.set(0, 0, 0);
	model2.scale.set(4, 4, 4);
	model2.position.set(0, 0, 7);
	
	scene2.add(model2);

	model2.traverse((child) => {
		if (child.isMesh) {
			console.log('Mesh Loaded:', child.name);
			child.userData.name = child.name;
			child.visible = true;
			child.material = child.material.clone();
			child.material.color.set('#CACACA');
			child.castShadow = true;       // ✅ 그림자를 떨어뜨리기
		}
	});
}, undefined, function(error) {
	console.error('모델 로딩 중 오류 발생:', error);
});


const groundGeo = new THREE.PlaneGeometry(200, 200);
const groundMat = new THREE.ShadowMaterial({ opacity: 0.5 }); // 그림자만 받는 재질

const ground = new THREE.Mesh(groundGeo, groundMat);
ground.rotation.x = -Math.PI / 2;
ground.position.y = 0; // y=0 위치에 평면

ground.receiveShadow = true; // 그림자 받기 활성화
scene2.add(ground);

//디버깅용	



let mouseX2 = 0;
let mouseY2 = 0;

// 브라우저 전체 기준으로 -1 ~ 1 정규화된 마우스 좌표 계산
window.addEventListener('mousemove', (event) => {
  mouseX2 = (event.clientX / window.innerWidth) * 2 - 1;
  mouseY2 = -(event.clientY / window.innerHeight) * 2 + 1;
});

function animate2() {
  requestAnimationFrame(animate2);
  
  // 카메라 회전(시선 따라오는 느낌) → 부드럽게 Lerp
   const targetX = mouseX2 * 0.3; // 좌우 회전 정도
   const targetY = mouseY2 * 0.3; // 위아래 회전 정도

   // 카메라가 중심을 바라보는 위치를 조절 (카메라가 고정된 위치에서 시선을 움직이는 느낌)
   camera2.lookAt(
     new THREE.Vector3(targetX, targetY, 0)
   );
  
  //controls2.update();
  renderer2.render(scene2, camera2);
  
}
animate2();
