 1.alter
 -테이블 변경(ALTER)
 - 테이블의 수정(컬럼 추가, 컬럼속성 변경, 컬럼 삭제, 제약사항 수정/삭제/추가)
 
1)테이블 이름 변경
 ALTER TABLE 테이블명
   RENAME TO 신규테이블명
  . '테이블명'을 '신규테이블명'으로 변경
  
예) EMP테이블 이름을 MYEMP로 변환하시오
ALTER TABLE EMP RENAME TO MYEMP;

2)컬럼을 추가
 ALTER TABLE 테이블명
   ADD 컬럼명 TYPE[(크기)] [DEFAULT 값] [NOT NULL];
   
예)사원테이블(MYEMP)에 급여컬럼(SALARY)을 추가하시오
   급여컬럼은 숫자 9자리로 구성되며 NULL을 허용한다.
ALTER TABLE MYEMP
  ADD SALARY NUMBER(9);
-- SALARY 필드가 추가됨

3)컬럼명 변경
ALTER TABLE 테이블명
  RENAME COLUMN 컬럼명1 TO 컬럼명2;
  . 컬럼명1을 컬럼명2로 변경
  
예)사원테이블(MYENP)에서 주소컬럼(ADDRESS)명을 EMP_ADDR로 변경하시오
ALTER TABLE MYEMP
  RENAME COLUMN ADDRESS TO EMP_ADDR;
  
4)컬럼속성(데이터타입, 크리, 제약사항) 변경
 ALTER TABLE 테이블명
   MODIFY 컬럼명 TYPE[(크기)] [DEFAULT 값] [NOT NULL];
 . 해당 '컬럼명'의 속성을 재설정 

예)사원테이블(MYEMP)에서 사원의 주소(EMP_ADDR)의 속성을 NOT NULL과
   고정길이 60BYTE로 변경하시오  -- 고정길이 CHAR
ALTER TABLE MYEMP
  MODIFY EMP_ADDR CHAR(60) NOT NULL;
  
5)컬럼 삭제
ALTER TABLE 테이블명
  DROP COLUMN 컬럼명;
 .'컬럼명'으로 정의된 컬럼 삭제
 
예)사원테이블에서 급여컬럼을 삭제
ALTER TABLE MYEMP
  DROP COLUMN SALARY;

6) 테이블 제약사항 수정/삭제/삽입
ALTER TABLE 테이블명
  ADD|MODIFY|DROP CONSTRAINT 기본키|외래키 설정명
  [PRIMARY KEY|FOREIGN KEY (컬럼명)
   [REFERENCES 테이블명(컬럼명)]] 
-- []는 ADD나 MODIFY에서는 붙여준다 DROP은 필요없음 설정이름만쓴다
-- 수정과 삭제의 대상은 존재 삽입은 데이터가 존재해서는안됨 중복이발생되어진다.

ALTER TABLE CONST_MATERIALS
  DROP CONSTRAINT FK_CONST_MATERIALS
-- 외래키가 삭제된다
-- CONST_SITE를 DROP 시킬수있다.

DROP TABLE CONST_SITE;
-- 삭제 가능하다. 왜리키관계를 잘라버렷기 때문에
  
ALTER TABLE MOVIE_BOOK
  ADD CONSTRAINT FK_
  [PRIMARY KEY|FOREIGN KEY (컬럼명)
   [REFERENCES 테이블명(컬럼명)]] 







  
  
  
  
  
  
  
  
  