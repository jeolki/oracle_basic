2020-06-17-02)�����Լ�
 - SUM, AVG, COUNT, MIN, MAX
 - ���� GROUP BY ���� ���̻�� 
 -- SELECT ������ �Ϲ��׸�� �����Լ��� ���̻��ɶ����� ������ GROYP BY �� ����ؾ��Ѵ�.
 (GROUP BY�� ����ؾ� �ϴ� ���)
  . SELECT������ �Ϲ��׸�(�÷�, ����)�� �����Լ��� ���� ���� ���
  . GROUP BY �÷���1 [, �÷���2,....] -- �÷���1�� ����� �׼ӿ��� �÷���2�� ������ �׷��� ����
  . SELECT������ ���� �Ϲ��׸�(�÷�, ����)�� �ݵ�� GROUP BY ���� ����ؾ� �Ѵ�.!
  . �����Լ��� �ο��� ������ HAVING���� ���
  --SELECT / FROM / WHERE / GROUP BY / HAVING / ORDER BY ����
  . GROUP BY���� WHERE�� ������ ��� (WHERE���� ���� ����)
  . HAVING���� GROUP BY�� ������ ��� 
  . ORDER BY���� �� �������� ���
  
1) COUNT(*|�÷���)  
  -- �ƿ��� �����Ҷ��� �ݵ�� �÷����� ����Ѵ� 
  - ���Ǽ��� ��ȯ

��) ������̺��� ��ü ������� ��ȸ�Ͻÿ�
SELECT COUNT(*), COUNT(EMP_NAME) 
  FROM EMPLOYEES;
-- �Ϲ��Լ��� �������ʾҰ� �����Լ��� ���Ǿ��⶧���� �׷���̸� ������� ����
-- ��ü�� �׷����� ���� 

��) ������̺��� �μ��� ������� ��ȸ�Ͻÿ�
SELECT DEPARTMENT_ID AS �μ��ڵ�,
       COUNT(*) AS �����
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
 ORDER BY 1;
  

��) ������̺��� �޿��� 3000�̻��� �μ��� ������� ��ȸ�Ͻÿ�  
SELECT DEPARTMENT_ID AS �μ��ڵ�,
       COUNT(*) AS �����
  FROM EMPLOYEES
 WHERE SALARY >= 3000
 GROUP BY DEPARTMENT_ID
 ORDER BY 1;  
  
��) ��ǰ���̺��� �з��� ��ǰ���� ��ȸ�Ͻÿ�
SELECT PROD_LGU AS ��ǰ�з��ڵ�,
       COUNT(*) AS ��ǰ��
  FROM PROD
 GROUP BY PROD_LGU
 ORDER BY 1;
  
��) ��ǰ���̺��� �з��� ��ǰ���� 20�� �̻��� �ڷḦ ��ȸ�Ͻÿ� 
SELECT PROD_LGU AS ��ǰ�з��ڵ�,
       COUNT(*) AS ��ǰ��
  FROM PROD
 GROUP BY PROD_LGU
HAVING COUNT(*) >= 20
 ORDER BY 1;  
  
2) SUM(�÷���)
  - '�÷���'�� ����� �ڷ��� �հ踦 ��ȯ
  
��) ������̺��� �� �μ��� �޿� �հ踦 ���Ͻÿ�
    Alias�� �μ��ڵ�, �μ���, �޿��հ�
SELECT A.DEPARTMENT_ID AS �μ��ڵ�,
       B.DEPARTMENT_NAME AS �μ���,
       COUNT(*) AS �����,
       NVL(SUM(A.SALARY), 0) AS �޿��հ�
  FROM EMPLOYEES A, DEPARTMENTS B
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID -- ������������
 GROUP BY A.DEPARTMENT_ID, B.DEPARTMENT_NAME  --�����Լ��� ������ ���� �Ϲ��׸��� ��� ������ 
 ORDER BY 3 DESC; 
 -- �÷��� ������ȣ�� ASC�������� �� DESC������������ ����.
 -- �޿��� �հ� ������������ 
  
��) 2005�� 2~5�� ���� �߻��� ��ǰ�� �������踦 ���Ͻÿ�
   Alias�� ��ǰ�ڵ�, ���Լ����հ�, ���Աݾ��հ�
   ��, ��ǰ�ڵ������ ����Ͻÿ�
  
SELECT BUY_PROD AS ��ǰ�ڵ�,
       SUM(BUY_QTY) AS ���Լ����հ�,
       SUM(BUY_COST*BUY_QTY) AS ���Աݾ��հ�,
       COUNT(*) AS ���԰Ǽ�
  FROM BUYPROD
 WHERE BUY_DATE BETWEEN TO_DATE('20050201') AND TO_DATE('20050531') 
 GROUP BY BUY_PROD   -- SELECT ������ �����Լ��� ������ �Ϲݼ����̳� �׸��� ���Ǿ����� GROUP BY ���
 ORDER BY 1;
  -- SELECT ���� ������ �׷��� ������Ѵٸ� ���� ���̺� �ִ� �Ϲ��׸��� ����Ҽ� �ִ�. 2�� �׷��� 
  -- GROUP BY BUY_PROD, BUY_DATE
  
  
  
  
  
  