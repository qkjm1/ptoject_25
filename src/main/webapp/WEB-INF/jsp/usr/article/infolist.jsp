<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="${board.code} LIST"></c:set>
<%@ include file="../common/head2.jspf"%>

<script type="module" src="/resource/ajax.js"></script>
<link rel="stylesheet" href="/resource/detail.css" />
<link rel="stylesheet" href="/resource/common.css" />


<div class="contain flex flex-col mx-auto">

	<div class="flex justify-center">
		<form class="w-full flex" action="/usr/article/infolist">
			<input type="hidden" name="searchKeywordTypeCode" value="info" />
			<input type="hidden" name="boardId" value="2" />
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
	<div class="contents-box flex mx-auto justify-around shadow-md ">
		<div class="side-box flex flex-col bg-white rounded-xl shadow-md p-4 w-64 space-y-2">
			<h2 class="text-lg font-semibold text-gray-800 border-b pb-2 mb-2">통증 부위 선택</h2>

			<ul class="space-y-1">
				<li>
					<a href="/usr/article/infolist?boardId=2&partId=1"
						class="partID block px-3 py-2 rounded-lg text-gray-700 hover:bg-emerald-100 hover:text-emerald-700 transition">머리</a>
				</li>
				<li>
					<a href="/usr/article/infolist?boardId=2&partId=2"
						class="partID block px-3 py-2 rounded-lg text-gray-700 hover:bg-emerald-100 hover:text-emerald-700 transition">목/어깨뒤쪽</a>
				</li>
				<li>
					<a href="/usr/article/infolist?boardId=2&partId=3"
						class="partID block px-3 py-2 rounded-lg text-gray-700 hover:bg-emerald-100 hover:text-emerald-700 transition">쇄골/어깨앞쪽</a>
				</li>
				<li>
					<a href="/usr/article/infolist?boardId=2&partId=4"
						class="partID block px-3 py-2 rounded-lg text-gray-700 hover:bg-emerald-100 hover:text-emerald-700 transition">팔</a>
				</li>
				<li>
					<a href="/usr/article/infolist?boardId=2&partId=5"
						class="partID block px-3 py-2 rounded-lg text-gray-700 hover:bg-emerald-100 hover:text-emerald-700 transition">등/허리</a>
				</li>
				<li>
					<a href="/usr/article/infolist?boardId=2&partId=6"
						class="partID block px-3 py-2 rounded-lg text-gray-700 hover:bg-emerald-100 hover:text-emerald-700 transition">가슴/배</a>
				</li>
				<li>
					<a href="/usr/article/infolist?boardId=2&partId=7"
						class="partID block px-3 py-2 rounded-lg text-gray-700 hover:bg-emerald-100 hover:text-emerald-700 transition">골반</a>
				</li>
				<li>
					<a href="/usr/article/infolist?boardId=2&partId=8"
						class="partID block px-3 py-2 rounded-lg text-gray-700 hover:bg-emerald-100 hover:text-emerald-700 transition">다리/앞쪽</a>
				</li>
				<li>
					<a href="/usr/article/infolist?boardId=2&partId=9"
						class="partID block px-3 py-2 rounded-lg text-gray-700 hover:bg-emerald-100 hover:text-emerald-700 transition">다리/뒤쪽</a>
				</li>
				<li>
					<a href="/usr/article/infolist?boardId=2&partId=10"
						class="partID block px-3 py-2 rounded-lg text-gray-700 hover:bg-emerald-100 hover:text-emerald-700 transition">종아리/발목</a>
				</li>
			</ul>
		</div>


		<div class="w-3"></div>
		<div class="info-box flex flex-col">
			<c:if test="${admin.usrAuthor}">
				<div class="write">
					<a class="hover:underline" href="../article/write">글쓰기</a>
				</div>
			</c:if>

			<div class=" flex flex-col">
				<div class="info-title-body">
					<div class="grid grid-cols-3 gap-4 flex" class="article-list">
						<c:forEach var="article" items="${articles}">
							<div class="card-flip">
								<div class="card-inner">
									<!-- 앞면 -->
									<div class="card-front">
										<div class="card-header">
											<a href="#" class="card-title">${article.title}</a>
										</div>
									</div>

									<!-- 뒷면 -->
									<form action="/usr/bookmark/doLike" method="POST" class="bookmark-form" data-article-id="${article.id}">
										<input type="hidden" name="articleId" value="${article.id}" />
										<button type="submit" class="bookmark-btn" title="북마크">
											<svg class="bookmark-icon ${article.isBookmarked == usr ? 'active' : ''}" xmlns="http://www.w3.org/2000/svg"
												width="24" height="24" fill="none" stroke="#555" stroke-width="2" viewBox="0 0 24 24">
            <path d="M7 3a2 2 0 0 0-2 2v16l7-3 7 3V5a2 2 0 0 0-2-2H7z" />
          </svg>
										</button>
									</form>
									<div class="card-back">
										<a href="detail?articleId=${article.id}" class="card-text">${article.body}</a>
									</div>
								</div>
							</div>

						</c:forEach>
					</div>
				</div>

			</div>
			<c:if test="${empty articles}">
				<div class="flex ">
					<div>게시글이 없습니다</div>
				</div>
			</c:if>
		</div>

		<div class="flex-grow"></div>

		<div class="paging">
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