1.RANK �Լ�
(RANK()�Լ� ���)
SELECT A.DID AS �μ���ȣ,
       A.PAMT AS �����
  FROM (SELECT DEPARTMENT_ID AS DID,
               COUNT(*) AS PAMT,
               RANK() OVER(ORDER BY COUNT(*) DESC) AS ���� 
          FROM EMPLOYEES
         GROUP BY DEPARTMENT_ID
         ORDER BY 2 DESC) A
  WHERE ����=1;
  
  -- ( �����ϼ��� �����̵Ǵ��÷���(����) ����) ����� ���ؼ� �ο��Ѵ�.
  -- RANK() OVER(ORDER BY �÷��� DESE/ASC )
  
  -- RANK�� ������ 3����
  
1) RANK() �Լ�
  - ������ ���� �ߺ� ���� �ο��� �� ���� ���� �ش� ���� ��ŭ �ǳʶٰ� �ο�
  (�������)
  SELECT �÷���1,
         �÷���2,
           :
         RANK() OVER(ORDER BY �����÷�(�Ǵ� ����) DESC|ASC) AS ��Ī
    FROM ���̺��
    
��) �������̺�(CART)�� 2005�� 5�� ��ǰ�� �Ǹż����հ踦 ���ϵ� �Ǹż����� ���� ��ǰ������ ������ �ο��Ͻÿ�
    Alias ��ǰ�ڵ�, ��ǰ��, �Ǹż����հ�, ����

SELECT A.CART_PROD AS ��ǰ�ڵ�,
       B.PROD_NAME AS ��ǰ��,
       SUM(A.CART_QTY)AS �Ǹż����հ�,
       RANK() OVER(ORDER BY SUM(A.CART_QTY) DESC) AS ����
  FROM CART A, PROD B
 WHERE A.CART_PROD = B.PROD_ID
   AND CART_NO LIKE '200505%'
 GROUP BY A.CART_PROD, B.PROD_NAME;



2) DENSE_RANK()�Լ�
  - ������ ���� �ߺ� ���� �ο��� �� ���� ������ �ߺ������� ������� �������� ���� �ο�
  (�������)

��) �������̺�(CART)�� 2005�� 5�� ��ǰ�� �Ǹż����հ踦 ���ϵ� �Ǹż����� ���� ��ǰ������ ������ �ο��ϰ�
    ���� 10���� ��ǰ������ ��ȸ�Ͻÿ�
   (DENSE_RANK ���)
    Alias ��ǰ�ڵ�, ��ǰ��, �Ǹż����հ�, ����
SELECT A.PCODE AS ��ǰ�ڵ�,
       A.AMT AS �Ǹż���,
       A.RK AS ����
  FROM (SELECT CART_PROD AS PCODE,
               SUM(CART_QTY)AS AMT,
               DENSE_RANK() OVER(ORDER BY SUM(CART_QTY) DESC) AS RK
          FROM CART
         WHERE CART_NO LIKE '200505%'
         GROUP BY CART_PROD) A
 WHERE A.RK <= 10;
         
         
-- �������̺� VIEW ��� �Ѵ�. ���� VIEW�� ������ ����� �信 �̸��� �ٿ���
-- ���̺� �̸��� �ٿ��ش� AS������� �ʴ´�

SELECT A.PCODE AS ��ǰ�ڵ�,
       A.AMT AS �Ǹż���,
       A.RK AS ����
  FROM (SELECT CART_PROD AS PCODE,
               SUM(CART_QTY)AS AMT,
               RANK() OVER(ORDER BY SUM(CART_QTY) DESC) AS RK
          FROM CART
         WHERE CART_NO LIKE '200505%'
         GROUP BY CART_PROD) A
 WHERE A.RK <= 10;
--���� 10��

---
SELECT C.PCODE AS ��ǰ�ڵ�,
       C.PNAME AS ��ǰ��,
       C.AMT AS �Ǹż���,
       C.RK AS ����    
  FROM (SELECT A.CART_PROD AS PCODE,
               B.PROD_NAME AS PNAME,
               SUM(A.CART_QTY)AS AMT,
               RANK() OVER(ORDER BY SUM(A.CART_QTY) DESC) AS RK
          FROM CART A, PROD B
         WHERE A.CART_PROD = B.PROD_ID
           AND CART_NO LIKE '200505%'
         GROUP BY A.CART_PROD, B.PROD_NAME) C
 WHERE C.RK <= 10;
---

3) ROW_NUMBER() �Լ�
  - �ߺ��� ������� ���ʴ�� �����ο�

SELECT A.PCODE AS ��ǰ�ڵ�,
       A.AMT AS �Ǹż���,
       A.RK AS ����
  FROM (SELECT CART_PROD AS PCODE,
               SUM(CART_QTY)AS AMT,
               ROW_NUMBER() OVER(ORDER BY SUM(CART_QTY) DESC) AS RK
          FROM CART
         WHERE CART_NO LIKE '200505%'
         GROUP BY CART_PROD) A
 WHERE A.RK <= 10;
 --���� 10���� �������������� ROW_NUMBER �̿�
 --ROW_NUMBER�� �������� �־ ����� �׳� ���������� �ο��Ѵ�.
  
 
  
4) �׷캰 ����ο�(PARTITION BY)
  - RANK, DENSE_RANK, ROW_NUMBER�� �Բ� ����Ͽ� �׷캰 ���� �ο�
  (�������)
  RANK() OVER(PARTITION BY �׷�з� �����׸� ORDER BY ����ο� �����׸� DESC|ASC)

��) ������̺��� �μ��� �޿��� ���� �޴� ������� ������ �ο��Ͽ� ��ȸ�Ͻÿ�
   Alias�� �����ȣ, �����, �μ���ȣ, �޿�, �����̰� �μ���ȣ������ ����Ͻÿ�

SELECT EMPLOYEE_ID AS �����ȣ,
       EMP_NAME AS �����,
       DEPARTMENT_ID AS �μ���ȣ,
       SALARY AS �޿�,
       RANK() OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY DESC) AS ����
  FROM EMPLOYEES
 ORDER BY 3;








