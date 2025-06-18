<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div class="img_upload">
  <img src="${empty profileImage ? '/profile/default.png' : profileImage}" alt="프로필 이미지" style="width:150px; height:150px; border-radius:50%;">
</div>

</style>
</body>
</html>