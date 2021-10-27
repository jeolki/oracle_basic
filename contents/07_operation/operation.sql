1.연산자

1). 산술 연산자.
 - 응용 프로그램언어의 산술연산자와 종류 및 기능이 같다
 - 조회되는 컬럼의 값을 대상으로 연산함
 - +,-,/,*,()로 구성
 
예) 회원테이블에서 회원들에게 마일리지를 1000씩 추가 지급하려 한다.
    Alias 는 회원번호, 회원명, 기존마일리지, 최종마일리지
    
    SELECT MEM_ID AS 회원번호,          --풀네임 ; 로그인계정, 테이블명 
           MEM_NAME AS 회원명,
           MEM_MILEAGE AS "기존 마일리지",         --공백이 들어갔다 ""로붙임
           MEM_MILEAGE+1000 AS "최종 마일리지"       --마지막 컬럼은 ,가없다
      FROM MEMBER;
      
예) 매입자료(BUYPROD)에서 2005년 1월 16일 매입정보를 조회하시오 --조건이 주어짐 
    Alias는 상품코드, 수량, 단가, 금액이다
    금액은 수량 * 단가 이다.

    SELECT BUY_PROD AS 상품코드, 
           BUY_QTY AS 수량,
           BUY_COST AS 단가,
           BUY_QTY * BUY_COST AS 금액
      FROM BUYPROD
     WHERE BUY_DATE=TO_DATE('20050116') --조건 , 주어진 문자열을 날짜타입으로 변환 TO_DATE


예) 사원테이블(EMPLOYEES)에서 사원들의 영업실적(COMMISSION_PCT)
    에 따른 보너스를 계산하여 지급액을 조회하려한다.
    보너스 = 본봉 * 영업실적
    지급액 = 본봉 + 보너스

    Alias는 사원번호, 사원명, 부서코드, 본봉, 보너스, 지급액이다.

    SELECT EMPLOYEE_ID AS 사원번호,
           EMP_NAME AS 사원명
           DEPARTMENT_ID AS 부서코드
           SALARY AS 본봉
           NVL(SALARY * COMMISSION_PCT,0) AS 보너스, -- NULL 값이 이어서 INT와NULL의 결과NULL// NVL처리해준다.
           SALARY + NVL((SALARY * COMMISSION_PCT),0) AS 지급액 
     FORM  EMPLOYES;
    
예) 회원테이블에서 회원들의 주민등록번호를 이용하여 나이를 계산하시오
    Alisa는 회원번호, 회원명, 주민번호1, 나이, 직업
    
    SELECT MEM_ID AS 회원번호, 
           MEM_NAME AS 회원명, 
           MEM_REGNO1 AS 주민번호1,
           EXTRACT(YEAR FROM SYSDATE)-               -- SYSDATE에서 YEAR 정보만 가져오기
             TO_NUMBER('19'||SUBSTR(MEM_REGNO1,1,2)) AS 나이,   -- 문자열에서 떼어내서 19를 앞에다 더한것 + =>|| 에 숫자로변경
           MEM_JOB AS 직업   
      FROM MEMBER;
    
2). 관계 연산자
 - 항목의 대소관계를 비교
 - >,<,=,>=,<=,!=(<>) 
 - 결과는 TRUE, FALSE -- SELECT 절에서는 못쓴다 조건절에서만 사용 오라클은 BOOLEAN 이 없다 
 - WHERE, HAVING절 및 표현식 CASE WHEN ~ THEN 에서 조건 기술에 사용
 
예) 사원테이블에서 급여가 5000이상인 사원을 조회하시오  --크거나 같다
    Alias 사원번호, 사원명, 직책코드, 급여

    SELECT EMPLOYEE_ID AS 사원번호, 
           EMP_NAME AS 사원명,
           JOB_ID AS 직책코드,
           SALARY AS 급여
      FROM EMPLOYEES
     WHERE SALARY >= 5000;     --반드시 부등호가 앞 >=, <=

예) 234567 * 94754 / 23을 구하시오  -- 가상의 테이블 DUAL 사용한다
    SELECT 234567 * 94754 / 23
      FROM DUAL;  
    
    
예) 회원테이블에서 여성회원정보를 조회하시오
    Alias는 회원번호, 회원명, 마일리지, 비고
    비고에는 '여성회원'이라는 메시지를 출력하시오
    
    SELECT MEM_ID AS 회원번호,
           MEM_NAME AS 회원명,
           MEM_MILEAGE AS 마일리지,
           '여성회원' AS 비고   -- 테이블에 비고의 칸이없으면 내용을 바로 넣어준다.
      FROM MEMBER
     WHERE SUBSTR(MEM_REGNO2,1,1)='2'  -- 문자열이기때문에 비교대상도 문자가 되어야한다.
        OR SUBSTR(MEM_REGNO2,1,1)='4';
    
예) 회원테이블에서 회원정보를 조회하시오
    Alias는 회원번호, 회원명, 마일리지, 성별
    성별에는 '여성회원' 또는 '남성회원'을 출력하시오  --조건이없다. -- CASE WHEN THEN ELSE END사용

    SELECT MEM_ID AS 회원번호,
           MEM_NAME AS 회원명,
           MEM_MILEAGE AS 마일리지,
           CASE WHEN (SUBSTR(MEM_REGNO2,1,1)='2' OR
                      SUBSTR(MEM_REGNO2,1,1)='4') THEN '여성회원'
                ELSE '남성회원' END AS 성별  
      FROM MEMBER;


3). 논리 연산자
  - 조건이 2개 이상 연결되는 경우 사용(AND,OR)
  - 조건의 결과를 부정하는 경우(NOT)
  (진리표)
---------------------------
   입력          출력
  A   B      AND    OR     
---------------------------  
  F   F       F     F
  F   T       F     T
  T   F       F     T
  T   T       T     T
  

예) 키보드로 본인의 출생년도를 입력하면 윤년인지 평년인지 구별하여
    '평년입니다' 또는 '윤년입니다'라는 메시지를 출력하는 쿼리작성
    
ACCEPT P_YEAR PROMPT '출생년도 : ' --세미콜롬 안들어감
DECLARE
  V_YEAR  NUMBER := TO_NUMBER('&P_YEAR');
  V_MESSAGE VARCHAR2(50);
BEGIN
  IF (MOD(V_YEAR,4)=0  AND MOD(V_YEAR,100)!=0) OR (MOD(V_YEAR,400)=0) THEN --MOD 나머지
     V_MESSAGE := V_YEAR||' 년도는 윤년입니다';  -- || 문자열더하기
  ELSE
     V_MESSAGE := V_YEAR||' 년도는 평년입니다';
  END IF;
  
  DBMS_OUTPUT.PUT_LINE(V_MESSAGE);  --보기메뉴에서 DBMS출력창 활성화시켜줘야 한다.
END;















  
  