package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.vo.Rq;

@Controller
public class usrMemberController {
	@Autowired
	private Rq rq;
	
	@RequestMapping("/usr/member/join")
	@ResponseBody
	public String showJoin() {
		
		return "ㅎㅇ";
	}
}
