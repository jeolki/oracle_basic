 변환함수
 - 데이터의 형 변환을 담당
 - CAST, TO_DATE, TO_CHAR, TO_NUMBER


SELECT * FROM EMPLOYEES
 WHERE HIRE_DATE >= '20050101'  
 -- 문자열과 날짜타입이만남// 이항연산이 수행될대에는 연산자보다 각각의 데이터타입을 일치시키는것이 먼저일어남 
 -- '20050101'이 날짜형으로 형변환 후에 비교가 일어난다. 묵시적으로 형변함 -- 오라클은 문자열이 우선이아니다
 -- 오라클에서는 숫자가 우선이다.
 
SELECT '20'+7 FROM dual;    --27
 -- 문자열이 숫자로 변하고 연산이 이루어진다 -- 묵시적 형변환
 
 1) CAST
  . 명시적 형 변환 함수
  (사용형식)
  CAST(expr  AS  type)
  . 'expr'로 표현된 데이터를 'type'형식의 자료로 변환  
  -- expr은 수식,컬럼명,함수,데이터,문자열 다될수있다
  -- 오라클에서 사용되는 데이터타입의 형식으로 자료를 변환
  
예)분류테이블(LPROD)의 분류순번(LPROD_ID)을 CHAR(5)로 변환하시오

SELECT LPROD_ID AS 순번 , CAST(LPROD_ID AS CHAR(5)) AS 순번 FROM LPROD;  
-- 남는기억공간 오른편에 빈공간 4자리가 들어감
-- 숫자는 오른쪽정렬
-- 문자는 왼쪽정렬


 2) TO_CHAR
  . 숫자나 날짜 타입의 데이터를 문자열로 변환
  (사용형식)
  TO_CHAR(d [,fmt])   -- 화폐기호나 재무재표표시 괄호표시 
   - 'fmt' 변환할 형식지정 문자열
   ** 날짜 변환형식
----------------------------------------------------------------
     format              설명                  사용예
----------------------------------------------------------------
    AM, A.M.             오전            TO_CHAR(SYSDATE, 'AM')
    PM, P.M.             오후            TO_CHAR(SYSDATE, 'PM') 
 Y, YY, YYY, YYYY        년도            TO_CHAR(SYSDATE, 'YY') 
   MONTH, MON             월             TO_CHAR(SYSDATE, 'MONTH')  --> 6월
    MM               01-12형태의 월       TO_CHAR(SYSDATE, 'MM')  --> 06
    D                 주중의 일자          TO_CHAR(SYSDATE, 'D') -->화요일-> 3 //일요일 = 1
    DD                월중의 일자          TO_CHAR(SYSDATE, 'DD') --> 16 오늘의 일자
    DDD               연중의 일자          TO_CHAR(SYSDATE, 'DDD') --> 1월1일기준 몇일지낫나
    DL               현재년월일+요일        TO_CHAR(SYSDATE, 'DL') 
    BC, AD, CC           세기             TO_CHAR(SYSDATE, 'CC')   --> 21
    Q                    분기             TO_CHAR(SYSDATE, 'Q')  --> 2
  HH, HH12, HH24         시간             TO_CHAR(SYSDATE, 'HH') -- HH=HH12
    MI                    분              TO_CHAR(SYSDATE, 'MI')
    SS                    초              TO_CHAR(SYSDATE, 'SS')
------------------------------------------------------------------
 ** 사용자지정 문자열은 " "로  묶어 정의 해야함   
         
    
 SELECT TO_CHAR(SYSDATE, 'PM') FROM DUAL; -- AM의 형식대로 출력하라 -- 오전 오후 판별해서 출력하라 
 SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') FROM DUAL; --공백도 하나의 문자열로 인식
 
 SELECT TO_CHAR(SYSDATE, 'YYYY"년" MM"월" DD"일" HH24:MI:SS') FROM DUAL; --문자열추가정의 ""로 묶어서 정의
 
 
 SELECT TO_CHAR(SYSDATE, 'Y-MONTH PM'), -- 여러개를 조합사용해도 상관없다.
        TO_CHAR(SYSDATE, 'YY-MON PM'),      -- 환경설정 데이터베이스의 NLS에서 표시언어셋팅을 바꿔주면 표시되는것도 바뀐다.
        TO_CHAR(SYSDATE, 'YYYY-MM DD DDD PM'),
        TO_CHAR(SYSDATE, 'YYYY/MM/DD'),
        TO_CHAR(SYSDATE, 'DL PM'),
        TO_CHAR(SYSDATE, 'CC'),
        TO_CHAR(SYSDATE, 'Q')
   FROM DUAL; 


    
   ** 숫자 변환형식
----------------------------------------------------------------
     format                       설명                   
----------------------------------------------------------------
       9           대응되는 데이터가 유효 숫자이면 유효숫자를
                   무효의 '0'이면 공백을 출력
       0           대응되는 데이터가 유효 숫자이면 유효숫자를
                   무효의 '0'이면 '0'을 출력
   ,(COMMA)        3자리 마다 자리구별을 위한 자리점
   .(소숫점)        소숫점 표현
       PR          음수 표현시 '< >'로 묶어 표현
       $, L        화폐기호를 삽입하여 출력 -- 달러사인을 가장 왼쪽에 기입 // L은 NLS에서 설정한 화폐기호
      
      
                   
예) 상품테이블에서 상품의 가격을 조회하시오
   SELECT PROD_NAME,
          TO_CHAR(PROD_PRICE,'99,999,999.99') AS 가격1, -- 8자리로 출력하세요 값을 모르니 넉넉히
          TO_CHAR(PROD_PRICE,'00,000,000.00') AS 가격2   -- 앞에 0이 출력된다.
     FROM PROD
    WHERE PROD_LGU = 'P101';

   SELECT TO_CHAR(0, '999') FROM DUAL;  -- 0 이 하나 유효의 0이라고 처리

예) KOR_LOAN_STATUS 테이블에서 2013년도 10월 각 시도의 대출잔액을 조회하시오
 SELECT REGION, GUBUN, 
        TO_CHAR(LOAN_JAN_AMT, 'L99,999,999.9') AS 대출잔액  -- 원화화폐단위 출력
   FROM KOR_LOAN_STATUS
  WHERE PERIOD = '201310'
  ORDER BY 1 ; -- 컬럼인덱스 1번인 REGION을 가지고 ASC 오름차순으로 정렬하십시오 ASC 생략된것

예) KOR_LOAN_STATUS 테이블에서 2013년도 10월 
    각 시도의 평균대출잔액과 평균 대출잔액과의 편차를 계산하여 조회
 
 (2013년도 10월 각 시도의 평균대출잔액)
 SELECT PERIOD,
        ROUND(AVG(LOAN_JAN_AMT),1) AS LAVG
   FROM KOR_LOAN_STATUS
  WHERE PERIOD = '201310'
  GROUP BY PERIOD;
 
 (2013년도 10월 각 시도별 대출잔액 합계)
 SELECT REGION, PERIOD,
        SUM(LOAN_JAN_AMT) AS LSUM
   FROM KOR_LOAN_STATUS
  WHERE PERIOD = '201310'
  GROUP BY REGION, PERIOD
  ORDER BY 1;
        
 (각 시도별 편차)
 SELECT REGION AS 지역,
        TO_CHAR(TBLA.LSUM, '9,999,999.9') AS 대출잔액합계,
        TO_CHAR(TBLB.LAVG, '99,999.9') AS 평균대출잔액,
        TO_CHAR(TBLB.LAVG-TBLA.LSUM, '9,999,999.9PR') AS 편차 -- PR 사용의 예
   FROM ( SELECT REGION, PERIOD,
                 SUM(LOAN_JAN_AMT) AS LSUM
            FROM KOR_LOAN_STATUS
           WHERE PERIOD = '201310'
           GROUP BY REGION, PERIOD
           ORDER BY 1 ) TBLA,
        ( SELECT PERIOD,
                 ROUND(AVG(LOAN_JAN_AMT),1) AS LAVG
            FROM KOR_LOAN_STATUS
           WHERE PERIOD = '201310'
           GROUP BY PERIOD ) TBLB
  WHERE TBLA.PERIOD = TBLB.PERIOD; 
 
 3) TO_NUMBER
  . 문자열로 자료를 숫자로 변환
  . 원본자료(문자열)에 숫자로 변환될 수 없는 기호나 문자가 없어야 함 -- 숫자로 변환가능한 데이터만
  (사용형식)
  TO_NUMBER(d [,fmt])
  - 'fmt'는 TO_CHAR의 숫자변환형식과 동일
  
예) 사원테이블에서 전화번호('PHONE_NUMBER')를 숫자로 변환하시오
SELECT TO_NUMBER(REPLACE(PHONE_NUMBER, '.')) AS 전화번호
  FROM EMPLOYEES;

예) 제품분류코드 'P102'에 속한 새로운 제품을 상품테이블(PROD)에 등록
    하려고 한다. 이때 새로운 제품의 상품코드를 생성하시오 

SELECT CONCAT('P102',TRIM(TO_CHAR((TO_NUMBER(SUBSTR(MAX(PROD_ID),5,6))+1),'000000'))) AS 제품코드
--     'P102'||TRIM(TO_CHAR((TO_NUMBER(SUBSTR(MAX(PROD_ID),5,6))+1),'000000')) AS 제품코드
  FROM PROD
 WHERE PROD_LGU = 'P102';
--     PROD_ID LIKE 'P102%';


 4) TO_DATE
  . 문자열 자료를 기본 날짜형(년월일)으로 변환
  . 반드시 8글자 필요 -- 날짜로 변환되어질수 있는 문자열 // 숫자이외의 다른 문자 포함하면 안됨
  (사용형식)
  TO_DATE(d [,fmt])
  
 예) 판매정보테이블(CART)에서 카드번호컬럼(CART_NO)을 이용하여 판매일을 구하고 
     2005년 4월 1일부터 4월 15일 사이에 발생된 판매 건수를 구하시오.
SELECT COUNT(*) AS 판매건수  -- 행의 갯수 
  FROM CART
 WHERE TO_DATE(SUBSTR(CART_NO, 1, 8)) BETWEEN TO_DATE('20050401') AND TO_DATE('20050415') ;

 (구매회원수)
SELECT COUNT(DISTINCT(CART_MEMBER)) AS 구매회원수  -- 행의 갯수 -- 중복제거 DISTINCT
  FROM CART
 WHERE TO_DATE(SUBSTR(CART_NO, 1, 8)) BETWEEN TO_DATE('20050401') AND TO_DATE('20050415') ; 
 
 
 (구매회원)
SELECT DISTINCT(CART_MEMBER) AS 구매회원  --  중복제거 DISTINCT
  FROM CART
 WHERE TO_DATE(SUBSTR(CART_NO, 1, 8)) BETWEEN TO_DATE('20050401') AND TO_DATE('20050415') 
 ORDER BY 1;
 
 
    