gsap.registerPlugin(ScrollTrigger);

gsap.to(".top-bar", {
	scrollTrigger: {
		trigger: ".top-bar", // 스크롤 기준 요소 변경
		start: "top -10%", // .main_1-box가 화면 20% 지점에 오면 트리거
		end: "top -11%",
		scrub: 2,
		markers: false
		//    markers: true // start/end 디버깅 라인 보이게
	},
	y: 15,
	opacity: 1,
	duration: 1,
	ease: "power1.out"
});

// 탑바

gsap.to(".mainP", {
	scrollTrigger: {
		trigger: ".top-bar", // 스크롤 기준 요소 변경
		start: "top -15%", // 탑바 나올때 깥이 나와라
		end: "top -15%",
		scrub: 2,
		markers: true // start/end 디버깅 라인 보이게
	},
	y: -10,
	opacity: 1,
	duration: 1,
	ease: "power1.out"
});




// 메인2화면 윗부분
/*
gsap.to(".sprite", {
	scrollTrigger: {
		trigger: ".sprite", // 스크롤 기준 요소 변경
		start: "top 30%", // .main_1-box가 화면 20% 지점에 오면 트리거3
		end: "bottom 40%",
		scrub: 2,
		markers: false // start/end 디버깅 라인 보이a
	},
	y: 10,
	duration: 1,
	ease: "power1.out"
});
*/




//
const observer = new IntersectionObserver((entries) => {
	entries.forEach(entry => {
		if (entry.isIntersecting) {
			entry.target.classList.add('in-view');
		}
	});
}, {
	threshold: 0.1
});

document.querySelectorAll('.mainP').forEach(el => observer.observe(el));



const sprites = document.querySelectorAll(".sprite");

const observerfade = new IntersectionObserver((entries) => {
	entries.forEach((entry, index) => {
		if (entry.isIntersecting) {
			// 순차 delay 부여
			sprites.forEach((el, i) => {
				setTimeout(() => {
					el.classList.add("in-view");
				}, i * 100); // 0.1초 간격으로 등장
			});
			// 한 번만 실행되도록 관찰 중지
			observerfade.disconnect();
		}
	});
}, {
	threshold: 0.2
});

if (sprites.length > 0) {
	observerfade.observe(sprites[0]); // 첫 번째 요소로 트리거
}


//


$('#scrollBtn').on('click', function () {
  $('html, body').animate({
    scrollTop: $('.mainP').offset().top
  }, 600);
});


//


$(document).ready(function () {
  $('#mapBtn').on('click', function () {
    $('#map').toggleClass('active');
  });
});


//

$('#mouse-icon').one('mouseover', function() {
  $(this).remove(); // ✅ DOM에서 영구히 제거
});
