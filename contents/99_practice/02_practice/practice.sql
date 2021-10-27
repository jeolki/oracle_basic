���� 1) ������
emp ���̺��� �Ի� ���ڰ� 1982�� 1�� 1�� ���ĺ��� 1983�� 1�� 1�� ������ 
����� ename, hiredate �����͸� ��ȸ�ϴ� SQL�� �ۼ��Ͻÿ� 
�� �����ڴ� �񱳿�����(>, >=, <=, <)�� ����Ѵ�.

SELECT ename, hiredate
  FROM emp
 WHERE hiredate >= '19820101'
   AND hiredate <= '19830101'
   
���� 2) ������
emp ���̺��� job�� SALESMAN �̰� �Ի����ڰ� 1981�� 6�� 1�� ������ 
����� ������ ������ ���� ��ȸ�ϴ� SQL�� �ۼ��Ͻÿ�

SELECT *
  FROM emp
 WHERE job = 'SALESMAN'
   AND hiredate >= '19810601'
   

���� 3) ������
emp ���̺��� �μ���ȣ�� 10���� �ƴϰ� �Ի����ڰ� 1981�� 6�� 1�� ������ 
����� ������ ������ ���� ��ȸ�ϴ� SQL�� �ۼ��Ͻÿ� 
(�� NOT IN ������ ���)

SELECT *
  FROM emp
 WHERE hiredate >= '19810601'
   AND deptno NOT IN (10)
   

���� 4) ������ ����
emp ���̺��� empno �÷��� �������� ������ ����� 1���� �����ϴ� ��ȣ�� ���������� �ο��ϴ� SQL�� �ۼ��Ͻÿ�

SELECT ROWNUM, empno, ename
  FROM emp
 ORDER BY empno


���� 5) ������ ����
emp ���̺��� 10��  �μ�(deptno) Ȥ�� 30��  �μ���  ���ϴ�  �����  �޿� (sal)�� 1500��  �Ѵ�  
����鸸  ��ȸ�ϰ�  �̸�����  ��������  ���ĵǵ��� SQL�� �ۼ��Ͻÿ�

SELECT *
  FROM emp
 WHERE (deptno = 10 OR deptno = 30)
   AND sal > 1500
 ORDER BY ename DESC;
 
���� 6) Function
�μ��� ���� ���� �޿�, ���� ���� �޿�, �޿� ����� ���ϼ��� �޿� ����� �Ҽ��� ��° �ڸ����� �ݿø��ϴ� SQL�� �ۼ��Ͻÿ�

SELECT deptno, MIN(sal), MAX(sal), ROUND(AVG(sal), 2)
  FROM emp
 GROUP BY deptno
 
���� 7) ������ ����
�޿� 2500 �ʰ�, ����� 7600����  ũ��, RESEARCH �μ���  ���ϴ�  ����� ������  ����  ��ȸ�ϴ�  SQL�� �ۼ��Ͻÿ�

SELECT A.empno, A.ename, A.sal, A.deptno, B.dname
  FROM emp A, dept B
 WHERE A.sal > 2500
   AND A.empno > 7600
   AND A.deptno = B.deptno
   AND B.dname = 'RESEARCH'
 ORDER BY A.empno DESC

���� 8) ������ ����
�μ���ȣ 10, 30��  ���ϴ�  ���  ������  ������  ����  ��ȸ�ϴ� SQL�� �ۼ��Ͻÿ�

SELECT A.empno, A.ename, A.deptno, B.dname
  FROM emp A, dept B
 WHERE A.deptno = B.deptno
   AND A.deptno IN (10, 30)
  
���� 9) ������ ����
�����  �̸���  �ش�  �����  �����  �̸���  ������  ����  ��ȸ�ϵ���  SQL�� �ۼ��Ͻÿ� 
(��, ����ڰ�  ����  ��� null��  ��������  �Ѵ�)

SELECT A.ename, B.ename mgr
  FROM emp A, emp B
 WHERE A.mgr = B.empno

���� 10) group function
����� �Ի� ������� ����� ����� �Ի��ߴ��� ��ȸ�ϴ� SQL�� �ۼ��Ͻÿ�

SELECT TO_CHAR(hiredate,'YYYYMM'), count(empno) CNT
  FROM emp
 GROUP BY TO_CHAR(hiredate, 'YYYYMM')
 
���� 11) ��������
SMITH�� WARD����� ���� �μ��� ��� ��� ������ ��ȸ�ϴ� SQL�� �ۼ��Ͻÿ� 
(�� ���������� Ȱ��)

SELECT *
  FROM emp
 WHERE deptno IN ( SELECT deptno
                     FROM emp
                    WHERE ename IN ( 'SMITH', 'WARD' ))
                    
���� 12) ��������
��� ��ü ��� �޿����� ���� �޿��� �޴� ����� ������ ��ȸ�ϴ� SQL�� �ۼ��Ͻÿ� 
(��ȸ ������ ���� ����)

SELECT *
  FROM emp
 WHERE sal > ( SELECT AVG(sal)
                 FROM emp )
                 
���� 13) �ű��Է�
dept ���̺� ������ ���� �ű� �����͸� �Է��ϴ� SQL�� �ۼ��Ͻÿ�

    ��   deptno : 99 
    ��   dname : ddit 
    ��   loc : ����

INSERT INTO dept VALUES( 99, 'ddit', '����')

���� 14) ����
dept ���̺��� 99�� �μ���ȣ�� ���� �����͸� ������ ���� �����ϴ� SQL�� �ۼ��Ͻÿ� 

    ��   dname : ddit_modi 
    ��   loc : ����_modi
    
UPDATE dept 
SET dname = 'ddit_modi', loc = '����_modi' 
WHERE deptno =99

���� 15) ����
dept ���̺��� 99�� �μ���ȣ�� ���� �����͸� �����ϴ� SQL�� �ۼ��Ͻÿ�

DELETE dept WHERE deptno = 99


���� 16) ��ü����
���� ���輭�� �����Ͽ� ���������� �����Ͽ� emp, dept ���̺��� �����ϴ� DDL�� �ۼ��Ͻÿ�
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

���� 17) report group function
�μ���  �޿�  �հ��, ��ü  �޿�  �հ踦  ������  ����  ���ϴ� SQL�� �ۼ��Ͻÿ� 
(ROLLUP Ȥ��  GROUPING SETS ����  �̿�)

SELECT deptno, SUM(sal)
  FROM emp
 GROUP BY ROLLUP(deptno)
 
SELECT deptno, SUM(sal)
  FROM emp
 GROUP BY GROUPING SETS( (deptno), ( ) )
 
���� 18) �м��Լ� / window �Լ�
�����  �ҼӺμ�������  �޿�  ������  ������  ����  ��ȸ�ǵ���  SQL�� �ۼ��Ͻÿ� 
(��  ������  ����  ���  �Ի����ڰ�  ���������  ������  ������  �ۼ�)

SELECT ename, sal, deptno, hiredate,
       RANK() OVER(PARTITION BY deptno ORDER BY sal DESC, hiredate DESC) salrank
  FROM emp

���� 19) �м��Լ� / window �Լ�
���  �����  ����  �����ȣ, ����̸�, �Ի�����, �޿�, ��ü  �����  �޿� 
������ 1�ܰ�  ����  �����  �޿���  ���ϴ�  SQL�� �ۼ��Ͻÿ� 
(�޿���  ����  ���  �Ի�����  ����  �����  ��������)

SELECT empno, ename, hiredate, sal,
       LEAD(sal, 1) OVER (ORDER BY sal DESC, hiredate ASC) as "LEAD_SAL" 
  FROM emp

���� 20) �м��Լ� / window �Լ�
��ü  �����  �޿�������  ��������  �����ϰ�, �ڽź���  �޿���  ����  ������� 
�޿�  ��������  ������  ����  ���ϴ� SQL��  �ۼ��Ͻÿ�

SELECT empno, ename, deptno, sal,
       SUM(sal) OVER(ORDER BY sal) CUM_SAL
  FROM emp


[PL/SQL]
���� �Ʒ��� �����ϰ� ���̺��� ������ ���̺� ��ũ��Ʈ�� �̿��Ͽ� �����͸� ������ �����Ͻÿ�

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

1) cycle ���̺��� ���� �����ϴ� ������ ����� 
2) ���ڷ� ���� ��� ���� �ش��ϴ� �Ͻ����� �����ϴ� ���ν��� �ۼ�
3) ������ �ش� ����� �ش��ϴ� �����ʹ� ������ ����

�ش� ������ �̿��Ͽ� ���ڷ� ���� ����� ���ڸ� ��� �Ͽ� daily 
���̺� ������ �ű� ���� 
    ��   ex) exec create_daily_sales(��201908��); 
    ��   1�� ���� ������(2)�� 100����ǰ�� ���� �ϰ� 
    ��   2019�� 8���� �������� �� 4��(5, 12, 19, 26)�� �����ϹǷ� ������ ���� �����Ͱ� �����Ǿ�� �Ѵ�

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
                WHERE CID = 1);-- 1.Ŀ������

BEGIN
 OPEN c_day; --2. Ŀ������
 DBMS_OUTPUT.PUT_LINE('=============================');
 DELETE daily WHERE SUBSTR(DT, 1, 6) = v_yearday;
 
 LOOP
   FETCH c_day INTO V_DAY;--3. Ŀ���κ��� ������ �б�
   EXIT WHEN c_day%NOTFOUND; --Ŀ������ �����͸� ã���� ������ �ݺ��� ����������.
   DBMS_OUTPUT.PUT_LINE('�ش���� ��1�� �����ϴ� ��¥ : ' || V_DAY );
   INSERT INTO daily VALUES( 1, 100, V_DAY, 1);
   
 END LOOP;
 DBMS_OUTPUT.PUT_LINE('��� ���ڵ�� => ' || c_day%ROWCOUNT);
 CLOSE c_day ;--4. Ŀ�� �ݱ�
END;
  
EXEC create_daily_sales('201908');

--DROP PROCEDURE create_daily_sales;
