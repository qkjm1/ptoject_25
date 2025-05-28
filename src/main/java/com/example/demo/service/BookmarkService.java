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

	// 즐겨찾기 저장
	public ResultData saveLike(String usrId, int articleId) {
		bookmarkRepository.saveLike(usrId, articleId);
		int likeRow = likeRow(usrId, articleId);

		if (likeRow != 1) {
			return ResultData.from("F-1", "삭제 실패", "likeRow", likeRow);
		}
		if (likeRow == 0) {
			return ResultData.from("F-2", "삭제 실패", "likeRow", likeRow);
		}
		return ResultData.from("S-1", "삭제 성공", "likeRow", likeRow);
	}

	// 즐겨찾기 삭제
	public ResultData delLike(String usrId, int articleId) {
		bookmarkRepository.delLike(usrId, articleId);
		int likeRow = likeRow(usrId, articleId);

		if (likeRow != 0) {
			return ResultData.from("F-1", "삭제 실패", "likeRow", likeRow);
		}
		return ResultData.from("S-1", "삭제 성공", "likeRow", likeRow);
	}

	// 유저고유번호랑 글아이디로 한줄 가지고오기
	public int likeRow(String usrId, int articleId) {
		System.err.println("==2==");
		int likeRow = bookmarkRepository.likeRow(usrId, articleId);
		System.err.println("==3==");
		return likeRow;
	}

}
