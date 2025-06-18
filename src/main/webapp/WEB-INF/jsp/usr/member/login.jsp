<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="MEMBER JOIN"></c:set>
<%@ include file="../common/head.jspf"%>

<title>LOGIN</title>
<link rel="stylesheet" href="/resource/common.css" />
<div class="top-boundry-box"></div>
<div class="contain flex">
	<div class="contents-box flex">
		<div class="signup-box flex flex-col">
			<div class="mx-auto">LOGO</div>
			<form action="/usr/member/doLogin" method="POST" onsubmit="return validateIdPasswords();">
				<input type="text" name="loginId" placeholder="아이디">
				<input type="password" name="loginPw" placeholder="비밀번호">
				<button type="submit">로그인</button>
			</form>
		</div>
	</div>
</div>
<script>
	function validateIdPasswords() {

		const loginId = $("input[name='loginId']").val();
		const loginPw = $("input[name='loginPw']").val();

		if (!loginId) {
			alert("아이디를 입력해주세요.");
			$("input[name='loginId']").focus();
			return false;
		}
		console.log("===아이디입력===");

		if (!loginPw) {
			alert("비밀번호를 입력해주세요.");
			$("input[name='loginPw']").focus();
			return false;
		}
		console.log("===비번입력===");

		return location.replace('/usr/member/doLogin');
	}
</script>

<%@ include file="../common/poot.jspf"%>