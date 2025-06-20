<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="MODIFY"></c:set>
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/toastUiEditorLib.jspf"%>


<link rel="stylesheet" href="/resource/common.css" />
<div class="top-boundry-box"></div>
<div class="contain flex flex-col mx-auto">
	<div class="h-5"></div>
	<div>
		<div class="mx-auto">
			<form onsubmit="ArticleModify__submit(this); return false;" id="articleForm" action="../article/doModify"
				method="POST">
				<input type="hidden" name="id" value="${article.id}" />
				<input type="hidden" name="boardId" value="2" />
				<input type="hidden" name="body" id="bodyInput" />

				<select name="partId" class="partId anto">
					<option value="${article.partId}">${article.part__name}</option>
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

				<input id="titleInput" required="required" name="title" type="text" autocomplete="off" placeholder="제목"
					value="${article.title }" />
				<div class="h-2"></div>

				<input type="hidden" id="articleBody" value="${article.body}" />
				<div id="editor" class="toast-ui-editor"></div>

				<div class="btns flex justify-between">
					<button class="btn btn-ghost" type="button" onclick="history.back();">뒤로가기</button>
					<button class="btn btn-primary" type="submit">수정</button>
				</div>
			</form>
		</div>
	</div>
</div>

<script>
$(function () {
  ToastEditor__init();
});

function ToastEditor__init() {
  $(".toast-ui-editor").each(function (index, node) {
    const $node = $(node);
    const initialValue = $('#articleBody').val()?.trim() || ''; // article.body 값

    const editor = new toastui.Editor({
      el: node,
      initialEditType: 'markdown',
      previewStyle: "vertical",
      height: "800px",
      initialValue: initialValue,
      plugins: [
	        [toastui.Editor.plugin.chart, ToastEditor__chartOptions],
	        [toastui.Editor.plugin.codeSyntaxHighlight, { highlighter: Prism }],
	        toastui.Editor.plugin.colorSyntax,
	        toastui.Editor.plugin.tableMergedCell,
	        toastui.Editor.plugin.uml,
	        katexPlugin,
	        youtubePlugin,
	        codepenPlugin,
	        replPlugin
	      ],
	      hooks: {
	            addImageBlobHook(blob, callback) {  // 이미지 업로드 로직 커스텀
	                console.log(blob);
	                console.log(callback);
	            }
	        }
    });

    $node.data("data-toast-editor", editor);
  });
}

function ArticleModify__submit(form) {
  form.title.value = form.title.value.trim();

  if (form.partId.value.length == 0) {
    alert('분류를 선택해주세요');
    return;
  }

  if (form.title.value.length == 0) {
    alert('제목을 써주세요');
    return;
  }

  const editor = $(form).find('.toast-ui-editor').data('data-toast-editor');
  const markdown = editor.getMarkdown().trim();

  if (markdown.length == 0) {
    alert('내용을 써주세요');
    return;
  }

  form.body.value = markdown;
  form.submit();
}
</script>


<%@ include file="../common/poot.jspf"%>