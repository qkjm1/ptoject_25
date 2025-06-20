package com.example.demo.controller;

import java.io.IOException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.ArticleService;
import com.example.demo.service.BookmarkService;
import com.example.demo.sse.SseEmitters;
import com.example.demo.util.Ut;
import com.example.demo.vo.Article;
import com.example.demo.vo.ResultData;
import com.example.demo.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class usrBookmarkController {
	@Autowired
	private Rq rq;

	@Autowired
	private BookmarkService bookmarkService;

	@Autowired
	private ArticleService articleService;

	@Autowired
	private SseEmitters sseEmitters;

	@RequestMapping("/usr/bookmark/doLike")
	@ResponseBody
	public ResultData doLike(HttpServletRequest req, int articleId) {

		System.err.println("==1==");
		System.err.println("articleId " + articleId);
		Article article = articleService.articleRowById(articleId);
		int likeRow = bookmarkService.likeRow(rq.getIsLoginMemberId(), articleId);

		System.err.println(likeRow);
		if (likeRow == 1) {
			bookmarkService.delLike(rq.getIsLoginMemberId(), articleId);

			return ResultData.from("FS-1", "즐찾취소");
		}
		if (likeRow == 0) {
			ResultData saveLike = bookmarkService.saveLike(rq.getIsLoginMemberId(), articleId);

			String message = "회원님의 글을 북마크 했습니다."; // 메세지저장

			Map<String, Object> data = Ut.mapOf("message", message, "articleId", articleId); // 키밸류로 묶어주기
			System.out.println("🔔 SSE 알림 전송됨: " + message);

			sseEmitters.noti((long) article.getUsrId(), "bookmark", data);
			return ResultData.from(saveLike.getResultCode(), saveLike.getMsg(), "saveLike", saveLike);
		}

		return ResultData.from("F-1", "처리되지 않은 요청입니다.");

	}

	@RequestMapping("/usr/bookmark/like")
	public String showLike() {
		return "/usr/bookmark/like";
	}


}