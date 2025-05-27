<%@page import="org.apache.jasper.tagplugins.jstl.core.Import"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>

<!-- 구글 폰트 직접 링크 -->
<link href="https://fonts.googleapis.com/css?family=Raleway:100,100i,200,300,400,500,600,700,800&display=swap"
	rel="stylesheet">

<!-- 스타일 정의 -->
<style>
body {
	font-family: 'Raleway', sans-serif;
}
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/style.css" />
<title>sadasd</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
<link type="text/css" rel="stylesheet" href="main.css">
</head>

<div id="container">

	<img id="border" src="https://image.ibb.co/gFxj6F/border.png">
	<div id="welcome">

		<p id="firstSentence">
			Welcome to my
			<span id="universe">universe</span>
		</p>
		<p id="lastSentence">
			Click on the
			<span id="sun">sun</span>
			to get started
		</p>
	</div>
	<div id="content">
		<h2 id="contentTitle"></h2>
		<p id="subtitle"></p>
		<p id="description"></p>
	</div>
	<div>
		<a id="social" target="_blank" href="https://twitter.com/nskargovskii">follow : @nskargovskii</a>
	</div>
</div>


</body>

</html>