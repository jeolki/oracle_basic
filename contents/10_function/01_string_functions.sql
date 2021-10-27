 �Լ� -- ���ĺ��� �������߿�
 - FUNCTION�� �̸� �������� �ۼ��Ͽ� ������ �س��� ���డ���� ���α׷�
 - �ݵ�� �ϳ��� ��ȯ ���� ����!!
 - �Լ��� ����
 1) ������ �Լ�(Single-Row Function)
    . ���̺� ����� ������ ���� ������� �Լ��� ����Ǿ� �ϳ��� ��� ��ȯ
    . ����, ����, ��¥ ó���Լ�, ����ȯ �Լ�
    . SELECT��, WHERE��, GROUP BY������ ���
    . ��ø ��� ����
 2) ������ �Լ�(MULTIPLE-ROW FUNCTION)
    . ���̺��� �ڷḦ ���� �׷����� �׷�ȭ�� �� �Լ��� �����Ͽ� �ϳ��� ����� ��ȯ --�׷캰���ϳ�
    . �����Լ�(SUM, COUNT, AVG, MIN, MAX)�� ����
    
1. �����Լ�
 1) CONCAT
  - �־��� ���ڿ��� �����Ͽ� ���ο� ���ڿ��� ��ȯ --�Լ��� ����� �� ��ġ�� ��ȯ
  - ���տ����� '||'�� ���� ��� ����
  (�������)
  CONCAT(c1,c2)     -- �Ű����� c1 c2 ���ڿ�Ÿ��
   . �� ���ڿ� 'c1'�� 'c2'�� �����Ͽ� ��ȯ 
    -- ||�� ���ϱ�� �ε� ||�� �� ���� ������ �߾Ⱦ���.
    
 ��)'BOYHOOD'�� 'ILPOSTINO'���ڿ� ���̿� ', '�� �����Ͽ� ����� ����Ͻÿ�
    'BOYHOOD, ILPOSTINO' �� ������
 ('||'������ ���) --���� ������
 SELECT 'BOYHOOD'||', '||'ILPOSTINO' FROM DUAL; -- ����ϱ����� �ӽ÷� ���̺��� �ִ°� DUAL
 
 (CONCAT�Լ� ���) -- 2���̻� �Ǵ� ���ڿ��� �����ϱ� ���� CONCAT(CONCAT())���
 SELECT CONCAT(CONCAT('BOYHOOD',', '),'ILPOSTINO') FROM DUAL;


��) ȸ�����̺��� ���￡ �����ϴ� ȸ���� ȸ����, �ֹι�ȣ, �ּҸ� ��ȸ�Ͻÿ�
    �ֹι�ȣ�� ��������� 'XXXXXX-XXXXXXX'�̰�, �ּҴ� �⺻�ּҿ� ���ּ� ���̿� ��ĭ��
    ������ �����Ͽ� ����Ѵ�. �� CONCAT�Լ��� ����Ͻÿ�
    
SELECT MEM_NAME AS ȸ����,
       CONCAT(MEM_REGNO1,CONCAT('-',MEM_REGNO2)) AS �ֹι�ȣ,
       CONCAT(CONCAT(MEM_ADD1,' '),MEM_ADD2) AS �ּ�
  FROM MEMBER 
 WHERE MEM_ADD1 LIKE '����%';
 
 
 2) UPPER, LOWER, INITCAP
   - �ҹ��ڸ� �빮�ڷ� ��ȯ(UPPER)
   - �빮�ڸ� �ҹ��ڷ� ��ȯ(LOWER)
   - �ܾ��� ù ���ڸ� �빮�ڷ� ��ȯ(INITCAP)
   (�������)
   UPPER(c1), LOWER(c1), INITCAP(c1)
   
��)������̺�(EMPLOYEES)���� EMAIL�� 'dgrant'�� ȸ���� 
   �����, �μ���, ������, �޿��� ���Ͻÿ� 
   
SELECT A.EMP_NAME AS �����,    --������̺��� �μ���� �������̾��� JOIN�� ����Ͽ����Ѵ�.
       B.DEPARTMENT_NAME AS �μ���,
       C.JOB_TITLE AS ������,  -- C���̺� �ִ� JOB TITLE
       A.SALARY AS �޿�  -- A���̺��� �ִ� 
  FROM EMPLOYEES A, DEPARTMENTS B, JOBS C --�μ����� B�� ����ְ� �������� C������ִ�.
 WHERE LOWER(A.EMAIL) = 'dgrant' --�̸����� dgrant�λ�� A���̺��� -- >>> �Ϲ�����
   AND A.DEPARTMENT_ID = B.DEPARTMENT_ID -- �μ����� ������������ A���̺��� ID�� B���̺��� ID�� ������  ->>>> ��������
   AND A.JOB_ID = C.JOB_ID;  -- --->>> ��������
 
-- ���� �˰��ִ±��ڰ� �ҹ����̴ϱ� �񱳴���� �Ǵ°��� �װͰ� �����ָ�ȴ� >>>> �ҹ��ڷ� �����Ѵ�

 3) LPAD, RPAD
  - ���õ� ũ���� ������ ���ڿ��� �����ϰ� ���� ������ ���ǵ� ���ڿ���
    ����(LPAD) �Ǵ� ������(RPAD)�� �����Ͽ� ����� ��ȯ
  (�������)
  LPAD[RPAD](c1, n [, c2])
   . n �ڸ��� ��ŭ�� �������� c1���ڿ��� �����ϰ� ���� ������ ������ �Ǵ�
     ���ʿ� 'c2'���ڿ��� ����
     
 ��) ȸ�����̺�(MEMBER)���� ȸ����, �ڵ�����ȣ, ���ϸ����� ��ȸ�Ͻÿ�
     �� ����ȭ��ȣ�� '(80)-'�̶�� ������ȣ�� ���ʿ� �����ϰ�
       ���ϸ����� 5�ڸ��� �����ϵ� ���� ������ '*'�� �����Ͻÿ�
       
SELECT MEM_NAME AS ȸ����,
       LPAD(MEM_HP,17,'(80)-') AS �ڵ�����ȣ,   -- 12+5���ڵ� 17���� �ʿ� �����̳��ԵǸ� �ݺ������̵ǹ�����
       LPAD(MEM_MILEAGE,5,'*') AS ���ϸ��� -- 5�ڸ��� ������ ������ *����

  FROM MEMBER;

��) 2005�� 3�� ��ǰ���������� ���� �������� ��ȸ�Ͻÿ�
    ��ȸ�� ���� : ��¥, ��ǰ�ڵ�, ���Լ���, ���Աݾ�
    ���Աݾ��� 9�ڸ��� ����ϸ� ,������ �����ϱ� ���� '#'��ȣ�� �ݾ��� ���������Ѵ�

SELECT BUY_DATE AS ��¥, 
       BUY_PROD AS ��ǰ�ڵ�, 
       BUY_QTY AS ���Լ���, 
       LPAD(BUY_QTY*BUY_COST, 9, '#') AS ���Աݾ�
  FROM BUYPROD
 WHERE BUY_DATE >= TO_DATE('20050301') AND BUY_DATE <= TO_DATE('20050331') ;
    -- BUY_DATE BETWEEN '20050301' AND '20050331' ; --BETWEEN �̿�
    -- BUY DATE �� ������ Ÿ���� Ȯ���ϰ� DATE Ÿ���̱� ������ LIKE ��� �����ʴ´�. 

 4) LTRIM, RTRIM, TRIM
  - ���ǵ� ���ڿ����� Ư�����ڿ��� ����(LTRIM) �Ǵ� ������(RTRIM)���� ã�� ������
  (�������)
  LTRIM[RTRIM](c1 [, c2,])
   . 'c1'���ڿ����� c2�� ����(�Ǵ� ������)���� ã�� ����
   . 'c2'�� �����Ǹ� ����(�Ǵ� ������)�� ������ ����. ��, ���ڿ� ���ο� �����ϴ� ������ �������� ����
  TRIM(c1)
   . 'c1' ���ڿ��� �հ� �ڿ� �����ϴ� ���� ����
   
    name char(15) <- 'ȫ�浿' ==> ����� ���� 'ȫ�浿      '-- 6byte�� ������ ���� ��ȿ�ǰ��� ����Ŭ 9i���ʹ� �˾Ƽ� ��������
 if (name='ȫ�浿')  ==> �����͸� ã�� ���� 
 -- �ڹٿ����� ������ ���̵��´� �����͸� ã�� ���� 
 -- if (name.equals("ȫ�浿")) --> false

��)
SELECT LTRIM('RDBMS DB Modeling�� OracleSQL','DB') FROM DUAL; -- ���� ù���ڰ� DB�����Ѵ�
SELECT LTRIM('DBMS DB Modeling�� OracleSQL','DB') FROM DUAL; -- ���� DB ������ �߰����ڴ� ���Ÿ���

SELECT RTRIM('DBMS DB Modeling�� OracleSQL','SQL') FROM DUAL; -- �ǵ� SQL ���ŵ�
SELECT RTRIM('DBMS DB Modeling�� OracleSQL!','SQL') FROM DUAL; -- ���� !�� �־ SQL�� �ȳ����� ���Ÿ���
SELECT RTRIM('DBMS DB Modeling�� OracleSQLSQL','SQL') FROM DUAL; --�ݺ��� SQLSQL �������

SELECT TRIM('  DBMS DB Modeling�� OracleSQLSQL   ') FROM DUAL; --���� ��ȿ�� �����͸� �μ� ���� ���� ����


��)������̺��� EMP_NAME �÷��� ������ Ÿ���� CHAR(80)�� �����Ͻÿ�

ALTER TABLE EMPLOYEES
  MODIFY EMP_NAME CHAR(80);

SELECT EMP_NAME FROM EMPLOYEES;

ALTER TABLE EMPLOYEES
  MODIFY EMP_NAME VARCHAR(80);  -- ������� ���ƿ��� �ʴ´�. ������ ���� CHAR ����� ���鵵 �����ͷ� �����ֱ� ������
  
UPDATE EMPLOYEES
   SET EMP_NAME=TRIM(EMP_NAME)  -- ������ �߶󳻼� EMP_NAME�� �־��
   
SELECT EMP_NAME FROM EMPLOYEES;

 5) SUBSTR
  - �κ� ���ڿ��� �����Ͽ� ��ȯ(��ȯ Ÿ�Ե� ���ڿ�) -- ���ڿ���
  (�������)
  SUBSTR(c1, m [,n])
   . 'c1'���ڿ����� m��°���� n����ŭ�� ���ڿ��� �����Ͽ� ��ȯ
   . m�� 0�Ǵ� 1�̸� 'c1'�� ù��° ���ں��� ���� -- 0�� 1�� ����Ѵ�.
   . m�� ���� ������ �����ϸ� ���ڿ��� �ڿ��� ���� ó��
   . n�� �����Ǹ� m��° ���� ��� ���ڿ��� ����
   
��) 
SELECT SUBSTR('DB Modeling�� OracleSQL',2,5),
       SUBSTR('DB Modeling�� OracleSQL',-8,5),
       SUBSTR('DB Modeling�� OracleSQL',-2,5),-- Q�������� ���� �ڷ� 5�ڸ�
       SUBSTR('DB Modeling�� OracleSQL',2)
  FROM DUAL;
  
��) ��ǰ���̺��� ��ǰ���� '����'���� �����ϴ� ��ǰ������ ��ȸ�Ͻÿ�
    Alias�� ��ǰ�ڵ�, ��ǰ��, �ǸŴܰ��̴�.
    
SELECT PROD_ID AS ��ǰ�ڵ�,
       PROD_NAME AS ��ǰ��,
       PROD_PRICE AS �ǸŴܰ�
  FROM PROD
 WHERE SUBSTR(PROD_NAME,1,2) = '����'; -- LIKE �������� ó���� ����
 
 
��) �Ǹ�����(CART)���� 2005�⵵�� �Ǹŵ� ��ǰ �� ��ǰ�� '����'���� �����ϴ� 
    ��ǰ�� �Ǹż����հ� ����ݾ��հܸ� ���϶�
    
--CART���̺��� ��ǰ���̾��� PROD ���̺� �ִ�. �ܰ��� ���� 
--��ǰ���� �׷��� ��� ���踦 ���� 

SELECT CART_PROD,
       PROD_NAME,
       SUM(CART_QTY),
       SUM(CART_QTY*PROD_PRICE)
  FROM CART, PROD
 WHERE SUBSTR(CART_NO,1,4) = '2005'
   AND SUBSTR(PROD_NAME,1,2)='����'
   AND CART_PROD=PROD_ID
 GROUP BY CART_PROD,PROD_NAME;


SELECT CART_PROD,
       PROD_NAME,
       SUM(CART_QTY),
       SUM(CART_QTY*PROD_PRICE)
  FROM CART, PROD
 WHERE CART_NO LIKE '2005%'
   AND PROD_NAME LIKE '����%'
   AND CART_PROD=PROD_ID
 GROUP BY CART_PROD,PROD_NAME;

6)REPLACE
 - ���ǵ� ���ڿ����� Ư�� ������ �ٸ� ���ڿ��� ��ġ
 (�������)
 REPLACE(c1,c2 [,c3]) --�ܾ�ο� ���ԵȰ����� �����ϰ����Ҷ� ���
  . 'c1'�� ���ڿ����� c2 ���ڿ��� ã�� C3 ���ڿ��� ġȯ
  . 'c3'�� �����Ǹ� ã�� ���ڿ��� �����Ѵ�.
  
��)�ŷ�ó���̺�(BUYER)���� �ŷ�ó�ּ� �� '����'�� '����������'�� �����Ͻÿ�
-- ��� �ٸ��������� �Է��Ͽ����� ����� ������ �������� ����ǵ��� �ٲ��ִ� ����
 ������ �ִ��� ��ȸ
SELECT BUYER_ID, BUYER_NAME
  FROM BUYER
 WHERE SUBSTR(BUYER_ADD1,1,2)='����';
 
 '����'�� '����������'�� ġȯ
SELECT BUYER_ID AS �ŷ�ó�ڵ�,
       BUYER_NAME AS �ŷ�ó��,
       BUYER_ADD1 AS �⺻�ּ�,
       REPLACE(BUYER_ADD1, '����', '���������� ') AS �⺻�ּ�2
  FROM BUYER
 WHERE SUBSTR(BUYER_ADD1,1,2)='����';
 
��)�ŷ�ó���̺�(BUYER)���� �ŷ�ó�ּҿ� ���Ե� ������ �����Ͻÿ�
SELECT BUYER_ID AS �ŷ�ó�ڵ�,
       BUYER_NAME AS �ŷ�ó��,
       BUYER_ADD1 AS �⺻�ּ�,
       REPLACE(BUYER_ADD1, ' ') AS �⺻�ּ�2
  FROM BUYER;

7)TRANSLATE  --���� �Ⱦ�
 - Ư�����ڿ��� ���ǵ� ���Ĺ��ڿ��� MAPPING�Ͽ� ��ȯ�� ��� ��ȯ
 (�������)
 TRANSLATE(c1,c2,c3)
  . c1�� ���Ե� ���ڿ��� c2�� ���ǵ� ���ڿ��� c3���ڿ��� ��ȯ
  
SELECT MEM_NAME,
       MEM_PASS,
       TRANSLATE(MEM_PASS, '0123456789', 'ABCDEFGHHIJ')
  FROM MEMBER;

8)INSTR
 - ã�����ϴ� ������ ��ġ��(INDEX)�� ��ȯ --ORACLE ������ 1������ ī��Ʈ�ȴ�.
 (�������)
 INSTR(c1,c2 [,m [,n]])
  . c1���ڿ����� c2������ ��ġ���� ��ȯ
  . m�� �˻� ������ġ
  . n�� �ݺ��Ǵ°�� n��° �ݺ��� ������ ��ġ

��)
SELECT INSTR('���� �ʸ� �𸣴µ� �ʴ� ���� �ưڴ���','��'), -- ��ó�������� '��'�� ��ġ //4
       INSTR('���� �ʸ� �𸣴µ� �ʴ� ���� �ưڴ���','��',5), -- 5��° ���Ŀ� ������ '��'�� ��ġ //12 
       INSTR('���� �ʸ� �𸣴µ� �ʴ� �ʸ� �ưڴ���','��',5,2), -- 5��° ���Ŀ� 2��° '��'�� ��ġ //15
       INSTR('���� �ʸ� �𸣴µ� �ʴ� ���� �ưڴ���','��',5,2) -- ���� ��쿡�� //0
  FROM DUAL;

9)LENGTH(LENGTHB)
 - �־��� ���ڿ��� ���ڼ�(LENGTH) �Ǵ� �������� ũ��(LENGTHB)�� ��ȯ
 (�������)
 LENGTH(c1)
 
��)�μ����̺��� �μ����� ���ڼ��� ������ ũ�⸦ ����Ʈ�� ��Ÿ���ÿ�
SELECT DEPARTMENT_NAME,             -- �ѹ���ȹ��
       LENGTH(DEPARTMENT_NAME),     -- 5
       LENGTHB(DEPARTMENT_NAME)     -- 15
  FROM DEPARTMENTS;





