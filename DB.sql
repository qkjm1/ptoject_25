DROP DATABASE IF EXISTS `project_25`;
CREATE DATABASE `project_25`;
USE `project_25`;

CREATE TABLE `user` (
   id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
   regDate DATETIME NOT NULL,
   updateDate DATETIME NOT NULL,
   loginId CHAR(30) NOT NULL,
   loginPw CHAR(100) NOT NULL,
   `authLevel` SMALLINT(2) UNSIGNED DEFAULT 3 COMMENT '권한 레벨 (3=일반,7=관리자,5=물리치료사)', 
   `name` CHAR(20) NOT NULL,
   nickname CHAR(20) NOT NULL,
   cellphoneNum CHAR(20) NOT NULL,
   email CHAR(20) NOT NULL,
   delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '탈퇴 여부 (0=탈퇴 전, 1=탈퇴 후)',
   delDate DATETIME COMMENT '탈퇴 날짜',
   google_loginId CHAR(100) NOT NULL UNIQUE,
   kakao_loginId CHAR(100) NOT NULL UNIQUE
);

CREATE TABLE board (
   id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
   `code` CHAR(50) NOT NULL UNIQUE COMMENT 'notice(공지사항) free(자유) QnA(질의응답)...',
   `name` CHAR(20) NOT NULL UNIQUE COMMENT '게시판 이름',
   delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '삭제 여부 (0=삭제 전, 1=삭제 후)',
   delDate DATETIME COMMENT '삭제 날짜'
);

CREATE TABLE article (
   id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
   regDate DATETIME NOT NULL,
   updateDate DATETIME NOT NULL,
   title CHAR(100) NOT NULL,
   `body` TEXT NOT NULL,
   usrId INT(10) UNSIGNED NOT NULL,
   hitCount INT(10) UNSIGNED NOT NULL DEFAULT 0,
   goodRp INT(10) UNSIGNED NOT NULL DEFAULT 0,
   boardId INT(10) UNSIGNED NOT NULL
);

CREATE TABLE cartoon (
   id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
   img TEXT NOT NULL COMMENT '이미지 주소'
);


CREATE TABLE info (
   id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
   delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '삭제 여부 (0=삭제 전, 1=삭제 후)',
   delDate DATETIME COMMENT '삭제 날짜',
   part CHAR(50) NOT NULL UNIQUE COMMENT '상하체의 하위분류 인체 테이블과 Fk',
   `body` TEXT NOT NULL
);

CREATE TABLE anatomy (
id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
board INT(10) UNSIGNED NOT NULL,
part CHAR(50) NOT NULL UNIQUE COMMENT '상하체의 하위분류',
ovrall CHAR(50) NOT NULL UNIQUE COMMENT '상체인지 하체인지 구분'
);

CREATE TABLE `like` (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    usrId CHAR(3) NOT NULL,
    articleId INT(10) UNSIGNED NOT NULL,
    regDate DATETIME NOT NULL
);
###########

INSERT INTO board
SET
`code` = 'NOTICE',
`name` = '공지사항';

INSERT INTO board
SET
`code` = 'info',
`name` = '정보';

INSERT INTO board
SET
`code` = 'QnA',
`name` = '질의응답';

		INSERT INTO article
		SET
		regDate = NOW(),
		updateDate = NOW(),
		usrId = 1,
		boardId =
		1,
		title =
		'123',
		`body` = '123';
		
		
		INSERT INTO article
		SET
		regDate = NOW(),
		updateDate = NOW(),
		usrId = 2,
		boardId =
		1,
		title =
		'123',
		`body` = '123';
		
		
		INSERT INTO `like`
		SET
		regDate = NOW(),
		usrId = 1,
		articleId = 1;
		
		INSERT INTO `like`
		SET
		regDate = NOW(),
		usrId = 2,
		articleId = 1;
################

SELECT *
FROM `user`;

SELECT *
FROM board;

SELECT *
FROM article;

SELECT *
FROM cartoon;

SELECT *
FROM anatomy;


SELECT *
FROM `like`;

#############

DELETE FROM `like` 
WHERE usrId = 1
AND
articleId = 1;

SELECT *
FROM article
WHERE id=1

SELECT COUNT(*)
FROM `like`
WHERE
usrId = 1
AND
articleId = 1;