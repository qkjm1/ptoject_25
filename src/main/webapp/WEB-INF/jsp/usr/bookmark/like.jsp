<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<style>
.box {
	width: 100px;
	height: 100px;
	background-color: black;
}
</style>


	<div class="box">123</div>

	<form action="../bookmark/doLike" method="POST">
		<input type="hidden" value="1" name="articleId" />
		<input type="hidden" value="test1" name="usrId" />
		<input type="submit" value="하트하트" />
	</form>

</body>
</html>