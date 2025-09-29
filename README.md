# ptoject_25-main

## 개요
이 저장소는 Spring Boot 기반의 웹 애플리케이션(백엔드)을(를) 포함하고 있습니다.

### 주요 기술 스택
- Spring Boot (Java)
- Maven
- MySQL
- MyBatis


## 디렉터리 구조 (요약)

```

./
  ptoject_25-main/

ptoject_25-main/
  .mvn/
  src/
  .gitattributes
  .gitignore
  DB.sql
  mvnw
  mvnw.cmd
  pom.xml
  src.zip

ptoject_25-main/.mvn/
  wrapper/

ptoject_25-main/src/
  main/
  test/

```

## 실행 방법

### 1) 백엔드 (Spring Boot)

#### Maven

```bash

cd ptoject_25-main

mvn clean package -DskipTests

java -jar target/*.jar

```

### 데이터베이스 설정 (MySQL)

- `spring.datasource.url`: `jdbc:mysql://127.0.0.1:3306/project_25?useUnicode=true&characterEncoding=utf8&autoReconnect=true&serverTimezone=Asia/Seoul`

- MyBatis 매퍼 위치: `ptoject_25-main/src/main/resources/mapper/` (추정)

- mybatis.mapper-locations: `classpath:/mapper/**/*.xml`



### 뷰/정적 리소스

- 정적자원(static): `ptoject_25-main/src/main/resources/static/`


### 메인 애플리케이션 클래스
- `ptoject_25-main/src/main/java/com/example/demo/Demo1Application.java`


## 참고 정보

- 컨트롤러 파일 수: 6개
- 서비스 파일 수: 4개
- 리포지토리/매퍼 파일 수: 4개
- 매퍼 XML 수: 4개


## 트러블슈팅 팁

1. **포트 충돌**: `server.port` 설정을 확인하세요.

2. **DB 연결 오류**: MySQL 접속 정보(`url`, `username`, `password`) 및 방화벽/포트를 점검하세요.

3. **매퍼 경로 오류**: `mybatis.mapper-locations`가 실제 경로와 일치하는지 확인하세요.

4. **정적/템플릿 경로**: `spring.thymeleaf.prefix`, `spring.web.resources.static-locations` 확인.

## 라이선스

프로젝트에 명시된 라이선스 파일이 없다면 사내/개인 프로젝트로 간주됩니다. 공개 배포 시 적절한 라이선스를 추가하세요.
