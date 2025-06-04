package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.vo.Rq;

@Controller
public class usrHomeController {
	@RequestMapping("/usr/home/main")
	public String main() {
		return "/usr/home/main";
	}
	
	@RequestMapping("/")
	public String demo() {
		return "/usr/home/main";
	}
	
	@RequestMapping("/demo")
	public String dddemo() {
		return "/usr/demo";
	}
}
