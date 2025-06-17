<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="WRTITE"></c:set>
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/toastUiEditorLib.jspf"%>

<link rel="stylesheet" href="/resource/article.css" />
<div class="top-boundry-box"></div>
<div class="contain flex flex-col mx-auto px-4 max-w-3xl">
	<div class="h-5"></div>
	<div>
		<div class="bg-white p-6 rounded-xl shadow-md border border-gray-200">
			<form id="articleForm" action="../article/doWrite" method="POST">
				<input type="hidden" name="boardId" value="2" />
				<input type="hidden" name="body" id="bodyInput" />

				<div>
					<label for="partId" class="block mb-1 text-sm font-semibold text-gray-700">분류</label>
					<select name="partId"
						class="partId border border-[#3C3C29] bg-white text-[#3C3C29] px-3 py-2 rounded focus:outline-none focus:ring-2 focus:ring-[#E1D8CD]">
						<option value="" selected disabled>분류를 선택하세요</option>
						<option value="1">머리</option>
						<option value="2">목/어깨뒤쪽</option>
						<option value="3">쇄골/어깨앞쪽</option>
						<option value="4">팔</option>
						<option value="5">등/허리</option>
						<option value="6">가슴/배</option>
						<option value="7">골반</option>
						<option value="8">다리 앞쪽</option>
						<option value="9">다리 뒤쪽</option>
						<option value="10">종아리/발목</option>
					</select>
				</div>
				<div>
					<label for="titleInput" class="block text-sm font-semibold text-gray-700">제목</label>
					<input id="titleInput" required name="title" type="text"
  class="border border-[#3C3C29] bg-white text-[#3C3C29] px-3 py-2 rounded w-full mt-2"
  autocomplete="off" placeholder="제목" />
				</div>
				<div>
					<label class="block mb-1 text-sm font-semibold text-gray-700"></label>
					<div id="editor" class="border border-gray-300 rounded-md"></div>
				</div>

				<!-- 버튼 -->
				<div class="flex justify-between pt-4">
					<button type="button" onclick="history.back();" class="px-4 py-2 bg-gray-200 text-gray-800 rounde">뒤로가기</button>
					<button class="btn btn-primary bg-[#3C3C29] text-[#E1D8CD] hover:bg-[#2f2f20]" type="submit">작성</button>
				</div>
			</form>
		</div>
	</div>

</div>
<script>
	$(document).ready(function() {
		const editor = new toastui.Editor({
			el : document.querySelector('#editor'),
			height : '750px',
			initialEditType : 'markdown',
			previewStyle : 'vertical'
		});

		$('#articleForm').on('submit', function(e) {
			const title = $('#titleInput').val().trim();
			const content = editor.getMarkdown().trim();
			const partId = $('.partId').val();

			if (!partId) {
				alert('분류를 선택해주세요.');
				e.preventDefault();
				return;
			}

			if (!title) {
				alert('제목을 입력해주세요.');
				$('#titleInput').focus();
				e.preventDefault();
				return;
			}

			if (!content) {
				alert('내용을 입력해주세요.');
				e.preventDefault();
				return;
			}

			$('#bodyInput').val(content);
		});
	});
</script>


<%@ include file="../common/poot.jspf"%>