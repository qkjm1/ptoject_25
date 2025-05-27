package com.example.demo.repository;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.vo.Article;

@Mapper
public interface ArticleRepository {
	
	public int writeArticle(int memberId, String title, String body, int boardId);

	public int lastInsertId();

	public void delArticle(int articleId);

	public Article articleRow(int articleId);
}
