1. JOIN ( ���̺� ���� )

�� �ΰ��� ���̺��� ����� �÷��� �ݵ������ �ؾ���

������ �����ͺ��̽� �ý����� ���� �߿��� ���
����ȭ ������ �и��� ���̺���� �̿��Ͽ� �ʿ��� �÷����� ��ȸ
���̺� ������ ����(Relationship)�� �̿��� ����

( ������� )
SELECT [���̺��|���̺�Ī.] �÷���,.....
  FROM ���̺��1 [��Ī], ���̺��2 [��Ī], ......
 WHERE [���̺��|���̺�Ī.]�÷��� ������ [���̺��|���̺�Ī.]�÷��� --- ��������
   AND [���̺��|���̺�Ī.]�÷��� ������ [���̺��|���̺�Ī.]�÷��� --- ��������
   AND [�Ϲ�����];
   .���̺�Ī�� �������� ���̺� �̸��� ������ �÷��� �����ϴ� ���
   .���������� ���� ���̺��� n���϶� n-1�� �̻��̾�� �Ѵ�.
   .�������ǿ� ���� �÷� ������ ���� �������̾�� �Ѵ�.
   
   
2. �з�
1) Cartesian Product(ANSI������ Cross join)
��� ����� ���� ��ȯ EX) A���̺��� 100�� 8��, B���̺��� 50�� 10���� �����ǰ� �� ���̺� Cartesian Product�� �����ϸ� 5000�� 18���� ��� ��ȯ
�ʿ����� ���� ��� ������� ����
���������� ���ų� �߸� ������ ��� �߻�
����)

CART�� PROD���̺� ���� Cartesian Product�� ����
SELECT COUNT(*) AS ���Ǽ� 
  FROM CART A, PROD B

SELECT * 
  FROM CART A, PROD B


CART ���̺��� ���Ǽ�
SELECT COUNT(*) FROM CART;

PROD ���̺��� ���Ǽ�
SELECT COUNT(*) FROM PROD;   
   
SELECT 207*74 FROM DUAL;


2) Equi-JOIN(ANSI������ Inner join)
�������ǿ� '=' �����ڰ� ���� ����
���������̶�� �Ѵ�.
���������� �������� �ʴ� �ڷ�� ������
��κ��� ������ �������ο� ����
( ANSI ���� )
SELECT [���̺��|���̺�Ī.] �÷���,.....
  FROM ���̺��1 [��Ī]
 INNER JOIN ���̺��2 [��Ī] ON(�������� [AND �Ϲ�����] ....)  --���ο� ���õ� �Ϲ�����
[INNER JOIN ���̺��3 [��Ī] ON(�������� [AND �Ϲ�����] ....)]
                          :
[WHERE �Ϲ�����];                          -- ��ü�� ���õ� �Ϲ�����


����) ������̺�� �μ����̺��� �̿��Ͽ� �����ȣ, �����, �μ��ڵ�, �μ����� ����Ͻÿ�

(�⺻ ����)
SELECT EMPLOYEES.EMPLOYEE_ID AS �����ȣ,
       EMPLOYEES.EMP_NAME AS �����,
       EMPLOYEES.DEPARTMENT_ID AS �μ��ڵ�,
       DEPARTMENTS.DEPARTMENT_NAME AS �μ���
  FROM EMPLOYEES , DEPARTMENTS 
 WHERE EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID;

(��Ī ���)
SELECT A.EMPLOYEE_ID AS �����ȣ,
       A.EMP_NAME AS �����,
       A.DEPARTMENT_ID AS �μ��ڵ�,
       B.DEPARTMENT_NAME AS �μ���
  FROM EMPLOYEES A, DEPARTMENTS B
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID;
 
(ANSI ����)
SELECT A.EMPLOYEE_ID AS �����ȣ,
       A.EMP_NAME AS �����,
       A.DEPARTMENT_ID AS �μ��ڵ�,
       B.DEPARTMENT_NAME AS �μ���
  FROM EMPLOYEES A
 INNER JOIN DEPARTMENTS B ON (A.DEPARTMENT_ID = B.DEPARTMENT_ID);
 
����) ��ǰ���̺��� �з��ڵ尡 'P201'���� ���� �з��ڵ带 �ο�����
        ��ǰ�� ��ǰ��ȣ, ��ǰ��, �з��ڵ�, �з����� ��ȸ�Ͻÿ�
        
(�⺻ ����)
SELECT A.PROD_ID AS ��ǰ��ȣ,
       A.PROD_NAME AS ��ǰ��, 
       A.PROD_LGU AS �з��ڵ�,
       B.LPROD_NM AS �з���
  FROM PROD A, LPROD B
 WHERE A.PROD_LGU = B.LPROD_GU          -- ��������
   AND UPPER(A.PROD_LGU) <= 'P201';      -- �Ϲ�����
 
(ANSI ����)  
SELECT A.PROD_ID AS ��ǰ��ȣ,
       A.PROD_NAME AS ��ǰ��, 
       A.PROD_LGU AS �з��ڵ�,
       B.LPROD_NM AS �з���
  FROM PROD A
 INNER JOIN LPROD B ON (A.PROD_LGU = B.LPROD_GU)  
 WHERE UPPER(A.PROD_LGU) <= 'P201';
--  INNER JOIN LPROD B ON (A.PROD_LGU = B.LPROD_GU  
--    AND UPPER(A.PROD_LGU) <= 'P201');


����) 2005�� 6�� ȸ���� ���ų����� ��ȸ�Ͻÿ� ( Alias�� ȸ����ȣ, ȸ����, ���ż���, ���űݾ� )

(�⺻ ����)
SELECT A.CART_MEMBER AS ȸ����ȣ, 
       B.MEM_NAME AS ȸ����,
       SUM(A.CART_QTY) AS ���ż���,
       SUM(C.PROD_PRICE * A.CART_QTY) AS ���űݾ�
  FROM CART A, MEMBER B, PROD C
 WHERE A.CART_MEMBER = B.MEM_ID
   AND A.CART_PROD = C.PROD_ID
   AND SUBSTR(A.CART_NO,1,6) = '200506'
-- AND A.CART_NO LIKE '200506%'
 GROUP BY A.CART_MEMBER, B.MEM_NAME;
    
                                                         
(ANSI ����)
SELECT A.CART_MEMBER AS ȸ����ȣ, 
       B.MEM_NAME AS ȸ����,
       SUM(A.CART_QTY) AS ���ż���,
       SUM(C.PROD_PRICE * A.CART_QTY) AS ���űݾ�
  FROM CART A  
 INNER JOIN MEMBER B ON (A.CART_MEMBER = B.MEM_ID)
 INNER JOIN PROD C ON (A.CART_PROD = C.PROD_ID) -- (CART�� MEMBER�� �����̵Ǿ��� ���)�� PROD�� ����
 WHERE SUBSTR(A.CART_NO,1,6) = '200506' -- �̰�쿡�� ����ʿ��� �޾Ƶ� �������.
 GROUP BY A.CART_MEMBER, B.MEM_NAME;
    
SELECT A.CART_MEMBER AS ȸ����ȣ, 
       B.MEM_NAME AS ȸ����,
       SUM(A.CART_QTY) AS ���ż���,
       SUM(C.PROD_PRICE * A.CART_QTY) AS ���űݾ�
  FROM CART A  
 INNER JOIN MEMBER B ON (A.CART_MEMBER = B.MEM_ID)
 INNER JOIN PROD C ON (A.CART_PROD = C.PROD_ID 
   AND SUBSTR(A.CART_NO,1,6) = '200506') -- �̰�쿡�� ����ʿ��� �޾Ƶ� �������.
 GROUP BY A.CART_MEMBER, B.MEM_NAME;  
 
 SELECT A.CART_MEMBER AS ȸ����ȣ, 
       B.MEM_NAME AS ȸ����,
       SUM(A.CART_QTY) AS ���ż���,
       SUM(C.PROD_PRICE * A.CART_QTY) AS ���űݾ�
  FROM CART A  
 INNER JOIN MEMBER B ON (A.CART_MEMBER = B.MEM_ID
   AND SUBSTR(A.CART_NO,1,6) = '200506') -- �̰�쿡�� ����ʿ��� �޾Ƶ� �������.
 INNER JOIN PROD C ON (A.CART_PROD = C.PROD_ID) 
 GROUP BY A.CART_MEMBER, B.MEM_NAME; 
 
 
 -- �񱳵Ǵ� �÷�Ÿ���� �ٸ��� �������� ����ϸ� ������
 
 ����) 2005�� 2~3�� ���� �ŷ�ó�� ���������� ��ȸ�Ͻÿ�
       ( Alias �� �ŷ�ó�ڵ�, �ŷ�ó��, ���Լ����հ�, ���Աݾ��հ� )
       
(�⺻ ����)   
SELECT A.BUYER_ID AS �ŷ�ó�ڵ�,
       A.BUYER_NAME AS �ŷ�ó��,
       SUM(C.BUY_QTY)AS ���Լ����հ�,
       SUM(C.BUY_QTY * C.BUY_COST) AS ���Աݾ��հ�
  FROM BUYER A, PROD B, BUYPROD C
 WHERE A.BUYER_ID = B.PROD_BUYER
   AND B.PROD_ID = C.BUY_PROD
   AND C.BUY_DATE BETWEEN TO_DATE('20050201') AND TO_DATE('20050331')
 GROUP BY A.BUYER_ID, A.BUYER_NAME;
    
    
(ANSI ����)    
SELECT A.BUYER_ID AS �ŷ�ó�ڵ�,
       A.BUYER_NAME AS �ŷ�ó��,
       SUM(C.BUY_QTY)AS ���Լ����հ�,
       SUM(C.BUY_QTY * C.BUY_COST) AS ���Աݾ��հ�
  FROM BUYER A
 INNER JOIN PROD B ON (A.BUYER_ID = B.PROD_BUYER)
 INNER JOIN BUYPROD C ON (B.PROD_ID = C.BUY_PROD)
 WHERE C.BUY_DATE BETWEEN TO_DATE('20050201') AND TO_DATE('20050331')
 GROUP BY A.BUYER_ID, A.BUYER_NAME;
 
����) 2005�� 2~3�� ���� �ŷ�ó�� ���������� ��ȸ�Ͻÿ�
        ( Alias �� �ŷ�ó�ڵ�, �ŷ�ó��, ���Լ����հ�, ���Աݾ��հ� )
        ��, ���Աݾ��� 1000�����̻��̰�, �ŷ�ó �ּҰ� '����'�� �ڷḸ ��ȸ�Ͻÿ�
        
(�⺻ ����)    
SELECT A.BUYER_ID AS �ŷ�ó�ڵ�,
       A.BUYER_NAME AS �ŷ�ó��,
       SUM(C.BUY_QTY)AS ���Լ����հ�,
       SUM(C.BUY_QTY * C.BUY_COST) AS ���Աݾ��հ�
  FROM BUYER A, PROD B, BUYPROD C
 WHERE A.BUYER_ID = B.PROD_BUYER
   AND B.PROD_ID = C.BUY_PROD
   AND SUBSTR(A.BUYER_ADD1,1,2) = '����'
   AND C.BUY_DATE BETWEEN TO_DATE('20050201') AND TO_DATE('20050331')
 GROUP BY A.BUYER_ID, A.BUYER_NAME    
HAVING SUM(C.BUY_QTY * C.BUY_COST) >= 10000000;


(ANSI ����)    
SELECT A.BUYER_ID AS �ŷ�ó�ڵ�,
       A.BUYER_NAME AS �ŷ�ó��,
       SUM(C.BUY_QTY)AS ���Լ����հ�,
       SUM(C.BUY_QTY * C.BUY_COST) AS ���Աݾ��հ�
  FROM BUYER A
 INNER JOIN PROD B ON (A.BUYER_ID = B.PROD_BUYER AND SUBSTR(A.BUYER_ADD1,1,2) = '����')
 INNER JOIN BUYPROD C ON (B.PROD_ID = C.BUY_PROD )
 WHERE C.BUY_DATE BETWEEN TO_DATE('20050201') AND TO_DATE('20050331')
 GROUP BY A.BUYER_ID, A.BUYER_NAME;    
HAVING SUM(C.BUY_QTY * C.BUY_COST) >= 10000000