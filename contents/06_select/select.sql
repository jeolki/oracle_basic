 1.SELECT 
 - 데이터 조회 기능 제공
 (사용형식)
 SELECT [[DISTINCT] 컬럼명 [AS] [["]별칭["]],  --조회한결과를 화면에 내보내기위해 필요한 절(생략불가)
        컬럼명 [AS] [["]별칭["]], --DISTINCT 중복되는것 제거
                    :
        컬럼명 [AS] [["]별칭["]]] | *  -- 컬럼명이 기술되든지 *를 사용한다. 모든컬럼조회
   FROM 테이블명 [별칭] [,테이블명 [별칭],....]  -- 생략될수 없다. -테이블2개이상 JOIN
 [WHERE 조건 [AND | OR 조건],...]   -- WHERE 절이 생략되면 모든행을 조회하는것 / 조건
 [GROUP BY 컬럼명 [,컬럼명,..]]
[HAVING 조건] --집계함수의 조건은 WHERE 말고 HAVING절 사용
 [ORDER BY 컬럼명|컬럼인덱스 [ASC|DESC] [,컬럼명|컬럼인덱스 [ASC|DESC],..]];
 -- 컬럼인덱스 : SELECT 절에나온 컬럼중 몇번째 컬럼인지// 테이블에서 순서 아니다.
 -- 정렬시키다
 -- 오름차순 ASC 내림차순 DESC 사용
 
 -- FROM -> WHERE -> SELECT 순으로 실행
 
 -- BUYER 거래처 테이블
 -- BUYER ID 거래처 코드
 -- BUYER NAME 거래처 명
 -- BUYER LGU 거래처 분류코드
 
 -- LPROD 상품분류테이블
 -- LPROD ID 시퀀스 숫자 의미없다
 -- LPROD GU 분류코드 
 -- LGU 분류코드
 
예) 상품분류테이블(LPROD) 의 모든 자료를 조회하시오.
SELECT * FROM LPROD;

예) 회원테이블(MEMBER)에서 마일리지가 3000이상인 회원정보를 조회하시오
   Alias는 회원번호, 회원명, 연락처(핸드폰번호), 보유마일리지

SELECT  MEM_ID AS 회원번호,
        MEM_NAME AS 회원명,
        MEM_HP AS "연락처(핸드폰번호)", --공백,특수문자나 괄호가 들어가기때문에 ""써야한다.
        MEM_MILEAGE AS 보유마일리지
  FROM  MEMBER
 WHERE  MEM_MILEAGE>=3000;   --조건
 
 -- FROM -> WHERE 이하 -> SELECT 순서로 실행된다.
 
 
 문제] 상품테이블(PROD)에서 상품코드와 상품명 및 판매가(PROD_PRICE)를 조회하시오 
 -- COST 매입단가
 -- PRICE 판매단가
 -- SALE 할인판매가
 -- TOTALSTOCK 총재고
 -- PROPERSTOCK 적정재고
 
SELECT  PROD_ID AS 상품코드,
        PROD_NAME AS 상품명,
        PROD_PRICE AS 판매가
  FROM  PROD;


-- 가장중요 select from where 






 
 
 
 
 
 
 
 
 
 