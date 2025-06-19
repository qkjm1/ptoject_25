package com.example.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.vo.Article;

@Mapper
public interface ArticleRepository {
	
	public int writeArticle(int memberId, String title, String body, int boardId, int partId);

	public int lastInsertId();

	public void delArticle(int articleId);

	public Article articleRow(int articleId);

	public void modifyArticle(int articleId, String title, String body, int boardId, int partId);

	public int getArticleCountByBoard(int boardId, String searchKeywordTypeCode, String searchKeyword);

	public List<Article> getForPrintArticles(int boardId, int limitTake, int limitForm, String searchKeywordTypeCode,
			String searchKeyword);

	public Article getForPrintArticle(int articleId);

	public int getArticleCountByLike(int isLoginMemberId, String searchKeywordTypeCode, String searchKeyword);

	public List<Article> getForPrintLikeArticles(int isLoginMemberId, int limitTake, int limitForm,
			String searchKeywordTypeCode, String searchKeyword);

	public int getArticleCountByMy(int isLoginMemberId, String searchKeywordTypeCode, String searchKeyword);

	public List<Article> getForPrintMyArticles(int isLoginMemberId, int limitTake, int limitForm,
			String searchKeywordTypeCode, String searchKeyword);

	public int getArticleCountByPartId(int partId, int boardId, String searchKeywordTypeCode, String searchKeyword);

	public List<Article> getForPrintArticlesByPartId(int partId, int limitTake, int limitForm,
			String searchKeywordTypeCode, String searchKeyword);

	public Article partName(int partId);

	public List<Article> getForPrintArticlesByPartIdNP(int partId);
}