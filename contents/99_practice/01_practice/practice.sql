DB TEST)
1) 상품 테이블로부터 모든 row와 column을 검색

SELECT * FROM PROD;

2) 회원 테이블로부터 모든 row와 column을 검색

SELECT * FROM MEMBER;

3) 상품 테이블로부터 상품코드와 상품명을 검색

SELECT PROD_ID AS 상품코드,
       PROD_NAME AS 상품명
  FROM PROD;

4) 회원 테이블의 마일리지를 12로 나눈 값을 검색

SELECT MEM_MILEAGE/12 AS 마일리지
  FROM MEMBER;

5) 상품 테이블의 상품코드, 상품명, 판매금액을 검색
(판매금액은 = 판매단가 * 55 로 계산)

SELECT PROD_ID AS 상품코드,
       PROD_NAME AS 상품명,
       ROUND(PROD_PRICE * 55) AS 판매금액
  FROM PROD;

6) 회원 테이블의 마일리지를 12로 나눈 값을 월평균으로 변경 검색

SELECT ROUND(MEM_MILEAGE/12) AS 월평균
  FROM MEMBER ;

7) 상품테이블에서 PROD_ID, PROD_NAME, PROD_BUYER를 검색
(단, Column __________는 상품코드, 상품명, 거래처코드로 정의)

SELECT PROD_ID AS 상품코드,
       PROD_NAME AS 상품명,
       PROD_BUYER AS 거래처코드
  FROM PROD;

8) 상품 테이블의 상품분류를 중복되지 않게 검색----

SELECT DISTINCT(PROD_LGU) AS  상품분류
  FROM PROD;
 
9) 상품 테이블의 거래처코드를 중복되지 않게 검색
(Alias는 거래처)

SELECT DISTINCT(PROD_BUYER) AS 거래처
  FROM PROD;

10) 회원테이블에서 회원ID, 회원명, 생일, 마일리지 검색

SELECT MEM_ID AS 회원ID,
       MEM_NAME AS 회원명,
       MEM_BIR AS 생일,
       MEM_MILEAGE AS 마일리지
  FROM MEMBER;

가. 회원ID 컬럼으로 오름차순 정렬

SELECT MEM_ID AS 회원ID,
       MEM_NAME AS 회원명,
       MEM_BIR AS 생일,
       MEM_MILEAGE AS 마일리지
  FROM MEMBER
 ORDER BY 1;

나. 성명이라는 ALIAS를 통해 오름차순 정렬

SELECT MEM_ID AS 회원ID,
       MEM_NAME AS 회원명,
       MEM_BIR AS 생일,
       MEM_MILEAGE AS 마일리지
  FROM MEMBER
 ORDER BY 2;

다. 3번째 컬럼으로 내림차순 정렬

SELECT MEM_ID AS 회원ID,
       MEM_NAME AS 회원명,
       MEM_BIR AS 생일,
       MEM_MILEAGE AS 마일리지
  FROM MEMBER
 ORDER BY 3 DESC;

라. 마일리지 컬럼으로 오름차순으로 1차 정렬 후 1번째 컬럼으로 오름차순으로 2차 정렬---

SELECT MEM_ID AS 회원ID,
       MEM_NAME AS 회원명,
       MEM_BIR AS 생일,
       MEM_MILEAGE AS 마일리지
  FROM MEMBER
 ORDER BY 4, 1;

11) 상품 중 판매가가 170,000원인 상품 조회

SELECT PROD_NAME AS 상품명
  FROM PROD
 WHERE PROD_PRICE = 170000;

12) 상품 중 판매가가 170,000원이 아닌 상품 조회----

SELECT PROD_NAME AS 상품명
  FROM PROD
 WHERE PROD_PRICE != 170000;

13) 상품 중 판매가가 170,000원 초과 또는 미만인 상품 조회

SELECT PROD_NAME AS 상품명
  FROM PROD
 WHERE 170000 < PROD_PRICE OR PROD_PRICE < 170000;

14) 상품 중 판매가가 170,000원이상 또는 이하인 상품 조회

SELECT PROD_NAME AS 상품명
  FROM PROD
 WHERE 170000 <= PROD_PRICE OR PROD_PRICE <= 170000;

15) 상품 중 매입가가 200,000원 이하인 상품을 검색
( Alias는 상품코드, 상품명, 매입가 )

SELECT PROD_ID AS 상품코드,
       PROD_NAME AS 상품명,
       PROD_COST AS 매입가
  FROM PROD
 WHERE PROD_COST <= 200000;

16) 회원 중 76년도 1월 1일 이후에 태어난 회원을 검색
- 주민등록번호 앞자리로 비교
( Alias는 회원ID, 회원 명, 주민등록번호 앞자리 )

SELECT MEM_ID AS 회원ID,
       MEM_NAME AS "회원 명",
       MEM_REGNO1 AS "주민등록번호 앞자리"
  FROM MEMBER
 WHERE TO_NUMBER(MEM_REGNO1) > 760101;

17) 상품 중 상품분류가 P201(여성 캐쥬얼)이고, 판매가가 170,000원인 상품 조회

SELECT PROD_NAME AS 상품명
  FROM PROD
 WHERE PROD_LGU = 'P201' AND PROD_PRICE = 170000;

18) 상품 중 상품분류가 P201(여성 캐쥬얼)이거나 판매가가 170,000원인 상품 조회

SELECT PROD_NAME AS 상품명
  FROM PROD
 WHERE PROD_LGU = 'P201' OR PROD_PRICE = 170000;

19) 상품 중 상품분류가 P201(여성 캐쥬얼)도 아니고 판매가가 170,000원도 아닌 상품 조회

SELECT PROD_NAME AS 상품명
  FROM PROD
 WHERE PROD_LGU != 'P201' AND PROD_PRICE != 170000;

20) 상품 중 판매가가 300,000원 이상, 500,000원 이하인 상품을 검색
( Alias는 상품코드, 상품명, 판매가 )

SELECT PROD_ID AS 상품코드,
       PROD_NAME AS 상품명,
       PROD_PRICE AS 판매가
  FROM PROD
 WHERE PROD_PRICE >= 300000 
   AND PROD_PRICE <= 500000; 

21) 상품 중 판매가가 150,000원,170,000원, 330,000원인 상품 조회

SELECT PROD_ID AS 상품코드,
       PROD_NAME AS 상품명,
       PROD_PRICE AS 판매가
  FROM PROD
 WHERE PROD_PRICE IN(150000, 170000, 330000); 


22) 회원테이블에서 회원ID가 C001, F001, W001 인 회원만 검색
( Alias는 회원ID, 회원명 )

SELECT MEM_ID AS 회원ID,
       MEM_NAME AS 회원명
  FROM MEMBER
 WHERE MEM_ID IN ('c001', 'f001', 'w001');

23) 상품 분류테이블에서 현재 상품테이블에 존재하는 분류만 검색  -----
( Alias는 분류코드, 분류명 )

SELECT DISTINCT(A.LPROD_GU) AS 분류코드,
       A.LPROD_NM AS 분류명
  FROM LPROD A, PROD B
 WHERE A.LPROD_GU = B.PROD_LGU
 ORDER BY 1;
 
24) 상품 분류테이블(LPROD)에서 현재 상품테이블 (PROD) 에 존재하지 않는 분류만 검색  -------------------------
( Alias는 분류코드, 분류명 )

SELECT DISTINCT(A.LPROD_GU) AS 분류코드,
       A.LPROD_NM AS 분류명
  FROM LPROD A, PROD B
 WHERE  A.LPROD_GU NOT IN (SELECT PROD_LGU FROM PROD)
 ORDER BY 1;

25) 상품 중 판매가가 100,000원 부터 300,000원 사이의 상품 조회

SELECT PROD_NAME AS 상품명
  FROM PROD
 WHERE PROD_PRICE BETWEEN 100000 AND 300000 ;

26) 회원 중 생일이 1975-01-01에서 1976-12-31사이에 태어난 회원을 검색 --
( Alias는 회원ID, 회원 명, 생일 )

SELECT MEM_ID AS 회원ID,
       MEM_NAME AS "회원 명",
       MEM_BIR AS 생일
  FROM MEMBER
 WHERE MEM_BIR BETWEEN TO_DATE('19750101') AND TO_DATE('19761231');

27) 상품 중 매입가가 300,000~1,500,000이고 판매가가 800,000~2,000,000 인 상품을 검색
( Alias는 상품명, 매입가, 판매가 )

SELECT PROD_NAME AS 상품명,
       PROD_COST AS 매입가,
       PROD_PRICE AS 판매가
  FROM PROD
 WHERE PROD_COST BETWEEN TO_NUMBER(300000) AND TO_NUMBER(1500000)
   AND PROD_PRICE BETWEEN TO_NUMBER(800000) AND TO_NUMBER(2000000);

28) 회원 중 생일이 1975년도 생이 아닌 회원을 검색
( Alias는 회원ID, 회원 명, 생일)

SELECT MEM_ID AS 회원ID,
       MEM_NAME AS "회원 명",
       MEM_BIR AS 생일
  FROM MEMBER
 WHERE SUBSTR(MEM_BIR, 1, 4) != '1975';

29) 회원테이블에서 김씨 성을 가진 회원을 검색( Alias는 회원ID, 성명 )

SELECT MEM_ID AS 회원ID,
       MEM_NAME AS 성명
  FROM MEMBER
 WHERE MEM_NAME LIKE '김%';

30) 회원테이블의 주민등록번호 앞자리를 검색하여 1975년생을 제외한 회원을 검색
( Alias는 회원ID, 성명, 주민등록번호 )

SELECT MEM_ID AS 회원ID,
       MEM_NAME AS 성명,
       MEM_REGNO1 || '-' || MEM_REGNO2 AS 주민등록번호
  FROM MEMBER
 WHERE SUBSTR(MEM_REGNO1, 1, 2) != '75';

31) 회원테이블의 회원ID를 대문자로 변환하여 검색(Alias명은 변환 전ID, 변환 후ID )

SELECT MEM_ID AS "변환 전ID",
       UPPER(MEM_ID) AS "변환 후ID"
  FROM MEMBER;

32) 회원테이블의 성씨 조회

SELECT SUBSTR(MEM_NAME,1,1) AS 성씨
  FROM MEMBER;
  
33) 상품테이블의 상품명의 4째 자리부터 2글자가 '칼라' 인 상품의 상품코드, 상품명을 검색
( Alias명은 상품코드, 상품명 )

SELECT PROD_ID AS 상품코드,
       PROD_NAME AS 상품명
  FROM PROD
 WHERE SUBSTR(PROD_NAME,4,2) = '칼라';

34) 상품테이블의 상품코드에서 왼쪽4자리, 오른쪽6자리를 검색 -----
(Alias명은 상품코드, 대분류, 순번 )

SELECT PROD_ID AS 상품코드,
       SUBSTR(PROD_ID,1,4) AS 대분류,
       SUBSTR(PROD_ID,-6,6) AS 순번
  FROM PROD;
    
35) 거래처 테이블의 거래처명 중 '삼' --> '육' 으로 치환

SELECT REPLACE(BUYER_NAME, '삼','육') AS 거래처명
  FROM BUYER;

36) 회원테이블의 회원성명 중 '이' --> '리' 로 치환 검색
(Alias명은 회원명, 회원명치환 )

SELECT MEM_NAME AS 회원명,
       REPLACE(MEM_NAME, '이', '리') AS 회원명치환
  FROM MEMBER;

37) 회원 테이블의 마일리지를 12로 나눈 값을 검색
(소수3째자리 반올림, 절삭)

SELECT ROUND(MEM_MILEAGE/12,2) AS "소수3째자리 반올림",
       TRUNC(MEM_MILEAGE/12) AS 절삭
  FROM MEMBER;

38) 상품테이블의 상품명, 원가율( 매입가 / 판매가 )을 비율(%)로(반올림 없는 것과 소수 첫째자리 반올림 비교) 검색(Alias는 상품명, 원가율1, 원가율2)

SELECT PROD_NAME AS 상품명,
       (PROD_COST/PROD_PRICE)*100 || '%' AS 원가율1,
       ROUND((PROD_COST/PROD_PRICE)*100,1) || '%' AS 원가율2
  FROM PROD;

39) 상품테이블에서 상품입고일을 '2008-09-28' 형식으로 나오게 검색
(Alias 상품명, 상품판매가, 입고일)

SELECT PROD_NAME AS 상품명,
       PROD_PRICE AS 상품판매가,
       REPLACE(PROD_INSDATE, '/', '-') AS 입고일
  FROM PROD;



---------------------------------------------------------------------



1) 상품테이블(PROD)의 상품분류(PROD_LGU)별 매입가격(PROD_COST) 평균 값
(소수점 2자리 반올림)

SELECT PROD_LGU AS 상품분류,
       ROUND(AVG(PROD_COST),1) AS 매입가격평균
  FROM PROD
 GROUP BY PROD_LGU
 ORDER BY 1;

2) 상품테이블(PROD)의 총 판매가격(PROD_SALE) 평균 값
(Alias는 상품총판매가격평균)

SELECT ROUND(AVG(PROD_SALE),1) AS 상품총판매가격평균
  FROM PROD
  
3) 상품테이블(PROD)의 상품분류별(PROD_LGU) 판매가격(PROD_SALE) 평균 값
(Alias는 상품분류, 상품분류별판매가격평균)

SELECT PROD_LGU AS 상품분류,
       ROUND(AVG(PROD_SALE),1) AS 상품총판매가격평균
  FROM PROD
 GROUP BY PROD_LGU
 ORDER BY 1;

4) 회원테이블(MEMBER)의 취미종류(MEM_LIKE)수를 COUNT집계
( Alias는 취미종류수 )

SELECT COUNT(MEM_LIKE) AS 취미종류수
  FROM MEMBER;

5) 회원테이블(MEMBER)의 취미(MEM_LIKE)별 COUNT집계
( Alias는 취미, 자료수, 자료수(*) )

SELECT MEM_LIKE AS 취미,
       COUNT(MEM_LIKE) AS 자료수,
       COUNT(*) AS "자료수(*)"
  FROM MEMBER
 GROUP BY MEM_LIKE;

6) 회원테이블(MEMBER)의 직업종류(MEM_JOB)수를 COUNT집계
( Alias는 직업종류수 )

SELECT COUNT(MEM_JOB) AS 직업종류수
  FROM MEMBER;

7) 장바구니테이블(CART)의 회원별 최대구매수량(CART_QTY)을 검색
( Alias는 회원ID(CART_MEMBER), 최대수량, 최소수량 )

SELECT CART_MEMBER AS 회원ID, 
       MAX(CART_QTY) AS 최대수량,
       MIN(CART_QTY) AS 최소수량
  FROM CART
 GROUP BY CART_MEMBER;

8) 오늘이 2005년도7월11일이라 가정하고 장바구니테이블(CART)에 발생될 추가주문번호(CART_NO)를 검색 ----
( Alias는 최고치주문번호, 추가주문번호 )

SELECT MAX(CART_NO) AS 최고치주문번호,
       TO_NUMBER(MAX(CART_NO)) + 1 AS 추가주문번호
  FROM CART
 WHERE TO_DATE(SUBSTR(CART_NO,1,8)) = TO_DATE('20050711');

9) 상품테이블(PROD)의 상품분류(PROD_LGU)별 판매가(PROD_SALE) 합계 값

SELECT PROD_LGU AS 상품분류,
       SUM(PROD_SALE) AS 판매합계
  FROM PROD
 GROUP BY PROD_LGU;

10) 상품입고테이블(BUYPROD)의 상품(BUY_PROD)별 입고수량(BUY_QTY)의 합계 값

SELECT BUY_PROD AS 상품,
       SUM(BUY_QTY) AS "입고수량 합계"
  FROM BUYPROD
 GROUP BY BUY_PROD;

11) 장바구니테이블(CART)의 상품분류(CART_PROD 왼쪽 네자리)별 판매수량(CART_QTY)의 합계 값
( Alias는 상품, 판매수량합계 )

SELECT SUBSTR(CART_PROD,1,4) AS 상품분류,
       SUM(CART_QTY) AS "판매수량 합계"
  FROM CART
 GROUP BY SUBSTR(CART_PROD,1,4);

12) 회원테이블(MEMBER)의 회원전체의 마일리지(MEM_MILEAGE) 평균, 마일리지 합계,
최고 마일리지, 최소 마일리지,인원수를 검색 
(Alias는 마일리지평균, 마일리지합계,최고마일리지, 최소마일리지,인원수)

SELECT ROUND(AVG(MEM_MILEAGE),1) AS 마일리지평균,
       SUM(MEM_MILEAGE) AS 마일리지합계,
       MAX(MEM_MILEAGE) AS 최고마일리지,
       MIN(MEM_MILEAGE) AS 최소마일리지,
       COUNT(*) AS 인원수
  FROM MEMBER;

13) 상품테이블(PROD)에서 거래처(PROD_BUYER), 상품분류(PROD_LGU)별로 최고판매가(PROD_SALE),
최소판매가, 자료 수를 검색

SELECT PROD_BUYER AS 거래처,
       PROD_LGU AS 상품분류,
       MAX(PROD_SALE) AS 최고판매가,
       MIN(PROD_SALE) AS 최소판매가,
       COUNT(*) AS 자료수
  FROM PROD
 GROUP BY PROD_BUYER, PROD_LGU;

14) 장바구니테이블(CART)에서 회원(CART_MEMBER), 상품분류(CART_PROD 왼쪽 네자리)별로 구매수량(CART_QTY)평균,
구매수량합계, 자료수를 검색
( Alias는 회원ID, 상품분류, 구매수량평균, 구매수량합계, 자료수 )
(회원ID(CART_MEMBER), 상품분류 순으로 SORT하시오)

SELECT CART_MEMBER AS 회원ID,
       SUBSTR(CART_PROD,1,4) AS 상품분류,
       ROUND(AVG(CART_QTY),1) AS 구매수량평균,
       SUM(CART_QTY) AS 구매수량합계,
       COUNT (*) AS 자료수
  FROM CART
 GROUP BY CART_MEMBER, SUBSTR(CART_PROD,1,4)
 ORDER BY 2;

15) 회원테이블(MEMBER)에서 지역(주소1(MEM_ADD1)의 2자리),생일년도(MEM_BIR)별로 마일리지(MEM_MILEAGE)평균, 마일리지합계,
최고마일리지, 최소마일리지, 자료수를 검색
( Alias는 지역, 생일연도, 마일리지평균, 마일리지합계, 최고마일리지,최소마일리지, 자료수 )

SELECT SUBSTR(MEM_ADD1,1,2) AS 지역,
       MEM_BIR AS 생일년도,
       ROUND(AVG(MEM_MILEAGE),1) AS 마일리지평균,
       SUM(MEM_MILEAGE) AS 마일리지합계,
       MAX(MEM_MILEAGE) AS 최고마일리지,
       MIN(MEM_MILEAGE) AS 최소마일리지,
       COUNT(*) AS 자료수
  FROM MEMBER
 GROUP BY SUBSTR(MEM_ADD1,1,2), MEM_BIR;

16) 거래처(BUYER_NAME) 담당자(BUYER_CHARGER)가 NULL인 자료 검색 
(alias는 거래처, 담당자)

SELECT BUYER_NAME AS 거래처,
       BUYER_CHARGER AS 담당자
  FROM BUYER
 WHERE BUYER_CHARGER IS NULL;

16-1) 거래처(BUYER_NAME) 담당자(BUYER_CHARGER)가 NULL이 아닌 자료 검색
(alias는 거래처, 담당자)

SELECT BUYER_NAME AS 거래처,
       BUYER_CHARGER AS 담당자
  FROM BUYER
 WHERE BUYER_CHARGER IS NOT NULL;

17) 거래처(BUYER_NAME) 담당자(BUYER_CHARGER)가 없는 경우 ‘없다’로 치환하여 자료 검색(alias는 거래처, 담당자)

SELECT BUYER_NAME AS 거래처,
       NVL(BUYER_CHARGER, '없다') AS 담당자
  FROM BUYER;

18) 상품 분류(PROD_LGU) 중 앞의 두 글자가 'P1' 이면 판매가(PROD_SALE)를 10%인상하고 'P2' 이면 판매가를 15%인상하고
, 나머지는 동일 판매가로 검색   
(DECODE 함수 사용, Alias는 상품명(PROD_NAME), 판매가, 변경판매가 )

SELECT PROD_NAME AS 상품명,
       PROD_SALE AS 판매가,
       DECODE(SUBSTR(PROD_LGU,1,2), 'P1', PROD_SALE*1.1, 'P2', PROD_SALE*1.15) AS 변경판매가
  FROM PROD

19) 회원정보테이블(MEMBER)의 주민등록 뒷자리(MEM_REGNO2)(7자리 중 첫째자리)에서 성별 구분을 검색
( CASE 구문 사용, Alias는 회원명,주민등록번호(주민1-주민2), 성별 )

SELECT MEM_NAME AS 회원명,
       MEM_REGNO1 ||'-'|| MEM_REGNO2 AS 주민등록번호,
       CASE WHEN SUBSTR(MEM_REGNO2,1,1)= '1'  THEN '남자' ELSE '여자' END AS 성별
  FROM MEMBER;


----------------------------------------------------------------------

1) 상품테이블에서 상품코드, 상품명, 분류명을 조회.
가. 기본형식
SELECT A.PROD_ID 상품코드, A.PROD_NAME 상품명, B.LPROD_NM 분류명
  FROM PROD A, LPROD B
 WHERE A.PROD_LGU = B.LPROD_GU

나. ANSI형식
SELECT A.PROD_ID 상품코드, A.PROD_NAME 상품명, B.LPROD_NM 분류명
  FROM PROD A
 INNER JOIN LPROD B ON A.PROD_LGU = B.LPROD_GU

2) 상품테이블에서 상품코드, 상품명, 분류명, 거래처 명을 조회

가. 테이블명 사용
SELECT A.PROD_ID, A.PROD_NAME, B.LPROD_NM, C.BUYER_NAME
  FROM PROD A, LPROD B, BUYER C
 WHERE A.PROD_LGU = B.LPROD_GU
   AND A.PROD_LGU = C.BUYER_LGU

나. Alias 사용
SELECT A.PROD_ID 상품코드, A.PROD_NAME 상품명, B.LPROD_NM 분류명, C.BUYER_NAME 거래처명
  FROM PROD A, LPROD B, BUYER C
 WHERE A.PROD_LGU = B.LPROD_GU
   AND A.PROD_LGU = C.BUYER_LGU

다. ANSI형식
SELECT A.PROD_ID 상품코드, A.PROD_NAME 상품명, B.LPROD_NM 분류명, C.BUYER_NAME 거래처명
  FROM PROD A
 INNER JOIN LPROD B ON A.PROD_LGU = B.LPROD_GU
 INNER JOIN BUYER C ON A.PROD_LGU = C.BUYER_LGU
 

3) 상품테이블에서 거래처가 '삼성전자' 인 자료의 상품코드, 상품명, 거래처 명을 조회
SELECT A.PROD_ID 상품코드, A.PROD_NAME 상품명, C.BUYER_NAME 거래처명
  FROM PROD A, BUYER C
 WHERE A.PROD_LGU = C.BUYER_LGU
   AND C.BUYER_NAME = '삼성전자'

4) 상품테이블에서 거래처가 '삼성전자' 인 자료의 상품코드, 상품명, 거래처 명을 조회
SELECT A.PROD_ID 상품코드, A.PROD_NAME 상품명, C.BUYER_NAME 거래처명
  FROM PROD A, BUYER C
 WHERE A.PROD_LGU = C.BUYER_LGU
   AND C.BUYER_NAME = '삼성전자'


5) 상품테이블에서 상품코드, 상품명, 분류명, 거래처명, 거래처주소를 조회.

- 판매가격이 10만원 이하 이고
SELECT A.PROD_ID 상품코드, A.PROD_NAME 상품명, B.LPROD_NM 분류명, C.BUYER_NAME 거래처명, C.BUYER_ADD1 거래처주소
  FROM PROD A, LPROD B, BUYER C
 WHERE A.PROD_LGU = B.LPROD_GU
   AND A.PROD_LGU = C.BUYER_LGU
   AND A.PROD_PRICE <= 100000

- 거래처 주소가 부산인 경우만 조회
SELECT A.PROD_ID 상품코드, A.PROD_NAME 상품명, B.LPROD_NM 분류명, C.BUYER_NAME 거래처명, C.BUYER_ADD1 거래처주소
  FROM PROD A, LPROD B, BUYER C
 WHERE A.PROD_LGU = B.LPROD_GU
   AND A.PROD_LGU = C.BUYER_LGU
   AND A.PROD_PRICE <= 100000
   AND C.BUYER_ADD1 LIKE '부산%'

6) 상품 분류가 전자제품(P102 )인 상품의 상품코드, 상품명, 분류명, 거래처 명을 조회.
SELECT A.PROD_ID 상품코드, A.PROD_NAME 상품명, B.LPROD_NM 분류명, C.BUYER_NAME 거래처명
  FROM PROD A, LPROD B, BUYER C
 WHERE A.PROD_LGU = B.LPROD_GU
   AND A.PROD_LGU = C.BUYER_LGU
   AND B.LPROD_GU = 'P102'


7) 상품입고테이블(BUYPROD)의 2005년도 1월의 거래처별(거래처코드, 거래처명) 매입금액을 검색( 매입금액 = 매입수량 * 매입단가 )
( Alias는 거래처코드, 거래처명, 매입금액 )

가. EQUAL JOIN 사용
SELECT C.BUYER_ID 거래처코드, C.BUYER_NAME 거래처명, SUM(A.BUY_QTY*A.BUY_COST) 매입금액
  FROM BUYPROD A, PROD B, BUYER C
 WHERE BUY_DATE BETWEEN '20050101' AND '20050131'
   AND A.BUY_PROD = B.PROD_ID
   AND B.PROD_LGU = C.BUYER_LGU
 GROUP BY C.BUYER_ID, C.BUYER_NAME

나) INNER JOIN 사용
SELECT C.BUYER_ID 거래처코드, C.BUYER_NAME 거래처명, SUM(A.BUY_QTY*A.BUY_COST) 매입금액
  FROM BUYPROD A
 INNER JOIN PROD B ON A.BUY_PROD = B.PROD_ID
 INNER JOIN BUYER C ON B.PROD_LGU = C.BUYER_LGU
 WHERE BUY_DATE BETWEEN '20050101' AND '20050131'
 GROUP BY C.BUYER_ID, C.BUYER_NAME


8) 장바구니테이블의 2005년도 5월의 회원별 구매금액을 검색( 구매금액 = 구매수량 * 판매가 )
( Alias는 회원ID, 회원명, 구매금액 )

(Equi Join 방식과 Inner Join 방식 중 선택)
SELECT B.MEM_ID 회원ID, B.MEM_NAME 회원명, SUM(C.PROD_PRICE*A.CART_QTY) 구매금액
  FROM CART A, MEMBER B, PROD C
 WHERE A.CART_MEMBER = B.MEM_ID
   AND C.PROD_ID = A.CART_PROD
   AND A.CART_NO LIKE '200505%'
 GROUP BY B.MEM_ID, B.MEM_NAME

9) OUTER JOIN 

10) 전체 분류의 상품자료 수 를 검색 조회( Alias는 분류코드, 분류명, 상품자료수 )

가. 분류테이블 조회
SELECT *
  FROM LPROD

나. EQUAL JOIN
SELECT A.LPROD_GU, A.LPROD_NM, COUNT(PROD_ID)
  FROM LPROD A, PROD B
 WHERE A.LPROD_GU = B.PROD_LGU
 GROUP BY A.LPROD_GU, A.LPROD_NM

다. OUTER JOIN
SELECT A.LPROD_GU, A.LPROD_NM, COUNT(PROD_ID)
  FROM LPROD A, PROD B
 WHERE A.LPROD_GU = B.PROD_LGU(+)
 GROUP BY A.LPROD_GU, A.LPROD_NM

라. ANSI OUTER JOIN
SELECT A.LPROD_GU, A.LPROD_NM, COUNT(PROD_ID)
  FROM LPROD A
  LEFT OUTER JOIN PROD B ON A.LPROD_GU = B.PROD_LGU(+)
 GROUP BY A.LPROD_GU, A.LPROD_NM


11) 전체상품의 2005년 1월 입고수량을 검색 조회( Alias는 상품코드, 상품명, 입고수량 )
SELECT A.PROD_ID 상품코드, A.PROD_NAME 상품명, SUM(B.BUY_QTY) 입고수량
  FROM PROD A, BUYPROD B
 WHERE A.PROD_INSDATE BETWEEN '20050101' AND '20050131'
   AND A.PROD_ID = B.BUY_PROD
 GROUP BY A.PROD_ID, A.PROD_NAME


12) 전체 상품의 2005년도 1월 5일의 입고.출고현황 조회(상품코드, 상품명, 입고수량의 합, 판매수량의 합 )

- 입고 확인(Equi Join)
SELECT A.PROD_ID 상품코드, A.PROD_NAME 상품명, SUM(B.BUY_QTY) 입고수량, SUM(C.CART_QTY) 판매수량
  FROM PROD A, BUYPROD B, CART C 
 WHERE A.PROD_INSDATE = '20050105'
   AND A.PROD_ID = B.BUY_PROD
   AND A.PROD_ID = C.CART_PROD
 GROUP BY A.PROD_ID, A.PROD_NAME

- 판매 확인(Inner Join)
SELECT A.PROD_ID 상품코드, A.PROD_NAME 상품명, SUM(B.BUY_QTY) 입고수량, SUM(C.CART_QTY) 판매수량
  FROM PROD A
 INNER JOIN BUYPROD B ON A.PROD_ID = B.BUY_PROD
 INNER JOIN CART C ON A.PROD_ID = C.CART_PROD
 WHERE A.PROD_INSDATE = '20050105'
 GROUP BY A.PROD_ID, A.PROD_NAME

13) 거래처의 2005년도 1월의 거래처별 일자별 매입현황 조회 ( 거래처명, 매입일자, 매입금액 )
SELECT C.BUYER_NAME, B.BUY_DATE, SUM(B.BUY_QTY*B.BUY_COST)
  FROM PROD A, BUYPROD B, BUYER C
 WHERE A.PROD_ID = B.BUY_PROD
   AND A.PROD_BUYER = C.BUYER_ID
   AND B.BUY_DATE BETWEEN '20050101' AND '20050131'
 GROUP BY C.BUYER_NAME, B.BUY_DATE


14) 2005년도 월별 판매 현황을 검색
(Alias는 판매월, 판매수량, 판매금액(판매수량*상품테이블의 판매가))
SELECT SUBSTR(A.CART_NO, 5,2), SUM(A.CART_QTY), SUM(A.CART_QTY*B.PROD_PRICE)
  FROM CART A, PROD B
 WHERE A.CART_PROD = B.PROD_ID
 GROUP BY SUBSTR(A.CART_NO, 5,2)


15) 상품분류가 컴퓨터제품('P101')인 상품의 2005년도 일자별 판매 조회
( 판매일, 판매금액(5,000,000초과의 경우만), 판매수량 )
SELECT A.CART_NO, SUM(A.CART_QTY), SUM(A.CART_QTY*B.PROD_PRICE)
  FROM CART A, PROD B
 WHERE A.CART_PROD = B.PROD_ID
   AND B.PROD_LGU = 'P101'
 GROUP BY A.CART_NO
 HAVING SUM(A.CART_QTY*B.PROD_PRICE) > 5000000



