<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="MEMBER JOIN"></c:set>
<%@ include file="../common/head.jspf"%>

<title>JOIN</title>
<link rel="stylesheet" href="/resource/common.css" />
<div class="top-boundry-box"></div>
<div class="contents-box">
	<div class="signup-box flex">
		<form action="/usr/member/dojoin" method="POST" onsubmit="return validatePasswords();">
			<h2>회원가입</h2>
			<input type="text" name="loginId" placeholder="아이디">

			<input type="password" name="loginPw" placeholder="비밀번호">

			<input type="password" name="loginPwConfirm" placeholder="비밀번호 확인">

			<input type="text" name="name" placeholder="이름">

			<input type="text" name="email" placeholder="이메일">

			<input type="text" name="nickname" placeholder="닉네임">

			<input type="text" name="cellphoneNum" placeholder="전화번호">

			<button type="submit">가입하기</button>
		</form>
	</div>
</div>

<a href="/oauth2/code/naver">
    네이버 로그인하기
</a>

<script>
	function validatePasswords() {

		const loginId = $("input[name='loginId']").val();
		const loginPw = $("input[name='loginPw']").val();
		const loginPwConfirm = $("input[name='loginPwConfirm']").val();
		const name = $("input[name='name']").val();
		const email = $("input[name='email']").val();
		const nickname = $("input[name='nickname']").val();
		const cellphoneNum = $("input[name='cellphoneNum']").val();

		if (!loginId || !loginPw || !loginPwConfirm || !name || !email
				|| !nickname || !cellphoneNum) {
			alert("모든 항목을 입력해주세요.");
			return false;
		}
		console.log("===모든항목입력===");

		if (loginPw !== loginPwConfirm) {
			alert("비밀번호가 일치하지 않습니다.");
			$("input[name='loginPwConfirm']").focus();
			return false;
		}
		console.log("===비번일치===");

		return location.replace('/usr/member/dojoin');
	}
</script>

<%@ include file="../common/poot.jspf"%>