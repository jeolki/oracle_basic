1.표현식
 - 하나이상의 값과 연산자, 함수들이 결합된 식
1) CASE WHEN THEN
  . 특정 조건에 따라 값을 변경할 수 있는 수식(표현식)
  . 주로 SELECT절에서 사용
  
  (사용형식)
  CASE WHEN 조건1 THEN 값1
       WHEN 조건2 THEN 값2
              : 
       ELSE 값n
  END
  
  
예) 사원테이블에서 80번 부서 사원들의 급여를 조회하여 급여가
    15000 이상이면 'A등급',
    5000-14999 사이이면 'B 등급',
    5000 미만이면 'C 등급'으로 비고에 표시하시오
   Alias는 사원번호, 사원명, 급여, 비고
  
  SELECT EMPLOYEE_ID AS 사원번호,
         EMP_NAME AS 사원명,
         SALARY AS 급여,
         CASE WHEN SALARY >= 15000 THEN 'A등급'
              WHEN SALARY >= 5000 AND SALARY < 15000 THEN 'B등급' 
                   -- SALARY BETWEEN 5000 AND 14999 THEN
              ELSE 'C등급'      
         END AS 비고
    FROM EMPLOYEES
   WHERE DEPARTMENT_ID = 80; -- 조건 숫자
  


















  
  
  