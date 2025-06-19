package com.example.demo.service;

import java.util.List;

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

	// 즐겨찾기 저장
	public ResultData saveLike(int usrId, int articleId) {
		bookmarkRepository.saveLike(usrId, articleId);
		int likeRow = likeRow(usrId, articleId);

		if (likeRow != 1) {
			return ResultData.from("F-1", "즐찾 실패", "likeRow", likeRow);
		}
		if (likeRow == 0) {
			return ResultData.from("F-2", "즐찾 실패", "likeRow", likeRow);
		}
		return ResultData.from("S-1", "즐찾 성공", "likeRow", likeRow);
	}

	// 즐겨찾기 삭제
	public ResultData delLike(int usrId, int articleId) {
		bookmarkRepository.delLike(usrId, articleId);
		
		int likeRow = likeRow(usrId, articleId);

		if (likeRow != 0) {
			return ResultData.from("F-1", "삭제 실패", "likeRow", likeRow);
		}
		
		return ResultData.from("S-1", "삭제 시도 함");
	}

	// 유저고유번호랑 글아이디로 한줄 가지고오기
	public int likeRow(int usrId, int articleId) {

		int likeRow = bookmarkRepository.likeRow(usrId, articleId);

		return likeRow;
	}

	public List<Article> likeByUsrid(int usrId) {

		return bookmarkRepository.likeByUsrid(usrId);
	}

	
	public ResultData isBookmarked(int usrId, int articleId) {
		int isBookmarked = bookmarkRepository.isBookmarked(usrId, articleId);
		
		if (isBookmarked != 1) {
			
			return ResultData.from("F-A", Ut.f("즐찾안되어있음"));
		}
		
		if (isBookmarked == 1) {
			return ResultData.from("S-1", Ut.f("즐찾되어있음"));
		}

		return ResultData.from("S-1", Ut.f("즐찾되어있음"));
	}

	public ResultData isBookmarkedById(int usrId, int articleId) {
		Article isBookmarkedArtilce = bookmarkRepository.isBookmarkedbyId(usrId);
		// 좋아요를 한 유저아이디를 조건으로 게시글 불러오기
		// 가져온게시글 현재 게시물이 같은 게시물인지 boolean으로
		if(isBookmarkedArtilce.getId()==articleId) {
			return ResultData.from("S-1", "즐찾한글","즐찾유저기준으로 게시글 조인해서 가져옴",isBookmarkedArtilce);
		}
		return ResultData.from("F-1", "게시글을 가져오지못함","즐찾유저기준으로 게시글 조인해서 가져옴",isBookmarkedArtilce);
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}