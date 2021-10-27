셀프(SELF-JOIN)조인
 - 하나의 테이블에 두개의 별칭을 부여하여 조인연산을 수행하는 방식
 
예) 거래처테이블에서 거래처코드가 'P10101'인 거래처와 같은
    지역에 속한 거래처를 조회하시오(거래처코드, 거래처명, 주소)
    
SELECT B.BUYER_ID AS 거래처코드,
       B.BUYER_NAME AS 거래처명,
       B.BUYER_ADD1 ||' '|| B.BUYER_ADD2 AS 주소
  FROM BUYER A, BUYER B
 WHERE UPPER(A.BUYER_ID) = 'P10101'    -- A 테이블은 P10101에대한 자료만 가지게됨
   AND SUBSTR(A.BUYER_ADD1,1,2) = SUBSTR(B.BUYER_ADD1,1,2)
 
   -- 전체자료를 B테이블에서 출력해야한다.
   
   
예)사원테이블에서 부서별 평균급여를 계산하고 자기부서의 평균급여보다 많은 급여를 받는 사원을 조회하시오      
   Alias는 사원번호, 사원명, 부서번호, 부서명, 급여
   
SELECT A.EMPLOYEE_ID AS 사원번호,
       A.EMP_NAME AS 사원명,
       A.DEPARTMENT_ID AS 부서번호,
       B.DEPARTMENT_NAME AS 부서명,
       A.SALARY AS 급여      
  FROM EMPLOYEES A, DEPARTMENTS B, (SELECT DEPARTMENT_ID AS DEPT_ID, 
                                           ROUND(AVG(SALARY),1) AS SAL_AVG 
                                      FROM EMPLOYEES
                                     GROUP BY DEPARTMENT_ID) C
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
   AND C.DEPT_ID = A. DEPARTMENT_ID
   AND A.SALARY >= C.SAL_AVG
 ORDER BY 3;
 
 
(부서별 평균급여)
SELECT DEPARTMENT_ID 
       ROUND(AVG(SALARY),1) 
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID

--부서가 같고 평균급여보다 급여가 많아야한다.