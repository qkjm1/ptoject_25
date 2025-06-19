<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="DETAIL"></c:set>
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/toastUiEditorLib.jspf"%>

<link rel="stylesheet" href="/resource/detail.css" />
<link rel="stylesheet" href="/resource/common.css" />
<script type="module" src="/resource/ajax.js"></script>

<div class="top-boundry-box"></div>
<div class="contain flex flex-col mx-auto">
	<div class="top-con h-10 w-full flex flex-col justify-between self-center">
		<div class="flex justify-between w-full">
			<button type="button" onclick="history.back();">
				<svg style="pointer-events: none" xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="none"
					stroke="#555" stroke-width="2" viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round">
  <path d="M15 6L9 12l6 6" />
</svg>

			</button>

			<form action="/usr/bookmark/doLike" method="POST" class="bookmark__form" data-article-id="${article.id}">
				<input type="hidden" name="articleId" value="${article.id}" />
				<button type="submit" class="bookmark-btn" title="북마크 추가/해제">
					<svg class="bookmark__icon ${article.isBookmarked == usr ? 'bookmark__icon_col' : ''}"
						xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="none" stroke="#555" stroke-width="3"
						viewBox="0 0 24 24">
      <path d="M7 3a2 2 0 0 0-2 2v16l7-3 7 3V5a2 2 0 0 0-2-2H7z" />
    </svg>
				</button>
			</form>

		</div>
	</div>

	<div class="mx-auto">
		<div class="article-detail">
			<h1>${article.title}</h1>
			<div class="btns">
				<c:if test="${article.usrAuthor }">
					<a class="btn btn-ghost hover:underline" href="../article/doDelete?articleId=${article.id}&boardId=${article.boardId}">삭제</a>
				</c:if>
				<div class="w-3"></div>
				<c:if test="${article.usrAuthor}">
					<a class="btn btn-ghost hover:underline" href="../article/modify?id=${article.id}">수정</a>
				</c:if>
			</div>
			<div class="article-meta ">작성자: ${article.extra__writer } · ${article.updateDate}</div>
			<div class="article-content">
				<div class="toast-ui-viewer">
					<script type="text/x-template">${article.body}</script>
				</div>
			</div>
		</div>

	</div>

</div>


<%@ include file="../common/poot.jspf"%>