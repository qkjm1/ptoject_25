gsap.registerPlugin(ScrollTrigger);

gsap.to(".top-bar", {
	scrollTrigger: {
		trigger: ".top-bar", // 스크롤 기준 요소 변경
		start: "top -10%", // .main_1-box가 화면 20% 지점에 오면 트리거
		end: "top -11%",
		scrub:2,
		markers: true
		//    markers: true // start/end 디버깅 라인 보이게
	},
	y: 20,
	opacity: 1,
	duration: 1,
	ease: "power1.out"
});



gsap.to(".main_2-box", {
	scrollTrigger: {
		trigger: ".main_2-box", // 스크롤 기준 요소 변경
		start: "top 68%", // .main_1-box가 화면 20% 지점에 오면 트리거
		end: "top 69%",
		scrub: 1,
		markers: false // start/end 디버깅 라인 보이게
	},
	y: -30,
	opacity: 1,
	duration: 1,
	ease: "power1.out"
});


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