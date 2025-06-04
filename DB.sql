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
   delDate DATETIME COMMENT '탈퇴 날짜'
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
    usrId CHAR(10) NOT NULL,
    articleId INT(10) UNSIGNED NOT NULL,
    regDate DATETIME NOT NULL
);
###########


INSERT INTO article
SET
regDate = NOW(),
updateDate =NOW(),
title = "장요근 통증",
`body` = "20대 남성이 축구 중 갑작스런 방향 전환 후 사타구니와 골반 깊은 부위 통증 발생.
걷거나 무릎을 드는 동작에서 통증 심화되어 병원 방문.",
usrId = 1,
boardId = 3;

INSERT INTO article
SET
regDate = NOW(),
updateDate =NOW(),
title = "디스크 수술 후에 걷는게 이상함",
`body` = "60대 여성, 허리 디스크 수술 후 장요근 약화로 보행 시 다리 들어올리기 어려움.
골반 전면과 허리 깊은 통증 지속되어 재활 물리치료 시작.",
usrId = 1,
boardId = 3;


INSERT INTO article
SET
regDate = NOW(),
updateDate =NOW(),
title = "일어날때 아파요",
`body` = "40대 직장인이 장시간 의자에 앉아 일한 후 요추 주변과 사타구니 근처 통증 호소.
특히 일어날 때 초기 움직임에 심한 당김 느낌 경험.",
usrId = 1,
boardId = 3;


INSERT INTO article
SET
regDate = NOW(),
updateDate =NOW(),
title = "넘어진 후에 계속 아픔",
`body` = "60대 여성이 빗길에 넘어지며 어깨를 직접 부딪힌 후, 팔을 위로 들 수 없는 극심한 통증 발생.
초기에는 단순 근육통으로 생각했으나 2주 이상 회복되지 않아 영상 검사 후 회전근개 파열 진단.",
usrId = 1,
boardId = 3;


INSERT INTO article
SET
regDate = NOW(),
updateDate =NOW(),
title = "목수입니다 물리치료를 다녀도 어깨가 아파요",
`body` = "40대 남성, 배관공으로 일하며 반복적인 머리 위 작업 이후 어깨 앞쪽 통증 및 야간 통증 악화.
진찰상 극상근 약화 및 외회전 약화 보이며 부분층 파열 의심.",
usrId = 1,
boardId = 3;


INSERT INTO article
SET
regDate = NOW(),
updateDate =NOW(),
title = "어깨에 뚝소리",
`body` = "70대 골다공증 여성, 창문 닫으려 팔 뻗는 순간 '뚝' 소리와 함께 날카로운 어깨 통증 발생.
팔이 전혀 올라가지 않아 응급실 내원, MRI에서 광범위 회전근개 완전 파열 확인.",
usrId = 1,
boardId = 3;


INSERT INTO article
SET
regDate = NOW(),
updateDate =NOW(),
title = "편두통이 너무 심해요",
`body` = "30대 회사원, 오후마다 머리 전체가 조여오는 듯한 통증을 느껴 내원.
최근 과중한 업무와 수면 부족이 있었으며, 통증은 규칙적인 식사와 휴식 후 완화됨.
신경학적 이상 소견은 없고 스트레스성 긴장성 두통으로 진단됨.",
usrId = 2,
boardId = 3;


INSERT INTO article
SET
regDate = NOW(),
updateDate =NOW(),
title = "머리가 지끈지끈함",
`body` = "20대 여성, 생리 전후로 주기적으로 나타나는 한쪽 머리의 욱신거리는 통증 호소.
두통은 4~6시간 지속되며, 빛과 소리에 민감해지고 오심 동반됨.
과거 가족력 있으며 MRI 정상이었고 편두통 진단 후 예방 치료 시작.",
usrId = 2,
boardId = 3;


INSERT INTO article
SET
regDate = NOW(),
updateDate =NOW(),
title = "아버지 뇌출혈 의심인가요?",
`body` = "60대 남성, 갑작스럽고 극심한 ‘벼락처럼’ 오는 두통으로 응급실 방문.
혈압 상승과 함께 구토, 의식 혼미 증상 동반됨.
CT에서 지주막하출혈 확인되어 신경외과 중환자실 입원.",
usrId = 2,
boardId = 3;


INSERT INTO article
SET
regDate = NOW(),
updateDate =NOW(),
title = "눈주변으로 통증이 심해요",
`body` = "40대 남성, 매년 특정 계절에만 눈 주위가 찌르는 듯한 통증이 일정 시간 동안 반복 발생.
통증은 1~2시간 동안 지속되고, 눈물 및 콧물 동반되며 자주 밤에 발생함.
군발두통 진단받고 산소요법 및 예방약 투여 시작함.",
usrId = 2,
boardId = 3;


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


###########################

SELECT *
		FROM board
		WHERE id = 1 AND delStatus = 0
		
		
		SELECT COUNT(*) , M.nickname AS extra__writer
		FROM article AS A
		INNER
		JOIN `user` AS M
		ON A.usrId = M.id
		AND A.boardId = ${boardId}</IF>
		<IF test="searchKeyword != ''">
			<choose>
				<WHEN test="searchKeywordTypeCode == 'title'">
					AND A.title LIKE CONCAT('%', #{searchKeyword}, '%')
				</WHEN>
				<WHEN test="searchKeywordTypeCode == 'body'">
					AND A.`body` LIKE CONCAT('%', #{searchKeyword}, '%')
				</WHEN>
				<otherwise>
					AND A.title LIKE CONCAT('%', #{searchKeyword}, '%')
					OR
					A.`body` LIKE CONCAT('%', #{searchKeyword}, '%')