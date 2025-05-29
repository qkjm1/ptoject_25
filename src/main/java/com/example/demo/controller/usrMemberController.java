package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.BookmarkService;
import com.example.demo.service.MemberService;
import com.example.demo.util.Ut;
import com.example.demo.vo.Article;
import com.example.demo.vo.Member;
import com.example.demo.vo.ResultData;
import com.example.demo.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class usrMemberController {
	@Autowired
	private Rq rq;
	@Autowired
	private BookmarkService bookmarkService;

	@Autowired
	private MemberService memberService;


	@RequestMapping("/usr/member/join")
	public String showJoin() {
		return "/usr/member/join";
	}

	@RequestMapping("/usr/member/dojoin")
	@ResponseBody
	public String doJoin(HttpServletRequest req, String loginId, String loginPw, String name, String email,
			String nickname, String cellphoneNum) {
		System.err.println("====진행상황====");
		System.err.println("====loginId====" + loginId);
		System.err.println("====loginPw====" + loginPw);
		System.err.println("====name====" + name);
		System.err.println("====email====" + email);
		System.err.println("====nickname====" + nickname);
		System.err.println("====cellphoneNum====" + cellphoneNum);

		// 인설트 시도
		ResultData member = memberService.doJoin(loginId, loginPw, name, email, nickname, cellphoneNum);

		if (member.isFail()) {
			return Ut.jsReplace(member.getData1Name(), member.getMsg(), "../member/join");
		}

		return Ut.jsReplace(member.getData1Name(), member.getMsg(), "../home/main");
	}

	@RequestMapping("/usr/member/login")
	public String showlogin(HttpServletRequest req) {
		return "/usr/member/login";
	}

	@RequestMapping("/usr/member/doLogin")
	@ResponseBody
	public String doLogin(HttpServletRequest req, String loginId, String loginPw) {
		System.err.println("====진행상황====");
		System.err.println("====loginId====" + loginId);
		System.err.println("====loginPw====" + loginPw);

		Rq rq = (Rq) req.getAttribute("rq");
		
		System.err.println("doLogin 실행 전--"+rq.getLoginedMemberId());

		Member member = memberService.doLogin(loginId);

		if (member == null) {
			return Ut.jsHistoryBack("F-1", Ut.f("s%아이디 없음", loginId));
		}
		if (member.getLoginPw().equals(loginPw) == false) {
			return Ut.jsHistoryBack("F-2", "비밀번호 틀림");
		}
		rq.login(member);
		System.err.println("doLogin 실행 후--"+rq.getLoginedMemberId());
		return Ut.jsReplace("S-1", "로그인 성공", "../home/main");
	}
	
	@RequestMapping("/usr/member/doLogout")
	@ResponseBody
	public String doLogout(HttpServletRequest req) {

		Rq rq = (Rq) req.getAttribute("rq");

		rq.logout();

//		return Ut.jsReplace("S-1", "로그아웃 성공", "/");
		return "성공이여라~";
	}


	@RequestMapping("/usr/member/myPage/likepage")
	public String likeList(Model model, HttpServletRequest req, String loginId) {
		System.err.println(rq.getLoginedMemberId());
		System.err.println(loginId);

		List<Article> likeArticles = bookmarkService.likeByUsrid(loginId);

		for (Article article : likeArticles) {
			System.out.println(article.getBody());
		}
		model.addAttribute("likeArticles", likeArticles);

		return "usr/member/mypage/likepage";

	}
}
