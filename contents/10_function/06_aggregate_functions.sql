2020-06-17-02)집계함수
 - SUM, AVG, COUNT, MIN, MAX
 - 보통 GROUP BY 절과 같이사용 
 -- SELECT 절에서 일반항목과 집계함수가 같이사용될때에는 무조건 GROYP BY 를 사용해야한다.
 (GROUP BY절 사용해야 하는 경우)
  . SELECT절에서 일반항목(컬럼, 수식)과 집계함수가 같이 사용된 경우
  . GROUP BY 컬럼명1 [, 컬럼명2,....] -- 컬럼명1을 만들고 그속에서 컬럼명2를 가지고 그룹을 만듬
  . SELECT절에서 사용된 일반항목(컬럼, 수식)은 반드시 GROUP BY 절에 기술해야 한다.!
  . 집계함수에 부여된 조건은 HAVING절에 기술
  --SELECT / FROM / WHERE / GROUP BY / HAVING / ORDER BY 순서
  . GROUP BY절은 WHERE절 다음에 기술 (WHERE절은 생략 가능)
  . HAVING절은 GROUP BY절 다음에 기술 
  . ORDER BY절은 맨 마지막에 기술
  
1) COUNT(*|컬럼명)  
  -- 아우터 조인할때는 반드시 컬럼명을 사용한다 
  - 행의수를 반환

예) 사원테이블에서 전체 사원수를 조회하시오
SELECT COUNT(*), COUNT(EMP_NAME) 
  FROM EMPLOYEES;
-- 일반함수가 사용되지않았고 집계함수만 사용되었기때문에 그룹바이를 사용하지 않음
-- 전체를 그룹으로 생각 

예) 사원테이블에서 부서별 사원수를 조회하시오
SELECT DEPARTMENT_ID AS 부서코드,
       COUNT(*) AS 사원수
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
 ORDER BY 1;
  

예) 사원테이블에서 급여가 3000이상인 부서별 사원수를 조회하시오  
SELECT DEPARTMENT_ID AS 부서코드,
       COUNT(*) AS 사원수
  FROM EMPLOYEES
 WHERE SALARY >= 3000
 GROUP BY DEPARTMENT_ID
 ORDER BY 1;  
  
예) 상품테이블에서 분류별 상품수를 조회하시오
SELECT PROD_LGU AS 상품분류코드,
       COUNT(*) AS 상품수
  FROM PROD
 GROUP BY PROD_LGU
 ORDER BY 1;
  
예) 상품테이블에서 분류별 상품수가 20개 이상인 자료를 조회하시오 
SELECT PROD_LGU AS 상품분류코드,
       COUNT(*) AS 상품수
  FROM PROD
 GROUP BY PROD_LGU
HAVING COUNT(*) >= 20
 ORDER BY 1;  
  
2) SUM(컬럼명)
  - '컬럼명'에 저장된 자료의 합계를 반환
  
예) 사원테이블에서 각 부서별 급여 합계를 구하시오
    Alias는 부서코드, 부서명, 급여합계
SELECT A.DEPARTMENT_ID AS 부서코드,
       B.DEPARTMENT_NAME AS 부서명,
       COUNT(*) AS 사원수,
       NVL(SUM(A.SALARY), 0) AS 급여합계
  FROM EMPLOYEES A, DEPARTMENTS B
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID -- 내부조인조건
 GROUP BY A.DEPARTMENT_ID, B.DEPARTMENT_NAME  --집계함수가 쓰이지 않은 일반항목을 모두 적어줌 
 ORDER BY 3 DESC; 
 -- 컬럼의 순서번호와 ASC오름차순 과 DESC내림차순으로 설정.
 -- 급여의 합계 내림차순으로 
  
예) 2005년 2~5월 사이 발생한 제품별 매입집계를 구하시오
   Alias는 상품코드, 매입수량합계, 매입금액합계
   단, 상품코드순으로 출력하시오
  
SELECT BUY_PROD AS 상품코드,
       SUM(BUY_QTY) AS 매입수량합계,
       SUM(BUY_COST*BUY_QTY) AS 매입금액합계,
       COUNT(*) AS 매입건수
  FROM BUYPROD
 WHERE BUY_DATE BETWEEN TO_DATE('20050201') AND TO_DATE('20050531') 
 GROUP BY BUY_PROD   -- SELECT 절에서 집계함수를 제외한 일반수식이나 항목이 사용되었으면 GROUP BY 사용
 ORDER BY 1;
  -- SELECT 절에 없더라도 그룹을 묶어야한다면 같은 테이블에 있는 일반항목을 사용할수 있다. 2중 그룹핑 
  -- GROUP BY BUY_PROD, BUY_DATE
  
  
  
  
  
  