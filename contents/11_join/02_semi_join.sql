세미(SEMI) 조인
 - 서브쿼리를 사용하여 서브쿼리의 결과에 존재하는 데이터만 메인쿼리에서 추출하는 조인 방법
 - IN과 EXISTS 연산자가 사용됨
 
 
예) 사원테이블에서 급여가 5000이상인 사원이 존재하는 부서번호와 부서명을 추출하시오
-- 어느부분을 메인으로 어느부분을 서브로 구성할것인지 판단해줘야한다.
-- 최종출력해줘야하는 부분이 메인쿼리이다.
-- 자료를 제공해주는것이 서브쿼리가 되는것. 

(메인쿼리 - 부서번호와 부서명을 추출)

SELECT A.DEPARTMENT_ID AS 부서번호,
       A.DEPARTMENT_NAME AS 부서명
  FROM DEPARTMENTS A
 WHERE A.DEPARTMENT_ID IN ( 서브쿼리 ) ;
 
(서브쿼리 - 급여가 5000이상인 사원이존재하는 부서번호)

SELECT DISTINCT B.DEPARTMENT_ID 
  FROM EMPLOYEES B
 WHERE SALARY >= 5000
 ORDER BY 1;
 
(IN 연산자사용)

SELECT A.DEPARTMENT_ID AS 부서번호,
       A.DEPARTMENT_NAME AS 부서명
  FROM DEPARTMENTS A
 WHERE A.DEPARTMENT_ID IN ( SELECT DISTINCT B.DEPARTMENT_ID
                              FROM EMPLOYEES B
                             WHERE B.SALARY >= 5000 )
 ORDER BY 1;
 
 
(EXISTS 연산자 사용)
  - 서브쿼리의 결과 한 행이라도 존재하면 참을 반환
  
SELECT A.DEPARTMENT_ID AS 부서번호,
       A.DEPARTMENT_NAME AS 부서명
  FROM DEPARTMENTS A
 WHERE EXISTS (SELECT 1
                 FROM EMPLOYEES B
                WHERE B.SALARY >= 5000 
                  AND A.DEPARTMENT_ID = B.DEPARTMENT_ID)
 ORDER BY 1; 
 
 -- SEMI JOIN은 중복이 발생하지 않음 
(동등조인 사용) -- 중복이 발생해서 DISTINCT 사용

SELECT DISTINCT A.DEPARTMENT_ID AS 부서번호,
       A.DEPARTMENT_NAME AS 부서명
  FROM DEPARTMENTS A, EMPLOYEES B
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
   AND B.SALARY >= 5000                 
 ORDER BY 1; 
 
 ** 세미조인은 서브쿼리의 결과에 중복된 자료가 있어도 최종 결과가 출력되는 
    메인쿼리에서 중복이 배제된다.
    
    
예) 사원테이블에서 평균급여보다 급여가 많은 사원이 소속된 부서코드와 부서명을 조회하시오

SELECT A.DEPARTMENT_ID AS 부서번호,
       A.DEPARTMENT_NAME AS 부서명
  FROM DEPARTMENTS A
 WHERE EXISTS (SELECT 1
                 FROM EMPLOYEES B
                WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
                  AND B.SALARY >=(SELECT AVG(SALARY)
                                    FROM EMPLOYEES))
 ORDER BY 1;
 

예)부서테이블에서 MANAGER_ID가 NULL이 아닌 부서에 속한 사원수를 조회하시오 

(메인쿼리 : 사원수)
SELECT COUNT(*)
  FROM EMPLOYEES A
 WHERE EXISTS ( 서브쿼리)


(서브쿼리 : 부서테이블에서 MANAGER_ID가 NULL이 아닌 부서에 속한 부서코드)
SELECT DEPARTMENT_ID
  FROM DEPARTMENTS
 WHERE MANAGER_ID IS NOT NULL;
 
 
(결합) 

SELECT COUNT(*) AS 사원수
  FROM EMPLOYEES A
 WHERE EXISTS (SELECT 1
                 FROM DEPARTMENTS B
                WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
                  AND B.MANAGER_ID IS NOT NULL); 
 
 
 
 