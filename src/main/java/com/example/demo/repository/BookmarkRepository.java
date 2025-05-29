package com.example.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.vo.Article;

@Mapper
public interface BookmarkRepository {

	//like DB 한줄 가져오기
	public int likeRow(String usrId, int articleId);
// like DB 유저아이디, 게시글 아이디로 저장하기
	public void saveLike(String usrId, int articleId);
	
	public void delLike(String usrId, int articleId);
	//유저아이디 당 즐찾테이블과 게시글테이블 조인해서 즐찾게시글 가져오기
	public List<Article> likeByUsrid(String usrId);
	
	
}
