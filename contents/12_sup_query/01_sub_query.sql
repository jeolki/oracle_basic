��������
1. ����
  - SQL�����ȿ� �� �ٸ� SELECT���� ���Ե� ����
  - JOIN�� ���ҽ��� QUERY�� ���⼺�� ��ȭ
  - ���������� �ݵ�� '( )'�ȿ� ��� 
  - �����ڿ� �Բ� ����ϴ� ��� ������ ������ ����ؾ��Ѵ�.
  - FROM���� ���Ǵ� ���������� Ư���� in-line ���������� �ϰ�  VIEW�� ������
    ���̺�ó�� Ȱ��Ǹ� ���� �����ؾ��Ѵ�. // FROM���� ���� ���� ����Ǳ� ������ �װ��� ����� ������ ����ɰ��̴�.

2. ������������ ������ ���ο� ����
  - ���������� ���� ���̺�� ���������� ���� ���̺��� JOIN����Ǿ����� ���ο�����
  - ������ ��������/���������� ��������
  
3. ���¿� ����
  - �Ϲݼ�������
  - IN-LINE �������� 
  - ��ø��������
  
4. ��ȯ�Ǵ� ��� ���� ���� 
  - ������/���Ͽ�, ������/���߿�, ������/���Ͽ�, ������/���߿� ��������
  - ���Ǵ� �����ڿ� ���� ����

  
1) ������ ���� ��������  
  - ���������� ���� ���̺�� ���������� ���� ���̺��� JOIN������ �߻����� �ʴ� ��������

��) ������̺��� ������� ��� �޿����� ���� �޿��� ���޹޴� ������� ��ȸ�Ͻÿ�
-- ������������ �����ϰ� ������������ �ذ��Ұ��� �����ؾ��Ѵ�.
-- ���������� ���� ����ؾ� �ϴ� �κ� (�����)
-- ���������� �߰��� ���Ǿ���� �ڷḦ �����°� (��ձ޿�)

(��������-������� ��ȸ)
SELECT COUNT(*) AS �����
  FROM EMPLOYEES
 WHERE SALARY > (��ձ޿�);
 

(��������-��ձ޿�)
SELECT AVG(SALARY)
  FROM EMPLOYEES


(����)
SELECT COUNT(*) AS �����
  FROM EMPLOYEES
 WHERE SALARY > (SELECT AVG(SALARY) 
                   FROM EMPLOYEES);


��) �μ����̺��� �μ��� ������ �����ȣ�� 100�� �μ��� ���� ������� ��ȸ�Ͻÿ�
(�������� - �����)
(�������� - ������ �����ȣ�� 100�� �μ�)

SELECT COUNT(*) AS �����
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID  -- ��Ģ������ = �� ���� �ȵǴ°�
                           FROM DEPARTMENTS
                          WHERE MANAGER_ID = 100);

��) ��ǰ���̺��� �з��ڵ尡 P200 ������ ���� ��ǰ�� ���� ��ȸ�Ͻÿ�
(�������� ������� �ʴ� ����)
SELECT COUNT(*) AS "��ǰ�� ��"
  FROM PROD
 WHERE UPPER(PROD_LGU) LIKE 'P2%'
 
(�������� ���)
SELECT COUNT(*) AS "��ǰ�� ��"
  FROM PROD
 WHERE PROD_LGU IN /* = ANY, =SOME */(SELECT LPROD_GU
                     FROM LPROD
                    WHERE UPPER(LPROD_GU) LIKE 'P2%');
-- ���������� ������ ���Ͽ��� ������ �����Ͱ� �ϳ��� �ƴ϶� �����������ȴ�
-- =�̶�� �����ڴ� ������ �������� ���� ��ġ�ؾ��Ѵ�.
-- �������� ��ҵ�� �������� �ʿ��Ҷ� IN, =ANY, =SOME ����Ѵ�.


SELECT COUNT(*) AS "��ǰ�� ��"
  FROM PROD
 WHERE EXISTS (SELECT 1
                 FROM LPROD
                WHERE UPPER(LPROD_GU) LIKE 'P2%'
                  AND PROD_LGU = LPROD_GU);  
--EXISTS �����ڴ� �ݵ�� �ڿ� ���������� �־���ϸ� ���ü��� �־���Ѵ�. 

��) ������̺��� 2006�� ���� �Ի��� ������� �޿��� ��ձݿ��� �����Ͻÿ�

(�������� - ������� �޿��� ����)
UPDATE EMPOLYEES
   SET SALARY = (��������)
 WHERE HIRE_DATE >= TO_DATE('20060101')
 
(�������� - ��ձ޿� )
SELECT ROUND(AVG(SALARY),1)
  FROM EMPLOYEES
  
(����)  
UPDATE EMPLOYEES
   SET SALARY = (SELECT ROUND(AVG(SALARY),1)
                   FROM EMPLOYEES)
 WHERE HIRE_DATE >= TO_DATE('20060101');
   
/*
CREATE OR REPLACE VIEW V_EMP01  -- �並 ����� �Z��.
AS
SELECT EMP_NAME, SALARY
  FROM EMPLOYEES
 WHERE HIRE_DATE >= TO_DATE('20060101');
*/

SELECT * FROM V_EMP01;

SELECT EMP_NAME, HIRE_DATE, SALARY
  FROM EMPLOYEES
 WHERE HIRE_DATE >= '20060101';

ROLLBACK;


��)��ձ޿����� ���� �޿��� �޴� ������� ����ó���Ͻÿ�
DELETE EMPLOYEES;
ROLLBACK;

(�������� -������� ���� (��ձ޿����� ���� �޿��� �޴�))
DELETE EMPLOYEES
 WHERE SALARY > (��������);
 
(�������� - ��ձ޿�)
SELECT AVG(SALARY) 
  FROM EMPLOYEES
  
(����)  
DELETE EMPLOYEES
 WHERE SALARY > (SELECT AVG(SALARY) 
                   FROM EMPLOYEES);  
  
ROLLBACK;  
  
���� ���ǿ� �´� ������ ���̺��� �����Ͻÿ�
 - ���̺�� : REMAIN
 - �÷�
   . �⵵ : REMAIN_YEAR    CHAR(4) N.N, PK
   . ��ǰ�ڵ� : REMAIN_PROD VARCHAR2(10) N.N, PK/FK -- PROD����
   . ������� : REMAIN_J_00 NUMBER(5),
   . �԰���� : REMAIN_I    NUMBER(5),
   . ������ : REMAIN_O    NUMBER(5),
   . �⸻��� : REMAIN_J_99 NUMBER(5),
   . �������� : REMAIN_DATE DATE
   
   
CREATE TABLE REMAIN( 
  REMAIN_YEAR CHAR(4),  --pk�� ��¥�� N.N
  REMAIN_PROD VARCHAR2(10), --pk�� ��¥�� N.N
  REMAIN_J_00 NUMBER(5),
  REMAIN_I    NUMBER(5),
  REMAIN_O    NUMBER(5),
  REMAIN_J_99 NUMBER(5),
  REMAIN_DATE DATE,
  
  CONSTRAINT pk_remain PRIMARY KEY(REMAIN_YEAR, REMAIN_PROD ),
  CONSTRAINT fk_remain FOREIGN KEY(REMAIN_PROD)
     REFERENCES PROD(PROD_ID));

��) ���������̺�(REMAIN)�� ���� �ڷḦ �ϰ� �Է��Ͻÿ�
 �⵵ : '2005'
 ��ǰ�ڵ� : PROD���̺��� ��ǰ�ڵ�
 �������� : 20050101
 
 
 ** ���������� �̿��� �ϰ��Է�
INSERT INTO ���̺��[(�÷���1, �÷���2,.....)]
 ��������; -- ��ȣ�� ���� �ʴ´�.
  .'��������'�� ��ȣ�� ������� ����
  .'�÷���1, �÷���2,.....'�� �Ҵ�� ���� ���������� SELECT ������ �����ؾ� ��


INSERT INTO REMAIN(REMAIN_YEAR, REMAIN_PROD, REMAIN_DATE)
  SELECT '2005', PROD_ID, TO_DATE('20050101')
    FROM PROD;
    
SELECT * FROM REMAIN;

��)��ǰ���̺��� �������(PROD_PROPERSTOCK)�� ���������̺�(REMAIN)
   �� ����(REMAIN_J_00) �� �⸻���(REMAIN_J_99)�� �����Ͻÿ� 

UPDATE REMAIN
   SET (REMAIN_J_00, REMAIN_J_99) = 
       (SELECT PROD_PROPERSTOCK, PROD_PROPERSTOCK 
          FROM PROD
         WHERE REMAIN_PROD = PROD_ID)
 WHERE REMAIN_YEAR='2005'; 
--�⺻Ű�� �ΰ��̻� ���յ� ����Ű�ΰ�� �Ѱ��� ���������� �ΰ��� ���׸��� �־���Ѵ�.
--������Ʈ �ؾ��� �÷��� �ΰ��̻��̸� ��� ���� ����Ʈ������ ������ ���缭 �������Ѵ�.
 
UPDATE REMAIN
   SET REMAIN_J_00 = (SELECT PROD_PROPERSTOCK, PROD_PROPERSTOCK 
                        FROM PROD
                       WHERE REMAIN_PROD = PROD_ID ),
       REMAIN_J_99 = (SELECT PROD_PROPERSTOCK, PROD_PROPERSTOCK 
                        FROM PROD
                       WHERE REMAIN_PROD = PROD_ID )               
 WHERE REMAIN_YEAR = '2005'; 
 
--�⺻Ű�� ������ŭ where��

 (2)������ �ִ� ��������
  - ���������� ���� ���̺�� ���������� ���� ���̺��� join���� ����� ��������
  
��) ��ٱ������̺��� �ְ� �Ǹż����� ����� ȸ���� ȸ����ȣ, ��ǰ��, ������ ��ȸ�Ͻÿ�

(�������� - ȸ���� ȸ����ȣ, ��ǰ��, ������ ��ȸ) -CART PROD

SELECT A.CART_MEMBER AS ȸ����ȣ,
       B.PROD_NAME AS ��ǰ��,
       A.CART_QTY AS ����
  FROM CART A, PROD B
 WHERE A.CART_PROD = B.PROD_ID
   AND A.CART_QTY = (��������)

(�������� - ���� ū �Ǹż���)
SELECT MAX(CART_QTY) FROM CART

(����)
SELECT A.CART_MEMBER AS ȸ����ȣ,
       B.PROD_NAME AS ��ǰ��,
       A.CART_QTY AS ����
  FROM CART A, PROD B
 WHERE A.CART_PROD = B.PROD_ID
   AND A.CART_QTY = (SELECT MAX(CART_QTY) 
                       FROM CART);




(������ �ִ� �������� ����)
SELECT * FROM 
    (SELECT A.CART_MEMBER AS ȸ����ȣ,
            B.PROD_NAME AS ��ǰ��,
            A.CART_QTY AS ����
       FROM CART A, PROD B
      WHERE A.CART_PROD = B.PROD_ID
        AND A.CART_QTY = (SELECT MAX(CART_QTY) 
                            FROM CART
                           WHERE CART_MEMBER = A.CART_MEMBER)
 ORDER BY 3 DESC) TBLA
WHERE ROWNUM = 1;


SELECT A.CART_MEMBER AS ȸ����ȣ,
       D.MEM_NAME AS ȸ����,
       B.PROD_NAME AS ��ǰ��,
       A.CART_QTY AS ����
  FROM CART A, PROD B, MEMBER D,
       (SELECT CART_MEMBER,
               E.MQTY AS AMT
          FROM CART, (SELECT MAX(CART_QTY) AS MQTY
                        FROM CART) E
         WHERE E.MQTY = CART_QTY) F               
 WHERE A.CART_PROD = B.PROD_ID
   AND A.CART_MEMBER = D.MEM_ID
   AND A.CART_MEMBER = F.CART_MEMBER
   AND A.CART_QTY = F.AMT ;
                      

��) ��� �ŷ�ó�� 2005�� ������հ踦 ���Ͻÿ�
    Alias�� �ŷ�ó�ڵ�, �ŷ�ó��, ������հ�

(ANSI OUTER JOIN)
SELECT A.BUYER_ID AS �ŷ�ó�ڵ�,  -- ��ü������ִ� ���̺� ���
       A.BUYER_NAME AS �ŷ�ó��,
       NVL(SUM(B.PROD_PRICE * C.CART_QTY),0) AS ������հ�
  FROM BUYER A
  LEFT OUTER JOIN PROD B ON (A.BUYER_ID = B.PROD_BUYER)
  LEFT OUTER JOIN CART C ON (B.PROD_ID = C.CART_PROD 
   AND C.CART_NO LIKE '2005%')
 GROUP BY A.BUYER_ID, A.BUYER_NAME
 ORDER BY 1;
 
                      
(SUBQUERY ����)
�������� - 2005�� �ŷ�ó�� �ŷ�ó�ڵ�, �ŷ�ó��, (��������)
�������� - 2005�� �ŷ�ó�� ������հ�

SELECT A.BUYER_ID AS �ŷ�ó�ڵ�,
       A.BUYER_NAME AS �ŷ�ó��
       (�����)   --����Ʈ���� �ִ°Ծƴϴ� WHERE���� ���Ǿ���ϱ⶧���� 
  FROM BUYER A ,(��������-2005�⵵ �ŷ�ó�� ������հ�) B           
 WHERE A.BUYER_ID = (..�ƿ�������..) (+)                                         
-- GROUP BY A.BUYER_ID, A.BUYER_NAME �׷���̰� �����ʿ䵵 �������� 
ORDER BY 1;

-- ���������� ����� ���������� ����Ʈ������ ����ϰ��� �Ұ�� �������� ���������� �;��Ѵ�.!!!!!!!!!!!!!!!!!!!!!
-- FROM���� �̸� ����Ǿ����⶧���� ���������� ����Ǿ����� ����� ������ �װ��� ����Ʈ������ �츮�� �����ϴ°��̴�.


SELECT A.BUYER_ID AS �ŷ�ó�ڵ�,
       A.BUYER_NAME AS �ŷ�ó��,
       NVL(B.OAMT,0) AS �����
  FROM BUYER A ,(SELECT BUYER_ID,
                        SUM(CART_QTY*PROD_PRICE) AS OAMT
                   FROM CART, PROD, BUYER
                  WHERE CART_PROD = PROD_ID
                    AND PROD_BUYER = BUYER_ID
                    AND CART_NO LIKE '2005%'
                  GROUP BY BUYER_ID ) B           
 WHERE A.BUYER_ID = B.BUYER_ID(+)                                         
ORDER BY 1;


��)��ٱ������̺��� 2005�� 4���� �Ǹŵ� ��ǰ �� 2005��6������ �Ǹŵ� ��ǰ�� ��ȸ�Ͻÿ� --���ÿ��Ǹŵ�
  Alias�� ��ǰ�ڵ�, ��ǰ��, �Ǹż���, �Ǹűݾ�

SELECT DISTINCT(A.CART_PROD) AS ��ǰ�ڵ�,
       D.PROD_NAME AS ��ǰ��
  FROM CART A, (SELECT DISTINCT(CART_PROD) AS BAMT
                  FROM CART
                 WHERE CART_NO LIKE '200504%') B, 
               (SELECT DISTINCT(CART_PROD) AS CAMT
                  FROM CART 
                 WHERE CART_NO LIKE '200506%') C,
                   PROD D   
 WHERE A.CART_PROD = B.BAMT
   AND A.CART_PROD = C.CAMT
   AND A.CART_PROD = D.PROD_ID
 ORDER BY 1;

SELECT DISTINCT(A.PROD_ID) AS ��ǰ�ڵ�,
       A.PROD_NAME AS ��ǰ��
  FROM PROD A, (SELECT DISTINCT(CART_PROD)
                  FROM CART
                 WHERE CART_NO LIKE '200504%') B, 
               (SELECT DISTINCT(CART_PROD)
                  FROM CART 
                 WHERE CART_NO LIKE '200506%') C                   
 WHERE A.PROD_ID = B.CART_PROD
   AND A.PROD_ID = C.CART_PROD
 ORDER BY 1; 
  
  
(���տ�����)
SELECT PROD_ID,PROD_NAME
  FROM CART, PROD
 WHERE CART_PROD = PROD_ID
   AND CART_NO LIKE '200504%'
  
INTERSECT

SELECT PROD_ID,PROD_NAME
  FROM CART, PROD
 WHERE CART_PROD = PROD_ID
   AND CART_NO LIKE '200506%'
 ORDER BY 1;
  

��) �����̷����̺�(JOB_HISTORY) ���̺� ����� ����� �μ���ȣ��
    ������̺��� �μ���ȣ�� ������ ����� �����ȣ, �����, �μ����� ��ȸ�Ͻÿ�
-- ���Ϻμ����� ������ ����Ȼ��

--�������� -������̺�� �������丮 �� ����̸���� 
--�μ����̺�� �μ��ڵ� ���ؼ� �μ��� ��ȸ
    
SELECT A.EMPLOYEE_ID AS �����ȣ,
       A.EMP_NAME AS �����,
       B.DEPARTMENT_NAME AS  �μ���
  FROM EMPLOYEES A, DEPARTMENTS B
 WHERE A.EMPLOYEE_ID IN (SELECT DISTINCT A.EMPLOYEE_ID
                           FROM JOB_HISTORY C
                          WHERE A.DEPARTMENT_ID = C.DEPARTMENT_ID
                            AND A.EMPLOYEE_ID = C.EMPLOYEE_ID)
   AND A.DEPARTMENT_ID = B.DEPARTMENT_ID;
   
��)������̺��� �� �μ��� ��� �޿����� ���� �޿��� �޴� ��������� ��ȸ�Ͻÿ�
   Alias�� �����ȣ, �����, �μ���ȣ, �޿��̸� �μ���ȣ ������ ����Ͻÿ�
  
SELECT A.EMPLOYEE_ID AS �����ȣ,
       A.EMP_NAME AS �����,
       A.DEPARTMENT_ID AS �μ���ȣ,
       A.SALARY AS �޿�,
       B.AVGSAL AS �μ�����ձ޿�
  FROM EMPLOYEES A, (SELECT DISTINCT(DEPARTMENT_ID),
                            ROUND(AVG(SALARY)) AS AVGSAL
                       FROM EMPLOYEES
                      GROUP BY DEPARTMENT_ID) B
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
   AND A.SALARY > B.AVGSAL 
 ORDER BY 3, 4;
 
 
��) 2005�⵵ ��ǰ�� ���Լ����հ�� ��������հ踦 ��ȸ�Ͻÿ�
   (SELECT ������ SUBQUERY ���)
   Alias ��ǰ��ȣ, ��ǰ��, �������, ���Լ���
   
   
SELECT PROD_ID AS ��ǰ��ȣ,
       PROD_NAME AS ��ǰ��,
       (SELECT SUM(CART_QTY)
          FROM CART
         WHERE PROD_ID = CART_PROD
           AND CART_NO LIKE '2005%') AS �������,
       (SELECT SUM(BUY_QTY)
          FROM BUYPROD
         WHERE BUY_PROD = PROD_ID
           AND BUY_DATE BETWEEN '20050101' AND '20051231') AS ���Լ���
  FROM PROD;
 
--OUTER ���ΰ� ���������.
--���������� �����Ҽ����� FROM������ �����ε� SELECT���� �����ϴ°��� ���� �������̶� �����Ұ���


��)2005�� 1�� ��ǰ�� ���Լ����� ���Ͽ� ���������̺�(REMAIN)�� UPDATE�Ͻÿ�

REMAIN ���̺��� �԰���� (REMAIN_I)�� ������(REMAIN_O)�� ��� 0���� ����

UPDATE REMAIN
   SET REMAIN_I = 0,
       REMAIN_O = 0;

COMMIT;

UPDATE REMAIN
   SET (REMAIN_I,REMAIN_O) = (SELECT 0,0 FROM DUAL);

UPDATE REMAIN
   SET (REMAIN_I, REMAIN_J_99) = (2005�� 1�� ��ǰ�� ���Լ���)
 WHERE REMAIN_YEAR = '2005'
   AND REMAIN_PROD = (    )
 
UPDATE REMAIN
   SET (REMAIN_I, REMAIN_J_99, REMAIN_DATE) = 
       (SELECT NVL(SUM(BUY_QTY),0),
               REMAIN_J_99+NVL(SUM(BUY_QTY),0),
               '20050201'
          FROM BUYPROD
         WHERE BUY_DATE BETWEEN '20050101' AND '20050131'
           AND BUY_PROD = REMAIN_PROD)
 WHERE REMAIN_YEAR = '2005'
   AND REMAIN_PROD IN (SELECT BUY_PROD
                         FROM BUYPROD
                        WHERE BUY_DATE BETWEEN '20050101' AND '20050131');

 ROLLBACK;

(PROCEDURE�� ����� ���)
CREATE OR REPLACE PROCEDURE PROC_REMAIN_UPDATE01(
   P_CODE IN BUYPROD.BUY_PROD%TYPE,
   P_AMT IN NUMBER)
IS
   V_CODE BUYPROD.BUY_PROD%TYPE := P_CODE;
   V_AMT NUMBER := P_AMT;
   V_DATE DATE := TO_DATE('20050201');
BEGIN
         
   UPDATE REMAIN
      SET REMAIN_I=V_AMT,
          REMAIN_J_99=REMAIN_J_99+V_AMT,
          REMAIN_DATE=V_DATE
    WHERE REMAIN_YEAR='2005'
      AND REMAIN_PROD=V_CODE;
END;      



DECLARE
  V_CODE PROD.PROD_ID%TYPE;
  V_AMT NUMBER := 0;
  CURSOR CUR_BUYPROD01 IS 
      SELECT BUY_PROD,
             SUM(BUY_QTY) AS V_AMT
        FROM BUYPROD
       WHERE BUY_DATE BETWEEN '20050101' AND '20050131'
       GROUP BY BUY_PROD;
BEGIN
   FOR REC IN CUR_BUYPROD01 LOOP
      PROC_REMAIN_UPDATE01(REC.BUY_PROD, REC.V_AMT);
   END LOOP;
END;   
  