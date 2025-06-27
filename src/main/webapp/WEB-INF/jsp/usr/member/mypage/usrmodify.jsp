<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="MY PAGE"></c:set>
<%@ include file="../../common/head2.jspf"%>

<script type="module" src="/resource/ajax.js"></script>
<link rel="stylesheet" href="/resource/common.css" />
<link rel="stylesheet" href="/resource/detail.css" />
<link rel="stylesheet" href="/resource/common2.css" />

<div class="contain flex flex-col items-center bg-gray-50 min-h-screen">

	<div class="info-con flex flex-col md:flex-row w-full max-w-5xl bg-white shadow-lg rounded-lg overflow-hidden">

		<!-- 좌측 사이드 메뉴 -->
		<div class="side-box w-full md:w-1/4 bg-emerald-100 p-6 space-y-4">
			<div class="h-12"></div>
			<ul class="space-y-2 text-gray-700 font-medium">
				<li>
					<a href="/usr/member/mypage/likepage" class="block py-2 px-4 rounded-lg hover:bg-emerald-200 transition">⭐ 즐겨찾기</a>
				</li>
				<li>
					<a href="/usr/member/mypage/myarticle" class="block py-2 px-4 rounded-lg hover:bg-emerald-200 transition">📝 내가
						쓴 글</a>
				</li>
				<li>
					<a href="/usr/member/mypage/usrmodify" class="block py-2 px-4 rounded-lg hover:bg-emerald-200 transition">⚙️
						회원정보 수정</a>
				</li>
			</ul>
		</div>

		<!-- 우측 내용 영역 -->
		<div class="info-box flex flex-col md:flex-row flex-1 p-8 space-x-0 md:space-x-8 space-y-8 md:space-y-0">

			<!-- 프로필 이미지 업로드 -->
			<div class="profile_img flex flex-col">
				<div class="MYimg_upload">
					<img src="${profileImage}" alt="프로필 이미지"
						class="w-40 h-40 object-cover rounded-full border border-gray-300 shadow-sm">
				</div>

				<form class="img_upload flex flex-col items-center space-y-2" action="/member/uploadProfile" method="post"
					enctype="multipart/form-data">
					<input type="file" name="profileImage" accept="image/*" class="text-sm">
					<button class="bg-emerald-500 rounded hover:bg-emerald-600 transition" type="submit">사진 저장</button>
				</form>
			</div>

			<!-- 회원정보 수정 폼 -->
			<div class="usrmodify-box">
				<form action="/usr/member/doModify" method="POST" onsubmit="return validatePasswords();" class="modify-form">
					<h2 class="modify-title">회원정보 수정</h2>

					<input type="hidden" name="loginId">

					<div class="form-group">
						<label class="form-label">아이디:</label>
						<span class="form-text">${member.loginId}</span>
					</div>

					<div class="form-group">
						<input type="password" name="loginPw" placeholder="비밀번호 변경" class="form-input">
					</div>

					<div class="form-group">
						<input type="password" name="loginPwConfirm" placeholder="비밀번호 확인" class="form-input">
					</div>

					<div class="form-group">
						<input type="text" required name="name" placeholder="이름" value="${member.name}" class="form-input">
					</div>

					<div class="form-group">
						<input type="text" required name="email" placeholder="이메일" value="${member.email}" class="form-input">
					</div>

					<div class="form-group">
						<input type="text" required name="nickname" placeholder="닉네임" value="${member.nickname}" class="form-input">
					</div>

					<div class="form-group">
						<input type="text" required name="cellphoneNum" placeholder="전화번호" value="${member.cellphoneNum}"
							class="form-input">
					</div>

					<c:if test="${rq.isLogined()}">
						<button type="submit" class="submit-btn">수정</button>
					</c:if>
				</form>
			</div>

		</div>

	</div>
</div>



<%@ include file="../../common/poot.jspf"%>