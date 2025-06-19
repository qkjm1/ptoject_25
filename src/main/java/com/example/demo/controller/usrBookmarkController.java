package com.example.demo.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.ArticleService;
import com.example.demo.service.BookmarkService;
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
	
	private ArticleService articleService;

	@RequestMapping("/usr/bookmark/doLike")
	@ResponseBody
	public ResultData doLike(HttpServletRequest req, int articleId) {
		
		System.err.println("==1==");
		System.err.println("articleId "+articleId);
		
		int likeRow = bookmarkService.likeRow(rq.getIsLoginMemberId(), articleId);

		System.err.println(likeRow);
		if(likeRow==1) {
			bookmarkService.delLike(rq.getIsLoginMemberId(), articleId);
			
			return ResultData.from("FS-1", "즐찾취소");
		} 
		if(likeRow==0) {
			ResultData saveLike  = bookmarkService.saveLike(rq.getIsLoginMemberId(), articleId);
			
			return ResultData.from(saveLike.getResultCode(),saveLike.getMsg(),"saveLike",saveLike);
		}
	
		return null;
	}
	
	@RequestMapping("/usr/bookmark/like")
	public String showLike() {
	
		return "/usr/bookmark/like";
	}
	
	
	@PostMapping("/article/bookmark")
	@ResponseBody
	public ResultData toggleBookmark(@RequestParam int articleId, HttpServletRequest req) {
	    Article article = articleService.articleRowById(articleId);
	    boolean bookmarked = bookmarkService.isBookmarkedById(rq.getIsLoginMemberId());

	    // 알림 전송
	    if (bookmarked) {
	        String message = actor.getUsername() + "님이 회원님의 글을 북마크 했습니다.";
	        sseEmitters.notify(article.getAuthor().getId(), "bookmark", message);
	    }

	    return ResultData.from("S-1", bookmarked ? "북마크 추가됨" : "북마크 해제됨");
	}
	
	
	
	
	
}