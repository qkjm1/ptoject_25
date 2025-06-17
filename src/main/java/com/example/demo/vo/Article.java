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
	private String regDate;
	private String updateDate;
	private String title;
	private String body;
	
	private int usrId;
	private int boardId;
	private int hitCount;
	private int goodRp;
	private int partId;

	private boolean delStatus;
	private LocalDateTime delDate;

	private boolean usrAuthor;
	
	private String extra__writer;
	private String part__name;
	private String isBookmarked;
}
