import * as THREE from 'three';
import { GLTFLoader } from 'GLTFLoader';
import { OrbitControls } from 'OrbitControls';

const container = document.getElementById('webgl-container');

// === Scene, Camera, Renderer ===
const scene = new THREE.Scene();
scene.background = new THREE.Color(0x494949);


const width = window.innerWidth;
const height = 1000;

const camera = new THREE.PerspectiveCamera(75, width / height, 0.1, 1000);
camera.position.set(0, 3, 8);

const renderer = new THREE.WebGLRenderer({ antialias: true });
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
const directionalLight = new THREE.DirectionalLight(0xffffff, 2);
directionalLight.position.set(-1, 2, 4);
scene.add(directionalLight);

const ambientLight = new THREE.AmbientLight(0xffffff, 0.6);
scene.add(ambientLight);

// === GLTF Model Load ===
const loader = new GLTFLoader();
let model; // 모델을 클릭 이벤트에서 사용하기 위해 전역 변수로

loader.load('/models/Low_Part.glb', function(gltf) {
	model = gltf.scene;
	scene.add(model);

	model.scale.set(3, 3, 3);
	model.position.set(2, -1.5, 4);

	model.traverse((child) => {
		if (child.isMesh) {
			console.log('Mesh Loaded:', child.name);
			child.userData.name = child.name;
			child.visible = true;
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

function InfoArticle__get(partId) {

	console.log(partId);
	$.get('/usr/article/infomainlist', {
		partId: partId,
		ajaxMode: 'Y'
	}, function(data) {
		const articles = data.articles;

		const $listContainer = $('#article-list'+partId); // 결과를 뿌릴 요소 ID
		$listContainer.empty(); // 기존 리스트 비우기


		if (!articles || articles.length === 0) {
			$listContainer.append('<div class="noAr flex" style="text-align:center;">게시글이 없습니다</div>');
		} else {
			articles.forEach(article => {
				console.log(articles);


				const dateStr = article.regDate.substring(0, 10);


				const html = `
				<div class="qna-con flex flex-col mx-auto">				
						<div class="qna-box">
						<div class="qna-title mx-auto flex items-end justify-center">
							<div class="flex-grow">	
								<a href="#" class="text-xl font-bold text-black">${article.title}</a>
							</div>
							<div class="flex-grow"></div>
							<div class="text-black">작성자:${article.extra__writer}&nbsp&nbsp</div>
							<div class="text-black">작성일:${dateStr}</div>
						</div>
						<div class="partLine w-100%"></div>		
						<div class="qna-body text-black">
						<a href="/usr/article/detail?articleId=${article.id}">${article.body}</a>
						</div>
					</div>
				</div>
	            `;
				$listContainer.append(html);


			});
		}
	}, 'json');
}



// === Raycaster ===
const raycaster = new THREE.Raycaster();
const mouse = new THREE.Vector2();

let selectedMesh = null;

window.addEventListener('click', (event) => {
	const rect = renderer.domElement.getBoundingClientRect();
	mouse.x = ((event.clientX - rect.left) / rect.width) * 2 - 1;
	mouse.y = -((event.clientY - rect.top) / rect.height) * 2 + 1;

	raycaster.setFromCamera(mouse, camera);

	if (model) {
		const intersects = raycaster.intersectObjects(model.children, true);

		if (intersects.length > 0) {
			const clickedPart = intersects[0].object;
			const partName = clickedPart.name;
			console.log('Clicked:', partName);
			let $target = $('.show.' + partName);
			const partId = nameToIdMap[partName];


			if (selectedMesh === clickedPart) {
				clickedPart.material = clickedPart.material.clone();
				clickedPart.material.color.set('#ccc'); // 기본색
				selectedMesh = null;
				$('.show').removeClass('active');
				return;
			}


			model.traverse(child => {
				if (child.isMesh) {
					// 모든 mesh 초기화 (필요 시 clone된 material도 덮어씀)
					if (child.material.isMaterial) {
						child.material = child.material.clone();
						child.material.color.set('#ccc'); // 기본색
					}
				}
			});

			// 클릭된 파트만 강조색으로 변경
			if (clickedPart.material.isMaterial) {
				clickedPart.material = clickedPart.material.clone();
				clickedPart.material.color.set('#EAD292'); // 강조색
				selectedMesh = clickedPart;
				console.log(partId);
			}

			if (partId !== undefined) {
				InfoArticle__get(partId);
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
	const deltaY = event.clientY - previousMousePosition.y;

	// 수평 회전 (Y축)
	model.rotation.y += deltaX * 0.01;

	// 수직 회전 (X축 기준으로 회전)
	model.rotation.x += deltaY * 0.01;

	previousMousePosition.x = event.clientX;
	previousMousePosition.y = event.clientY;
});


// === 반응형 ===
window.addEventListener('resize', () => {
	camera.aspect = window.innerWidth / height;
	camera.updateProjectionMatrix();
});

// === 애니메이션 루프 ===
function animate() {
	requestAnimationFrame(animate);
	controls.update();
	renderer.render(scene, camera);
}
animate();