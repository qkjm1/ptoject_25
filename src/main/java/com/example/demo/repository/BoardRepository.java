package com.example.demo.repository;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.vo.Article;
import com.example.demo.vo.Board;

@Mapper
public interface BoardRepository {
	// 보드아이디로 있는지 확인
	public Board getBoardById(int id);

	public Board getBoardByName(String boardName);
}
