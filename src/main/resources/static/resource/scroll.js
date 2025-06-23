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
	y: 18,
	opacity: 1,
	duration: 1,
	ease: "power1.out"
});

// 탑바

gsap.to(".main_2-box", {
	scrollTrigger: {
		trigger: ".top-bar", // 스크롤 기준 요소 변경
		start: "top -15%", // 탑바 나올때 깥이 나와라
		end: "top -15%",
		scrub: 2,
		markers: true // start/end 디버깅 라인 보이게
	},
	y: -200,
	opacity: 1,
	duration: 1,
	ease: "power1.out"
});


ScrollTrigger.create({
	trigger: ".pin-section",
	start: "top top",       // 섹션이 화면 상단에 닿을 때
	end: "+=100",          // 100px 스크롤할 때까지 고정
	pin: true,              // 고정!
	pinSpacing: true		// 아래 콘텐츠 밀려나게 (false로 하면 겹침)
});

// 메인2화면 윗부분

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


gsap.to(".mob", {
	scrollTrigger: {
		trigger: ".sprite", // 스크롤 기준 요소 변경
		start: "top 30%", // .main_1-box가 화면 20% 지점에 오면 트리거3
		end: "bottom 60%",
		scrub: 2,
		markers: false // start/end 디버깅 라인 보이게
	},
	y: 20,
	duration: 1,
	ease: "power1.out"
});





//



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
