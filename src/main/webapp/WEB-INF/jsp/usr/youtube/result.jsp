<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head><title>YouTube 검색 결과</title></head>
<body>
    <h2>YouTube 검색 결과</h2>
    <c:forEach var="item" items="${videos}">
        <c:set var="id" value="${item['id']}" />
        <c:set var="snippet" value="${item['snippet']}" />
        <c:set var="videoId" value="${id['videoId']}" />
        <c:set var="thumbnail" value="${snippet['thumbnails']['medium']['url']}" />
        <div style="margin-bottom: 20px;">
            <a href="https://www.youtube.com/watch?v=${videoId}" target="_blank">
                <img src="${thumbnail}" width="200" /><br/>
                <strong>${snippet['title']}</strong>
            </a>
        </div>
    </c:forEach>
</body>
</html>
