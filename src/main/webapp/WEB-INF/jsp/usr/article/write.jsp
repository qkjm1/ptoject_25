<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="${board.code } LIST"></c:set>
<%@ include file="../common/head.jspf"%>

<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>

<link rel="stylesheet" href="/resource/common.css" />
<div class="top-boundry-box"></div>
<div class="contain flex flex-col mx-auto">

	<section class="mt-8 text-xl px-4">
		<div class="mx-auto">
			<form action="../article/doWrite" method="POST">
				<table class="table" border="1" cellspacing="0" cellpadding="5" style="width: 100%; border-collapse: collapse;">
					<tbody>

						<tr>
							<th style="text-align: center;">게시판</th>
							<td style="text-align: center;">
								<select name="boardId">
									<option value="" selected disabled>게시판을 선택해주세요</option>
									<option value="1">공지사항</option>
									<option value="2">정보게시판</option>
									<option value="3">QnA</option>
								</select>
							</td>
						</tr>
						<tr>
							<th style="text-align: center;">제목</th>
							<td style="text-align: center;">
								<input class="input input-primary input-sm" required="required" name="title" type="text" autocomplete="off"
									placeholder="제목" />
							</td>
						</tr>
						<tr>
							<th style="text-align: center;">내용</th>
							<td style="text-align: center;">
								<input class="input input-primary input-sm" required="required" name="body" type="text" autocomplete="off"
									placeholder="내용" />
							</td>
						</tr>
						<tr>
							<th></th>
							<td style="text-align: center;">
								<button class="btn btn-primary">작성</button>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
			<div class="btns">
				<button class="btn btn-ghost" type="button" onclick="history.back();">뒤로가기</button>
			</div>
		</div>
	</section>
	
	
	<!-- TOAST UI Editor가 들어갈 div태그 -->
    <div id="editor"></div>
    
    <!-- 에디터 내용을 받을 button -->
    <button onclick="see1()">getHTML</button>
    <button onclick="see2()">getMarkdown</button>

    <!-- TOAST UI Editor CDN URL(JS) -->
    <script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>

    <!-- TOAST UI Editor 생성 JavaScript 코드 -->
    <script>
        const editor = new toastui.Editor({
            el: document.querySelector('#editor'),
            previewStyle: 'vertical',
            height: '500px',
            initialValue: '안녕하세요. METASTAR입니다.',
        });

        // editor.getHtml()을 사용해서 에디터 내용 받아오기
        see1 = function() {
            console.log(editor.getHTML());
        }
        see2 = function() {
            console.log(editor.getMarkdown());
        }
        </script>
</div>
</body>
</html>