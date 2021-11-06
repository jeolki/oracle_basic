# 1\. SUB QUERY ( 서브 쿼리 )

​    

   

## 1\. 개념

-   SQL구문안에 또 다른 SELECT문이 포함된 형태
-   JOIN을 감소시켜 QUERY의 복잡성을 완화
-   서브 쿼리는 반드시 '( )'안에 기술
-   연산자와 함께 사용하는 경우 연산자 우측에 기술해야 한다.
-   FROM절에 사용되는 서브 쿼리를 특별히 in-line 서브 쿼리라 하고 VIEW나 독립된 테이블처럼 활용되며 실행 가능해야 한다. // FROM절이 제일 먼저 실행되기 때문에 그것의 결과를 가지고 실행될 것이다.

   

​    

   

## 2\. 메인 쿼리와의 연관성 여부에 따라

-   메인 쿼리에 사용된 테이블과 서브 쿼리에 사용된 테이블이 JOIN 연산되었는지 여부에 따라
-   연관성 서브 쿼리/연관성없는 서브쿼리

   

   

   

## 3\. 형태에 따라

-   일반 서브 쿼리
-   IN-LINE 서브 쿼리
-   중첩 서브 쿼리

   

​    

   

## 4\. 반환되는 행과 열에 따라

-   단일행/단일 열, 단일행/다중 열, 다중행/단일 열, 다중행/다중 열 서브 쿼리
-   사용되는 연산자에 따라 구분

### 1) 연관성 없는 서브 쿼리

-   메인 쿼리에 사용된 테이블과 서브 쿼리에 사용된 테이블이 JOIN연산이 발생되지 않는 서브쿼리

예제) 사원 테이블에서 사원들의 평균 급여보다 많은 급여를 지급받는 사원수를 조회하시오

```sql
-- 서브쿼리에서 해줄일과 메인쿼리에서 해결할것을 구분해야한다.
-- 메인쿼리는 최종 출력해야 하는 부분 (사원수)
-- 서브쿼리는 중간에 사용되어야할 자료를 만들어내는것 (평균급여)

(메인쿼리-사원수를 조회)
SELECT COUNT(*) AS 사원수
  FROM EMPLOYEES
 WHERE SALARY > (평균급여);
 

(서브쿼리-평균급여)
SELECT AVG(SALARY)
  FROM EMPLOYEES


(결합)
SELECT COUNT(*) AS 사원수
  FROM EMPLOYEES
 WHERE SALARY > (SELECT AVG(SALARY) 
                   FROM EMPLOYEES);
```

  

  

예제) 부서 테이블의 부서의 관리자 사원번호가 100인 부서에 속한 사원수를 조회하시오

```sql
(메인쿼리 - 사원수)
(서브쿼리 - 관리자 사원번호가 100인 부서)

SELECT COUNT(*) AS 사원수
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID  -- 원칙적으로 = 을 쓰면 안되는것
                           FROM DEPARTMENTS
                          WHERE MANAGER_ID = 100);
```

   

   

예제) 상품 테이블에서 분류코드가 P200 구간에 속한 상품의 수를 조회하시오

```sql
(서브쿼리 사용하지 않는 쿼리)
SELECT COUNT(*) AS "상품의 수"
  FROM PROD
 WHERE UPPER(PROD_LGU) LIKE 'P2%'
 
(서브쿼리 사용)
SELECT COUNT(*) AS "상품의 수"
  FROM PROD
 WHERE PROD_LGU IN /* = ANY, =SOME */(SELECT LPROD_GU
                     FROM LPROD
                    WHERE UPPER(LPROD_GU) LIKE 'P2%');
-- 서브쿼리가 다중행 단일열을 가진다 데이터가 하나가 아니라 여러가가나옴다
-- =이라는 연산자는 양쪽의 데이터의 수가 일치해야한다.
-- 오른쪽의 요소들과 같은것을 필요할때 IN, =ANY, =SOME 사용한다.


SELECT COUNT(*) AS "상품의 수"
  FROM PROD
 WHERE EXISTS (SELECT 1
                 FROM LPROD
                WHERE UPPER(LPROD_GU) LIKE 'P2%'
                  AND PROD_LGU = LPROD_GU);  
--EXISTS 연산자는 반드시 뒤에 서브쿼리가 있어야하며 관련성이 있어야한다.
```

​      

​      

예제) 사원 테이블에서 2006년 이후 입사한 사원들의 급여를 평균 금 여로 갱신하시오

```sql
(메인쿼리 - 사원들의 급여를 갱신)
UPDATE EMPOLYEES
   SET SALARY = (서브쿼리)
 WHERE HIRE_DATE >= TO_DATE('20060101')
 
(서브쿼리 - 평균급여 )
SELECT ROUND(AVG(SALARY),1)
  FROM EMPLOYEES
  
(결합)  
UPDATE EMPLOYEES
   SET SALARY = (SELECT ROUND(AVG(SALARY),1)
                   FROM EMPLOYEES)
 WHERE HIRE_DATE >= TO_DATE('20060101');
   
/*
CREATE OR REPLACE VIEW V_EMP01  -- 뷰를 만들어 줫다.
AS
SELECT EMP_NAME, SALARY
  FROM EMPLOYEES
 WHERE HIRE_DATE >= TO_DATE('20060101');
*/

SELECT * FROM V_EMP01;

SELECT EMP_NAME, HIRE_DATE, SALARY
  FROM EMPLOYEES
 WHERE HIRE_DATE >= '20060101';

ROLLBACK;
```

   

   

예제) 평균 급여보다 많은 급여를 받는 사원들을 삭제 처리하시오

```sql
DELETE EMPLOYEES;
ROLLBACK;

(메인쿼리 -사원정보 삭제 (평균급여보다 많은 급여를 받는))
DELETE EMPLOYEES
 WHERE SALARY > (서브쿼리);
 
(서브쿼리 - 평균급여)
SELECT AVG(SALARY) 
  FROM EMPLOYEES
  
(결합)  
DELETE EMPLOYEES
 WHERE SALARY > (SELECT AVG(SALARY) 
                   FROM EMPLOYEES);  
  
ROLLBACK;
```

   

   

예제)

```sql
다음 조건에 맞는 재고수불 테이블을 생성하시오
 - 테이블명 : REMAIN
 - 컬럼
   . 년도 : REMAIN_YEAR    CHAR(4) N.N, PK
   . 상품코드 : REMAIN_PROD VARCHAR2(10) N.N, PK/FK -- PROD에서
   . 기초재고 : REMAIN_J_00 NUMBER(5),
   . 입고수량 : REMAIN_I    NUMBER(5),
   . 출고수량 : REMAIN_O    NUMBER(5),
   . 기말재고 : REMAIN_J_99 NUMBER(5),
   . 갱신일자 : REMAIN_DATE DATE
   
   
CREATE TABLE REMAIN( 
  REMAIN_YEAR CHAR(4),  --pk는 어짜피 N.N
  REMAIN_PROD VARCHAR2(10), --pk는 어짜피 N.N
  REMAIN_J_00 NUMBER(5),
  REMAIN_I    NUMBER(5),
  REMAIN_O    NUMBER(5),
  REMAIN_J_99 NUMBER(5),
  REMAIN_DATE DATE,
  
  CONSTRAINT pk_remain PRIMARY KEY(REMAIN_YEAR, REMAIN_PROD ),
  CONSTRAINT fk_remain FOREIGN KEY(REMAIN_PROD)
     REFERENCES PROD(PROD_ID));

예) 재고수불테이블(REMAIN)에 다음 자료를 일괄 입력하시오
 년도 : '2005'
 상품코드 : PROD테이블의 상품코드
 갱신일자 : 20050101
 
 
 ** 서브쿼리를 이용한 일괄입력
INSERT INTO 테이블명[(컬럼명1, 컬럼명2,.....)]
 서브쿼리; -- 괄호로 묶지 않는다.
  .'서브쿼리'는 괄호를 사용하지 않음
  .'컬럼명1, 컬럼명2,.....'에 할당될 값은 서브쿼리의 SELECT 절에서 결정해야 함


INSERT INTO REMAIN(REMAIN_YEAR, REMAIN_PROD, REMAIN_DATE)
  SELECT '2005', PROD_ID, TO_DATE('20050101')
    FROM PROD;
    
SELECT * FROM REMAIN;

예)상품테이블의 적정재고(PROD_PROPERSTOCK)을 재고수불테이블(REMAIN)
   의 기초(REMAIN_J_00) 및 기말재고(REMAIN_J_99)로 갱신하시오 

UPDATE REMAIN
   SET (REMAIN_J_00, REMAIN_J_99) = 
       (SELECT PROD_PROPERSTOCK, PROD_PROPERSTOCK 
          FROM PROD
         WHERE REMAIN_PROD = PROD_ID)
 WHERE REMAIN_YEAR='2005'; 
--기본키가 두개이상 결합된 복합키인경우 한개만 비교하지말고 두개다 비교항목이 있어야한다.
--업데이트 해야할 컬럼이 두개이상이면 묶어서 쓰고 셀렉트절에도 갯수에 맞춰서 나오게한다.
 
UPDATE REMAIN
   SET REMAIN_J_00 = (SELECT PROD_PROPERSTOCK, PROD_PROPERSTOCK 
                        FROM PROD
                       WHERE REMAIN_PROD = PROD_ID ),
       REMAIN_J_99 = (SELECT PROD_PROPERSTOCK, PROD_PROPERSTOCK 
                        FROM PROD
                       WHERE REMAIN_PROD = PROD_ID )               
 WHERE REMAIN_YEAR = '2005'; 
 
--기본키의 개수만큼 where절
```

   

   

### 2) 연관성 있는 서브 쿼리

-   메인 쿼리에 사용된 테이블과 서브 쿼리에 사용된 테이블이 join으로 연결된 서브쿼리

예제) 장바구니 테이블에서 최고 판매수량을 기록한 회원의 회원번호, 상품명, 수량을 조회하시오

```sql
(메인쿼리 - 회원의 회원번호, 상품명, 수량을 조회) -CART PROD

SELECT A.CART_MEMBER AS 회원번호,
       B.PROD_NAME AS 상품명,
       A.CART_QTY AS 수량
  FROM CART A, PROD B
 WHERE A.CART_PROD = B.PROD_ID
   AND A.CART_QTY = (서브쿼리)

(서브쿼리 - 제일 큰 판매수량)
SELECT MAX(CART_QTY) FROM CART

(결합)
SELECT A.CART_MEMBER AS 회원번호,
       B.PROD_NAME AS 상품명,
       A.CART_QTY AS 수량
  FROM CART A, PROD B
 WHERE A.CART_PROD = B.PROD_ID
   AND A.CART_QTY = (SELECT MAX(CART_QTY) 
                       FROM CART);


(연관성 있는 서브쿼리 적용)
SELECT * FROM 
    (SELECT A.CART_MEMBER AS 회원번호,
            B.PROD_NAME AS 상품명,
            A.CART_QTY AS 수량
       FROM CART A, PROD B
      WHERE A.CART_PROD = B.PROD_ID
        AND A.CART_QTY = (SELECT MAX(CART_QTY) 
                            FROM CART
                           WHERE CART_MEMBER = A.CART_MEMBER)
 ORDER BY 3 DESC) TBLA
WHERE ROWNUM = 1;


SELECT A.CART_MEMBER AS 회원번호,
       D.MEM_NAME AS 회원명,
       B.PROD_NAME AS 상품명,
       A.CART_QTY AS 수량
  FROM CART A, PROD B, MEMBER D,
       (SELECT CART_MEMBER,
               E.MQTY AS AMT
          FROM CART, (SELECT MAX(CART_QTY) AS MQTY
                        FROM CART) E
         WHERE E.MQTY = CART_QTY) F               
 WHERE A.CART_PROD = B.PROD_ID
   AND A.CART_MEMBER = D.MEM_ID
   AND A.CART_MEMBER = F.CART_MEMBER
   AND A.CART_QTY = F.AMT ;
```

   

   

예제) 모든 거래처별 2005년 매출액 합계를 구하시오 ( Alias는 거래처코드, 거래처명, 매출액합계 )

```sql
(ANSI OUTER JOIN)
SELECT A.BUYER_ID AS 거래처코드,  -- 전체가들어있는 테이블꺼 사용
       A.BUYER_NAME AS 거래처명,
       NVL(SUM(B.PROD_PRICE * C.CART_QTY),0) AS 매출액합계
  FROM BUYER A
  LEFT OUTER JOIN PROD B ON (A.BUYER_ID = B.PROD_BUYER)
  LEFT OUTER JOIN CART C ON (B.PROD_ID = C.CART_PROD 
   AND C.CART_NO LIKE '2005%')
 GROUP BY A.BUYER_ID, A.BUYER_NAME
 ORDER BY 1;
 
                      
(SUBQUERY 적용)
메인쿼리 - 2005년 거래처별 거래처코드, 거래처명, (서브쿼리)
서브쿼리 - 2005년 거래처별 매출액합계

SELECT A.BUYER_ID AS 거래처코드,
       A.BUYER_NAME AS 거래처명
       (매출액)   --셀렉트절에 넣는게아니다 WHERE에서 사용되어야하기때문에 
  FROM BUYER A ,(서브쿼리-2005년도 거래처별 매출액합계) B           
 WHERE A.BUYER_ID = (..아우터조인..) (+)                                         
-- GROUP BY A.BUYER_ID, A.BUYER_NAME 그룹바이가 나올필요도 없어진다 
ORDER BY 1;

-- 서브쿼리의 결과를 메인쿼리의 셀렉트절에서 출력하고자 할경우 프롬절에 서브쿼리가 와야한다.!!!!!!!!!!!!!!!!!!!!!
-- FROM절은 미리 실행되어지기때문에 서브쿼리가 실행되어지면 결과가 나오고 그것을 셀렉트절에서 우리가 참조하는것이다.


SELECT A.BUYER_ID AS 거래처코드,
       A.BUYER_NAME AS 거래처명,
       NVL(B.OAMT,0) AS 매출액
  FROM BUYER A ,(SELECT BUYER_ID,
                        SUM(CART_QTY*PROD_PRICE) AS OAMT
                   FROM CART, PROD, BUYER
                  WHERE CART_PROD = PROD_ID
                    AND PROD_BUYER = BUYER_ID
                    AND CART_NO LIKE '2005%'
                  GROUP BY BUYER_ID ) B           
 WHERE A.BUYER_ID = B.BUYER_ID(+)                                         
ORDER BY 1;
```

   

   

예제) 장바구니 테이블에서 2005년 4월에 판매된 상품 중 2005년 6월에도 판매된 상품을 조회하시오 --동시에 판매됨  
         ( Alias는 상품코드, 상품명, 판매수량, 판매금액 )

```sql
SELECT DISTINCT(A.CART_PROD) AS 상품코드,
       D.PROD_NAME AS 상품명
  FROM CART A, (SELECT DISTINCT(CART_PROD) AS BAMT
                  FROM CART
                 WHERE CART_NO LIKE '200504%') B, 
               (SELECT DISTINCT(CART_PROD) AS CAMT
                  FROM CART 
                 WHERE CART_NO LIKE '200506%') C,
                   PROD D   
 WHERE A.CART_PROD = B.BAMT
   AND A.CART_PROD = C.CAMT
   AND A.CART_PROD = D.PROD_ID
 ORDER BY 1;

SELECT DISTINCT(A.PROD_ID) AS 상품코드,
       A.PROD_NAME AS 상품명
  FROM PROD A, (SELECT DISTINCT(CART_PROD)
                  FROM CART
                 WHERE CART_NO LIKE '200504%') B, 
               (SELECT DISTINCT(CART_PROD)
                  FROM CART 
                 WHERE CART_NO LIKE '200506%') C                   
 WHERE A.PROD_ID = B.CART_PROD
   AND A.PROD_ID = C.CART_PROD
 ORDER BY 1; 
  
  
(집합연산자)
SELECT PROD_ID,PROD_NAME
  FROM CART, PROD
 WHERE CART_PROD = PROD_ID
   AND CART_NO LIKE '200504%'
  
INTERSECT

SELECT PROD_ID,PROD_NAME
  FROM CART, PROD
 WHERE CART_PROD = PROD_ID
   AND CART_NO LIKE '200506%'
 ORDER BY 1;
```

   

   

예제) 직무이력 테이블(JOB\_HISTORY) 테이블에 저장된 사원의 부서 번호가  
       사원 테이블의 부서 번호와 동일한 사원의 사원번호, 사원명, 부서명을 조회하시오

```sql
-- 동일부서에서 직무만 변경된사람

--서브쿼리 -사원테이블과 잡히스토리 비교 사원이름출력 
--부서테이블과 부서코드 비교해서 부서명 조회
    
SELECT A.EMPLOYEE_ID AS 사원번호,
       A.EMP_NAME AS 사원명,
       B.DEPARTMENT_NAME AS  부서명
  FROM EMPLOYEES A, DEPARTMENTS B
 WHERE A.EMPLOYEE_ID IN (SELECT DISTINCT A.EMPLOYEE_ID
                           FROM JOB_HISTORY C
                          WHERE A.DEPARTMENT_ID = C.DEPARTMENT_ID
                            AND A.EMPLOYEE_ID = C.EMPLOYEE_ID)
   AND A.DEPARTMENT_ID = B.DEPARTMENT_ID;
```

   

   

예제) 사원 테이블에서 각 부서별 평균 급여보다 많은 급여를 받는 사원 정보를 조회하시오  
       ( Alias는 사원번호, 사원명, 부서 번호, 급여이며 부서 번호순으로 출력하시오 )

```sql
SELECT A.EMPLOYEE_ID AS 사원번호,
       A.EMP_NAME AS 사원명,
       A.DEPARTMENT_ID AS 부서번호,
       A.SALARY AS 급여,
       B.AVGSAL AS 부서별평균급여
  FROM EMPLOYEES A, (SELECT DISTINCT(DEPARTMENT_ID),
                            ROUND(AVG(SALARY)) AS AVGSAL
                       FROM EMPLOYEES
                      GROUP BY DEPARTMENT_ID) B
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
   AND A.SALARY > B.AVGSAL 
 ORDER BY 3, 4;
```

   

   

예제) 2005년도 제품별 매입수량 합계와 매출수량 합계를 조회하시오  
       ( SELECT 절에서 SUBQUERY 사용 )  
       ( Alias 제품번호, 제품명, 매출수량, 매입수량 )

```sql
SELECT PROD_ID AS 제품번호,
       PROD_NAME AS 제품명,
       (SELECT SUM(CART_QTY)
          FROM CART
         WHERE PROD_ID = CART_PROD
           AND CART_NO LIKE '2005%') AS 매출수량,
       (SELECT SUM(BUY_QTY)
          FROM BUYPROD
         WHERE BUY_PROD = PROD_ID
           AND BUY_DATE BETWEEN '20050101' AND '20051231') AS 매입수량
  FROM PROD;
 
--OUTER 조인과 결과가같다.
--서브쿼리를 참조할수없다 FROM절부터 실행인데 SELECT절에 도달하는것이 제일 마지막이라 참조불가능
```

   

   

예제) 2005년 1월 제품별 매입수량을 구하여 재고 수불 테이블(REMAIN)을 UPDATE 하시오

```sql
REMAIN 테이블의 입고수량 (REMAIN_I)과 출고수량(REMAIN_O)을 모두 0으로 변경

UPDATE REMAIN
   SET REMAIN_I = 0,
       REMAIN_O = 0;

COMMIT;

UPDATE REMAIN
   SET (REMAIN_I,REMAIN_O) = (SELECT 0,0 FROM DUAL);

UPDATE REMAIN
   SET (REMAIN_I, REMAIN_J_99) = (2005년 1월 제품별 매입수량)
 WHERE REMAIN_YEAR = '2005'
   AND REMAIN_PROD = (    )
 
UPDATE REMAIN
   SET (REMAIN_I, REMAIN_J_99, REMAIN_DATE) = 
       (SELECT NVL(SUM(BUY_QTY),0),
               REMAIN_J_99+NVL(SUM(BUY_QTY),0),
               '20050201'
          FROM BUYPROD
         WHERE BUY_DATE BETWEEN '20050101' AND '20050131'
           AND BUY_PROD = REMAIN_PROD)
 WHERE REMAIN_YEAR = '2005'
   AND REMAIN_PROD IN (SELECT BUY_PROD
                         FROM BUYPROD
                        WHERE BUY_DATE BETWEEN '20050101' AND '20050131');

 ROLLBACK;

(PROCEDURE를 사용한 방식)
CREATE OR REPLACE PROCEDURE PROC_REMAIN_UPDATE01(
   P_CODE IN BUYPROD.BUY_PROD%TYPE,
   P_AMT IN NUMBER)
IS
   V_CODE BUYPROD.BUY_PROD%TYPE := P_CODE;
   V_AMT NUMBER := P_AMT;
   V_DATE DATE := TO_DATE('20050201');
BEGIN
         
   UPDATE REMAIN
      SET REMAIN_I=V_AMT,
          REMAIN_J_99=REMAIN_J_99+V_AMT,
          REMAIN_DATE=V_DATE
    WHERE REMAIN_YEAR='2005'
      AND REMAIN_PROD=V_CODE;
END;      



DECLARE
  V_CODE PROD.PROD_ID%TYPE;
  V_AMT NUMBER := 0;
  CURSOR CUR_BUYPROD01 IS 
      SELECT BUY_PROD,
             SUM(BUY_QTY) AS V_AMT
        FROM BUYPROD
       WHERE BUY_DATE BETWEEN '20050101' AND '20050131'
       GROUP BY BUY_PROD;
BEGIN
   FOR REC IN CUR_BUYPROD01 LOOP
      PROC_REMAIN_UPDATE01(REC.BUY_PROD, REC.V_AMT);
   END LOOP;
END;
```