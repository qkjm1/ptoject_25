<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="MAIN PAGE"></c:set>
<%@ include file="../common/head.jspf"%>
<title>MAIN</title>

<link rel="stylesheet" href="/resource/main.css" />
<link rel="stylesheet" href="/resource/main2.css" />
<div class="contain mx-auto flex flex-col">
	<div class="main_1-box flex">

		<div class="show Head">
			<div id="article-list1" class="flex flex-col"></div>
		</div>
		<div class="show Neck_Shoulder_B">
			<div id="article-list2" class="flex flex-col"></div>
		</div>
		<div class="show Neck_Shoulder_F">
			<div id="article-list2" class="flex flex-col"></div>
		</div>
		<div class="show Arms">
			<div id="article-list3" class="flex flex-col"></div>
		</div>
		<div class="show Chest_B">
			<div id="article-list4" class="flex flex-col"></div>
		</div>
		<div class="show Chest_F">
			<div id="article-list4" class="flex flex-col"></div>
		</div>
		<div class="show Legs_B">
			<div id="article-list5" class="flex flex-col"></div>
		</div>
		<div class="show Legs_F">
			<div id="article-list5" class="flex flex-col"></div>
		</div>
		<div class="show Pelvic">
			<div id="article-list5" class="flex flex-col"></div>
		</div>
		<div class="show Calf">
			<div id="article-list6" class="flex flex-col"></div>
		</div>



		<div id="webgl-container"></div>

	</div>



	<div class="main_2-box">
		<div class="info-box flex flex-col">
			<form action="/usr/article/infolist" method="post" class="mx-auto">
				<input type="hidden" name="searchKeywordTypeCode" value="QnA" />
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
			<div class="info-box-items grid grid-cols-3 gap-4 max-w-xl mx-auto">
				<div>
					<a href="">
						<img src="" alt="" />
					</a>
				</div>
				<div>
					<a href="">
						<img src="" alt="" />
					</a>
				</div>
				<div>
					<a href="">
						<img src="" alt="" />
					</a>
				</div>
				<div>
					<a href="">
						<img src="" alt="" />
					</a>
				</div>
				<div>
					<a href="">
						<img src="" alt="" />
					</a>
				</div>
				<div>
					<a href="">
						<img src="" alt="" />
					</a>
				</div>
			</div>
		</div>
	</div>
	<div class="flex-grow main_3-box"></div>
</div>
<%@ include file="../common/poot.jspf"%>


<script type="importmap">
    {
      "imports": {
        "three": "https://unpkg.com/three@0.141.0/build/three.module.js",
        "GLTFLoader": "https://unpkg.com/three@0.141.0/examples/jsm/loaders/GLTFLoader.js",
        "OrbitControls": "https://unpkg.com/three@0.141.0/examples/jsm/controls/OrbitControls.js"
      }
    }
  </script>

<script type="module" src="/resource/00_TEST.js"></script>

</script>