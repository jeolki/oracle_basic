 1. SQL 명령
 - Structured Query language의 약자
 - 구조적 언어이기 때문에 비교, 반복문이 존재하지 않음
 - 변수 사용이 허용되지 않음
 
1) 종류
 (1) DML(Data Manupulaion Language)
    - 테이블의 자료를 조작하는 명령문
    - INSERT, UPDATE, DELETE
 (2) DCL(Data Control Language)
    - grant, commit, rollback, revoke
    - 권한, 저장, 명령취소 등의 기능 수행
 (3) DDL(Data Defintion Language)
    - 데이터 정의어
    - CREATE, ALTER, DROP
 (4) 질의어
    - 데이터 조회기능 수행
    - SELECT 
    
2. 자료형
 - 오라클에서 제공하는 데이터 타입으로는 문자형, 숫자형, 날짜형, 기타
1) 문자형
 - 문자열을 저장할 수 있는 자료형
 - 문자열은 ''로 묶어서 처리
 (1) CHAR
   . 고정길이 문자열 자료 저장
   . 데이터가 정의된 공간보다 작으면 왼쪽부터 저장되고 남는 기억공간(오른쪽)
     은 공백이 삽입 -- 가변길이는 들어온 데이터만큼쓰고 남는공간은 반납처리한다.
     -- 공간이 부족하면 저장되지않음 기억장소가 모자라서 오류발생
   . 주로 KEY항목에 사용
   . 2000BYTE 까지 사용가능
   (사용형식)
   컬럼명 CHAR(크기[BYTE|CHAR])
     - 기본값은 BYTE임
     - 한글 한 글자는 3 BYTE로 처리
     EX) COL1 CHAR(2000 CHAR) -- 2000 글자를 초과할수 없다.

CREATE TABLE TEMP01(
  COL1 CHAR(10),
  COL2 CHAR(10 BYTE),
  COL3 CHAR(10 CHAR));

INSERT INTO TEMP01(COL1, COL2, COL3)
  VALUES ('대한','대한','대한');

SELECT * FROM TEMP01;

SELECT LENGTHB(COL1),LENGTHB(COL2),LENGTHB(COL3) FROM TEMP01; 
-- LENGTHB 길이를 BYTE로 나타내어라
-- COL1,COL2는 10BYTE // COL3는 14BYTE가 나온다.
-- 10칸중 대한은 2칸을 차지한다 한글2칸 => 6BYTE , 남는칸 8칸 => 8BYTE  6+8= 14BYTE

INSERT INTO TEMP01(COL1, COL2, COL3)
  VALUES ('KOR','KOR','KOR');

SELECT LENGTHB(COL1),LENGTHB(COL2),LENGTHB(COL3) FROM TEMP01; 
-- 10 // 10 // 10 이 나왓다
-- KOR = 3BYTE + 나머지 7BYTE = 10BYTE
-- 빈공간이 남아있는 고정길이

INSERT INTO TEMP01(COL1, COL2, COL3)
  VALUES ('무궁화 꽃이 피었습니다','무궁화 ','무궁화 꽃이 피었습');
-- 10BYTE가 넘는것 입력
-- 실행되지 않는다
-- value too large for column "HJG"."TEMP01"."COL1" (actual: 32, maximum: 10)
-- 기술해놓은것 32인데 넣을수있는것은 10바이트

INSERT INTO TEMP01(COL1, COL2, COL3)
  VALUES ('무궁','무궁화 ','무궁화 꽃이 피었습');

SELECT * FROM TEMP01; 
-- COL3는 CHAR 이기때문에 10글자이기만하면됨.
SELECT LENGTHB(COL1),LENGTHB(COL2),LENGTHB(COL3) FROM TEMP01; 
-- 10 / 10 / 26
-- COL3는 10글자 들어가고 26BYTE가됨
-- COL1는 고정길이 이기때문에 쓰고남아도 10BYTE

-- '홍길동' 과 '홍길동 ' 은 다르다.
-- 각가의 아스키코드로 구별되기 때문에 공백도 값을갖기때문에다르다

-- 공백을 추가해서 길이를 정해놓은것 고정길이
-- char (30) -> 30BYTE 저장
-- char (30char) ->30글자저장 한글입력시 최대 90BYTE
-- 2000byte를 절대로초과할수없다.
-- char (2000char) 해도 한글은 2000byte 초과못한다.







