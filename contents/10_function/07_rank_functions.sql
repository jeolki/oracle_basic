1.RANK 함수
(RANK()함수 사용)
SELECT A.DID AS 부서번호,
       A.PAMT AS 사원수
  FROM (SELECT DEPARTMENT_ID AS DID,
               COUNT(*) AS PAMT,
               RANK() OVER(ORDER BY COUNT(*) DESC) AS 순위 
          FROM EMPLOYEES
         GROUP BY DEPARTMENT_ID
         ORDER BY 2 DESC) A
  WHERE 순위=1;
  
  -- ( 정렬하세요 기준이되는컬럼명(수식) 차순) 등수를 비교해서 부여한다.
  -- RANK() OVER(ORDER BY 컬럼명 DESE/ASC )
  
  -- RANK의 종류는 3가지
  
1) RANK() 함수
  - 동일한 값에 중복 순위 부여한 후 다음 순위 해당 갯수 만큼 건너뛰고 부여
  (사용형식)
  SELECT 컬럼명1,
         컬럼명2,
           :
         RANK() OVER(ORDER BY 기준컬럼(또는 수식) DESC|ASC) AS 별칭
    FROM 테이블명
    
예) 매출테이블(CART)에 2005년 5월 제품별 판매수량합계를 구하되 판매수량이 많은 제품순으로 순위를 부여하시오
    Alias 상품코드, 상품명, 판매수량합계, 순위

SELECT A.CART_PROD AS 상품코드,
       B.PROD_NAME AS 상품명,
       SUM(A.CART_QTY)AS 판매수량합계,
       RANK() OVER(ORDER BY SUM(A.CART_QTY) DESC) AS 순위
  FROM CART A, PROD B
 WHERE A.CART_PROD = B.PROD_ID
   AND CART_NO LIKE '200505%'
 GROUP BY A.CART_PROD, B.PROD_NAME;



2) DENSE_RANK()함수
  - 동일한 값에 중복 순위 부여한 후 다음 순위는 중복순위에 관계없이 순차적인 값을 부여
  (사용형식)

예) 매출테이블(CART)에 2005년 5월 제품별 판매수량합계를 구하되 판매수량이 많은 제품순으로 순위를 부여하고
    상위 10위의 상품정보를 조회하시오
   (DENSE_RANK 사용)
    Alias 상품코드, 상품명, 판매수량합계, 순위
SELECT A.PCODE AS 상품코드,
       A.AMT AS 판매수량,
       A.RK AS 순위
  FROM (SELECT CART_PROD AS PCODE,
               SUM(CART_QTY)AS AMT,
               DENSE_RANK() OVER(ORDER BY SUM(CART_QTY) DESC) AS RK
          FROM CART
         WHERE CART_NO LIKE '200505%'
         GROUP BY CART_PROD) A
 WHERE A.RK <= 10;
         
         
-- 가상테이블 VIEW 라고 한다. 다음 VIEW가 나오면 사라짐 뷰에 이름을 붙여줌
-- 테이블에 이름을 붙여준다 AS사용하지 않는다

SELECT A.PCODE AS 상품코드,
       A.AMT AS 판매수량,
       A.RK AS 순위
  FROM (SELECT CART_PROD AS PCODE,
               SUM(CART_QTY)AS AMT,
               RANK() OVER(ORDER BY SUM(CART_QTY) DESC) AS RK
          FROM CART
         WHERE CART_NO LIKE '200505%'
         GROUP BY CART_PROD) A
 WHERE A.RK <= 10;
--상위 10위

---
SELECT C.PCODE AS 상품코드,
       C.PNAME AS 상품명,
       C.AMT AS 판매수량,
       C.RK AS 순위    
  FROM (SELECT A.CART_PROD AS PCODE,
               B.PROD_NAME AS PNAME,
               SUM(A.CART_QTY)AS AMT,
               RANK() OVER(ORDER BY SUM(A.CART_QTY) DESC) AS RK
          FROM CART A, PROD B
         WHERE A.CART_PROD = B.PROD_ID
           AND CART_NO LIKE '200505%'
         GROUP BY A.CART_PROD, B.PROD_NAME) C
 WHERE C.RK <= 10;
---

3) ROW_NUMBER() 함수
  - 중복에 관계없이 차례대로 순위부여

SELECT A.PCODE AS 상품코드,
       A.AMT AS 판매수량,
       A.RK AS 순위
  FROM (SELECT CART_PROD AS PCODE,
               SUM(CART_QTY)AS AMT,
               ROW_NUMBER() OVER(ORDER BY SUM(CART_QTY) DESC) AS RK
          FROM CART
         WHERE CART_NO LIKE '200505%'
         GROUP BY CART_PROD) A
 WHERE A.RK <= 10;
 --상위 10개를 내보내기위래서 ROW_NUMBER 이용
 --ROW_NUMBER는 같은값이 있어도 등수로 그냥 위에서부터 부여한다.
  
 
  
4) 그룹별 등수부여(PARTITION BY)
  - RANK, DENSE_RANK, ROW_NUMBER와 함께 사용하여 그룹별 순위 부여
  (사용형식)
  RANK() OVER(PARTITION BY 그룹분류 기준항목 ORDER BY 등수부여 기준항목 DESC|ASC)

예) 사원테이블에서 부서별 급여를 많이 받는 사원부터 순위를 부여하여 조회하시오
   Alias는 사원번호, 사원명, 부서번호, 급여, 순위이고 부서번호순으로 출력하시오

SELECT EMPLOYEE_ID AS 사원번호,
       EMP_NAME AS 사원명,
       DEPARTMENT_ID AS 부서번호,
       SALARY AS 급여,
       RANK() OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY DESC) AS 순위
  FROM EMPLOYEES
 ORDER BY 3;








