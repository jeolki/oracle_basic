 1.NULL처리 함수
 - 테이블에 저장된 데이터 중 NULL 자료 값은 연산 시 오류를 유발 
 - NVL, NVL2, NULLIF, IS NULL(IS NOT NULL) 등으로 NULL값을 처리
   --  = NULL 하면 처리못한다. IS NULL 로서 해줘야한다.
 
1) NVL(expr1, expr2)
  - 'expr1'의 값이 NULL 이면 'expr2'를 반환하고
    'expr1'의 값이 NULL 이 아니면 자기자신의 값 ('expr1')을 반환
  - 'expr1'과 'expr2'는 같은 데이터 타입이어야 함 
 
예)사원테이블에서 사원들의 보너스를 계산하여 조회하시오
   단, 80번과 50번 부서에 속한 사원만 조회하시오
   보너스 = 본봉 * 영업실적(COMMISSION_PCT)의 30%이다.
   Alias은 사원번호, 사원명, 급여, 보너스

SELECT EMPLOYEE_ID AS 사원번호,
       EMP_NAME AS 사원명,
       SALARY AS 급여,
       NVL(SALARY * COMMISSION_PCT*0.3, 0) * 0.3 AS 보너스,
       SALARY + NVL(SALARY * COMMISSION_PCT*0.3, 0) AS 지급액
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID = 80
    OR DEPARTMENT_ID = 50;
   
    -- NVL(SALARY * COMMISSION_PCT*0.3, '없음') * 0.3 AS 보너스 -- 오류난다
    -- 변수가 모두 같은 타입이여야 한다.
    -- NVL(TO_CHAR(SALARY * COMMISSION_PCT*0.3), '없음') * 0.3 AS 보너스,
    -- 타입을 맞춰주면 성립한다.
   

예) 장바구니테이블(CART)에서 2005년 6월 판매정보를 이용하여 모든 제품별 판매현황을 조회하시오 
    -- 모든 -> OUTER JOIN -- 제품별 --> GROUP BY
    -- 기본이되는 테이블에 어떤자료가 들어있는지 먼저 파악한다.
    -- CART_NO 는 2005년 6월에 판매된이라는 조건에 사용될것이다
    -- CART_PROD 상품코드
    -- CART_QTY 수량합계
    -- 상품명과 판매금액합계는 CART테이블에 존재하지않는 것들이다.
    -- PROD 테이블가보면 PROD_NAME이 있고 PROD_PRICE가 있다. 
    -- 두개의 테이블이 사용되어질것이다 공통되어진 컬럼이 있어야 조인이 발생
    -- PROD_ID와 CART_PROD 가 같다
    -- PROD 테이블에는 모든 상품에 대한 정보가 들어있으니 찾아서 상품명과 판매금액을 찾아낸다.
    -- 모든상품에 대해서 --> 외부조인
   Alias는 상품코드, 상품명, 판매수량합계, 판매금액합계

SELECT B.PROD_ID AS 상품코드,
       B.PROD_NAME AS 상품명,
       NVL(SUM(A.CART_QTY), 0) AS 판매수량합계,
       NVL(SUM(A.CART_QTY*B.PROD_PRICE), 0) AS 판매금액합계  
  FROM CART A 
 RIGHT OUTER JOIN PROD B ON(A.CART_PROD=B.PROD_ID
   AND A.CART_NO LIKE '200506%')
 GROUP BY B.PROD_ID, B.PROD_NAME
 ORDER BY 1;
 

2) NVL2(expr1, expr2, expr3)
  - 'expr1'이 NULL이면 'expr3'을 반환하고, NULL이 아니면 'expr2'를 반환한다.
  - 'expr2'와 'expr3'는 같은 데이터 타입 이어야 함
 
예)사원테이블에서 사원들의 보너스를 계산하여 조회하시오
   단, 80번과 50번 부서에 속한 사원만 조회하시오 (NVL2 사용)
   보너스 = 본봉 * 영업실적(COMMISSION_PCT)의 30%이다.
   Alias은 사원번호, 사원명, 급여, 보너스, 지급액

SELECT EMPLOYEE_ID AS 사원번호,
       EMP_NAME AS 사원명,
       SALARY AS 급여,
       NVL2(SALARY * COMMISSION_PCT*0.3, SALARY * COMMISSION_PCT*0.3, 0) * 0.3 AS 보너스,
       SALARY + NVL2(SALARY * COMMISSION_PCT*0.3, SALARY * COMMISSION_PCT*0.3, 0) AS 지급액
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID = 80
    OR DEPARTMENT_ID = 50; 
 
예)회원테이블에서 마일리지가 1000미만인 회원들의 마일리지를 NULL로 갱신하라

UPDATE MEMBER
   SET MEM_MILEAGE = NULL
 WHERE MEM_MILEAGE < 1000;
 
문제1] 회원테이블에서 마일리지가 NULL인 회원의
      회원번호, 회원명, 이메일주소를 조회하시오
      
SELECT MEM_ID AS 회원번호,
       MEM_NAME AS 회원명,
       MEM_MAIL AS 이메일주소
  FROM MEMBER
 WHERE MEM_MILEAGE IS NULL;   -- NULL 인지 아닌지 비교할때 IS 사용
 
예) 회원들의 마일리지를 조회하여 그 값이 NULL이면 '비활동회원',
    NULL이 아니면 '정상회원' 이라는 메시지를 비고난에 출력하시오
    Alias는 회원번호, 회원명, 마일리지, 비고

SELECT MEM_ID AS 회원번호,
       MEM_NAME AS 회원명,
       NVL(MEM_MILEAGE, 0) AS 마일리지,
       NVL2(MEM_MILEAGE, '정상회원', '비활동회원') AS 비고
  FROM MEMBER ;
  
ROLLBACK;
COMMIT;

3) NULLIF(c1, c2)
  - c1 과 c2를 비교하여 그 값이 같으면 NULL 반환하고 다르면 c1값을 반환

예) 상품테이블에서 분류번호 'P301'에 속한 자료의 PROD_SALE 값을 
    PROD_PRICE값으로 변경하시오

UPDATE PROD
   SET PROD_SALE = PROD_PRICE
 WHERE UPPER(PROD_LGU) = 'P301';  -- 좀 더 안정적 이도록 UPPER 사용

예) 상품테이블에서 판매가와 할인가가 동일한(할인되지 않는 상품) 상품을 조회하시오
    Alias는 상품번호, 상품명, 판매가, 할인가

SELECT PROD_ID AS 상품번호,
       PROD_NAME AS 상품명,
       PROD_PRICE AS 판매가,
       PROD_SALE AS 할인가
  FROM PROD
 WHERE NULLIF(PROD_PRICE, PROD_SALE) IS NULL ;
 
 ROLLBACK;
  