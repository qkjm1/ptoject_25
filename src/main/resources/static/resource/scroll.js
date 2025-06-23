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



gsap.to(".main_2-box", {
	scrollTrigger: {
		trigger: ".top-bar", // 스크롤 기준 요소 변경
		start: "top -11%", // 탑바 나올때 깥이 나와라
		end: "top 81%",
		scrub: 2,
		markers: true // start/end 디버깅 라인 보이게
	},
	y: -20,
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


let features = gsap.utils.toArray(".sprite");

features.forEach((item, index) => {
	gsap.set(item, {
		autoAlpha: 0,
		yPercent: index > 3 ? "200" : "-200"
	});
});

const featureTL = gsap.timeline({ paused: true });

featureTL.to(features, {
	yPercent: 0,
	duration: 3,
	autoAlpha: 1,
	ease: "power2.inOut",
	stagger: {
		grid: [2, 4],
		from: "end",
		each: 0.5
	}
});


