그룹함수
1. ROLLUP
  - 그룹별 소계와 총계를 반환
  (사용형식)
  SELECT 컬럼명1, 컬럼명2, 집계함수
    FROM 테이블명
  [WHERE 조건]
   GROUP BY [컬럼명...]ROLLUP(컬럼명,...)
   . ROLLUP다음 ( )안에 기술된 순서에 따른 (오른쪽->왼쪽) 레벨별 집계처리를 반환
   . ROLLUP다음 ( )안에 n개의 컬럼이 사용된 경우 n+1개의 종류 만큼 집계반환
   EX)ROLLUP(PERIOD,REGION,GUBUN)을 기술한 경우
      'GUBUN'을 기준으로 집계 한 후 'REGION,GUBUN'으로 집계 후
      'PERIOD,REGION,GUBUN'으로 집계를 반환한 후 전체집계 반환
      
      
예)KOR_LOAN_STATUS 테이블에서 ROLLUP을 사용하여 기간, 지역별 대출잔액 집계를 조회하시오
(일반 GROUP BY절 사용)
SELECT PERIOD AS 기간,
       REGION AS 지역,
       GUBUN AS 대출구분,
       SUM(LOAN_JAN_AMT) AS 대출잔액
  FROM KOR_LOAN_STATUS
 WHERE SUBSTR(PERIOD,1,4)='2011'
 GROUP BY PERIOD, REGION,GUBUN
 ORDER BY 1;

(ROLLUP GROUP BY절 사용)
SELECT PERIOD AS 기간,
       REGION AS 지역,
       GUBUN AS 대출구분,
       SUM(LOAN_JAN_AMT) AS 대출잔액
  FROM KOR_LOAN_STATUS
 WHERE SUBSTR(PERIOD,1,4)='2011'
 GROUP BY ROLLUP(PERIOD, REGION, GUBUN)
 ORDER BY 1;

SELECT PERIOD AS 기간,
       REGION AS 지역,
       GUBUN AS 대출구분,
       SUM(LOAN_JAN_AMT) AS 대출잔액
  FROM KOR_LOAN_STATUS
 WHERE SUBSTR(PERIOD,1,4)='2011'
 GROUP BY PERIOD, ROLLUP(REGION, GUBUN)
 ORDER BY 1;
 -- 부분 ROLLUP



2. CUBE
  - ROLLUP 과 사용형식은 동일
  - CUBE다음 ( )안에 사용된 컬럼의 수의 제곱한 결과와 같은 종류의 집계반환
    (모든 경우의 집계종류별 결과 반환)
  (사용형식)

-- CUBE 사용
SELECT PERIOD AS 기간,
       REGION AS 지역,
       GUBUN AS 대출구분,
       SUM(LOAN_JAN_AMT) AS 대출잔액
  FROM KOR_LOAN_STATUS
 WHERE SUBSTR(PERIOD,1,4)='2011'
 GROUP BY CUBE(PERIOD, REGION, GUBUN)
 ORDER BY 1;
--2^3 8종류의 집계처리

