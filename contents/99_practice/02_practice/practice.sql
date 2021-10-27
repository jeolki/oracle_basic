문제 1) 논리연산
emp 테이블에서 입사 일자가 1982년 1월 1일 이후부터 1983년 1월 1일 이전인 
사원의 ename, hiredate 데이터를 조회하는 SQL을 작성하시오 
단 연산자는 비교연산자(>, >=, <=, <)를 사용한다.

SELECT ename, hiredate
  FROM emp
 WHERE hiredate >= '19820101'
   AND hiredate <= '19830101'
   
문제 2) 논리연산
emp 테이블에서 job이 SALESMAN 이고 입사일자가 1981년 6월 1일 이후인 
사원의 정보를 다음과 같이 조회하는 SQL을 작성하시오

SELECT *
  FROM emp
 WHERE job = 'SALESMAN'
   AND hiredate >= '19810601'
   

문제 3) 논리연산
emp 테이블에서 부서번호가 10번이 아니고 입사일자가 1981년 6월 1일 이후인 
사원의 정보를 다음과 같이 조회하는 SQL을 작성하시오 
(단 NOT IN 연산자 사용)

SELECT *
  FROM emp
 WHERE hiredate >= '19810601'
   AND deptno NOT IN (10)
   

문제 4) 데이터 정렬
emp 테이블에서 empno 컬럼을 기준으로 정렬한 결과에 1부터 시작하는 번호를 순차적으로 부여하는 SQL을 작성하시오

SELECT ROWNUM, empno, ename
  FROM emp
 ORDER BY empno


문제 5) 데이터 정렬
emp 테이블에서 10번  부서(deptno) 혹은 30번  부서에  속하는  사람중  급여 (sal)가 1500이  넘는  
사람들만  조회하고  이름으로  내림차순  정렬되도록 SQL을 작성하시오

SELECT *
  FROM emp
 WHERE (deptno = 10 OR deptno = 30)
   AND sal > 1500
 ORDER BY ename DESC;
 
문제 6) Function
부서별 가장 낮은 급여, 가장 높은 급여, 급여 평균을 구하세요 급여 평균은 소수점 셋째 자리에서 반올림하는 SQL을 작성하시오

SELECT deptno, MIN(sal), MAX(sal), ROUND(AVG(sal), 2)
  FROM emp
 GROUP BY deptno
 
문제 7) 데이터 결합
급여 2500 초과, 사번이 7600보다  크고, RESEARCH 부서에  속하는  사원을 다음과  같이  조회하는  SQL을 작성하시오

SELECT A.empno, A.ename, A.sal, A.deptno, B.dname
  FROM emp A, dept B
 WHERE A.sal > 2500
   AND A.empno > 7600
   AND A.deptno = B.deptno
   AND B.dname = 'RESEARCH'
 ORDER BY A.empno DESC

문제 8) 데이터 결합
부서번호 10, 30에  속하는  사원  정보를  다음과  같이  조회하는 SQL을 작성하시오

SELECT A.empno, A.ename, A.deptno, B.dname
  FROM emp A, dept B
 WHERE A.deptno = B.deptno
   AND A.deptno IN (10, 30)
  
문제 9) 데이터 결합
사원의  이름과  해당  사원의  상급자  이름을  다음과  같이  조회하도록  SQL을 작성하시오 
(단, 상급자가  없는  경우 null이  나오도록  한다)

SELECT A.ename, B.ename mgr
  FROM emp A, emp B
 WHERE A.mgr = B.empno

문제 10) group function
사원의 입사 년월별로 몇명의 사원이 입사했는지 조회하는 SQL을 작성하시오

SELECT TO_CHAR(hiredate,'YYYYMM'), count(empno) CNT
  FROM emp
 GROUP BY TO_CHAR(hiredate, 'YYYYMM')
 
문제 11) 서브쿼리
SMITH와 WARD사원이 속한 부서의 모든 사원 정보를 조회하는 SQL을 작성하시오 
(단 서브쿼리를 활용)

SELECT *
  FROM emp
 WHERE deptno IN ( SELECT deptno
                     FROM emp
                    WHERE ename IN ( 'SMITH', 'WARD' ))
                    
문제 12) 서브쿼리
사원 전체 평균 급여보다 높은 급여를 받는 사원의 정보를 조회하는 SQL을 작성하시오 
(조회 순서는 관계 없음)

SELECT *
  FROM emp
 WHERE sal > ( SELECT AVG(sal)
                 FROM emp )
                 
문제 13) 신규입력
dept 테이블에 다음과 같은 신규 데이터를 입력하는 SQL을 작성하시오

    ○   deptno : 99 
    ○   dname : ddit 
    ○   loc : 대전

INSERT INTO dept VALUES( 99, 'ddit', '대전')

문제 14) 수정
dept 테이블의 99번 부서번호를 갖는 데이터를 다음과 같이 수정하는 SQL을 작성하시오 

    ○   dname : ddit_modi 
    ○   loc : 대전_modi
    
UPDATE dept 
SET dname = 'ddit_modi', loc = '대전_modi' 
WHERE deptno =99

문제 15) 삭제
dept 테이블의 99번 부서번호를 갖는 데이터를 삭제하는 SQL을 작성하시오

DELETE dept WHERE deptno = 99


문제 16) 객체생성
물리 설계서를 참고하여 제약조건을 포함하여 emp, dept 테이블을 생성하는 DDL을 작성하시오
CREATE TABLE EMPTEST(
    EMPNO       NUMBER(4) NOT NULL,
    ENAME       VARCHAR2(10),
    JOB         VARCHAR2(9),
    MGR         NUMBER(4),
    HIREDATE    DATE,
    SAL         NUMBER(7,2),
    COMM        NUMBER(7,2),
    DEPTNO      NUMBER(2),
    
    CONSTRAINT pk_emptest PRIMARY KEY(EMPNO)
);

CREATE TABLE DEPTTEST(
    DEPTNO  NUMBER(2)    NOT NULL,
    DNAME   VARCHAR2(14) NULL,
    LOC     VARCHAR2(13) NULL,
    
    CONSTRAINT pk_depttest PRIMARY KEY(DEPTNO)
);

문제 17) report group function
부서별  급여  합계와, 전체  급여  합계를  다음과  같이  구하는 SQL을 작성하시오 
(ROLLUP 혹은  GROUPING SETS 절을  이용)

SELECT deptno, SUM(sal)
  FROM emp
 GROUP BY ROLLUP(deptno)
 
SELECT deptno, SUM(sal)
  FROM emp
 GROUP BY GROUPING SETS( (deptno), ( ) )
 
문제 18) 분석함수 / window 함수
사원의  소속부서에서의  급여  순위를  다음과  같이  조회되도록  SQL을 작성하시오 
(단  순위가  같을  경우  입사일자가  빠른사람이  순위가  높도록  작성)

SELECT ename, sal, deptno, hiredate,
       RANK() OVER(PARTITION BY deptno ORDER BY sal DESC, hiredate DESC) salrank
  FROM emp

문제 19) 분석함수 / window 함수
모든  사원에  대해  사원번호, 사원이름, 입사일자, 급여, 전체  사원중  급여 
순위가 1단계  낮은  사람의  급여를  구하는  SQL을 작성하시오 
(급여가  같을  경우  입사일이  빠른  사람이  높은순위)

SELECT empno, ename, hiredate, sal,
       LEAD(sal, 1) OVER (ORDER BY sal DESC, hiredate ASC) as "LEAD_SAL" 
  FROM emp

문제 20) 분석함수 / window 함수
전체  사원을  급여순으로  오름차순  정렬하고, 자신보다  급여가  낮은  사람들의 
급여  누적합을  다음과  같이  구하는 SQL을  작성하시오

SELECT empno, ename, deptno, sal,
       SUM(sal) OVER(ORDER BY sal) CUM_SAL
  FROM emp


[PL/SQL]
모델은 아래를 참고하고 테이블은 제공된 테이블 스크립트를 이용하여 데이터를 생성후 진행하시오

CREATE TABLE CUSTOMER(
    CID NUMBER  NOT NULL,
    CNM VARCHAR2(50) NOT NULL,
    
    CONSTRAINT pk_cid PRIMARY KEY(CID)
);

CREATE TABLE CYCLE(
    CID NUMBER NOT NULL,
    PID NUMBER NOT NULL,
    DAY NUMBER NOT NULL,
    CNT NUMBER NOT NULL,
    
    CONSTRAINT pk_cid_pid_day PRIMARY KEY(CID, PID, DAY)
);

CREATE TABLE PRODUCT(
    PID NUMBER NOT NULL,
    PNM VARCHAR2(50) NOT NULL,
    
    CONSTRAINT pk_pid PRIMARY KEY(PID)
);

CREATE TABLE BATCH(
    BID NUMBER NOT NULL,
    BCD VARCHAR2(20) NOT NULL,
    ST  VARCHAR2(20) NOT NULL,
    ST_DT   DATE,
    ED_DT   DATE,
    
    CONSTRAINT pk_bid PRIMARY KEY(BID)
);

CREATE TABLE DAILY(
    CID NUMBER  NOT NULL,
    PID NUMBER  NOT NULL,
    DT  VARCHAR2(8) NOT NULL,
    CNT NUMBER  NOT NULL,
    
    CONSTRAINT pk_cid_pid_dt PRIMARY KEY(CID, PID, DT)
);

ALTER TABLE CYCLE
  ADD (CONSTRAINT fk_cid FOREIGN KEY (CID) REFERENCES CUSTOMER(CID) ON DELETE SET NULL);

ALTER TABLE CYCLE
  ADD (CONSTRAINT fk_pid FOREIGN KEY (PID) REFERENCES PRODUCT(PID) ON DELETE SET NULL);

ALTER TABLE DAILY
  ADD (CONSTRAINT fk_cid_daily FOREIGN KEY (CID) REFERENCES CUSTOMER(CID) ON DELETE SET NULL);

ALTER TABLE DAILY
  ADD (CONSTRAINT fk_pid_daily FOREIGN KEY (PID) REFERENCES PRODUCT(PID) ON DELETE SET NULL);

1) cycle 테이블에는 고객이 애음하는 요일이 저장됨 
2) 인자로 들어온 년월 값에 해당하는 일실적을 생성하는 프로시져 작성
3) 생성전 해당 년월에 해당하는 데이터는 삭제후 생성

해당 요일을 이용하여 인자로 들어온 년월의 일자를 계산 하여 daily 
테이블에 데이터 신규 생성 
    ○   ex) exec create_daily_sales(‘201908’); 
    ○   1번 고객은 월요일(2)에 100번제품을 애음 하고 
    ○   2019년 8월에 월요일은 총 4일(5, 12, 19, 26)이 존재하므로 다음과 같이 데이터가 생성되어야 한다

CREATE OR REPLACE PROCEDURE create_daily_sales(v_yearday IN VARCHAR2)
IS
  V_DAY VARCHAR2(100);
  CURSOR c_day 
  IS 
  SELECT TO_CHAR(dtt, 'YYYYMMDD') dt
    FROM (SELECT LEVEL - 1 + TO_DATE( v_yearday, 'YYYYMM') dtt,
                   TO_CHAR(LEVEL - 1 + TO_DATE( v_yearday, 'YYYYMM'),'D') d
            FROM dual
            CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE( v_yearday, 'YYYYMM')), 'DD'))
    WHERE d = (SELECT DAY
                 FROM CYCLE
                WHERE CID = 1);-- 1.커서선언

BEGIN
 OPEN c_day; --2. 커서열기
 DBMS_OUTPUT.PUT_LINE('=============================');
 DELETE daily WHERE SUBSTR(DT, 1, 6) = v_yearday;
 
 LOOP
   FETCH c_day INTO V_DAY;--3. 커서로부터 데이터 읽기
   EXIT WHEN c_day%NOTFOUND; --커서에서 데이터를 찾을수 없으면 반복문 빠져나가라.
   DBMS_OUTPUT.PUT_LINE('해당월의 고객1이 애음하는 날짜 : ' || V_DAY );
   INSERT INTO daily VALUES( 1, 100, V_DAY, 1);
   
 END LOOP;
 DBMS_OUTPUT.PUT_LINE('결과 레코드수 => ' || c_day%ROWCOUNT);
 CLOSE c_day ;--4. 커서 닫기
END;
  
EXEC create_daily_sales('201908');

--DROP PROCEDURE create_daily_sales;
