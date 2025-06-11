package com.example.demo.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.ArticleService;
import com.example.demo.service.BoardService;
import com.example.demo.service.BookmarkService;
import com.example.demo.service.MemberService;
import com.example.demo.util.Ut;
import com.example.demo.vo.Article;
import com.example.demo.vo.Board;
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
	
	@Autowired
	private ArticleService articleService;

	@Autowired
	private BoardService boardService;

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

		System.err.println("doLogin 실행 전--" + rq.getIsLoginMemberId());

		Member member = memberService.doLogin(loginId);

		if (member==null) {
			return Ut.jsHistoryBack(" ", Ut.f("%s는 없는 아이디입니다", loginId));
		}
		if (member.getLoginPw().equals(loginPw) == false) {
			return Ut.jsHistoryBack(" ", "아이디 혹은 비밀번호가 틀렸습니다");
		}
		rq.login(member);
		System.err.println("doLogin 실행 후--" + rq.getIsLoginMemberId());
		return Ut.jsReplace(" ", "로그인되었습니다", "/");
	}

	@RequestMapping("/usr/member/doLogout")
	@ResponseBody
	public String doLogout(HttpServletRequest req) {

		Rq rq = (Rq) req.getAttribute("rq");

		rq.logout();

		return Ut.jsReplace(" ", "로그아웃되었습니다", "/");
	}

	@RequestMapping("/usr/member/myPage/likepage")
	public String likeList(Model model, HttpServletRequest req, String loginId) {
		System.err.println(rq.getIsLoginMemberId());
		System.err.println(loginId);

		List<Article> likeArticles = bookmarkService.likeByUsrid(loginId);

		for (Article article : likeArticles) {
			System.out.println(article.getBody());
		}
		model.addAttribute("likeArticles", likeArticles); 

		return "usr/member/mypage/likepage";

	}

	//

	@RequestMapping("/usr/member/mypage/likepage")
	public String showMypage(
			HttpServletRequest req, Model model,
			@RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "") String searchKeywordTypeCode,
			@RequestParam(defaultValue = "") String searchKeyword) throws IOException {

		int listInApage = 6;

		int articlesCntBylike = articleService.getArticleCountByLike(rq.getIsLoginMemberId() , searchKeywordTypeCode, searchKeyword);
		System.err.println("articlesCntBylike: "+articlesCntBylike);
		int totalPage = (int) Math.ceil(articlesCntBylike / (double) listInApage);
		System.err.println("totalPage: "+totalPage);

		List<Article> likeArticles = articleService.getForPrintLikeArticles(rq.getIsLoginMemberId(), listInApage, page, searchKeywordTypeCode,
				searchKeyword);

		model.addAttribute("articlesCntBylike", articlesCntBylike);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("likeArticles", likeArticles);
		model.addAttribute("page", page);
		model.addAttribute("searchKeywordTypeCode", searchKeywordTypeCode);
		model.addAttribute("searchKeyword", searchKeyword);

		return "/usr/member/mypage/likepage";
	}
	
	@RequestMapping("/usr/member/mypage/myarticle")
	public String showMyArticle(
			HttpServletRequest req, Model model,
			@RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "") String searchKeywordTypeCode,
			@RequestParam(defaultValue = "") String searchKeyword) throws IOException {

		int listInApage = 6;

		int articlesCntByMy = articleService.getArticleCountByMy(rq.getIsLoginMemberId() , searchKeywordTypeCode, searchKeyword);
		System.err.println("articlesCntByMy: "+articlesCntByMy);
		int totalPage = (int) Math.ceil(articlesCntByMy / (double) listInApage);
		System.err.println("totalPage: "+totalPage);

		List<Article> myArticles = articleService.getForPrintMyArticles(rq.getIsLoginMemberId(), listInApage, page, searchKeywordTypeCode,
				searchKeyword);

		model.addAttribute("articlesCntByMy", articlesCntByMy);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("myArticles", myArticles);
		model.addAttribute("page", page);
		model.addAttribute("searchKeywordTypeCode", searchKeywordTypeCode);
		model.addAttribute("searchKeyword", searchKeyword);

		return "/usr/member/mypage/myarticle";
	}
	
	@RequestMapping("/usr/member/mypage/usrmodify")
	public String showusrmodify(HttpServletRequest req, Model model) {		
		Member member = memberService.memberByIntId(rq.getIsLoginMemberId());
		
		model.addAttribute("member", member);
		return "/usr/member/mypage/usrmodify";
	}
			
}
