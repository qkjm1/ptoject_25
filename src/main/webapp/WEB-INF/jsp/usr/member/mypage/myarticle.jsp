<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="MY PAGE"></c:set>
<%@ include file="../../common/head.jspf"%>


<link rel="stylesheet" href="/resource/common.css" />
<link rel="stylesheet" href="/resource/detail.css" />
<script type="module" src="/resource/ajax.js"></script>
<div class="top-boundry-box"></div>
<div class="contain flex flex-col mx-auto">


	<div class="h-6"></div>
	<div class="flex">
		<form class="mx-auto w-full">
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
	<div class="info-con flex mx-auto justify-around">
		<div class="side-box flex flex-col">
			<div class="h-40"></div>
			<ul>
				<li>
					<a href="/usr/member/mypage/likepage">즐겨찾기</a>
				</li>
			</ul>
			<ul>
				<li>
					<a href="/usr/member/mypage/myarticle">내가쓴글</a>
				</li>
			</ul>
			<ul>
				<li>
					<a href="/usr/member/mypage/usrmodify">회원정보수정</a>
				</li>
			</ul>
			<div class="flex-grow"></div>
		</div>
		<div class="w-3"></div>
		<div class="info-box flex flex-col">

			<c:if test="${rq.isLogined() }">
				<div class="write">
					<a class="hover:underline" href="../article/write">글쓰기</a>
				</div>
			</c:if>

			<div class="info-box-in flex flex-col">
				<div class="grid grid-cols-3 gap-2" class="article-list">
					<c:forEach var="article" items="${myArticles}">
						<div class="p-3 ">
							<div class="info-title-box flex justify-between justify-center items-end">
								<div class="info-title">
									<a href="#" class="text-xl font-bold text-black">${article.title}</a>
								</div>
								<div class="text-black">작성자:${article.extra__writer}&nbsp&nbsp</div>
								<div>
									<form action="/usr/bookmark/doLike" method="POST" id="bookmark__btn">
										<input type="hidden" name="articleId" value="${article.id}" />
										<button type="submit">
											<div>
												<svg id="bookmark__icon" xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="none" stroke="#555"
													stroke-width="3" viewBox="0 0 24 24" class="${isBookmarked== article.id ? 'bookmark__icon_col' : ''}">
  <path d="M7 3a2 2 0 0 0-2 2v16l7-3 7 3V5a2 2 0 0 0-2-2H7z" />
</svg>

											</div>
										</button>
									</form>
								</div>
							</div>
							<div class="info-body">
								<a href="detail?articleId=${article.id}">${article.body}</a>
							</div>
						</div>
					</c:forEach>
				</div>
				<c:if test="${empty myArticles}">
					<div class="flex ">
						<div>게시글이 없습니다</div>
					</div>
				</c:if>
			</div>




			<div class="paging flex justify-center mt-4">
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
</div>

<%@ include file="../../common/poot.jspf"%>