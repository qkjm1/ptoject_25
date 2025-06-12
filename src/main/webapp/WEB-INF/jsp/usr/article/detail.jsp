<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="DETAIL"></c:set>
<%@ include file="../common/head.jspf"%>


<link rel="stylesheet" href="/resource/common.css" />
<script type="module" src="/resource/ajax.js"></script>
<div class="top-boundry-box"></div>
<div class="contain flex flex-col mx-auto">

	<form action="../bookmark/doLike" method="POST" id="bookmark__btn">
		<input type="hidden" name="articleId" value="${article.id}" />
		<button type="submit">
			<div>
				<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" stroke="#555" stroke-width="2"
					viewBox="0 0 24 24">
  <path d="M7 3a2 2 0 0 0-2 2v16l7-3 7 3V5a2 2 0 0 0-2-2H7z" />
</svg>
			</div>
		</button>
	</form>

	<section class="mt-24 text-xl px-4">
		<div class="mx-auto">
			<table class="table" border="1" cellspacing="0" cellpadding="5" style="width: 100%; border-collapse: collapse;">
				<tbody>
					<tr>
						<th style="text-align: center;">ID</th>
						<td style="text-align: center;">${article.id}</td>
					</tr>
					<tr>
						<th style="text-align: center;">Registration Date</th>
						<td style="text-align: center;">${article.regDate}</td>
					</tr>
					<tr>
						<th style="text-align: center;">Update Date</th>
						<td style="text-align: center;">${article.updateDate}</td>
					</tr>
					<tr>
						<th style="text-align: center;">Writer</th>
						<td style="text-align: center;">${article.extra__writer }</td>
					</tr>
					<tr>
						<th style="text-align: center;">BoardId</th>
						<td style="text-align: center;">${article.boardId }</td>
					</tr>
					<tr>
						<th style="text-align: center;">Title</th>
						<td style="text-align: center;">${article.title }</td>
					</tr>
					<tr>
						<th style="text-align: center;">Body</th>
						<td style="text-align: center;">${article.body }</td>
					</tr>
				</tbody>
			</table>
			<div class="btns">
				<button class="btn btn-ghost" type="button" onclick="history.back();">뒤로가기</button>
				<c:if test="${article.usrAuthor }">
					<a class="btn btn-ghost" href="../article/modify?id=${article.id}">수정</a>
				</c:if>
				<c:if test="${article.usrAuthor }">
					<a class="btn btn-ghost" href="../article/doDelete?id=${article.id}">삭제</a>
				</c:if>
			</div>
		</div>
	</section>
</div>
<%@ include file="../common/poot.jspf"%>