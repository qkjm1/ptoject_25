<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="MAIN PAGE"></c:set>
<%@ include file="../common/head.jspf"%>
<title>MAIN</title>


<script type="importmap">
    {
      "imports": {
        "three": "https://unpkg.com/three@0.141.0/build/three.module.js",
        "GLTFLoader": "https://unpkg.com/three@0.141.0/examples/jsm/loaders/GLTFLoader.js",
        "OrbitControls": "https://unpkg.com/three@0.141.0/examples/jsm/controls/OrbitControls.js"
      }
    }
  </script>

<script type="module" src="/resource/ajax.js"></script>
<script type="module" src="/resource/00_TEST.js"></script>
<link rel="stylesheet" href="/resource/main.css" />

<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=dfd275f49b78960a0458d6f6294cbde2&libraries=services"></script>
<script type="module" src="/resource/kakao.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.4/gsap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.4/ScrollTrigger.min.js"></script>
<script type="module" src="/resource/scroll.js"></script>

<div class="contain mx-auto flex flex-col">
	<div class="main_1-box flex">

		<form class="w-full flex">
			<input type="hidden" name="searchKeywordTypeCode" value="info" />
			<input type="hidden" name="boardId" value="2" />
			<div class="search-box">
				<input type="text" placeholder="검색어를 입력하세요" name="searchKeyword" value="${param.searchKeyword}" />
				<button type="submit">
					<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
						stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
  <circle cx="11" cy="11" r="8" />
  <line x1="21" y1="21" x2="16.65" y2="16.65" />
</svg>
				</button>
			</div>
		</form>

	</div>



	<div class="mainP main_2-box">

		<button id="scrollBtn" class="scroll-down">
			<div>
				<span>말로 표현하기 어렵다면?</span>
				<br />
				<span>click!</span>
			</div>
			<svg width="40" height="40" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" stroke="black"
				stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
    <polyline points="6 9 12 15 18 9" />
  </svg>
		</button>
		<div class="text">
			<span>어디가 아픈지</span>
			<br />
			<span>클릭만 하세요!</span>
			<br />
			<span>당신의 통증, </span>
			<span>시각적으로 해결합니다.</span>
		</div>

		<div class="main_1-box1 flex">
			<c:forEach var="i" begin="1" end="10">
				<div class="show partNo${i}">
					<div id="article-list${i}" class="flex flex-col"></div>
				</div>
			</c:forEach>
		</div>

		<div class="main_1-box2 flex youtube-block">
			<c:forEach var="i" begin="1" end="10">
				<div class="show partNo${i}">
					<div class="youtube-et">YOUTUBE</div>
					<div id="youtube-con${i}" class="flex"></div>
				</div>
			</c:forEach>
		</div>

		<div id="mouse-icon" class="">
			<svg class="mouse-icon" viewBox="0 0 60 90" fill="none" xmlns="http://www.w3.org/2000/svg">
    <rect x="10" y="5" width="40" height="80" rx="20" stroke="white" stroke-width="4" />
    <line x1="30" y1="20" x2="30" y2="35" stroke="white" stroke-width="4" stroke-linecap="round" />
  </svg>
		</div>

		<div id="webgl-container">
			<div id="mouse-icon-min" class="flex">
				<span>좌우로 회전</span>
				<svg class="mouse-icon-min" viewBox="0 0 60 90" fill="none" xmlns="http://www.w3.org/2000/svg">
    <rect x="10" y="5" width="40" height="80" rx="20" stroke="black" stroke-width="4" />
    <line x1="30" y1="20" x2="30" y2="35" stroke="black" stroke-width="4" stroke-linecap="round" />
  </svg>
			</div>
		</div>

	</div>





	<div class="main_3-box">

		<span>간편 클릭으로도 가능해요!</span>
		<span>간편 클릭으로 해당부위를 알아볼 수 있어요!</span>
		<div class="info-box flex flex-col">
			<div class="info-box-items grid grid-cols-5 max-w-4xl gap-4 mx-auto">
				<div class="sprite sprite-1" onclick="location.href='/usr/article/infolist?boardId=2&partId=1'"></div>
				<div class="sprite sprite-2" onclick="location.href='/usr/article/infolist?boardId=2&partId=2'"></div>
				<div class="sprite sprite-3" onclick="location.href='/usr/article/infolist?boardId=2&partId=3'"></div>
				<div class="sprite sprite-4" onclick="location.href='/usr/article/infolist?boardId=2&partId=4'"></div>
				<div class="sprite sprite-5" onclick="location.href='/usr/article/infolist?boardId=2&partId=5'"></div>
				<div class="sprite sprite-6" onclick="location.href='/usr/article/infolist?boardId=2&partId=6'"></div>
				<div class="sprite sprite-7" onclick="location.href='/usr/article/infolist?boardId=2&partId=7'"></div>
				<div class="sprite sprite-8" onclick="location.href='/usr/article/infolist?boardId=2&partId=8'"></div>
				<div class="sprite sprite-9" onclick="location.href='/usr/article/infolist?boardId=2&partId=9'"></div>
				<div class="sprite sprite-10" onclick="location.href='/usr/article/infolist?boardId=2&partId=10'"></div>
			</div>
		</div>
		<button id="mapBtn" class="map-slide">
			click!
			<svg width="40" height="40" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" stroke="black"
				stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
    <polyline points="6 9 12 15 18 9" />
  </svg>
		</button>
		<div class="slide-map">
			<div id="map" style="width: 200px; height: 200px;">map</div>
		</div>

	</div>
</div>

<%@ include file="../common/poot.jspf"%>