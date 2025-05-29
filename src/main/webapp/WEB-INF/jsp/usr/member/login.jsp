<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../common/head.jspf"%>
<meta charset="UTF-8">
<title>LOGIN</title>
</head>
<body>

	<div class="contents-box">
		<div class="signup-box flex">
			<form action="/usr/member/doLogin" method="POST">
				<h2>로그인</h2>
				<input type="text" name="loginId" placeholder="아이디">
				<input type="password" name="loginPw" placeholder="비밀번호">
				<button type="submit">로그인</button>
			</form>
		</div>
	</div>
</body>
</html>