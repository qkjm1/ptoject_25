package com.example.demo.vo;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Article {

	private int id;
	private LocalDateTime regDate;
	private LocalDateTime updateDate;
	private String title;
	private String body;
	
	private int usrId;
	private int boardId;
	private int hitCount;
	private int goodRp;

	private boolean delStatus;
	private LocalDateTime delDate;

	private boolean usrAuthor;
}
