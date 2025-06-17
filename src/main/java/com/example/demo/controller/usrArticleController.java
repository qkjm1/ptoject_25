package com.example.demo.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.service.ArticleService;
import com.example.demo.service.BoardService;
import com.example.demo.service.BookmarkService;
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
	
	@Autowired
	private BookmarkService bookmarkService;
	
	
//	@PostMapping("/upload-image")
//	@ResponseBody
//	public ResultData uploadImage(@RequestParam("image") MultipartFile image) throws IOException {
//	    String uploadDir = "C:/upload/";
//	    String filename = UUID.randomUUID() + "_" + image.getOriginalFilename();
//	    Path path = Paths.get(uploadDir + filename);
//	    Files.copy(image.getInputStream(), path);
//
//	    Map<String, String> result = new HashMap<>();
//	    result.put("url", "/images/" + filename); // 클라이언트에서 접근 가능한 경로
//	    return ResultData.from(filename, uploadDir, filename, null);
//	}
	
	@PostMapping("/upload-image")
	@ResponseBody
	public ResultData uploadImage(@RequestParam("image") MultipartFile image) throws IOException {
	    String uploadDir = "C:/upload/";

	    // 저장 디렉터리 생성 (없는 경우)
	    File dir = new File(uploadDir);
	    if (!dir.exists()) {
	        dir.mkdirs();
	    }

	    String filename = UUID.randomUUID() + "_" + image.getOriginalFilename();
	    Path path = Paths.get(uploadDir + filename);
	    Files.copy(image.getInputStream(), path);

	    // 클라이언트에서 접근할 수 있는 경로
	    String imageUrl = "/images/" + filename;

	    return ResultData.from("S-1", "이미지 업로드 성공", "imageUrl", imageUrl);
	}
	
	
	
	
	@RequestMapping("/usr/article/detail")
	public String showDetail(HttpServletRequest req, Model model, int articleId) {

		Article article = articleService.getForPrintArticle(rq.getIsLoginMemberId(), articleId);
		
		ResultData isBookmarkedRD = bookmarkService.isBookmarked(rq.getIsLoginMemberId(), articleId);
		System.out.println("++++===="+isBookmarkedRD.isSuccess());
		model.addAttribute("isBookmarked", isBookmarkedRD.isSuccess()); // 좋아요를 했는지 안했는지		
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

		int listInApage = 4;

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

		//부위별로 검색어랑 같이 가져오기
		int getArticleCountByPartId = articleService.getArticleCountByPartId(boardId, partId, searchKeywordTypeCode, searchKeyword);
		System.err.println("getArticleCountByPartId: "+getArticleCountByPartId);
		int totalPage = (int) Math.ceil(getArticleCountByPartId / (double) listInApage);
		System.err.println("totalPage: "+totalPage);

		// 가지고올때 해당글에 좋아요를 누른 사람의 id도 같이 들고와서 jsp에서 if문쓰기
		List<Article> articles = articleService.getForPrintArticlesByPartId(partId, listInApage, page, searchKeywordTypeCode,
				searchKeyword);		
		
		
		Article getPartId = articleService.partName(partId);

		model.addAttribute("usr", rq.getIsLoginMemberId());
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
	        @RequestParam(defaultValue = "0") int partId) throws IOException {

	    System.err.println("showMainPartId : "+partId);

	    if (boardId != 0) {
	        Board board = boardService.getBoardById(boardId);
	        if (board == null) {
	            Map<String, Object> error = new HashMap<>();
	            error.put("error", "존재하지 않는 게시판");
	            return error;
	        }
	    }
	    

	    List<Article> articles = articleService.getForPrintArticlesByPartIdNP(partId);
	    
	    // html에서 오류나도 놀라지말것 내용 호출 확인용
//	    System.err.println(articles.get(partId));
	    
	    Map<String, Object> result = new HashMap<>();

	    result.put("articles", articles);

	    return result;
	}


}

