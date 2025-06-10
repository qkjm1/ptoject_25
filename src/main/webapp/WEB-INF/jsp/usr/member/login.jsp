<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="MEMBER JOIN"></c:set>
<%@ include file="../common/head.jspf"%>

<title>LOGIN</title>
<link rel="stylesheet" href="/resource/common.css" />
<div class="top-boundry-box"></div>
<div class="contents-box">
	<div class="signup-box flex flex-col">
			<div class="mx-auto">LOGO</div>
		<form action="/usr/member/doLogin" method="POST">
			<input type="text" name="loginId" placeholder="아이디">
			<input type="password" name="loginPw" placeholder="비밀번호">
			<button type="submit">로그인</button>
		</form>
	</div>
</div>

<%@ include file="../common/poot.jspf"%>