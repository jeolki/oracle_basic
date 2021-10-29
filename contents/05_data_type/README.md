## 자료형

-   오라클에서 제공하는 데이터 타입으로는 문자형, 숫자형, 날짜형, 기타

### 1) 문자형

-   문자열을 저장할 수 있는 자료형
-   문자열은 ''로 묶어서 처리

### CHAR

⇒ 고정길이 문자열 자료 저장

⇒ 데이터가 정의된 공간보다 작으면 왼쪽부터 저장되고 남는 기억공간(오른쪽)은 공백이 삽입  
    → 가변길이는 들어온 데이터만큼 쓰고 남는 공간은 반납 처리한다.  
    → 공간이 부족하면 저장되지 않음 기억 장소가 모자라서 오류 발생

⇒ 주로 KEY항목에 사용

⇒ 2000BYTE까지 사용 가능

( 사용 형식 )

```
컬럼명 CHAR(크기[BYTE|CHAR])
```

⇒ 기본값은 BYTE임  
⇒ 한글 한 글자는 3 BYTE로 처리

예제) 2000 글자를 초과할 수 없다.

```sql
COL1 CHAR(2000 CHAR)
```

예제)

```sql
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
-- 각각의 아스키코드로 구별되기 때문에 공백도 값을갖기때문에다르다

-- 공백을 추가해서 길이를 정해놓은것 고정길이
-- char (30) -> 30BYTE 저장
-- char (30char) ->30글자저장 한글입력시 최대 90BYTE
-- 2000byte를 절대로초과할수없다.
-- char (2000char) 해도 한글은 2000byte 초과못한다.
```

```sql
    name char(15) <- '홍길동' ==> 저장된 형태 '홍길동      '-- 6byte의 공백이 생김 무효의공백 오라클 9i부터는 알아서 제거해줌
 if (name='홍길동')  ==> 데이터를 찾지 못함 
 -- 자바에서는 공백이 같이들어온다 데이터를 찾기 못함 
 -- if (name.equals("홍길동")) --> false
```



## 가변 길이 문자형

⇒ 선언한 크기보다 작은 자료를 저장할 때 남은 공간을 되돌려준다.

### 1) VARCHAR

- 사용자가 정의한 데이터 길이 만큼 기억공간 사용.

(사용 형식)

```
컬럼명 VARCHAR(크기 [BYTE|CHAR])
```

⇒ 4000 BYTE까지 저장 가능
⇒ [BYTE|CHAR] : 입력 공간의 종류로 Default는 BYTE임

예제)

```sql
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
```

⇒ 쓰고 나머지 반납

### 2) VARCHAR2

- VARCHAR와 사용이 동일
- 오라클에서만 사용되는 데이터 타입(오라클에서 사용 권고)

### 3) LONG

- 가변 길이 문자열을 저장할 때 사용
- 2gb 크기의 자료 저장 가능
- 한 테이블에 하나의 LONG 타입으로 선언 가능
- SELECT문의 SELECT절, UPDATE문의 SET절, INSERT문의 VALUES절에서 사용 가능

( 사용 형식 )

```
컬럼명 LONG; 
-- 사용을 권하지 않는다
-- 한테이블에 한컬럼만 LONG타입을 사용할수있어서 사용하지않는다.
```

⇒ LONG 타입은 기술지원이 종료됨
⇒ CLOB, NCLOB 사용으로 대치

예제)

```sql
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
```

⇒ LEBGTHB(COL1), 2gb라서 길이를 체크할 수 없다.

### 4) CLOB

- 가변 길이 문자열 저장
- 최대 4gb 문자열 저장 가능
- LONG 타입을 개선한 데이터 타입
- 한 테이블에 여러 개 칼럼에서 CLOB타입 사용이 가능
- 일부 기능들(길이, 부분 문자열 추출)은 DEMS_LOB API의 지원을 활용

( 사용 형식 )

```
컬럼명  CLOB; 
--LONG 타입과 마찬가지로 길이를 지정하지않는다. MAX 4gb안에있는 모든자료 가능
```

예제)

```sql
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
-- SUBSTR 는 5번째 자리에서 3글자
```

### 5) NVARCHAR2, NCLOB

- 다국적 언어 지원 형식(National)
- UTF-8, UTF-16 형식의 코드로 변환하여 저장
- 나머지 기능은 VARCHAR2, CLOB와 동일



## 숫자형 ( NUMBER )

-   number 데이터 타입 지원
-   정수와 실수 모두 표현 가능 -- 고정소수점 = 정수, 가변소수점 = 실수

( 사용형식 )

```
컬럼명 NUMBER[(정밀도 [, 스케일])]

- 정밀도 : 전체자리수(단, 정밀도 > 스케일 인경우)
             1 ~ 38 까지의 정수 사용
- 스케일 : 소숫점이하의 자리수(단, 양수인 경우, 음수인경우에는 소숫점 이상의 자리수)
            -84 ~ 127 사이의 정수 사용
```

예제)

```sql
입력값      선언형식        저장값
-----------------------------------------
  123,456.78   NUMBER        123,456.78
  123,456.78   NUMBER(*,1)   123,456.8     --소수점 두번째 자리에서 반올림
  123,456.78   NUMBER()      123,457       --소수첫재짜리에서 반올림해서 소수점없애라
  123,456.787  NUMBER(9,2)   123,456.79    --소수점 셋째 자리에서 반올림
  123,456.78   NUMBER(6)     123,457       --스케일생략=0 소수첫재반올림해서 정수부분만 나타내어라
  123,456.78   NUMBER(6,0)   123,457
  123,456.78   NUMBER(5)     에러           --자리수가 부족해서 에러가난다
  123,456.78   NUMBER(7,-2)  123,500
------------------------------------------

**정밀도보다 큰 스케일이 사용된 경우
  -(스케일 - 정밀도) : 소숫점이하에서 나올 '0'의 갯수
  -스케일 : 소숫점 이하의 자리수

     입력값      선언형식        저장값
---------------------------------------
  12.34        NUMBER(4,5)   에러
  12.3         NUMBER(3,5)   에러    
  0.01234      NUMBER(4,5)   0.01234       
  0.001234     NUMBER(3,5)   0.00123    -- 5-3=2 소수점이하 0두개나오고 5째자리까지 나오게반올림    
---------------------------------------

SELECT ROUND((100/3)*100,2)||'%' FROM DUAL;


CREATE TABLE TEMP05(
  COL1 NUMBER,
  COL2 NUMBER(*,1),
  COL4 NUMBER(9,2),
  COL5 NUMBER(6),
  COL6 NUMBER(6,0),
  COL7 NUMBER(5),
  COL8 NUMBER(7,-2));

INSERT INTO TEMP05 VALUES(123456.78,123456.78,123456.78,123456.78,123456.78,
                          12345.78,123456.78);
                          
INSERT INTO TEMP05 VALUES(123456.78,123456.78,123456.789,123456.78,123456.78,
                          12345.78,123456.78);

SELECT * FROM TEMP05;
```



## 날짜형

-   날짜 자료형은 기본형인 DATE와 시간대 정보를 저장하는 TIMESTAMP타입이 제공

### 1) DATE

-   기본 날자정보(년,월,일,시,분,초:'YYYY/MM/DD HH24:MI:SS')를 저장
-   4712년 1월 1일~9999년 12월 31일까지 저장

( 사용형식 )

```
컬럼명 DATE;
```

⇒ **날짜 형식의 칼럼은 사칙연산 중 '+'와 '-'연산이 가능**

예제)

```sql
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
```

### 2) TIMESTAMP

-   시간대(TIME ZONE)정보와 10억 분의 1초 단위의 시작 정보 저장

( 사용형식 )

```
컬럼명 TIMESTAMP;
컬럼명 TIMESTAMP WITH TIME ZONE;
컬럼명 TIMESTAMP WITH LOCAL TIME ZONE;
```

예제)

```sql
CREATE TABLE TEMP08(
  COL1 TIMESTAMP,
  COL2 TIMESTAMP WITH TIME ZONE,
  COL3 TIMESTAMP WITH LOCAL TIME ZONE);

INSERT INTO TEMP08 VALUES(SYSDATE, SYSDATE, SYSDATE);
SELECT * FROM TEMP08;
```



## 기타 자료형

### 1) RAW

-   상대적으로 작은 양의 2진 자료 저장
-   2000BYTE까지 자료저장
-   이미지 등의 자료를 정해 사용된다.
-   인덱스 처리 가능 ⇒ 사용 거의 안 함 사진 용량이 커서 부족하다.

( 사용 형식 )

```
컬럼명 RAW(크기)
```

### 2) LONG RAW

-   이진 자료 저장
-   2GB까지 저장 가능 / 인덱스 처리 불가능 ⇒ 사용 거의 안 함
-   기존의 자료형과 호환성을 위해 존치되고 있는 자료형

( 사용 형식 )

```
컬럼명 LONG RAW;
```

### 3) BFILE

-   이진 자료를 저장하고 처리
-   이진 자료(원본자료)를 데이터베이스 외부에 저장 ⇒ 외부에 저장된 디렉터리 반드시 지정
-   디렉터리 별칭은 30BYTE, 파일명은 256BYTE를 초과할 수 없음

( 사용 형식 )

```
컬럼명 BFILE;
```

예제)

1\. 디렉터리 생성

```sql
CREATE DIRECTORY 별칭 AS '절대경로명';
CREATE DIRECTORY TEST_DIR AS 'D:\A_TeachingMaterial\2.Oracle\20200608';
```

2\. 테이블 생성

```sql
CREATE TABLE TEMP09(
  COL1 BFILE);
```

3\. 그림파일 경로 저장(INSERT문 사용)

```sql
INSERT INTO TEMP09 VALUES(BFILENAME('TEST_DIR','pixabay.JPG')); 

SELECT * FROM TEMP09;
```

### 4) BLOB

-   이진 자료를 저장하고 처리함
-   이진 자료(원본자료)를 데이터베이스 내부에 저장 ⇒ 사진자료들이 자주 변경되는 경우는 BFILE이 더 좋다
-   최대 4GB 자료 처리 가능

( 사용 형식 )

```
컬럼명 BLOB;
```

예제)

1\. 테이블 생성

```sql
CREATE TABLE TEMP10(
  COL1 BLOB);
```

2\. 테이블에 그림파일을 삽입하는 익명 블록 작성

```sql
DECLARE
  L_DIR VARCHAR2(50) := 'TEST_DIR';
  L_FILE VARCHAR2(20) := 'pixabay.JPG';
  L_BFILE BFILE;
  L_BLOB BLOB;
BEGIN
  INSERT INTO TEMP10 VALUES(EMPTY_BLOB())
    RETURN COL1 INTO L_BLOB;

  L_BFILE := BFILENAME(L_DIR,L_FILE);
  DBMS_LOB.FILEOPEN(L_BFILE,DBMS_LOB.FILE_READONLY);
  DBMS_LOB.LOADFROMFILE(L_BLOB,L_BFILE,DBMS_LOB.GETLENGTH(L_BFILE));
  DBMS_LOB.FILECLOSE(L_BFILE);
   
  COMMIT;
END;

(확인)
SELECT * FROM TEMP10;  --디스플레이 하는것은 오라클에서는 할수없다.
```