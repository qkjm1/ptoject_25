package com.example.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.vo.Article;

@Mapper
public interface BookmarkRepository {

	//like DB 한줄 가져오기
	public int likeRow(int usrId, int articleId);
// like DB 유저아이디, 게시글 아이디로 저장하기
	public void saveLike(int usrId, int articleId);
	
	public void delLike(int usrId, int articleId);
	//유저아이디 당 즐찾테이블과 게시글테이블 조인해서 즐찾게시글 가져오기
	public List<Article> likeByUsrid(int usrId);
	
	//즐찾한 유저인지 아닌지
	public int isBookmarked(int usrId, int articleId);
	//아이디로 아티클과 북마크 조인
	public List<Article> isBookmarkedbyId(int usrId);
}