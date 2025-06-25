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
<link rel="stylesheet" href="/resource/main2.css" />

<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=dfd275f49b78960a0458d6f6294cbde2&libraries=services"></script>
<script type="module" src="/resource/kakao.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.4/gsap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.4/ScrollTrigger.min.js"></script>
<script type="module" src="/resource/scroll.js"></script>

<div class="contain mx-auto">

	<div class="main_1-box">
		<div>
			<span>통증 부위를 직접 클릭해보세요</span>
		</div>
		<div class="webgl-container" id="webgl-container"></div>
	</div>

</div>

