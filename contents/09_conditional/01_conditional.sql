1. 조건식
 - 하나 이상의 표현식과 관계연산자(논리연산자)가 결합된 식
 - 연산자는 논리연산자, 관계연산자, 기타연산자(IN, ANY, SOME, ALL, EXISTS,
   LIKE, BETWEEN)  --LIKE 패턴비교연산자 될수있으면 안씀
 
1) IN 연산자
 - 주어진 값 중 비교항목이 포함되면 TRUE를 반환하는 연산자
 - SOME, ANY와 같은 기능
 - OR 연산자로 대치 가능 --OR 연산자보다 단순간단
 - WHERE 절에 사용
 (사용형식)
 컬럼명 IN(값1, 값2,...) 
예) 상품테이블에서 분류코드가 'P101', 'P201', 'P301' 중 어느 한 분류에 속한
    상품정보를 출력하시오
    Alias는 상품코드, 상품명, 분류코드, 판매가격
    
    (OR 연산자 사용)
    SELECT PROD_ID AS 상품코드,
           PROD_NAME AS 상품명,
           PROD_LGU AS 분류코드,
           PROD_PRICE AS 판매가격
      FROM PROD
     WHERE PROD_LGU = 'P101'
        OR PROD_LGU = 'P201'
        OR PROD_LGU = 'P301'
  ORDER BY PROD_LGU ASC; -- 컬럼명 사용
  -- ORDER BY 3 ASC;     -- 컬럼인덱스 사용 SELECT문에 기술되어진순서 ASC 안써줘도댐 
  -- ORDER BY PROD_LGU ASC, PROD_PRICE DESC ; 분류코드가 똑같은 것은 그안에서 가격이 내림차순으로 정렬한다.
    
   (IN 연산자 사용)
    SELECT PROD_ID AS 상품코드,
           PROD_NAME AS 상품명,
           PROD_LGU AS 분류코드,
           PROD_PRICE AS 판매가격
      FROM PROD
     WHERE PROD_LGU IN('P101', 'P201','P301') 
-- WHERE PROD_LGU NOT IN('P101', 'P201','P301') 부정은 IN앞에 NOT
  ORDER BY PROD_LGU ASC;    
    
     (ANY 연산자 사용)
    SELECT PROD_ID AS 상품코드,
           PROD_NAME AS 상품명,
           PROD_LGU AS 분류코드,
           PROD_PRICE AS 판매가격
      FROM PROD
     WHERE PROD_LGU =ANY('P101', 'P201','P301')  -- ANY와 SUM은 관계연산자가 붙는다 , IN은 관계연산자가 붙지 않는다.
 --        NOT PROD_LGU =ANY ('P101', 'P201','P301')  부정은 전체부정 범위가아닌 나머지 제품들
  ORDER BY PROD_LGU ASC;        
  
   (SOME 연산자 사용)
    SELECT PROD_ID AS 상품코드,
           PROD_NAME AS 상품명,
           PROD_LGU AS 분류코드,
           PROD_PRICE AS 판매가격
      FROM PROD
     WHERE /*NOT*/ PROD_LGU =SOME ('P101', 'P201','P301') 
  ORDER BY PROD_LGU ASC;   
  
  
예) 직무이력테이블{JOB_HISTORY)에 존재하는 사원정보를 조회하시오
    Alias는 사원번호, 사원명, 직무코드, 급여
(JOIN을 이용) --공통컬럼존재 FROM절 테이블두개 --조건은 적어도 테이블-1개 
SELECT DISTINCT A.EMPLOYEE_ID AS 사원번호, --중복된것을 없애기 위해
       A.EMP_NAME AS 사원명,
       A.JOB_ID AS 직무코드,
       A.SALARY AS 급여
  FROM EMPLOYEES A, JOB_HISTORY B      --별칭사용
 WHERE A.EMPLOYEE_ID = B.EMPLOYEE_ID;  --별칭을이용 소속추가

(IN을 이용)
SELECT EMPLOYEE_ID AS 사원번호, 
       EMP_NAME AS 사원명,
       JOB_ID AS 직무코드,
       SALARY AS 급여
  FROM EMPLOYEES   
 WHERE EMPLOYEE_ID IN (SELECT EMPLOYEE_ID 
                         FROM JOB_HISTORY);


(EXISTS을 이용)
SELECT A.EMPLOYEE_ID AS 사원번호, 
       EMP_NAME AS 사원명,
       A.JOB_ID AS 직무코드,
       SALARY AS 급여
  FROM EMPLOYEES A  
 WHERE EXISTS (SELECT 1   --1은 의미없다, 
                 FROM JOB_HISTORY B
                WHERE A.EMPLOYEE_ID=B.EMPLOYEE_ID);
                
                
2)LIKE 연산자
 - 패턴을 비교할 때 사용하는 연산자
 - 대치 문자열(와일드카드) '%', '_'이 사용
 - '%'는 해당문자열이 사용된 위치 이후에 존재하는 모든 문자열과 대응됨
   ex) '김%' ->'김'으로 시작하는 모든 문자열과 대응
       '%김' ->'김'으로 끝나는 모든 문자열과 대응
 - '_'는 해당문자열이 사용된 위치에 하나의 문자와 대응됨
   ex) '김_열' ->'김'으로 시작하고 3글자로 구성되며 끝자리에는 '열'이 와야 대응됨
       '_김' ->2글자로 구성되어 있으며 '김'으로 끝나는 문자열과 대응
 - 문자열 비교에만 사용 할 것
 - 너무 많이사용 하지 말 것 
 (사용형식)
 컬럼명 LIKE '패턴문자열'
 
 예} 회원테이블에서 주소지가 '대전'인 회원정보를 조회하시오
    Alias는 회원번호, 회원명, 주소, 집전화번호
  SELECT MEM_ID AS 회원번호,
         MEM_NAME AS 회원명,
         MEM_ADD1||' '||MEM_ADD2 AS 주소,  -- 문자열의 결합 ||으로한다. 사이에 한칸집에 넣겟다
         MEM_HOMETEL AS 집전화번호
    FROM MEMBER
   WHERE MEM_ADD1 LIKE '대전%'
 
 예) 매출자료(CART)에서 2005년 6월 매출정보를 조회하시오 
    Alias는 날짜, 제품코드, 판매수량이다.
  SELECT TO_CHAR(TO_DATE(SUBSTR(CART_NO,1,8)),'YYYY"년" MM"월"DD"일"') AS 날짜, 
      -- TO_DATE(SUBSTR(CART_NO,1,8)) AS 날짜, /로 구분되어서 나온다 
         CART_PROD AS 제품코드,
         CART_QTY AS 판매수량
    FROM CART
   WHERE CART_NO LIKE '200506%';
 
 
 문제] 매입테이블(BUYPROD)에서 2005년 3-5월 매입정보를 조회하시오 --날짜를 할때에는 LIKE 연산자 쓰지말아라
      Alias는 일자, 제품코드, 매입수량, 매입단가, 매입금액이다.
 
  SELECT BUY_DATE AS 일자,
         BUY_PROD AS 제품코드,
         BUY_QTY AS 매입수량,
         BUY_COST AS 매입단가,
         BUY_QTY * BUY_COST AS 매입금액
    FROM BUYPROD
   WHERE BUY_DATE >= '20050301' AND BUY_DATE <= '20050531';
   -- 문자열이 날짜열로 바뀌었다
   -- 데이터다 NLS에서 지정한 날짜의 형태포맷을 전체 같추어야 저절로 바뀐다.
   -- 날짜 타입은 LIKE 사용하지않고 날짜 타입이나 이와같은 형식으로 비교해준다.
   -- BUY_DATE >= TO_DATE('20050301') AND BUY_DATE <= TO_DATE('20050531');
   
   (BETWEEN 연산자 사용)
  SELECT BUY_DATE AS 일자,
         BUY_PROD AS 제품코드,
         BUY_QTY AS 매입수량,
         BUY_COST AS 매입단가,
         BUY_QTY * BUY_COST AS 매입금액
    FROM BUYPROD
   WHERE BUY_DATE BETWEEN '20050301' AND '20050531';
   

 문제] 매입테이블(BUYPROD)에서 2005년 4월 매입정보를 조회하시오 
      Alias는 일자, 제품코드, 매입수량, 매입단가, 매입금액이다.
 
   SELECT BUY_DATE AS 일자,
          BUY_PROD AS 제품코드,
          BUY_QTY AS 매입수량,
          BUY_COST AS 매입단가,
          BUY_QTY * BUY_COST AS 매입금액
     FROM BUYPROD
    WHERE TO_CHAR(BUY_DATE) LIKE '2005_04%'; 
    -- /가 없으면 데이터가 안나온다
    -- 데이터베이스의 NLS의 날짜 형식을 바꿔주면 또 안나온다.
    -- 안쓰는게 좋음  사이에 _로 해주면 가능
 
   SELECT TO_CHAR(BUY_DATE) FROM BUYPROD;
   
   
3)BETWEEN 연산자
 - 지정된 범위 값을 표현할 때 사용
 - AND 연산자를 대신할 수 있음
 
 (사용형식)
 컬럼명 BETWEEN 값1 AND 값2; --%와일드카드 사용못함
 
예)회원테이블에서 40대 여성회원정보를 조회하시오
  Alias는 회원번호, 회원명, 주민번호, 나이, 마일리지
  단, 주민번호의 출력형식은 xxxxxx-xxxxxxx 이다.
   
  SELECT MEM_ID AS 회원번호,
         MEM_NAME AS 회원명,
         MEM_REGNO1||'-'||MEM_REGNO2 AS 주민번호,
         EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR) AS 나이,  -- EXTRACT("YEAR,NONTH,DAY 등등" FROM SYSDATE)
         MEM_MILEAGE AS 마일리지 
    FROM MEMBER
   WHERE EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR) BETWEEN 40 AND 49
     AND (SUBSTR(MEM_REGNO2,1,1)='2' OR SUBSTR(MEM_REGNO2,1,1)='4') ; -- NOR AND OR 순이라 괄호 해줘야한다.















  
  
  