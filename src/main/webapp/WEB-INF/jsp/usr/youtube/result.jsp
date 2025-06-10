<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>YouTube 검색 결과</title>
</head>
<body>
	<h2>YouTube 검색 결과</h2>
	<c:forEach var="item" items="${videos}">
		<div style="margin-bottom: 20px;">
			<a href="https://www.youtube.com/watch?v=${item.id.videoId}" target="_blank">
				<img src="${item.snippet.thumbnails.medium.url}" width="200" alt="${item.snippet.title}" />
				<br />
				<strong>${item.snippet.title}</strong>
			</a>
			<p>${item.snippet.description}</p>
		</div>
	</c:forEach>
</body>
</html>