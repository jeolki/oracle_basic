 함수 -- 형식보다 적용이중요
 - FUNCTION은 미리 모듈단위로 작성하여 컴파일 해놓은 실행가능한 프로그램
 - 반드시 하나의 반환 값이 존재!!
 - 함수의 유형
 1) 단일행 함수(Single-Row Function)
    . 테이블에 저장된 각각의 행을 대상으로 함수가 적용되어 하나의 결과 반환
    . 문자, 숫자, 날짜 처리함수, 형변환 함수
    . SELECT절, WHERE절, GROUP BY절에서 사용
    . 중첩 사용 가능
 2) 복수행 함수(MULTIPLE-ROW FUNCTION)
    . 테이블의 자료를 여러 그룹으로 그룹화한 후 함수를 적용하여 하나의 결과를 반환 --그룹별로하나
    . 집계함수(SUM, COUNT, AVG, MIN, MAX)가 속함
    
1. 문자함수
 1) CONCAT
  - 주어진 문자열을 결합하여 새로운 문자열로 반환 --함수를 사용한 그 위치에 반환
  - 결합연산자 '||'와 같은 기능 제공
  (사용형식)
  CONCAT(c1,c2)     -- 매개변수 c1 c2 문자열타입
   . 두 문자열 'c1'과 'c2'를 결합하여 반환 
    -- ||와 동일기능 인데 ||이 더 쓰기 쉬워서 잘안쓴다.
    
 예)'BOYHOOD'와 'ILPOSTINO'문자열 사이에 ', '를 삽입하여 결과를 출력하시오
    'BOYHOOD, ILPOSTINO' 로 만들어라
 ('||'연산자 사용) --제일 쉬운방법
 SELECT 'BOYHOOD'||', '||'ILPOSTINO' FROM DUAL; -- 출력하기위해 임시로 테이블대신 넣는것 DUAL
 
 (CONCAT함수 사용) -- 2개이상 되는 문자열을 결합하기 위해 CONCAT(CONCAT())사용
 SELECT CONCAT(CONCAT('BOYHOOD',', '),'ILPOSTINO') FROM DUAL;


예) 회원테이블에서 서울에 거주하는 회원의 회원명, 주민번호, 주소를 조회하시오
    주민번호의 출력형식은 'XXXXXX-XXXXXXX'이고, 주소는 기본주소와 상세주소 사이에 한칸의
    공백을 삽입하여 출력한다. 또 CONCAT함수를 사용하시오
    
SELECT MEM_NAME AS 회원명,
       CONCAT(MEM_REGNO1,CONCAT('-',MEM_REGNO2)) AS 주민번호,
       CONCAT(CONCAT(MEM_ADD1,' '),MEM_ADD2) AS 주소
  FROM MEMBER 
 WHERE MEM_ADD1 LIKE '서울%';
 
 
 2) UPPER, LOWER, INITCAP
   - 소문자를 대문자로 변환(UPPER)
   - 대문자를 소문자로 변환(LOWER)
   - 단어의 첫 글자만 대문자로 변환(INITCAP)
   (사용형식)
   UPPER(c1), LOWER(c1), INITCAP(c1)
   
예)사원테이블(EMPLOYEES)에서 EMAIL이 'dgrant'인 회원의 
   사원명, 부서명, 직무명, 급여를 구하시오 
   
SELECT A.EMP_NAME AS 사원명,    --사원테이블에는 부서명과 직무명이없다 JOIN을 사용하여야한다.
       B.DEPARTMENT_NAME AS 부서명,
       C.JOB_TITLE AS 직무명,  -- C테이블에 있는 JOB TITLE
       A.SALARY AS 급여  -- A테이블에만 있다 
  FROM EMPLOYEES A, DEPARTMENTS B, JOBS C --부서명은 B에 들어있고 직무명은 C에들어있다.
 WHERE LOWER(A.EMAIL) = 'dgrant' --이메일이 dgrant인사람 A테이블이 -- >>> 일반조건
   AND A.DEPARTMENT_ID = B.DEPARTMENT_ID -- 부서명을 가져오기위함 A테이블의 ID와 B테이블의 ID가 같을때  ->>>> 조인조건
   AND A.JOB_ID = C.JOB_ID;  -- --->>> 조인조건
 
-- 내가 알고있는글자가 소문자이니까 비교대상이 되는것을 그것과 맞춰주면된다 >>>> 소문자로 변경한다

 3) LPAD, RPAD
  - 제시된 크기의 공간에 문자열을 저장하고 남는 공간에 정의된 문자열을
    왼쪽(LPAD) 또는 오른쪽(RPAD)에 삽입하여 결과를 반환
  (사용형식)
  LPAD[RPAD](c1, n [, c2])
   . n 자리수 만큼의 기억공간에 c1문자열을 저장하고 남는 공간의 오른쪽 또는
     왼쪽에 'c2'문자열을 삽입
     
 예) 회원테이블(MEMBER)에서 회원명, 핸드폰번호, 마일리지를 조회하시오
     단 집전화번호는 '(80)-'이라는 국가번호를 왼쪽에 삽입하고
       마일리지는 5자리로 저장하되 남는 공간은 '*'를 삽입하시오
       
SELECT MEM_NAME AS 회원명,
       LPAD(MEM_HP,17,'(80)-') AS 핸드폰번호,   -- 12+5글자들어감 17공간 필요 공간이남게되면 반복저장이되버린다
       LPAD(MEM_MILEAGE,5,'*') AS 마일리지 -- 5자리로 저장함 나머지 *삽입

  FROM MEMBER;

예) 2005년 3월 제품매입정보를 다음 조건으로 조회하시오
    조회할 내용 : 날짜, 제품코드, 매입수량, 매입금액
    매입금액은 9자리로 출력하며 ,조작을 방지하기 위해 '#'기호를 금액의 왼편에삽입한다

SELECT BUY_DATE AS 날짜, 
       BUY_PROD AS 제품코드, 
       BUY_QTY AS 매입수량, 
       LPAD(BUY_QTY*BUY_COST, 9, '#') AS 매입금액
  FROM BUYPROD
 WHERE BUY_DATE >= TO_DATE('20050301') AND BUY_DATE <= TO_DATE('20050331') ;
    -- BUY_DATE BETWEEN '20050301' AND '20050331' ; --BETWEEN 이용
    -- BUY DATE 의 데이터 타입을 확인하고 DATE 타입이기 때문에 LIKE 사용 하지않는다. 

 4) LTRIM, RTRIM, TRIM
  - 정의된 문자열에서 특정문자열을 왼쪽(LTRIM) 또는 오른쪽(RTRIM)에서 찾아 제거함
  (사용형식)
  LTRIM[RTRIM](c1 [, c2,])
   . 'c1'문자열에서 c2를 왼쪽(또는 오른쪽)에서 찾아 제거
   . 'c2'가 생략되면 왼쪽(또는 오른쪽)의 공백을 제거. 단, 문자열 내부에 존재하는 공백은 제거하지 못함
  TRIM(c1)
   . 'c1' 문자열의 앞과 뒤에 존재하는 공백 제거
   
    name char(15) <- '홍길동' ==> 저장된 형태 '홍길동      '-- 6byte의 공백이 생김 무효의공백 오라클 9i부터는 알아서 제거해줌
 if (name='홍길동')  ==> 데이터를 찾지 못함 
 -- 자바에서는 공백이 같이들어온다 데이터를 찾기 못함 
 -- if (name.equals("홍길동")) --> false

예)
SELECT LTRIM('RDBMS DB Modeling과 OracleSQL','DB') FROM DUAL; -- 왼쪽 첫글자가 DB여야한다
SELECT LTRIM('DBMS DB Modeling과 OracleSQL','DB') FROM DUAL; -- 시작 DB 삭제됨 중간문자는 제거못함

SELECT RTRIM('DBMS DB Modeling과 OracleSQL','SQL') FROM DUAL; -- 맨뒤 SQL 제거됨
SELECT RTRIM('DBMS DB Modeling과 OracleSQL!','SQL') FROM DUAL; -- 끝에 !가 있어서 SQL로 안끝나서 제거못함
SELECT RTRIM('DBMS DB Modeling과 OracleSQLSQL','SQL') FROM DUAL; --반복된 SQLSQL 다지운다

SELECT TRIM('  DBMS DB Modeling과 OracleSQLSQL   ') FROM DUAL; --실제 유효의 데이터만 인쇄 양쪽 공백 제거


예)사원테이블의 EMP_NAME 컬럼의 데이터 타입을 CHAR(80)로 변경하시오

ALTER TABLE EMPLOYEES
  MODIFY EMP_NAME CHAR(80);

SELECT EMP_NAME FROM EMPLOYEES;

ALTER TABLE EMPLOYEES
  MODIFY EMP_NAME VARCHAR(80);  -- 원래대로 돌아오지 않는다. 공백이 있음 CHAR 선언시 공백도 데이터로 남아있기 때문에
  
UPDATE EMPLOYEES
   SET EMP_NAME=TRIM(EMP_NAME)  -- 공백을 잘라내서 EMP_NAME에 넣어라
   
SELECT EMP_NAME FROM EMPLOYEES;

 5) SUBSTR
  - 부분 문자열을 추출하여 반환(반환 타입도 문자열) -- 문자열만
  (사용형식)
  SUBSTR(c1, m [,n])
   . 'c1'문자열에서 m번째에서 n개만큼의 문자열을 추출하여 반환
   . m이 0또는 1이면 'c1'의 첫번째 글자부터 추출 -- 0을 1로 취급한다.
   . m을 음의 정수로 설정하면 문자열의 뒤에서 부터 처리
   . n이 생략되면 m번째 이후 모든 문자열이 추출
   
예) 
SELECT SUBSTR('DB Modeling과 OracleSQL',2,5),
       SUBSTR('DB Modeling과 OracleSQL',-8,5),
       SUBSTR('DB Modeling과 OracleSQL',-2,5),-- Q에서부터 시작 뒤로 5자리
       SUBSTR('DB Modeling과 OracleSQL',2)
  FROM DUAL;
  
예) 상품테이블에서 상품명이 '여성'으로 시작하는 상품정보를 조회하시오
    Alias는 상품코드, 상품명, 판매단가이다.
    
SELECT PROD_ID AS 상품코드,
       PROD_NAME AS 상품명,
       PROD_PRICE AS 판매단가
  FROM PROD
 WHERE SUBSTR(PROD_NAME,1,2) = '여성'; -- LIKE 구문보다 처리가 빠름
 
 
예) 판매정보(CART)에서 2005년도에 판매된 상품 중 상품명에 '여성'으로 시작하는 
    상품별 판매수량합과 매출금액합겨를 구하라
    
--CART테이블에서 상품명이없다 PROD 테이블에 있다. 단가도 없다 
--상품별로 그룹을 묶어서 집계를 내라 

SELECT CART_PROD,
       PROD_NAME,
       SUM(CART_QTY),
       SUM(CART_QTY*PROD_PRICE)
  FROM CART, PROD
 WHERE SUBSTR(CART_NO,1,4) = '2005'
   AND SUBSTR(PROD_NAME,1,2)='여성'
   AND CART_PROD=PROD_ID
 GROUP BY CART_PROD,PROD_NAME;


SELECT CART_PROD,
       PROD_NAME,
       SUM(CART_QTY),
       SUM(CART_QTY*PROD_PRICE)
  FROM CART, PROD
 WHERE CART_NO LIKE '2005%'
   AND PROD_NAME LIKE '여성%'
   AND CART_PROD=PROD_ID
 GROUP BY CART_PROD,PROD_NAME;

6)REPLACE
 - 정의된 문자열에서 특정 문열을 다른 문자열로 대치
 (사용형식)
 REPLACE(c1,c2 [,c3]) --단어내부에 포함된공백을 제거하고자할때 사용
  . 'c1'의 문자열에서 c2 문자열을 찾아 C3 문자열로 치환
  . 'c3'가 생략되면 찾은 문자열을 제거한다.
  
예)거래처테이블(BUYER)에서 거래처주소 중 '대전'를 '대전광역시'로 변경하시오
-- 모두 다른형식으로 입력하였을때 저장시 일정한 형식으로 저장되도록 바꿔주는 역할
 대전이 있는지 조회
SELECT BUYER_ID, BUYER_NAME
  FROM BUYER
 WHERE SUBSTR(BUYER_ADD1,1,2)='대전';
 
 '대전'을 '대전광역시'로 치환
SELECT BUYER_ID AS 거래처코드,
       BUYER_NAME AS 거래처명,
       BUYER_ADD1 AS 기본주소,
       REPLACE(BUYER_ADD1, '대전', '대전광역시 ') AS 기본주소2
  FROM BUYER
 WHERE SUBSTR(BUYER_ADD1,1,2)='대전';
 
예)거래처테이블(BUYER)에서 거래처주소에 포함된 공백을 제거하시오
SELECT BUYER_ID AS 거래처코드,
       BUYER_NAME AS 거래처명,
       BUYER_ADD1 AS 기본주소,
       REPLACE(BUYER_ADD1, ' ') AS 기본주소2
  FROM BUYER;

7)TRANSLATE  --자주 안씀
 - 특정문자열을 정의된 형식문자열에 MAPPING하여 변환된 결과 반환
 (사용형식)
 TRANSLATE(c1,c2,c3)
  . c1에 포함된 문자열중 c2에 정의된 문자열이 c3문자열로 변환
  
SELECT MEM_NAME,
       MEM_PASS,
       TRANSLATE(MEM_PASS, '0123456789', 'ABCDEFGHHIJ')
  FROM MEMBER;

8)INSTR
 - 찾고자하는 문자의 위치값(INDEX)을 반환 --ORACLE 에서는 1번부터 카운트된다.
 (사용형식)
 INSTR(c1,c2 [,m [,n]])
  . c1문자열에서 c2문자의 위치값을 반환
  . m은 검색 시작위치
  . n은 반복되는경우 n번째 반복된 문자의 위치

예)
SELECT INSTR('내가 너를 모르는데 너는 나를 아겠느냐','너'), -- 맨처음만나는 '너'의 위치 //4
       INSTR('내가 너를 모르는데 너는 나를 아겠느냐','너',5), -- 5번째 이후에 만나는 '너'의 위치 //12 
       INSTR('내가 너를 모르는데 너는 너를 아겠느냐','너',5,2), -- 5번째 이후에 2번째 '너'의 위치 //15
       INSTR('내가 너를 모르는데 너는 나를 아겠느냐','너',5,2) -- 없는 경우에는 //0
  FROM DUAL;

9)LENGTH(LENGTHB)
 - 주어진 문자열의 글자수(LENGTH) 또는 기억공간의 크기(LENGTHB)를 반환
 (사용형식)
 LENGTH(c1)
 
예)부서테이블에서 부서명의 글자수와 점유된 크기를 바이트로 나타내시오
SELECT DEPARTMENT_NAME,             -- 총무기획부
       LENGTH(DEPARTMENT_NAME),     -- 5
       LENGTHB(DEPARTMENT_NAME)     -- 15
  FROM DEPARTMENTS;





