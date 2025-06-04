package com.example.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.repository.ArticleRepository;
import com.example.demo.repository.BoardRepository;
import com.example.demo.util.Ut;
import com.example.demo.vo.Article;
import com.example.demo.vo.Board;
import com.example.demo.vo.ResultData;

@Service
public class BoardService {

	@Autowired
	private BoardRepository boardRepository;

	public BoardService(BoardRepository boardRepository) {
		this.boardRepository = boardRepository;
	}
	
// 보드아이디로 있는 보드인지 확인
	public Board getBoardById(int boardId) {
		return boardRepository.getBoardById(boardId);
	}
	
	public Board getBoardByName(String boardName) {
		return boardRepository.getBoardByName(boardName);
	}
}
