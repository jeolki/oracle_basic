1. JOIN ( 테이블 조인 )

⇒ 두개의 테이블에서 공통된 컬럼이 반드시존재 해야함

관계형 데이터베이스 시스템의 가장 중요한 기능
정규화 등으로 분리된 테이블들을 이용하여 필요한 컬럼들을 조회
테이블 사이의 관계(Relationship)를 이용한 연산

( 사용형식 )
SELECT [테이블명|테이블별칭.] 컬럼명,.....
  FROM 테이블명1 [별칭], 테이블명2 [별칭], ......
 WHERE [테이블명|테이블별칭.]컬럼명 연산자 [테이블명|테이블별칭.]컬럼명 --- 조인조건
   AND [테이블명|테이블별칭.]컬럼명 연산자 [테이블명|테이블별칭.]컬럼명 --- 조인조건
   AND [일반조건];
   .테이블별칭은 복수개의 테이블에 이름이 동일한 컬럼이 존재하는 경우
   .조인조건은 사용된 테이블이 n개일때 n-1개 이상이어야 한다.
   .조인조건에 사용된 컬럼 내용은 같은 데이터이어야 한다.
   
   
2. 분류
1) Cartesian Product(ANSI에서는 Cross join)
모든 행들의 조합 반환 EX) A테이블이 100행 8열, B테이블이 50행 10열로 구성되고 두 테이블에 Cartesian Product를 수행하면 5000행 18열의 결과 반환
필요하지 않은 경우 사용하지 말것
조인조건이 없거나 잘못 설정된 경우 발생
예제)

CART와 PROD테이블에 대한 Cartesian Product를 수행
SELECT COUNT(*) AS 행의수 
  FROM CART A, PROD B

SELECT * 
  FROM CART A, PROD B


CART 테이블의 행의수
SELECT COUNT(*) FROM CART;

PROD 테이블의 행의수
SELECT COUNT(*) FROM PROD;   
   
SELECT 207*74 FROM DUAL;


2) Equi-JOIN(ANSI에서는 Inner join)
조인조건에 '=' 연산자가 사용된 조인
내부조인이라고도 한다.
조인조건을 만족하지 않는 자료는 무시함
대부분의 조인이 동등조인에 속함
( ANSI 형식 )
SELECT [테이블명|테이블별칭.] 컬럼명,.....
  FROM 테이블명1 [별칭]
 INNER JOIN 테이블명2 [별칭] ON(조인조건 [AND 일반조건] ....)  --조인에 관련된 일반조건
[INNER JOIN 테이블명3 [별칭] ON(조인조건 [AND 일반조건] ....)]
                          :
[WHERE 일반조건];                          -- 전체에 관련된 일반조건


예제) 사원테이블과 부서테이블을 이용하여 사원번호, 사원명, 부서코드, 부서명을 출력하시오

(기본 형식)
SELECT EMPLOYEES.EMPLOYEE_ID AS 사원번호,
       EMPLOYEES.EMP_NAME AS 사원명,
       EMPLOYEES.DEPARTMENT_ID AS 부서코드,
       DEPARTMENTS.DEPARTMENT_NAME AS 부서명
  FROM EMPLOYEES , DEPARTMENTS 
 WHERE EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID;

(별칭 사용)
SELECT A.EMPLOYEE_ID AS 사원번호,
       A.EMP_NAME AS 사원명,
       A.DEPARTMENT_ID AS 부서코드,
       B.DEPARTMENT_NAME AS 부서명
  FROM EMPLOYEES A, DEPARTMENTS B
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID;
 
(ANSI 형식)
SELECT A.EMPLOYEE_ID AS 사원번호,
       A.EMP_NAME AS 사원명,
       A.DEPARTMENT_ID AS 부서코드,
       B.DEPARTMENT_NAME AS 부서명
  FROM EMPLOYEES A
 INNER JOIN DEPARTMENTS B ON (A.DEPARTMENT_ID = B.DEPARTMENT_ID);
 
예제) 상품테이블에서 분류코드가 'P201'보다 작은 분류코드를 부여받은
        상품의 상품번호, 상품명, 분류코드, 분류명을 조회하시오
        
(기본 형식)
SELECT A.PROD_ID AS 상품번호,
       A.PROD_NAME AS 상품명, 
       A.PROD_LGU AS 분류코드,
       B.LPROD_NM AS 분류명
  FROM PROD A, LPROD B
 WHERE A.PROD_LGU = B.LPROD_GU          -- 조인조건
   AND UPPER(A.PROD_LGU) <= 'P201';      -- 일반조건
 
(ANSI 형식)  
SELECT A.PROD_ID AS 상품번호,
       A.PROD_NAME AS 상품명, 
       A.PROD_LGU AS 분류코드,
       B.LPROD_NM AS 분류명
  FROM PROD A
 INNER JOIN LPROD B ON (A.PROD_LGU = B.LPROD_GU)  
 WHERE UPPER(A.PROD_LGU) <= 'P201';
--  INNER JOIN LPROD B ON (A.PROD_LGU = B.LPROD_GU  
--    AND UPPER(A.PROD_LGU) <= 'P201');


예제) 2005년 6월 회원별 구매내역을 조회하시오 ( Alias는 회원번호, 회원명, 구매수량, 구매금액 )

(기본 형식)
SELECT A.CART_MEMBER AS 회원번호, 
       B.MEM_NAME AS 회원명,
       SUM(A.CART_QTY) AS 구매수량,
       SUM(C.PROD_PRICE * A.CART_QTY) AS 구매금액
  FROM CART A, MEMBER B, PROD C
 WHERE A.CART_MEMBER = B.MEM_ID
   AND A.CART_PROD = C.PROD_ID
   AND SUBSTR(A.CART_NO,1,6) = '200506'
-- AND A.CART_NO LIKE '200506%'
 GROUP BY A.CART_MEMBER, B.MEM_NAME;
    
                                                         
(ANSI 형식)
SELECT A.CART_MEMBER AS 회원번호, 
       B.MEM_NAME AS 회원명,
       SUM(A.CART_QTY) AS 구매수량,
       SUM(C.PROD_PRICE * A.CART_QTY) AS 구매금액
  FROM CART A  
 INNER JOIN MEMBER B ON (A.CART_MEMBER = B.MEM_ID)
 INNER JOIN PROD C ON (A.CART_PROD = C.PROD_ID) -- (CART와 MEMBER가 조인이되어진 결과)와 PROD의 조인
 WHERE SUBSTR(A.CART_NO,1,6) = '200506' -- 이경우에는 어느쪽에다 달아도 상관없다.
 GROUP BY A.CART_MEMBER, B.MEM_NAME;
    
SELECT A.CART_MEMBER AS 회원번호, 
       B.MEM_NAME AS 회원명,
       SUM(A.CART_QTY) AS 구매수량,
       SUM(C.PROD_PRICE * A.CART_QTY) AS 구매금액
  FROM CART A  
 INNER JOIN MEMBER B ON (A.CART_MEMBER = B.MEM_ID)
 INNER JOIN PROD C ON (A.CART_PROD = C.PROD_ID 
   AND SUBSTR(A.CART_NO,1,6) = '200506') -- 이경우에는 어느쪽에다 달아도 상관없다.
 GROUP BY A.CART_MEMBER, B.MEM_NAME;  
 
 SELECT A.CART_MEMBER AS 회원번호, 
       B.MEM_NAME AS 회원명,
       SUM(A.CART_QTY) AS 구매수량,
       SUM(C.PROD_PRICE * A.CART_QTY) AS 구매금액
  FROM CART A  
 INNER JOIN MEMBER B ON (A.CART_MEMBER = B.MEM_ID
   AND SUBSTR(A.CART_NO,1,6) = '200506') -- 이경우에는 어느쪽에다 달아도 상관없다.
 INNER JOIN PROD C ON (A.CART_PROD = C.PROD_ID) 
 GROUP BY A.CART_MEMBER, B.MEM_NAME; 
 
 
 -- 비교되는 컬럼타입이 다를때 공통으로 사용하면 좋을듯
 
 예제) 2005년 2~3월 매입 거래처별 매입정보를 조회하시오
       ( Alias 는 거래처코드, 거래처명, 매입수량합계, 매입금액합계 )
       
(기본 형식)   
SELECT A.BUYER_ID AS 거래처코드,
       A.BUYER_NAME AS 거래처명,
       SUM(C.BUY_QTY)AS 매입수량합계,
       SUM(C.BUY_QTY * C.BUY_COST) AS 매입금액합계
  FROM BUYER A, PROD B, BUYPROD C
 WHERE A.BUYER_ID = B.PROD_BUYER
   AND B.PROD_ID = C.BUY_PROD
   AND C.BUY_DATE BETWEEN TO_DATE('20050201') AND TO_DATE('20050331')
 GROUP BY A.BUYER_ID, A.BUYER_NAME;
    
    
(ANSI 형식)    
SELECT A.BUYER_ID AS 거래처코드,
       A.BUYER_NAME AS 거래처명,
       SUM(C.BUY_QTY)AS 매입수량합계,
       SUM(C.BUY_QTY * C.BUY_COST) AS 매입금액합계
  FROM BUYER A
 INNER JOIN PROD B ON (A.BUYER_ID = B.PROD_BUYER)
 INNER JOIN BUYPROD C ON (B.PROD_ID = C.BUY_PROD)
 WHERE C.BUY_DATE BETWEEN TO_DATE('20050201') AND TO_DATE('20050331')
 GROUP BY A.BUYER_ID, A.BUYER_NAME;
 
예제) 2005년 2~3월 매입 거래처별 매입정보를 조회하시오
        ( Alias 는 거래처코드, 거래처명, 매입수량합계, 매입금액합계 )
        단, 매입금액이 1000만원이상이고, 거래처 주소가 '서울'인 자료만 조회하시오
        
(기본 형식)    
SELECT A.BUYER_ID AS 거래처코드,
       A.BUYER_NAME AS 거래처명,
       SUM(C.BUY_QTY)AS 매입수량합계,
       SUM(C.BUY_QTY * C.BUY_COST) AS 매입금액합계
  FROM BUYER A, PROD B, BUYPROD C
 WHERE A.BUYER_ID = B.PROD_BUYER
   AND B.PROD_ID = C.BUY_PROD
   AND SUBSTR(A.BUYER_ADD1,1,2) = '서울'
   AND C.BUY_DATE BETWEEN TO_DATE('20050201') AND TO_DATE('20050331')
 GROUP BY A.BUYER_ID, A.BUYER_NAME    
HAVING SUM(C.BUY_QTY * C.BUY_COST) >= 10000000;


(ANSI 형식)    
SELECT A.BUYER_ID AS 거래처코드,
       A.BUYER_NAME AS 거래처명,
       SUM(C.BUY_QTY)AS 매입수량합계,
       SUM(C.BUY_QTY * C.BUY_COST) AS 매입금액합계
  FROM BUYER A
 INNER JOIN PROD B ON (A.BUYER_ID = B.PROD_BUYER AND SUBSTR(A.BUYER_ADD1,1,2) = '서울')
 INNER JOIN BUYPROD C ON (B.PROD_ID = C.BUY_PROD )
 WHERE C.BUY_DATE BETWEEN TO_DATE('20050201') AND TO_DATE('20050331')
 GROUP BY A.BUYER_ID, A.BUYER_NAME;    
HAVING SUM(C.BUY_QTY * C.BUY_COST) >= 10000000