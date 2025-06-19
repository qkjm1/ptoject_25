<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="MY PAGE"></c:set>
<%@ include file="../../common/head.jspf"%>

<script type="module" src="/resource/ajax.js"></script>
<link rel="stylesheet" href="/resource/common.css" />
<link rel="stylesheet" href="/resource/detail.css" />
<link rel="stylesheet" href="/resource/common2.css" />
<div class="top-boundry-box"></div>
<div class="contain flex flex-col mx-auto">

	<div class="info-con flex mx-auto justify-around">
		<div class="side-box flex flex-col">
			<div class="h-40"></div>
			<ul>
				<li>
					<a href="/usr/member/mypage/likepage">즐겨찾기</a>
				</li>
			</ul>
			<ul>
				<li>
					<a href="/usr/member/mypage/myarticle">내가쓴글</a>
				</li>
			</ul>
			<ul>
				<li>
					<a href="/usr/member/mypage/usrmodify">회원정보수정</a>
				</li>
			</ul>
			<div class="flex-grow"></div>
		</div>
		<div class="w-3"></div>
		<div class="info-box flex justify-around">

			<div class="profile_img flex flex-col">

				<div class="MYimg_upload">
					<img src="${profileImage}" alt="프로필 이미지"
						style="width: 200px; height: 200px; border-radius: 50%;">
				</div>
				
				<form class="img_uploard flex flex-col" action="/member/uploadProfile" method="post" enctype="multipart/form-data">
					<input type="file" name="profileImage" accept="image/*" />
					<button class="btn" type="submit">저장</button>
				</form>
				
			</div>
			<div class="contents-box">
				<div class="usrModify-box">
					<form action="/usr/member/doModify" method="POST" onsubmit="return validatePasswords();">
						<h2>회원정보 수정</h2>
						<input type="hidden" name="loginId">
						<div>아이디: ${member.loginId}</div>

						<input type="password" name="loginPw" placeholder="비밀번호 변경">

						<input type="password" name="loginPwConfirm" placeholder="비밀번호 확인">

						<input type="text" required="required" name="name" placeholder="이름" value="${member.name}">

						<input type="text" required="required" name="email" placeholder="이메일" value="${member.email}">

						<input type="text" required="required" name="nickname" placeholder="닉네임" value="${member.nickname}">

						<input type="text" required="required" name="cellphoneNum" placeholder="전화번호" value="${member.cellphoneNum}">
						<c:if test="${rq.isLogined() }">
							<button type="submit">수정</button>
						</c:if>
					</form>
				</div>
			</div>


		</div>



	</div>
</div>



<%@ include file="../../common/poot.jspf"%>