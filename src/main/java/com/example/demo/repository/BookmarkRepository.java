package com.example.demo.repository;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.vo.Article;

@Mapper
public interface BookmarkRepository {

	//like DB 한줄 가져오기
	public int likeRow(String usrId, int articleId);
// like DB 유저아이디, 게시글 아이디로 저장하기
	public void saveLike(String usrId, int articleId);
	
	public void delLike(String usrId, int articleId);
	
	
}
