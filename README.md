# 파이널 프로젝트

---

### 과정

- 기능프로세스(참조사이트 시연)->요구사항 분석 모델링 -> 클래스 설계(Mapper,Service/impl, Controller, DTO)->**view(html)**->본인, 참조사이트 확인, Template 제외->DB Modeling->스키마 생성, 스프링부트 프로젝트 만들어서 깃허브 올리기 -> 협업자 등록->프로젝트 계획(todo, inProgress, Done)->브랜치 생성->코딩->병합

- 테이블별로(CRUD List, 사용자, 관리자페이지)

  xml, controller, service, view 한 테이블 당 나올 수 있는 모든 것 한명이 담당

- 공통모듈(일반적으로 사용)
  회원가입, 로그인/로그아웃, 공지, QnA,리뷰(상품사진, ckediter),댓글(rest controller), 소통게시판

### 맡은 구현 사항

- CRUD(DELETE비밀번호확인X 로그인 상태면 되게, 정말 삭제하시겠습니까?)
- 공지(INTERCEPTOR사용)
