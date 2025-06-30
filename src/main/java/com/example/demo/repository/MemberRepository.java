package com.example.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.vo.Article;
import com.example.demo.vo.Member;

@Mapper
public interface MemberRepository {

	// loginId로 전체 셀렉
	public Member memberById(String loginId);

	// 회원가입
	public int  memberJoin(String loginId, String loginPw, String name, String email, String nickname,
			String cellphoneNum, int authLevel);

	// id로 전체 셀렉
	public Member memberByIntId(int usrId);
	
	// 멤버프로필 사진
	public void updateProfileImage(int usrId, String url);

	public Member findById(int usrId);
		
}
