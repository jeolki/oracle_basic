 외부조인
 - 내부조인은 조인조건에 맞지않은 자료를 무시하고 결과 반환
 - 외부조인은 자료가 부족한 쪽 테이블에 부족한 행만큼 NULL을 추가 삽입하여 조인 수행
 - 조인조건에서 데이터가 없는 테이블의 컬럼에 외부조인 연산자 '(+)'를 붙여기술
 - 외부조인 조건이 두개 이상인경우 모든 조인조건에 외부조인 연산자를 기술
 - 한번에 한테이블에만 외부조인을 할수 있다.
   예) A,B,C 테이블에서 A를 기준으로 B테이블을 외부조인 했다면
      동시에 C를 기준으로 B테이블을 외부조인 할 수 없다.
      즉,
      WHERE A.COL = B.COL(+)
        AND C.COL = B.COL(+)는 허용되지 않음  -- C.COL(+)는 가능
 - 외부조인 연산자 '(+)'와 OR 연산자는 같이 사용할 수 없다.

 (일반 외부조인 사용 형식)
 SELECT 컬럼list
   FROM 테이블명1, 테이블명2 [,...]
  WHERE 테이블명1.컬럼명 = 테이블명2.컬럼명(+)  -- 자료의 종류가 부족할때 행의수는 아님!!
  -- 테이블명1.컬럼명(+) = 테이블명2.컬럼명(+) 양쪽이 모두 부족할때


 (ANSI 외부조인 사용 형식)
 SELECT 컬럼list
   FROM 테이블명1
  LEFT|RIGHT|FULL [OUTER] JOIN 테이블명2 ON(테이블명1.컬럼명 = 테이블명2.컬럼명
   [AND 일반조건])
 [WHERE 일반조건];
 
  .'LEFT OUTER JOIN'은 '테이블명1'의 데이터가 '테이블명2'의 데이터보다 많은 경우
  .'RIGHT OUTER JOIN'은 '테이블명2'의 데이터가 '테이블명1'의 데이터보다 많은 경우
  .'FULL OUTER JOIN'은 양쪽 테이블 모두 부족한경우 
  
예)전체 분류코드별 상품의 수를 조회하시오 
  Alias는 분류코드, 분류명, 상품의수

(내부조인)
SELECT A.LPROD_GU AS 분류코드,
       A.LPROD_NM AS 분류명,
       COUNT(*) AS 상품의수
  FROM LPROD A, PROD B
 WHERE A.LPROD_GU = B.PROD_LGU
 GROUP BY A.LPROD_GU, A.LPROD_NM;
   
  ** 분류테이블의 분류의 종류
  SELECT COUNT(*) FROM LPROD;  -- 9가지
  
  ** 상품테이블에서 사용되는 분류의 종류
  SELECT COUNT(DISTINCT PROD_LGU) FROM PROD;  -- 6가지
  
  PROD가 LPROD보다 종류가 작기때문에 (+)가 PROD에 붙는다 

(외부조인)
SELECT A.LPROD_GU AS 분류코드,
       A.LPROD_NM AS 분류명,
       NVL(COUNT(B.PROD_ID),0) AS 상품의수 -- 대상이 되어지는 테이블의 키의 칼럼명을 써주면 제일좋다
  FROM LPROD A, PROD B
 WHERE A.LPROD_GU = B.PROD_LGU(+)
 GROUP BY A.LPROD_GU, A.LPROD_NM
 ORDER BY 1;

(ANSI 외부조인)
SELECT A.LPROD_GU AS 분류코드,
       A.LPROD_NM AS 분류명,
       NVL(COUNT(B.PROD_ID),0) AS 상품의수 
  FROM LPROD A
  LEFT OUTER JOIN PROD B ON (A.LPROD_GU = B.PROD_LGU)
 GROUP BY A.LPROD_GU, A.LPROD_NM
 ORDER BY 1;

-- LEFT 를 안쓰고 RIGHT를 사용하면 INNER JOIN 의 결과가 나온다. 
 
예)사원테이블과 부서테이블을 조인하여 전체 부서별 사원수를 조회하시오
   Alias는 부서코드, 부서명, 사원수
   
   **부서테이블에서 부서코드의 종류
   SELECT COUNT(*) FROM DEPARTMENTS;  --27 NULL이없음 부족함
   
   **사용테이블에서 사용중인 부서코드의 수
   SELECT DISTINCT DEPARTMENT_ID FROM EMPLOYEES; -- 12 NULL포함 종류가부족함

(일반 외부조인) -- 일반 외부조인에서는 FULL OUTER JOIN을 지원하지 않는다.
SELECT B.DEPARTMENT_ID AS 부서코드,
       B.DEPARTMENT_NAME AS 부서명,
       NVL(COUNT(A.EMPLOYEE_ID),0) AS 사원수 
  FROM EMPLOYEES A, DEPARTMENTS B 
 WHERE A.DEPARTMENT_ID(+) = B.DEPARTMENT_ID(+)
 GROUP BY B.DEPARTMENT_ID, B.DEPARTMENT_NAME
 ORDER BY 1; 


(ANSI 외부조인)
SELECT NVL(TO_CHAR(B.DEPARTMENT_ID),'없음') AS 부서코드,
       NVL(B.DEPARTMENT_NAME,'없음') AS 부서명,
       NVL(COUNT(A.EMPLOYEE_ID),0) AS 사원수 
  FROM EMPLOYEES A
  FULL OUTER JOIN DEPARTMENTS B ON (A.DEPARTMENT_ID = B.DEPARTMENT_ID)
 GROUP BY B.DEPARTMENT_ID, B.DEPARTMENT_NAME
 ORDER BY B.DEPARTMENT_ID; 
 
 
 
 2005년 6월 상품별 매출액계산
 Alias는 상품번호, 상품명, 매출액

(내부조인)
SELECT A.CART_PROD AS 상품번호,
       B.PROD_NAME AS 상품명,
       SUM(A.CART_QTY * B.PROD_PRICE) AS 매출액
  FROM CART A, PROD B
 WHERE A.CART_PROD = B.PROD_ID
   AND A.CART_NO LIKE '200506%'
 GROUP BY A.CART_PROD, B.PROD_NAME
 ORDER BY 1;
 
-- 조인조건에 맞지않는 자료는 모두 무시된다 => 내부조인

-- 외부조인
-- CART 테이블의 자료가 PROD 보다 부족하다 부족한 행들을 모두 NULL로만 채우고 PROD 테이블과 조인을한다.
-- 그럼 모든행이 1:1로 비교가된다.

-- 모두 , 전부라는 말이 사용되면 모두 비교해줘야하기때문에 OUTER 조인을 해야한다.
-- 모두비교하고 안팔린것은 0으로 만들어서 줘야한다. 모든값을 비교

-- 될수 있으면 ANSI 조인을 사용한다. 
-- 일반 조인은 조인조건과 일반조건이 결합되면 나오지않기때문에 서브쿼리나 ANSI를 사용해서 OUTER조인한다.

(외부조인)
SELECT B.PROD_ID AS 상품번호,
       B.PROD_NAME AS 상품명,
       COUNT(A.CART_PROD) AS 판매횟수,
       NVL(SUM(A.CART_QTY * B.PROD_PRICE), 0) AS 매출액
  FROM CART A, PROD B
 WHERE A.CART_PROD(+) = B.PROD_ID
--   AND A.CART_NO LIKE '200506%' 일반조건이 껴버리면 모두 나오지않는다.
 GROUP BY B.PROD_ID, B.PROD_NAME
 ORDER BY 1;

-- COUNT 사용시 *을 사용하면 안된다. 행이있으면 NULL 이라도 1이 되기때문에
-- 반드시 컬럼명을 사용한다.

-- 상품번호에 NULL이들어가있다 부족한 CART에 NULL을 넣어줫기때문에 CART쪽을 출력하면 NULL이나온다.
-- 공통컬럼이 존재한다면 큰쪽을 출력해야한다. A.CART_PROD -> B.PROD_ID

-- (+)는 부족한쪽에 찍는다.

-- NVL을 이용하여 매출액이 NULL이면 0이 출력되도록한다.


예) 장바구니 테이블에서 2005년 4월 모든 회원별 구매현황을 조회하시오 --일반조건
    Alias는 회원번호, 회원명, 구매횟수, 구매금액 --MEMBER CART PROD 조인

(내부조인) -- 없는것은 무시해버린다.
SELECT A.CART_MEMBER AS 회원번호,
       B.MEM_NAME AS 회원명,
       COUNT(*) AS 구매횟수,
       SUM(A.CART_QTY*C.PROD_PRICE)AS 구매금액
  FROM CART A, MEMBER B, PROD C
 WHERE A.CART_MEMBER = B.MEM_ID --조인조건(회원명 추출)
   AND A.CART_PROD = C.PROD_ID --조인조건(상품의 단가추출)
   AND A.CART_NO LIKE '200504%'
 GROUP BY A.CART_MEMBER, B.MEM_NAME
 ORDER BY 1;

(일반 외부조인 사용 형식) --내부조인과 같은결과.. 나머지 여섯명도 0의 값으로 나와야한다.
SELECT A.CART_MEMBER AS 회원번호,
       B.MEM_NAME AS 회원명,
       COUNT(*) AS 구매횟수,
       SUM(A.CART_QTY*C.PROD_PRICE)AS 구매금액
  FROM CART A, MEMBER B, PROD C
 WHERE A.CART_MEMBER(+) = B.MEM_ID --한번확장되면 또 확장될수 없다
   AND A.CART_PROD = C.PROD_ID 
   AND A.CART_NO LIKE '200504%' -- 일반조건이 부여되어진경우 일반외부조인형식으로는 해결할수 없다.
 GROUP BY A.CART_MEMBER, B.MEM_NAME
 ORDER BY 1;

(ANSI 외부조인)
SELECT B.MEM_ID AS 회원번호,
       B.MEM_NAME AS 회원명,
       COUNT(A.CART_MEMBER) AS 구매횟수, -- 아우터조인은 *쓰면안되고 배경의되는 테이블의 PK사용
       NVL(SUM(A.CART_QTY*C.PROD_PRICE),0) AS 구매금액
  FROM CART A
 RIGHT OUTER JOIN MEMBER B ON (A.CART_MEMBER = B.MEM_ID AND A.CART_NO LIKE '200504%')
  LEFT OUTER JOIN PROD C ON (A.CART_PROD = C.PROD_ID)
 GROUP BY B.MEM_ID, B.MEM_NAME
 ORDER BY 1;
 
 
예) 장바구니 테이블에서 2005년 4월 모든 제품별 구매현황을 조회하시오 
    Alias는 상품코드, 상품명, 구매횟수, 구매금액
    
SELECT B.PROD_ID AS 상품코드,
       B.PROD_NAME AS 상품명,
       COUNT(A.CART_MEMBER) AS 구매횟수,
       NVL(SUM(A.CART_QTY*B.PROD_PRICE),0) AS 구매금액
  FROM CART A
 RIGHT OUTER JOIN PROD B ON (A.CART_PROD = B.PROD_ID 
   AND A.CART_NO LIKE '200504%')
 GROUP BY B.PROD_ID, B.PROD_NAME
 ORDER BY 1;


예)2005년 6월 전체 상품별 매입, 매출현황을 조회하시오
  Alias는 상품코드, 상품명, 매입금액합계, 매출금액합계
  단, 매출매입금액이 없으면 '0'으로 출력하고 상품번호순으로 출력

(ANSI 외부조인)
SELECT A.PROD_ID AS 상품코드,
       A.PROD_NAME AS 상품명,
       NVL(SUM(B.BUY_QTY * A.PROD_COST),0) AS 매입금액합계,
       NVL(SUM(C.CART_QTY * A.PROD_PRICE),0) AS 매출금액합계
  FROM PROD A   
  LEFT OUTER JOIN BUYPROD B ON (B.BUY_PROD = A.PROD_ID
   AND BUY_DATE BETWEEN TO_DATE('20050601') AND TO_DATE('20050630'))
  LEFT OUTER JOIN CART C ON (A.PROD_ID = C.CART_PROD
   AND C.CART_NO LIKE '200506%')
 GROUP BY A.PROD_ID, A.PROD_NAME
 ORDER BY 1;
 
 (SUBQUERY)
SELECT A.PROD_ID AS 상품코드,
       A.PROD_NAME AS 상품명,
       NVL(B.IAMT,0) AS 매입금액합계,
       NVL(C.OAMT,0) AS 매출금액합계
  FROM PROD A,
       -- 2005년 6월 상품별 매입집계(내부조인)
     ( SELECT BUY_PROD, 
              SUM(BUY_QTY*BUY_COST) AS IAMT
         FROM BUYPROD
        WHERE BUY_DATE BETWEEN TO_DATE('20050601') AND TO_DATE('20050630')
        GROUP BY BUY_PROD) B,
       -- 2005년 5월 상품별 매출집계(내부조인)
     ( SELECT CART_PROD,
              SUM(CART_QTY*PROD_PRICE) AS OAMT
         FROM CART, PROD 
        WHERE PROD_ID = CART_PROD
          AND CART_NO LIKE '200506%'
        GROUP BY CART_PROD) C
 WHERE A.PROD_ID = B.BUY_PROD(+)
   AND A.PROD_ID = C.CART_PROD(+)
 ORDER BY 1;

예) 2005년 1월 모든 거래처별 매입현황을 조회하시오
    Alias는 거래처명, 매입금액이며 거래처 순으로 출력하시오
    
SELECT A.BUYER_NAME AS 거래처명,     
       NVL(SUM(C.BUY_QTY*B.PROD_COST),0) AS 매입금액
  FROM BUYER A
  LEFT OUTER JOIN PROD B ON (A.BUYER_ID = B.PROD_BUYER)
  LEFT OUTER JOIN BUYPROD C ON (C.BUY_PROD = B.PROD_ID
   AND C.BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050131'))
 GROUP BY A.BUYER_NAME
 ORDER BY 1; 