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
<link rel="stylesheet" href="/resource/main2.css" />
<link rel="stylesheet" href="/resource/main3.css" />
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=dfd275f49b78960a0458d6f6294cbde2&libraries=services"></script>
<script type="module" src="/resource/kakao.js"></script>
<div class="contain mx-auto flex flex-col">
	<div class="main_1-box flex">

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

	
	
	<div class="main_2-box">
	
		<div id="map" style="width: 800px; height: 800px;">map</div>
		
	</div>
	
	
	
	<div class="main_line_2-3"></div>
	
	
	
	<div class="flex-grow main_3-box">
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
					<h1 class="text-5xl">YOUTUBE</h1>
					<div id="article-list${i}" class="flex flex-col">
						<div id="youtube-con${i}" class="flex flex-col"></div>
					</div>
				</div>
			</c:forEach>
		</div>

		<div id="webgl-container"></div>


	</div>
</div>

<%@ include file="../common/poot.jspf"%>