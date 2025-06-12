<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="${board.code } LIST"></c:set>
<%@ include file="../common/head.jspf"%>


<link rel="stylesheet" href="/resource/common.css" />
<script type="module" src="/resource/ajax.js"></script>
<div class="top-boundry-box"></div>
<div class="contain flex flex-col mx-auto">


	<div class="h-6"></div>
	<div class="flex ">
		<form class="mx-auto w-full">
			<input type="hidden" name="searchKeywordTypeCode" value="QnA" />
			<input type="hidden" name="boardId" value="3" />
			<div class="search-box">
				<input type="text" placeholder="검색어를 입력하세요" name="searchKeyword" value="${param.searchKeyword}" />
				<button type="submit">
					<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
						stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
  <circle cx="11" cy="11" r="8" />
  <line x1="21" y1="21" x2="16.65" y2="16.65" />
</svg>
				</button>
			</div>
		</form>
	</div>





	<div class="flex flex-grow ">
		<div class="qna-con felx flex-col mx-auto">
			<c:forEach var="article" items="${articles}">
				<div class="qna-box">
					<div class="qna-title mx-auto flex items-center justify-center">
						<a href="/" class="text-xl font-bold">${article.title}</a>
						<div class="flex-grow"></div>
						<div class="">${article.regDate.substring(0,10)}</div>
					</div>
					<div class="qna-body">
						<a href="/">${article.body}</a>
						<div class="qna-open">
							<svg xmlns="http://www.w3.org/2000/svg" width="35" height="35" viewBox="0 0 24 24" fill="none"
								stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
  <polyline points="6 9 12 15 18 9" />
				</svg>
						</div>
					</div>
				</div>
				<div id="qna-answer" class=""></div>
			</c:forEach>
			<c:if test="${empty articles }">
				<div class="qna-box flex flex-col">
					<div class="flex-grow"></div>
					<div style="text-align: center;">게시글이 없습니다</div>
					<div class="flex-grow"></div>
				</div>
			</c:if>
		</div>
	</div>


	<div class="flex flex-grow">
		<div class="flex mx-auto mt-4">
			<div class="btn-group join ">
				<c:set var="paginationLen" value="5" />
				<c:set var="startPage" value="${page - paginationLen >= 1 ? page - paginationLen : 1 }" />
				<c:set var="endPage" value="${page + paginationLen <= totalPage ? page + paginationLen : totalPage}" />

				<c:set var="baseUri" value="?boardId=${boardId}" />
				<c:set var="baseUri" value="?searchKeywordTypeCode=${searchKeywordTypeCode}" />
				<c:set var="baseUri" value="?searchKeyword=${searchKeyword}" />

				<c:if test="${startPage > 1}">
					<a class="join-item btn btn-sm" href="${baseUri}&page=1&boardId=${boardId}">1</a>
				</c:if>

				<c:if test="${startPage > 2}">
					<button class="join-item btn btn-sm btn-disabled">...</button>
				</c:if>

				<c:forEach begin="${startPage }" end="${endPage }" var="i">
					<a class="join-item btn btn-sm ${param.page == i ? 'btn-active' : ''}"
						href="${baseUri}&page=${i }&boardId=${boardId}">${i }</a>
				</c:forEach>

				<c:if test="${endPage < totalPage - 1}">
					<button class="join-item btn-sm btn btn-disabled">...</button>
				</c:if>

				<c:if test="${endPage < totalPage}">
					<a class="join-item btn btn-sm" href="${baseUri}&page=${totalPage }&boardId=${boardId}">${totalPage }</a>
				</c:if>
			</div>
		</div>
	</div>

</div>

<%@ include file="../common/poot.jspf"%>