package com.example.demo.vo;

import java.io.IOException;

import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.stereotype.Component;

import com.example.demo.util.Ut;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.Getter;
import lombok.Setter;

@Component
@Scope(value = "request", proxyMode = ScopedProxyMode.TARGET_CLASS)
@Getter
@Setter
public class Rq {

	private final HttpServletRequest req;
	private final HttpServletResponse resp;
	private final HttpSession session;

	private boolean isLogined = false;
	private int isLoginMemberId = 0;

	public Rq(HttpServletRequest req, HttpServletResponse resp) {
		this.req = req;
		this.resp = resp;
		this.session = req.getSession();

		if (session.getAttribute("loginedMemberId") != null) {
			isLogined = true;
			isLoginMemberId = (int) session.getAttribute("loginedMemberId");
		}

		this.req.setAttribute("rq", this);
	}

	public void printHistoryBack(String msg) throws IOException {
	    resp.setContentType("text/html; charset=UTF-8");
	    println("<script>");
	    if (!Ut.isEmpty(msg)) {
	    	println("alert('" + msg.replace("'", "\\'") + "');");
	    }
	    println("history.back();");
	    println("</script>");
	    resp.getWriter().flush();
	    resp.getWriter().close();
	}

	private void println(String str) throws IOException {
		print(str + "\n");
	}

	private void print(String str) throws IOException {
		resp.getWriter().append(str);
	}

	public void logout() {
		session.removeAttribute("loginedMemberId");
	}

	public void login(Member member) {
		session.setAttribute("loginedMemberId", member.getId());
	}

	public void initBeforeActionInterceptor() {
		System.err.println("initBeforeActionInterceptor 실행됨");
	}

	public String historyBackOnView(String msg) {
		req.setAttribute("msg", msg);
		req.setAttribute("historyBack", true);
		return "usr/common/js";
	}
	
	
	public String getCurrentUri() {
		String currentUri = req.getRequestURI();
		String queryString = req.getQueryString();
		
		if (currentUri != null && queryString != null) {
			currentUri += "?" + queryString;
		}

		return currentUri;
	}
	
}