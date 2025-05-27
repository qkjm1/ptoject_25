package com.example.demo.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.ArticleService;
import com.example.demo.util.Ut;
import com.example.demo.vo.Article;
import com.example.demo.vo.ResultData;
import com.example.demo.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class usrArticleController {
	@Autowired
	private Rq rq;

	@Autowired
	private ArticleService articleService;

	@RequestMapping("/usr/article/doWrite")
	@ResponseBody
	public ResultData doWrite(int usrId, String title, String body, int boardId) {

		ResultData doWriteRd = articleService.writeArticle(usrId, title, body, boardId);

		return ResultData.from(doWriteRd.getResultCode(), doWriteRd.getMsg());
	}

	@RequestMapping("/usr/article/doDelete")
	@ResponseBody
	public ResultData doDelete(int usrId, int articleId) {

		Article article = articleService.articleRowById(articleId);

		if (article == null) {
			return ResultData.from("F-1", "없는 게시글");
		}

		ResultData usrAuthor = articleService.usrAuthor(usrId, article);

		if (usrAuthor.isFail()) {
			return ResultData.from(usrAuthor.getResultCode(), usrAuthor.getMsg());
		}

		if (usrAuthor.isSuccess()) {
			articleService.delArticle(articleId);
		}		

		return ResultData.from(usrAuthor.getResultCode(), usrAuthor.getMsg());
	}

	@RequestMapping("/usr/article/list")
	@ResponseBody
	public String showList(HttpServletRequest req, Model model, @RequestParam(defaultValue = "1") int boardId,
			@RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "title") String searchKeywordTypeCode,
			@RequestParam(defaultValue = "") String searchKeyword) throws IOException {

		ResultData rd = articleService.printArticles();

		return "";
	}
}
