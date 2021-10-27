날짜함수
1. SYSDATE
  - 시스템이 제공하는 날짜정보(년,월,일,시,분,초)
  - 덧셈과 뺄셈의 대상이 될 수 있다.('/'와 '*'는 허용되지 않음)
  - 출력은 년월일까지만 출력(시분초까지 출력하기 위하여 TO_CHAR함수가 필요)

예)사원들의 입사일을 기준으로 오늘날짜에서 한달 이내에 입사한 사원들에게 
   특별 상여금을 지급하려한다. 
   Alias는 사원번호, 이름, 부서번호, 급여, 상여금, 지급액
   단, 상여금은 본봉의 10%이다.
   
SELECT EMPLOYEE_ID AS 사원번호,
       EMP_NAME AS 이름,
       DEPARTMENT_ID AS 부서번호,
       HIRE_DATE AS 입사일,
       SALARY AS 급여,
       SALARY *0.1 AS 상여금,
       SALARY + (SALARY*0.1) AS지급액
  FROM EMPLOYEES
 WHERE EXTRACT(MONTH FROM HIRE_DATE) = EXTRACT(MONTH FROM SYSDATE); -- 날짜로 부터 월을 추출하세요
 
예)
SELECT SYSDATE, SYSDATE-10, SYSDATE+10 FROM DUAL;

SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS'),   -- 시분초까지 출력하기위해서 TO_CHAR 사용한다.
       TO_CHAR(SYSDATE-10,'YYYY-MM-DD HH24:MI:SS'),
       TO_CHAR(SYSDATE+10,'YYYY-MM-DD HH24:MI:SS') 
  FROM DUAL;


2. ADD_MONTHS
  - 주어진 날짜 정보에 개월수를 더한 날짜를 반환
  (사용형식)
  ADD_MONTHS(d, n)
   . 'd'날에 'n'개월을 더한 날짜 반환

예) 회원들의 생일을 조회하여 현재달과 한달전, 한달후 생일인 회원을 조회하시오
    Alias는 회원명, 생년월일, 마일리지
    
SELECT MEM_NAME AS 회원명,
       MEM_BIR AS 생년월일,
       MEM_MILEAGE AS 마일리지
  FROM MEMBER
 WHERE EXTRACT(MONTH FROM MEM_BIR) =
       EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE, -1))  -- 한달전
    OR EXTRACT(MONTH FROM MEM_BIR) =
       EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE, 1))  -- 한달후 
    OR EXTRACT(MONTH FROM MEM_BIR) =
       EXTRACT(MONTH FROM SYSDATE); 
 
예) 사원들의 입사일을 이용하여 정식직원으로 발령된 일자를 조회하시오
    정식 발령일은 입사 후 3개월의 수습기간이 지난 일자이다.
    Alias는 사원번호, 사원명, 입사일, 발령일, 부서번호
    
SELECT EMPLOYEE_ID AS 사원번호,
       EMP_NAME AS 사원명,
       HIRE_DATE AS 입사일,
       ADD_MONTHS (HIRE_DATE, 3) AS 발령일,
       DEPARTMENT_ID AS 부서번호
  FROM EMPLOYEES
    
3. EXTRACT
  - 주어진 날짜정보에서 필요란 부분(년,월,일,시,분,초)을 추출할때 사용
  (사용형식)
  EXTRACT(fmt FROM d)
   . 'fmt' : YEAR, MONTH, DAY, HOUR, MINUTE, SECOND 이다.
   
예)오늘이 2010년 6월 15일이라 가정하고 사원테이블에서 5년이상 근속한
   사원정보를 추출하시오
   Alias는 사원번호, 사원명, 입사일, 부서코드, 직무코드이다.
  
SELECT EMPLOYEE_ID AS 사원번호,
       EMP_NAME AS 사원명,
       HIRE_DATE AS 입사일,
       DEPARTMENT_ID AS 부서코드,
       JOB_ID AS 직무코드
  FROM EMPLOYEES
 WHERE EXTRACT(YEAR FROM TO_DATE('20100615')) - EXTRACT(YEAR FROM HIRE_DATE) >= 5;

-- WHERE (EXTRACT(YEAR FROM SYSDATE)-10) - EXTRACT(YEAR FROM HIRE_DATE) >= 5;

4. MONTHS_BETWEEN
  - 주어진 두 날짜 데이터 사이의 개월수를 반환
  (사용형식)
  MONTHS_BETWEEN(d1, d2)
  
예) 회원들의 생년월일(MEM_BIR)자료와 오늘날짜를 이용하여 나이를 개월수로 조회하시오
    Alias는 이름, 생년월일, 경과된개월수
    
SELECT MEM_NAME AS 이름,
       MEM_BIR AS 생년월일,
       ROUND(MONTHS_BETWEEN(SYSDATE, MEM_BIR)) AS 경과된개월수,
       TRUNC(ROUND(MONTHS_BETWEEN(SYSDATE, MEM_BIR))/12) AS 나이
  FROM MEMBER;








