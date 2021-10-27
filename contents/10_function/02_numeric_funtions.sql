숫자형 함수
1. 수학적함수
   ABS(n), SIGN(n), POWER(n,m), SQRT(n)
-- 절대값 / 음수(-1) 0 양수(1)/ n^m 거듭제곱 / 평방근(루트)

예)
SELECT ABS(-205),
       SIGN(50000),
       SIGN(-0.0006),
       SIGN(0),
       POWER(2,10),
       SQRT(56*3)
  FROM DUAL;
  
2.GREATEST, LEAST
 - 주어진 자료 중 최소값, 최대값 반환
 (사용예)
 SELECT GREATEST('대한민국','미국','일본','필리핀') FROM DUAL; --가나다순으로 처리
 -- GREATEST는 이미알고있는 자료중 최대값을 구하는것 --거의 안씀
 -- MAX 불특정 자료들 중 가장 큰값을 구하는것
 
 회원테이블에서 가장 큰 마일리지 값을 조회하시오
 -- GREATEST는 ,로 다적어줘야한다.
 
 SELECT MAX (MEM_MILEAGE) FROM MEMBER;
 
 
 --집계함수와 반드시 일반항목이 같이나와야 그룹바이사용해야한다 
 
 
 SELECT MEM_NAME,
        MAX(MEM_MILEAGE)
   FROM MEMBER
 GROUP BY MEM_NAME;
 
 
  SELECT MEM_NAME,
         A.MAXMILE
   FROM SELECT MAX(MEM_MILEAGE) AS A.MAXMLLE,
        FORM MOMBER, MEMBER 9
  WHERE A.MAXILL=B.MEM_MILAGAE
 
 
 SELECT LEAST(1000,800,3200,8700) FROM DUAL;
 
 문제]회원테이블에서 마일리지가 1000보다 작은경우 1000으로 변경하여 조회하시오
     Alias는 회원번호, 회원명, 직업, 마일리지, 변경된마일리지 
 
 SELECT MEM_ID AS 회원번호,
        MEM_NAME AS 회원명,
        MEM_JOB AS 직업,
        MEM_MILEAGE AS 마일리지,
        GREATEST(MEM_MILEAGE, 1000) AS 변경된마일리지  -- 작은것이 1000값으로 변경된다. 큰값은 그대로출력
   FROM MEMBER ;


3.ROUND, TRUNC
 - 반올림(ROUND)과 절삭(TRUNC)한 값을 반환
 1)ROUND(n[,m])
   . m이 양의 정수인 경우 n의 값 중 소숫점 m+1자리에서 반올림하여 m자리까지 수를 반환
   . m이 생략되면 0으로 간주
   . m이 음수이면 소숫점 이상(정수부분) m자리에서 반올림(소숫점이하는 삭제)
 2)TRUNC(n[,m])
   . m이 양의 정수인 경우 n의 값 중 소숫점 m+1자리에서 절삭하여 m자리까지 수를 반환
   . m이 생략되면 0으로 간주
   . m이 음수이면 소숫점 이상(정수부분) m자리에서 절삭(소숫점이하는 삭제)
 
 예)사원테이블의 급여가 월급여액으로 가정하고 주급으로 급여를 지급하려 한다.
    사원들에게 지급할 주급액을 계산하여 주급이 1000이상인 사원을 조회하시오
    주급액은 소숫점 2자리에서 반올림하시오
    Alias는 사원번호, 사원명, 월급여액, 주급액, 직무코드

SELECT EMPLOYEE_ID AS 사원번호,
       EMP_NAME AS 사원명,
       SALARY AS 월급여액,
       ROUND(SALARY/4,1) AS 주급액,
       JOB_ID AS 직무코드
  FROM EMPLOYEES
 WHERE ROUND(SALARY/4,1) >= 1000;
  

예)상품테이블에서 분류코드 'P202'에 속한 상품들을 할인판매 하려한다.
   할인율이 18%일때 각 상품의 할인 판매가를 조회하시오
   Alias는 상품명, 할인전가격, 할인후가격, 할인가격
   단, 할인가격은 10원단위까지 계산
   
SELECT PROD_NAME AS 상품명,
       PROD_PRICE AS 할인전가격,
       PROD_PRICE - ROUND((PROD_PRICE*0.013),-1) AS "할인후가격(ROUND)",
       PROD_PRICE - TRUNC((PROD_PRICE*0.013),-1) AS "할인후가격(TRUNC)",
       ROUND((PROD_PRICE*0.013),-1) AS "할인가격(ROUND)",
       TRUNC((PROD_PRICE*0.013),-1) AS "할인가격(TRUNC)",
       PROD_PRICE*0.013 AS 할인가격
  FROM PROD 
 WHERE UPPER(PROD_LGU)='P202';  -- 실제데이타기준으로 컬럼명을 바꿔준다.
 
 예)각 상품별 이익률을 조회하시오
    이익률(조수익률)=(매출가-매입가)/매입가
    이익률은 소수2자리까지 구하여(반올림) %단위로 출력
    Alias는 상품명, 매입가, 매출가, 조수익, 이익률 
 
 SELECT PROD_NAME AS 상품명,
        PROD_COST AS 매입가,
        PROD_PRICE AS 매출가,
        PROD_PRICE - PROD_COST AS 조수익,
        ROUND(((PROD_PRICE - PROD_COST)/PROD_COST),2)*100 || '%' AS 이익률
   FROM PROD;
 
4. CEIL, FLOOR
  - 가장 가까운 정수를 구하는 함수 
  - 세금, 급여등 금액에 관련된 계산에 주로 사용
 
  1) CEIL(n)
   . n과 같거나 큰 쪽에서 가장 가까운 정수를 반환한다.
  예)
  SELECT CEIL(10.34), CEIL(10), CEIL(-10.34) FROM DUAL; -- 큰쪽에서 가장 먼저 만나는 정수

  2) FLOOR(n)
   . n과 같거나 작은쪽에서 가장 가까운 정수 반환한다.
  예)
  SELECT FLOOR(10.34), FLOOR(10), FLOOR(-10.34) FROM DUAL;  -- 작은쪽에서 가장 먼저 만나는 정수
 
5. MOD, REMAINDER
  - 나머지를 구할때 사용
  - 자바의 '%'연산자 역활
  - 내부적으로 구현 방법이 다름
  (1) MOD
    MOD(n, c) = n - c * FLOOR(n / c)  -- n을 c로 나눈 나머지
    예) MOD(14 , 5)            -- 내부적으로 FLOOR 사용된다
        = 14 - 5 * FLOOR(14/5)
        = 14 - 5 * FLOOR(2.8)
        = 14 - 5 * 2
        = 4
    SELECT MOD(14, 5) FROM DUAL; 
          
 (2) REMAINDER(n, c)
    REMAINDER(n, c) = n - c * ROUND(n / c)  -- ROUND(10) 소수 첫재짜리에서 반올림 = ROUND(10, 0)
    예) REMAINDER(14, 5)    -- 몫이 3이되기위해서 더해져야할 수??
        = 14 - 5 * ROUND(14/5)
        = 14 - 5 * ROUND(2.8)
        = 14 - 5 * 3
        = 14 - 15
        = -1
   
       REMAINDER(12, 5)    
        = 12 - 5 * ROUND(12/5)
        = 12 - 5 * ROUND(2.4)
        = 12 - 5 * 2
        = 12 - 10
        = 2 
 
       REMAINDER(13, 5)    
        = 13 - 5 * ROUND(12/5)
        = 13 - 5 * ROUND(2.6)
        = 13 - 5 * 3
        = 13 - 15
        = -2  
 
  SELECT REMAINDER(14, 5), REMAINDER(13, 5), REMAINDER(12, 5) FROM DUAL;
 
 
6. WIDTH_BUCKET
  - 주어진 자료에 대하여 구간을 구하고 어느 구간에 주어진 값이 속하는 지를 반환
  (사용형식)
  WIDTH_BUCKET(c, min, max, b) 
   . c : 주어진 수 또는 컬럼명
   . min : 구간의 하한 값
   . max : 구간의 상한 값
   . b : 구간의 갯수
   
 예) 회원테이블에서 마일리지를 1000~9000사이의 구간을 9개로 구분한 후
     회원들의 마일리지가 어느 구간에 속하는지를 조회하시오
     Alias는 회원명, 마일리지, 등급
     등급은 반환된 구간값에 '등급'문자열을 결합하여 출력
     
 SELECT MEM_NAME AS 회원명,
        MEM_MILEAGE AS 마일리지,
        WIDTH_BUCKET(MEM_MILEAGE, 9000, 1000, 9) ||'등급' AS 등급 
                    -- 하한값과 상한값의 위치를 반대로해주면 역순으로 받을수있다.
   FROM MEMBER;   -- 전체회원이니까 WHERE절 불필요   
     
 예) 회원테이블에서 마일리지를 500~9000사이의 구간을 4개로 구분한 후
     회원들의 마일리지가 어느 구간에 속하는지를 조회하시오
     Alias는 회원명, 마일리지, 등급
     등급은 반환된 구간값이 1이면 'vip 회원' 2이면 '정회원' 
                        3이면 '준회원' 4이면 '새싹회원'이라고 출력     
     
 SELECT MEM_NAME AS 회원명,
        MEM_MILEAGE AS 마일리지,
   CASE WHEN WIDTH_BUCKET(MEM_MILEAGE, 9000, 500, 4) = 1 THEN 'vip회원'
        WHEN WIDTH_BUCKET(MEM_MILEAGE, 9000, 500, 4) = 2 THEN '정회원'
        WHEN WIDTH_BUCKET(MEM_MILEAGE, 9000, 500, 4) = 3 THEN '준회원'
        ELSE '새싹회원'       
        END AS 등급                     
   FROM MEMBER;     
 
 
 
 
 