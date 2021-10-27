 1. 자료형
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

2. 가변길이 문자형 -- 선언한 크기보다 작은자료를 저장할때 남은공간을 되돌려준다.
 1) VARCHAR
   - 사용자가 정의한 데이터 길이 만큼 기억공간 사용.
   (사용형식)
   컬럼명 VARCHAR(크기 [BYTE|CHAR])
    . 4000 BYTE 까지 저장 가능
    . [BYTE|CHAR] : 입력공간의 종류로 Default는 BYTE임
    
예)
CREATE TABLE TEMP02 (
  COL1 CHAR(20),
  COL2 VARCHAR(20),
  COL3 VARCHAR(20 CHAR));
  
INSERT INTO TEMP02 VALUES('무궁화','무궁화','무궁화');
INSERT INTO TEMP02 VALUES ('PERSIMON','BANANA','APPLE');

SELECT * FROM TEMP02;

SELECT LENGTHB(COL1)    고정길이,  -- AS "컬럼의 별칭" -- 특수문자들어가면 ""로 묶는다.
       LENGTHB(COL2) AS "가변길이(BYTE)",  -- LENGTHB BYTE크기 출력
       LENGTHB(COL3)    "가변길이(CHAR)" -- AS를 쓰지않아도 되지만 쓰는게 좋다
  FROM TEMP02;
-쓰고 나머지 반납

2) VARCHAR2
  - VARCHAR와 사용이 동일
  - 오라클에서만 사용되는 데이터 타입(오라클에서 사용권고)
  
3) LONG
  - 가변길이 문자열을 저장할때 사용
  - 2gb크기의 자료 저장 가능
  - 한 테이블에 하나의 LONG 타입으로 선언 가능
  - SELECT문의 SELECT절, UPDATE문의 SET절, INSERT문의 VALUES절
    에서 사용 가능
   (사용형식)
   컬럼명 LONG; -- 사용을 권하지 않는다-- 한테이블에 한컬럼만 LONG타입을 사용할수있어서 사용하지않는다.
   . LONG 타입은 기술지원이 종료됨
   . CLOB, NCLOB 사용으로 대치

예)
CREATE TABLE TEMP03(
  COL1 LONG,
  COL2 CLOB,
  COL3 CLOB);
  

INSERT INTO TEMP03 VALUES('일포스티노','ILPOSTINO','일포스티노');  
  
SELECT * FROM TEMP03; 

SELECT --LEBGTHB(COL1), --2gb라서 길이를 체크할수 없다.
       DBMS_LOB.GETLENGTH(COL2),
       DBMS_LOB.GETLENGTH(COL3)
  FROM TEMP03;
       
4) CLOB  
  - 가별길이 문자열 저장
  - 최대 4gb 문자열 저장 가능
  - LONG 타입을 개선한 데이터 타입
  - 한 테이블에 여러개 컬럼에서 CLOB타입 사용이 가능
  - 일부 기능들(길이, 부분문자열 추출)은 DEMS_LOB API의 지원을 활용
  (사용형식)
  컬럼명  CLOB; --LONG 타입과 마찬가지로 길이를 지정하지않는다. MAX 4gb안에있는 모든자료 가능
  
예)
CREATE TABLE TEMP04(
  COL1  CLOB,
  COL2  CLOB,
  COL3  VARCHAR2(4000));
  
INSERT INTO TEMP04 
  VALUES('DM MODELING과 OracleSQL','대전시 중구 대흥동 500',
         '무궁화 꽃이 피었습니다');
  
select * from temp04;

SELECT DBMS_LOB.SUBSTR(COL1,5,3) AS 제목1,
       SUBSTR(COL2,5,3) AS 제목2,
       SUBSTR(COL3,5,3) AS 제목3 
  FROM TEMP04;
-- DEMS_LOB.SUBSTR(부분문자열추출) 자르고자하는문자열, 5글자수(갯수), 3번째에서시작
-- SUBSTE 는 5번째 자리에서 3글자

5) NVARCHAR2, NCLOB
  - 다국적 언어 지원 형식(National)
  - UTF-8, UTF-16형식의 코드로 변환하여 저장
  - 나머지 기능은 VARCHAR2, CLOB와 동일





