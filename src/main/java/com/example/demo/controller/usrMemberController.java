package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
	
	@RequestMapping("/usr/article/likeList")
	public String showList(int usrId) {

		List<Article> likeArticles = bookmarkService.likeByUsrid(usrId);



		return "usr/article/list";

	}
}
