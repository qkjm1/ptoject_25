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
   `code` CHAR(50) NOT NULL UNIQUE COMMENT 'notice(공지사항) free(자유) info(정보)...',
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
   boardId INT(10) UNSIGNED NOT NULL,
   partId INT(10) UNSIGNED NOT NULL
);

CREATE TABLE profileImg (
   id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
   usrId INT(10) UNSIGNED NOT NULL,
   img TEXT NOT NULL COMMENT '이미지 주소'
);


CREATE TABLE anatomy (
id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
part CHAR(50) NOT NULL UNIQUE COMMENT '상하체의 하위분류'
);

CREATE TABLE `like` (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    usrId CHAR(10) NOT NULL,
    articleId INT(10) UNSIGNED NOT NULL,
    regDate DATETIME NOT NULL
);
###########

INSERT INTO `user`
SET
regDate = NOW(),
updateDate = NOW(),
loginId  = '11',
loginPw = '11',
`name` = '11',
nickname = '회원1',
cellphoneNum = '1231231234',
email = '11@naver.com';

INSERT INTO `user`
SET
regDate = NOW(),
updateDate = NOW(),
loginId  = '22',
loginPw = '22',
`name` = '22',
nickname = '회원2',
cellphoneNum = '1234431234',
email = '22@naver.com';

INSERT INTO `user`
SET
regDate = NOW(),
updateDate = NOW(),
loginId  = '33',
loginPw = '33',
`name` = '33',
nickname = '회원3',
cellphoneNum = '123123254',
email = '33@naver.com';

INSERT INTO `user`
SET
regDate = NOW(),
updateDate = NOW(),
loginId  = '44',
loginPw = '44',
`name` = '44',
nickname = '회원4',
cellphoneNum = '12f3123254',
authLevel = 7,
email = '33ds@naver.com';


INSERT INTO anatomy
SET
part = '머리';


INSERT INTO anatomy
SET
part = '목/뒤쪾어깨';

INSERT INTO anatomy
SET
part = '쇄골/앞쪽어깨';

INSERT INTO anatomy
SET
part = '팔';

INSERT INTO anatomy
SET
part = '등/허리';

INSERT INTO anatomy
SET
part = '가슴,배';

INSERT INTO anatomy
SET
part = '골반';


INSERT INTO anatomy
SET
part = '다리앞쪽';

INSERT INTO anatomy
SET
part = '다리뒤쪽';

INSERT INTO anatomy
SET
part = '종아리/발목';


INSERT INTO article
SET
regDate = NOW(),
updateDate =NOW(),
title = "장요근 통증",
`body` = "20대 남성이 축구 중 갑작스런 방향 전환 후 사타구니와 골반 깊은 부위 통증 발생.
걷거나 무릎을 드는 동작에서 통증 심화되어 병원 방문.",
usrId = 1,
partId = 5,
boardId = 3;

INSERT INTO article
SET
regDate = NOW(),
updateDate =NOW(),
title = "디스크 수술 후에 걷는게 이상함",
`body` = "60대 여성, 허리 디스크 수술 후 장요근 약화로 보행 시 다리 들어올리기 어려움.
골반 전면과 허리 깊은 통증 지속되어 재활 물리치료 시작.",
usrId = 1,
partId = 4,
boardId = 3;


INSERT INTO article
SET
regDate = NOW(),
updateDate =NOW(),
title = "일어날때 아파요",
`body` = "40대 직장인이 장시간 의자에 앉아 일한 후 요추 주변과 사타구니 근처 통증 호소.
특히 일어날 때 초기 움직임에 심한 당김 느낌 경험.",
usrId = 1,
partId = 5,
boardId = 3;


INSERT INTO article
SET
regDate = NOW(),
updateDate =NOW(),
title = "넘어진 후에 계속 아픔",
`body` = "60대 여성이 빗길에 넘어지며 어깨를 직접 부딪힌 후, 팔을 위로 들 수 없는 극심한 통증 발생.
초기에는 단순 근육통으로 생각했으나 2주 이상 회복되지 않아 영상 검사 후 회전근개 파열 진단.",
usrId = 3,
partId = 2,
boardId = 3;


INSERT INTO article
SET
regDate = NOW(),
updateDate =NOW(),
title = "목수입니다 물리치료를 다녀도 어깨가 아파요",
`body` = "40대 남성, 배관공으로 일하며 반복적인 머리 위 작업 이후 어깨 앞쪽 통증 및 야간 통증 악화.
진찰상 극상근 약화 및 외회전 약화 보이며 부분층 파열 의심.",
usrId = 3,
partId = 2,
boardId = 3;


INSERT INTO article
SET
regDate = NOW(),
updateDate =NOW(),
title = "어깨에 뚝소리",
`body` = "70대 골다공증 여성, 창문 닫으려 팔 뻗는 순간 '뚝' 소리와 함께 날카로운 어깨 통증 발생.
팔이 전혀 올라가지 않아 응급실 내원, MRI에서 광범위 회전근개 완전 파열 확인.",
usrId = 1,
partId = 2,
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
partId = 1,
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
partId = 1,
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
partId = 1,
boardId = 3;


INSERT INTO article
SET
regDate = NOW(),
updateDate =NOW(),
title = "눈주변으로 통증이 심해요",
`body` = "40대 남성, 매년 특정 계절에만 눈 주위가 찌르는 듯한 통증이 일정 시간 동안 반복 발생.
통증은 1~2시간 동안 지속되고, 눈물 및 콧물 동반되며 자주 밤에 발생함.
군발두통 진단받고 산소요법 및 예방약 투여 시작함.",
usrId = 3,
partId = 1,
boardId = 3;

#############


-- 두통 관련
INSERT INTO article
SET regDate = NOW(), updateDate = NOW(),
title = "긴장성 두통이란?",
`body` = "긴장성 두통은 가장 흔한 유형의 두통으로, 주로 스트레스나 불안으로 인해 발생하며 머리에 띠를 두른 듯한 압박감을 느끼게 된다.",
usrId = 3, partId = 1, boardId = 2;

INSERT INTO article
SET regDate = NOW(), updateDate = NOW(),
title = "뇌경색 증상과 초기 대처 방법",
`body` = "뇌경색은 뇌혈관이 막혀 발생하는 질환으로 갑작스러운 언어 장애, 편측 마비, 어지럼증 등이 주요 증상입니다. 증상이 나타나면 즉시 병원을 찾아야 하며, 빠른 치료가 후유증을 줄입니다.",
usrId = 1, partId = 1, boardId = 2;

INSERT INTO article
SET regDate = NOW(), updateDate = NOW(),
title = "편두통의 원인과 관리법",
`body` = "편두통은 주로 스트레스, 수면 부족, 특정 음식 섭취 등으로 유발됩니다. 증상으로는 머리 한쪽의 욱신거림, 메스꺼움, 빛과 소리에 민감함 등이 있습니다. 카페인 조절과 규칙적인 생활이 도움이 됩니다.",
usrId = 3, partId = 1, boardId = 2;

INSERT INTO article
SET regDate = NOW(), updateDate = NOW(),
title = "뇌출혈의 위험성과 예방법",
`body` = "뇌출혈은 고혈압, 외상 등으로 인해 뇌혈관이 터지며 발생합니다. 심한 두통, 구토, 의식 저하 등이 나타날 수 있으며, 예방을 위해서는 혈압 관리와 금연이 중요합니다.",
usrId = 2, partId = 1, boardId = 2;

INSERT INTO article
SET regDate = NOW(), updateDate = NOW(),
title = "후두하근 뻐근함의 원인과 해결 방법",
`body` = "후두하근 뻐근함은 주로 장시간의 스마트폰 사용이나 잘못된 자세에서 비롯됩니다. 꾸준한 스트레칭과 자세 교정, 마사지가 효과적이며, 증상이 지속될 경우 전문의 상담이 필요합니다.",
usrId = 1, partId = 1, boardId = 2;


-- 목/어깨 관련
INSERT INTO article
SET regDate = NOW(), updateDate = NOW(),
title = "목디스크 증상의 초기 징후",
`body` = "목디스크는 목의 추간판이 돌출되어 신경을 압박하는 질환으로, 팔 저림이나 어깨 통증이 동반될 수 있다.",
usrId = 2, partId = 2, boardId = 2;

INSERT INTO article
SET regDate = NOW(), updateDate = NOW(),
title = "거상근 통증의 원인과 해결 방법",
`body` = "거상근은 어깨를 으쓱하게 만드는 근육으로, 장시간의 스마트폰 사용이나 스트레스 등으로 쉽게 긴장해 통증을 유발합니다. 스트레칭과 자세 교정, 온찜질이 도움이 됩니다.",
usrId = 2, partId = 2, boardId = 2;

INSERT INTO article
SET regDate = NOW(), updateDate = NOW(),
title = "긴장성 어깨의 특징과 관리법",
`body` = "긴장성 어깨는 스트레스나 근육 긴장으로 인해 어깨 부위가 지속적으로 뻐근하고 무거운 느낌을 주는 증상입니다. 꾸준한 운동과 휴식, 이완 요법이 도움이 됩니다.",
usrId = 3, partId = 2, boardId = 2;

INSERT INTO article
SET regDate = NOW(), updateDate = NOW(),
title = "승모근 통증 완화하는 방법",
`body` = "승모근은 목과 어깨를 잇는 근육으로, 잘못된 자세나 무거운 물건을 자주 드는 습관이 통증을 유발합니다. 마사지와 스트레칭, 물리치료로 증상을 완화할 수 있습니다.",
usrId = 1, partId = 2, boardId = 2;

INSERT INTO article
SET regDate = NOW(), updateDate = NOW(),
title = "어깨 뻐근함의 흔한 원인들",
`body` = "어깨 뻐근함은 컴퓨터 작업, 운전, 수면 자세 불량 등이 주된 원인입니다. 휴식과 함께 스트레칭을 자주 해주고, 의자와 모니터 높이 조절 등 자세 개선이 중요합니다.",
usrId = 2, partId = 2, boardId = 2;

INSERT INTO article
SET regDate = NOW(), updateDate = NOW(),
title = "회전근개 통증과 재활 운동",
`body` = "회전근개는 어깨 관절을 지지하는 근육 그룹으로, 반복적인 사용이나 외상으로 인해 손상될 수 있습니다. 초기에는 냉찜질과 안정을 취하고 이후 재활 운동이 필요합니다.",
usrId = 1, partId = 2, boardId = 2;


-- 어깨 관련
INSERT INTO article
SET regDate = NOW(), updateDate = NOW(),
title = "회전근개 파열이란?",
`body` = "회전근개는 어깨 관절을 안정화시키는 근육들의 집합이며, 이 부위의 손상은 어깨의 운동 범위 감소 및 통증을 유발한다.",
usrId = 1, partId = 3, boardId = 2;

-- 팔꿈치 관련
INSERT INTO article
SET regDate = NOW(), updateDate = NOW(),
title = "팔꿈치 부상의 예방 방법",
`body` = "팔꿈치 관절은 반복된 움직임에 민감하므로 운동 전 스트레칭과 올바른 자세가 부상을 예방하는 핵심이다.",
usrId = 1, partId = 4, boardId = 2;

-- 허리 관련
INSERT INTO article
SET regDate = NOW(), updateDate = NOW(),
title = "허리디스크 초기 증상 알아보기",
`body` = "허리디스크는 추간판이 돌출되면서 신경을 누르는 질환으로, 다리 저림이나 허리통증이 주요 증상이다.",
usrId = 2, partId = 5, boardId = 2;

INSERT INTO article
SET regDate = NOW(), updateDate = NOW(),
title = "추간판탈출증(Herniated Disc)의 이해",
`body` = "추간판탈출증은 흔히 '디스크'로 불리며, 척추 사이의 디스크가 밀려나 신경을 압박하는 질환입니다. 주로 허리 통증과 함께 다리 저림, 감각 저하 등의 증상이 나타납니다. 자세 교정, 물리치료, 운동 요법 등이 치료에 사용됩니다.",
usrId = 1, partId = 5, boardId = 2;

INSERT INTO article
SET regDate = NOW(), updateDate = NOW(),
title = "강직성 척추염(Ankylosing Spondylitis)의 증상",
`body` = "강직성 척추염은 척추에 만성 염증이 생겨 움직임이 제한되고 통증이 생기는 자가면역질환입니다. 초기에는 엉덩이나 허리 통증으로 시작되며, 시간이 지날수록 척추가 굳습니다. 조기 진단과 약물 치료가 매우 중요합니다.",
usrId = 2, partId = 5, boardId = 2;

INSERT INTO article
SET regDate = NOW(), updateDate = NOW(),
title = "얀다의 법칙과 자세 불균형",
`body` = "얀다의 법칙은 특정 근육 그룹의 불균형이 신체의 자세와 움직임에 영향을 준다는 이론입니다. 상교차증후군과 하교차증후군이 대표적 예로, 특정 근육의 긴장과 약화가 통증을 유발합니다. 치료는 스트레칭과 근육 강화에 중점을 둡니다.",
usrId = 2, partId = 5, boardId = 2;

INSERT INTO article
SET regDate = NOW(), updateDate = NOW(),
title = "척추측만증(Scoliosis)의 원인과 치료",
`body` = "척추측만증은 척추가 옆으로 휘는 상태로, 성장기 청소년에게 자주 발생합니다. 자세 불균형, 유전, 신경근 이상 등 다양한 원인이 있습니다. 치료는 경과 관찰, 보조기 착용, 심할 경우 수술이 필요합니다.",
usrId = 1, partId = 5, boardId = 2;

INSERT INTO article
SET regDate = NOW(), updateDate = NOW(),
title = "Slump Test로 신경 긴장 확인하기",
`body` = "Slump Test는 앉은 자세에서 척수 신경의 긴장 상태를 확인하기 위해 사용됩니다. 머리를 숙이고 다리를 들어 신경 자극 증상을 유발하는지 확인합니다. 좌골신경통 또는 추간판탈출증 진단에 도움이 됩니다.",
usrId = 2, partId = 5, boardId = 2;

INSERT INTO article
SET regDate = NOW(), updateDate = NOW(),
title = "Straight Leg Raising Test의 진단적 의미",
`body` = "SLR 테스트는 다리를 들어올려 좌골신경의 긴장을 유발해 디스크 이상 여부를 확인하는 검사입니다. 30~70도 사이에서 통증이 발생하면 추간판탈출증 가능성을 의심합니다. 비교적 간단하지만 민감도가 높은 검사입니다.",
usrId = 1, partId = 5, boardId = 2;

INSERT INTO article
SET regDate = NOW(), updateDate = NOW(),
title = "Brudzinski Sign으로 수막 자극 확인",
`body` = "Brudzinski Sign은 환자의 목을 굽힐 때 무릎이 반사적으로 굽혀지는 현상으로, 수막 자극 증후군에서 관찰됩니다. 수막염, 지주막하출혈 등 신경학적 질환에서 중요한 진단 지표입니다. 다른 신경계 검진과 병행됩니다.",
usrId = 1, partId = 5, boardId = 2;

INSERT INTO article
SET regDate = NOW(), updateDate = NOW(),
title = "Bragard's Test와 신경근 평가",
`body` = "Bragard's Test는 SLR 검사 후 발목을 족배굴곡시켜 좌골신경 자극 증상을 확인하는 검사입니다. 추가적인 신경 뿌리 압박 여부를 판단하는 데 유용합니다. 추간판 탈출증 진단 시 SLR과 함께 사용됩니다.",
usrId = 2, partId = 5, boardId = 2;

INSERT INTO article
SET regDate = NOW(), updateDate = NOW(),
title = "Kemp Quadrant Test로 요추 신경근 평가",
`body` = "Kemp Test는 환자의 몸을 뒤로 젖히고 회전시키는 동작을 통해 요추 신경근의 압박을 확인합니다. 통증이 유발되면 추간판 이상 또는 척추관 협착증을 의심할 수 있습니다. 물리치료 평가 시 유용하게 사용됩니다.",
usrId = 1, partId = 5, boardId = 2;


-- 복부 관련
INSERT INTO article
SET regDate = NOW(), updateDate = NOW(),
title = "소화불량과 복부 팽만의 원인",
`body` = "소화불량은 식사 후 복부 팽만, 트림, 속쓰림 등을 유발하며 식습관 개선과 위장 관리가 필요하다.",
usrId = 1, partId = 6, boardId = 2;

-- 골반 관련
INSERT INTO article
SET regDate = NOW(), updateDate = NOW(),
title = "만성 골반통 증후군",
`body` = "만성 골반통은 여성에게 흔하게 나타나는 증상으로, 생식기 질환 외에도 요추, 신경통 등이 원인이 될 수 있다.",
usrId = 3, partId = 7, boardId = 2;



###################
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
`code` = 'free',
`name` = '자유';

      
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
FROM profileImg;

SELECT *
FROM anatomy
ORDER BY id;

SELECT *
FROM info
ORDER BY id;

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
FROM article A 
INNER JOIN board B
ON A.boardId = B.id



SELECT *
FROM article A
LEFT JOIN `like` L
ON A.id = L.articleId
WHERE L.usrId = 1

SELECT *
FROM article 
WHERE partId = 8

SELECT *
      FROM board
      WHERE id = 1 AND delStatus = 0
      
      
      SELECT COUNT(*) , M.nickname AS extra__writer
      FROM article AS A
      INNER
      JOIN `user` AS M
      ON A.usrId = M.id
      WHERE  A.title LIKE '%어깨%'
      
      
      SELECT COUNT(*)
      FROM `like` L
      INNER JOIN `user` U
      ON L.usrId =
      U.id
      WHERE
      L.articleId = 1
      AND
      U.id = 1;
      
      SELECT COUNT(*)
      FROM `like` L
      INNER JOIN `user` U
      ON L.usrId =
      U.id
      WHERE
      L.articleId = 16
      AND
      U.id = 1;
      
      
      
      SELECT COUNT(*)
      FROM article A
      INNER JOIN board B
      ON A.boardId = B.id
      INNER JOIN anatomy T
      ON
      A.partId = T.id
      WHERE T.id = 3
      AND B.id =2
      
            SELECT A.id
      FROM `like` L
      INNER JOIN article A
      ON L.articleId =
      A.id
      WHERE
      L.usrId = 1;
      
     SELECT P.img AS ProfileImage
		FROM profileImg P
		INNER JOIN `user` U
		ON P.usrId = U.id
		WHERE P.usrId =
		1
		
		SELECT U.*, P.img AS ProfileImage
		FROM `user` U
		INNER JOIN profileImg P
		ON P.usrId = U.id
		WHERE
		
		SELECT P.img AS ProfileImage
		FROM profileImg P
		INNER JOIN `user` U
		ON P.usrId = U.id
		WHERE P.usrId =
		1
		LIMIT 1;