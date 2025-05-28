package com.example.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.repository.ArticleRepository;
import com.example.demo.repository.BookmarkRepository;
import com.example.demo.util.Ut;
import com.example.demo.vo.Article;
import com.example.demo.vo.ResultData;

@Service
public class BookmarkService {
	
	@Autowired
	private BookmarkRepository bookmarkRepository;

	public ResultData saveLike(int usrId, int articleId) {
		
		return null;
	}

	public int likeRow(int usrId, int articleId) {

		return 0;
	}


}
