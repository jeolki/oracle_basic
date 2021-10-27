����(SELF-JOIN)����
 - �ϳ��� ���̺� �ΰ��� ��Ī�� �ο��Ͽ� ���ο����� �����ϴ� ���
 
��) �ŷ�ó���̺��� �ŷ�ó�ڵ尡 'P10101'�� �ŷ�ó�� ����
    ������ ���� �ŷ�ó�� ��ȸ�Ͻÿ�(�ŷ�ó�ڵ�, �ŷ�ó��, �ּ�)
    
SELECT B.BUYER_ID AS �ŷ�ó�ڵ�,
       B.BUYER_NAME AS �ŷ�ó��,
       B.BUYER_ADD1 ||' '|| B.BUYER_ADD2 AS �ּ�
  FROM BUYER A, BUYER B
 WHERE UPPER(A.BUYER_ID) = 'P10101'    -- A ���̺��� P10101������ �ڷḸ �����Ե�
   AND SUBSTR(A.BUYER_ADD1,1,2) = SUBSTR(B.BUYER_ADD1,1,2)
 
   -- ��ü�ڷḦ B���̺��� ����ؾ��Ѵ�.
   
   
��)������̺��� �μ��� ��ձ޿��� ����ϰ� �ڱ�μ��� ��ձ޿����� ���� �޿��� �޴� ����� ��ȸ�Ͻÿ�      
   Alias�� �����ȣ, �����, �μ���ȣ, �μ���, �޿�
   
SELECT A.EMPLOYEE_ID AS �����ȣ,
       A.EMP_NAME AS �����,
       A.DEPARTMENT_ID AS �μ���ȣ,
       B.DEPARTMENT_NAME AS �μ���,
       A.SALARY AS �޿�      
  FROM EMPLOYEES A, DEPARTMENTS B, (SELECT DEPARTMENT_ID AS DEPT_ID, 
                                           ROUND(AVG(SALARY),1) AS SAL_AVG 
                                      FROM EMPLOYEES
                                     GROUP BY DEPARTMENT_ID) C
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
   AND C.DEPT_ID = A. DEPARTMENT_ID
   AND A.SALARY >= C.SAL_AVG
 ORDER BY 3;
 
 
(�μ��� ��ձ޿�)
SELECT DEPARTMENT_ID 
       ROUND(AVG(SALARY),1) 
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID

--�μ��� ���� ��ձ޿����� �޿��� ���ƾ��Ѵ�.