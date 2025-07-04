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
public class Member {

	private int id;
	private LocalDateTime regDate;
	private LocalDateTime updateDate;
	private String loginId;
	private String loginPw;
	private String name;
	private String nickname;
	private String cellphoneNum;
	private String email;
	private int authLevel;
	
	private boolean usrAuthor;
	
	private boolean delStatus;
	private LocalDateTime delDate;

	private String google_loginId;
	private String kakao_loginId;
	
	private String ProfileImage;
}
