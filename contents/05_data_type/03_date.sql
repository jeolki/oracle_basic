 1.날짜형
 - 날짜자료형은 기본형인 DATE와 
   시간대 정보를 저장하는 TIMESTAMP타입이 제공

1) DATE
  - 기본 날자정보(년,월,일,시,분,초:'YYYY/MM/DD HH24:MI:SS')를 저장
  - -4712년 1월 1일~9999년 12월 31일까지 저장
 (사용형식)
 컬럼명 DATE;
   . 날짜 형식의 컬럼은 사칙연산 중 '+'와 '-'연산이 가능

예)
CREATE TABLE TEMP06(
  COL1  DATE,
  COL2  DATE);
  
INSERT INTO TEMP06(COL1,COL2) VALUES(SYSDATE, TO_DATE('20190605')); 
-- 문자열은 날짜타입으로 자동 형변환되어진다.
-- 변환함수 TO_DATE 안써도 된다. 문자열안에 년월일 자료가 다들어있으면 가능

INSERT INTO TEMP06(COL1,COL2) VALUES(SYSDATE+30,SYSDATE-30); 

SELECT * FROM TEMP06;
SELECT COL1 - COL2  FROM TEMP06;  
-- 두 날짜 사이의 경과된 일수 
-- 소수점이 나온이유 : 시분초까지 있기때문에 '20190605' 0시0분0초로 계산되어지기때문에

SELECT TO_CHAR(COL1, 'YYYY-MM-DD HH24:MI:SS'),
       TO_CHAR(COL2, 'YYYY-MM-DD HH24:MI:SS'),
       COL1 - COL2
  FROM TEMP06;


CREATE TABLE TEMP07(
  COL1 TIMESTAMP WITH TIME ZONE);
  
INSERT INTO TEMP07 VALUES(SYSDATE);
  
SELECT * FROM TEMP07;

SELECT * FROM TEMP06;
DELETE TEMP06;

INSERT INTO TEMP06 VALUES ('19940305','00010101');

SELECT * FROM TEMP06;

SELECT CASE WHEN MOD((COL1 - COL2-1),7)=0 THEN '일요일' 
            WHEN MOD((COL1 - COL2-1),7)=1 THEN '월요일' 
            WHEN MOD((COL1 - COL2-1),7)=2 THEN '화요일' 
            WHEN MOD((COL1 - COL2-1),7)=3 THEN '수요일' 
            WHEN MOD((COL1 - COL2-1),7)=4 THEN '목요일' 
            WHEN MOD((COL1 - COL2-1),7)=5 THEN '금요일' 
            ELSE '토요일' END "요일"                             
  FROM TEMP06;

2020-06-08)
2) TIMESTAMP
  - 시간대(TIME ZONE)정보와 10억분의 1초 단위의 시작 정보 저장
(사용형식)
 컬럼명 TIMESTAMP;
 컬럼명 TIMESTAMP WITH TIME ZONE;
 컬럼명 TIMESTAMP WITH LOCAL TIME ZONE;

예)
CREATE TABLE TEMP08(
  COL1 TIMESTAMP,
  COL2 TIMESTAMP WITH TIME ZONE,
  COL3 TIMESTAMP WITH LOCAL TIME ZONE);

INSERT INTO TEMP08 VALUES(SYSDATE, SYSDATE, SYSDATE);
SELECT * FROM TEMP08;


















