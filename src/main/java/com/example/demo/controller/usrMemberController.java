package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.BookmarkService;
import com.example.demo.vo.Article;
import com.example.demo.vo.Rq;

@Controller
public class usrMemberController {
	@Autowired
	private Rq rq;
	@Autowired
	private BookmarkService bookmarkService;

	
	@RequestMapping("/usr/member/join")
	@ResponseBody
	public String showJoin() {
		
		return "ㅎㅇ";
	}
	
	@RequestMapping("/usr/member/myPage/likepage")
	public String likeList(Model model, int usrId) {

		List<Article> likeArticles = bookmarkService.likeByUsrid(usrId);

		for (Article article : likeArticles) {
			System.out.println(article.getBody());
		}
		model.addAttribute("likeArticles", likeArticles);

		return "usr/member/mypage/likepage";

	}
}
