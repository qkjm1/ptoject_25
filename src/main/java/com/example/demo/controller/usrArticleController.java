package com.example.demo.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.ArticleService;
import com.example.demo.service.BoardService;
import com.example.demo.util.Ut;
import com.example.demo.vo.Article;
import com.example.demo.vo.Board;
import com.example.demo.vo.ResultData;
import com.example.demo.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class usrArticleController {
	@Autowired
	private Rq rq;

	@Autowired
	private ArticleService articleService;

	@Autowired
	private BoardService boardService;
	
	
	
	
	@RequestMapping("/usr/article/detail")
	public String showDetail(HttpServletRequest req, Model model, int articleId) {

		Article article = articleService.getForPrintArticle(rq.getIsLoginMemberId(), articleId);
		
		model.addAttribute("article", article);
		
		return "usr/article/detail";
	}

	
	@RequestMapping("/usr/article/doWrite")
	@ResponseBody
	public String doWrite(HttpServletRequest req, String title, String body, int boardId, int partId) {
		System.err.println("로그인id: "+rq.getIsLoginMemberId());
		System.err.println("title: "+title);
		System.err.println("body: "+body);
		System.err.println("boardId: "+boardId);
		System.err.println("partId: "+partId);
		ResultData doWriteRd = articleService.writeArticle(rq.getIsLoginMemberId(), title, body, boardId, partId);

		return Ut.jsReplace(doWriteRd.getResultCode(), doWriteRd.getMsg(), "/usr/article/infolist?boardId="+boardId+"&partId="+partId);
	}

	@RequestMapping("/usr/article/write")
	public String showWrite(HttpServletRequest req) {
		return "usr/article/write";
	}

	@RequestMapping("/usr/article/modify")
	public String showModify(HttpServletRequest req, Model model, int id) {

		Article article = articleService.getForPrintArticle(rq.getIsLoginMemberId(), id);

		if (article == null) {
			return Ut.jsHistoryBack("F-1", Ut.f("%d번 게시글은 없습니다", id));
		}

		model.addAttribute("article", article);

		return "/usr/article/modify";
	}
	
	@RequestMapping("/usr/article/doModify")
	@ResponseBody
	public String doModify(HttpServletRequest req, int usrId, String title, String body, int articleId) {

		Article article = articleService.articleRowById(articleId);

		if (article == null) {
			return Ut.f("F-1", "없는 게시글");
		}

		ResultData usrAuthor = articleService.usrAuthor(usrId, article);

		if (usrAuthor.isFail()) {
			return Ut.f(usrAuthor.getResultCode(), usrAuthor.getMsg());
		}

		if (usrAuthor.isSuccess()) {
			articleService.modifyArticle(articleId, title, body);
		}

		return Ut.f(usrAuthor.getResultCode(), usrAuthor.getMsg());
	}

	@RequestMapping("/usr/article/doDelete")
	@ResponseBody
	public ResultData doDelete(HttpServletRequest req, int articleId) {

		Article article = articleService.articleRowById(articleId);

		if (article == null) {
			return ResultData.from("F-1", "없는 게시글");
		}

		ResultData usrAuthor = articleService.usrAuthor(rq.getIsLoginMemberId(), article);

		if (usrAuthor.isFail()) {
			return ResultData.from(usrAuthor.getResultCode(), usrAuthor.getMsg());
		}

		if (usrAuthor.isSuccess()) {
			articleService.delArticle(articleId);
		}

		return ResultData.from(usrAuthor.getResultCode(), usrAuthor.getMsg());
	}

	@RequestMapping("/usr/article/qnalist")
	public String showQnaList(
			HttpServletRequest req, Model model, @RequestParam(defaultValue = "2") int boardId,
			@RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "QnA") String searchKeywordTypeCode,
			@RequestParam(defaultValue = "") String searchKeyword) throws IOException {

		// 보드아이디로 있는 게시판인지 확인
		if (boardId != 0) {
			Board board = boardService.getBoardById(boardId);
			if (board == null) {
				return "존재하지 않는 게시판";
			}
		}

		Board board = boardService.getBoardById(boardId);

		int listInApage = 5;

		int articlesCntByboard = articleService.getArticleCountByBoard(boardId, searchKeywordTypeCode, searchKeyword);
		System.err.println(articlesCntByboard);
		int totalPage = (int) Math.ceil(articlesCntByboard / (double) listInApage);
		System.err.println(totalPage);

		List<Article> articles = articleService.getForPrintArticles(boardId, listInApage, page, searchKeywordTypeCode,
				searchKeyword);

		model.addAttribute("articlesCntByboard", articlesCntByboard);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("articles", articles);
		model.addAttribute("board", board);
		model.addAttribute("boardId", boardId);
		model.addAttribute("page", page);
		model.addAttribute("searchKeywordTypeCode", searchKeywordTypeCode);
		model.addAttribute("searchKeyword", searchKeyword);

		return "/usr/article/qnalist";
	}
	
	@RequestMapping("/usr/article/infolist")
	public String showInfoList(
			HttpServletRequest req, Model model, @RequestParam(defaultValue = "2") int boardId, @RequestParam(defaultValue = "1")int partId,
			@RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "info") String searchKeywordTypeCode,
			@RequestParam(defaultValue = "") String searchKeyword) throws IOException {

		System.err.println("partId : "+partId);
		
		// 보드아이디로 있는 게시판인지 확인
		if (boardId != 0) {
			Board board = boardService.getBoardById(boardId);
			if (board == null) {
				return "존재하지 않는 게시판";
			}
		}

		Board board = boardService.getBoardById(boardId);

		int listInApage = 6;

		int getArticleCountByPartId = articleService.getArticleCountByPartId(partId, searchKeywordTypeCode, searchKeyword);
		System.err.println("getArticleCountByPartId: "+getArticleCountByPartId);
		int totalPage = (int) Math.ceil(getArticleCountByPartId / (double) listInApage);
		System.err.println("totalPage: "+totalPage);

		List<Article> articles = articleService.getForPrintArticlesByPartId(partId, listInApage, page, searchKeywordTypeCode,
				searchKeyword);
		
		Article getPartId = articleService.partName(partId);

		model.addAttribute("getArticleCountByPartId", getArticleCountByPartId);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("getPartId", getPartId);
		model.addAttribute("articles", articles);
		model.addAttribute("board", board);
		model.addAttribute("boardId", boardId);
		model.addAttribute("page", page);
		model.addAttribute("searchKeywordTypeCode", searchKeywordTypeCode);
		model.addAttribute("searchKeyword", searchKeyword);

		return "/usr/article/infolist";
	}
	
	
	@RequestMapping("/usr/article/infomainlist")
	@ResponseBody
	public Map<String, Object> showMainInfoList(
	        HttpServletRequest req, Model model,
	        @RequestParam(defaultValue = "2") int boardId,
	        @RequestParam(defaultValue = "1") int partId,
	        @RequestParam(defaultValue = "1") int page,
	        @RequestParam(defaultValue = "info") String searchKeywordTypeCode,
	        @RequestParam(defaultValue = "") String searchKeyword) throws IOException {

	    System.err.println("partId : "+partId);

	    if (boardId != 0) {
	        Board board = boardService.getBoardById(boardId);
	        if (board == null) {
	            Map<String, Object> error = new HashMap<>();
	            error.put("error", "존재하지 않는 게시판");
	            return error;
	        }
	    }

	    Board board = boardService.getBoardById(boardId);

	    int listInApage = 6;

	    int getArticleCountByPartId = articleService.getArticleCountByPartId(partId, searchKeywordTypeCode, searchKeyword);
	    System.err.println("getArticleCountByPartId: "+getArticleCountByPartId);
	    int totalPage = (int) Math.ceil(getArticleCountByPartId / (double) listInApage);
	    System.err.println("totalPage: "+totalPage);

	    List<Article> articles = articleService.getForPrintArticlesByPartId(partId, listInApage, page, searchKeywordTypeCode,
	            searchKeyword);

	    Map<String, Object> result = new HashMap<>();
	    result.put("getArticleCountByPartId", getArticleCountByPartId);
	    result.put("totalPage", totalPage);
	    result.put("articles", articles);
	    result.put("board", board);
	    result.put("boardId", boardId);
	    result.put("page", page);
	    result.put("searchKeywordTypeCode", searchKeywordTypeCode);
	    result.put("searchKeyword", searchKeyword);

	    return result;
	}

	
	

	
	
	
	
	
}


