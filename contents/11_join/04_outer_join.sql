 �ܺ�����
 - ���������� �������ǿ� �������� �ڷḦ �����ϰ� ��� ��ȯ
 - �ܺ������� �ڷᰡ ������ �� ���̺� ������ �ุŭ NULL�� �߰� �����Ͽ� ���� ����
 - �������ǿ��� �����Ͱ� ���� ���̺��� �÷��� �ܺ����� ������ '(+)'�� �ٿ����
 - �ܺ����� ������ �ΰ� �̻��ΰ�� ��� �������ǿ� �ܺ����� �����ڸ� ���
 - �ѹ��� �����̺��� �ܺ������� �Ҽ� �ִ�.
   ��) A,B,C ���̺��� A�� �������� B���̺��� �ܺ����� �ߴٸ�
      ���ÿ� C�� �������� B���̺��� �ܺ����� �� �� ����.
      ��,
      WHERE A.COL = B.COL(+)
        AND C.COL = B.COL(+)�� ������ ����  -- C.COL(+)�� ����
 - �ܺ����� ������ '(+)'�� OR �����ڴ� ���� ����� �� ����.

 (�Ϲ� �ܺ����� ��� ����)
 SELECT �÷�list
   FROM ���̺��1, ���̺��2 [,...]
  WHERE ���̺��1.�÷��� = ���̺��2.�÷���(+)  -- �ڷ��� ������ �����Ҷ� ���Ǽ��� �ƴ�!!
  -- ���̺��1.�÷���(+) = ���̺��2.�÷���(+) ������ ��� �����Ҷ�


 (ANSI �ܺ����� ��� ����)
 SELECT �÷�list
   FROM ���̺��1
  LEFT|RIGHT|FULL [OUTER] JOIN ���̺��2 ON(���̺��1.�÷��� = ���̺��2.�÷���
   [AND �Ϲ�����])
 [WHERE �Ϲ�����];
 
  .'LEFT OUTER JOIN'�� '���̺��1'�� �����Ͱ� '���̺��2'�� �����ͺ��� ���� ���
  .'RIGHT OUTER JOIN'�� '���̺��2'�� �����Ͱ� '���̺��1'�� �����ͺ��� ���� ���
  .'FULL OUTER JOIN'�� ���� ���̺� ��� �����Ѱ�� 
  
��)��ü �з��ڵ庰 ��ǰ�� ���� ��ȸ�Ͻÿ� 
  Alias�� �з��ڵ�, �з���, ��ǰ�Ǽ�

(��������)
SELECT A.LPROD_GU AS �з��ڵ�,
       A.LPROD_NM AS �з���,
       COUNT(*) AS ��ǰ�Ǽ�
  FROM LPROD A, PROD B
 WHERE A.LPROD_GU = B.PROD_LGU
 GROUP BY A.LPROD_GU, A.LPROD_NM;
   
  ** �з����̺��� �з��� ����
  SELECT COUNT(*) FROM LPROD;  -- 9����
  
  ** ��ǰ���̺��� ���Ǵ� �з��� ����
  SELECT COUNT(DISTINCT PROD_LGU) FROM PROD;  -- 6����
  
  PROD�� LPROD���� ������ �۱⶧���� (+)�� PROD�� �ٴ´� 

(�ܺ�����)
SELECT A.LPROD_GU AS �з��ڵ�,
       A.LPROD_NM AS �з���,
       NVL(COUNT(B.PROD_ID),0) AS ��ǰ�Ǽ� -- ����� �Ǿ����� ���̺��� Ű�� Į������ ���ָ� ��������
  FROM LPROD A, PROD B
 WHERE A.LPROD_GU = B.PROD_LGU(+)
 GROUP BY A.LPROD_GU, A.LPROD_NM
 ORDER BY 1;

(ANSI �ܺ�����)
SELECT A.LPROD_GU AS �з��ڵ�,
       A.LPROD_NM AS �з���,
       NVL(COUNT(B.PROD_ID),0) AS ��ǰ�Ǽ� 
  FROM LPROD A
  LEFT OUTER JOIN PROD B ON (A.LPROD_GU = B.PROD_LGU)
 GROUP BY A.LPROD_GU, A.LPROD_NM
 ORDER BY 1;

-- LEFT �� �Ⱦ��� RIGHT�� ����ϸ� INNER JOIN �� ����� ���´�. 
 
��)������̺�� �μ����̺��� �����Ͽ� ��ü �μ��� ������� ��ȸ�Ͻÿ�
   Alias�� �μ��ڵ�, �μ���, �����
   
   **�μ����̺��� �μ��ڵ��� ����
   SELECT COUNT(*) FROM DEPARTMENTS;  --27 NULL�̾��� ������
   
   **������̺��� ������� �μ��ڵ��� ��
   SELECT DISTINCT DEPARTMENT_ID FROM EMPLOYEES; -- 12 NULL���� ������������

(�Ϲ� �ܺ�����) -- �Ϲ� �ܺ����ο����� FULL OUTER JOIN�� �������� �ʴ´�.
SELECT B.DEPARTMENT_ID AS �μ��ڵ�,
       B.DEPARTMENT_NAME AS �μ���,
       NVL(COUNT(A.EMPLOYEE_ID),0) AS ����� 
  FROM EMPLOYEES A, DEPARTMENTS B 
 WHERE A.DEPARTMENT_ID(+) = B.DEPARTMENT_ID(+)
 GROUP BY B.DEPARTMENT_ID, B.DEPARTMENT_NAME
 ORDER BY 1; 


(ANSI �ܺ�����)
SELECT NVL(TO_CHAR(B.DEPARTMENT_ID),'����') AS �μ��ڵ�,
       NVL(B.DEPARTMENT_NAME,'����') AS �μ���,
       NVL(COUNT(A.EMPLOYEE_ID),0) AS ����� 
  FROM EMPLOYEES A
  FULL OUTER JOIN DEPARTMENTS B ON (A.DEPARTMENT_ID = B.DEPARTMENT_ID)
 GROUP BY B.DEPARTMENT_ID, B.DEPARTMENT_NAME
 ORDER BY B.DEPARTMENT_ID; 
 
 
 
 2005�� 6�� ��ǰ�� ����װ��
 Alias�� ��ǰ��ȣ, ��ǰ��, �����

(��������)
SELECT A.CART_PROD AS ��ǰ��ȣ,
       B.PROD_NAME AS ��ǰ��,
       SUM(A.CART_QTY * B.PROD_PRICE) AS �����
  FROM CART A, PROD B
 WHERE A.CART_PROD = B.PROD_ID
   AND A.CART_NO LIKE '200506%'
 GROUP BY A.CART_PROD, B.PROD_NAME
 ORDER BY 1;
 
-- �������ǿ� �����ʴ� �ڷ�� ��� ���õȴ� => ��������

-- �ܺ�����
-- CART ���̺��� �ڷᰡ PROD ���� �����ϴ� ������ ����� ��� NULL�θ� ä��� PROD ���̺�� �������Ѵ�.
-- �׷� ������� 1:1�� �񱳰��ȴ�.

-- ��� , ���ζ�� ���� ���Ǹ� ��� ��������ϱ⶧���� OUTER ������ �ؾ��Ѵ�.
-- ��κ��ϰ� ���ȸ����� 0���� ���� ����Ѵ�. ��簪�� ��

-- �ɼ� ������ ANSI ������ ����Ѵ�. 
-- �Ϲ� ������ �������ǰ� �Ϲ������� ���յǸ� �������ʱ⶧���� ���������� ANSI�� ����ؼ� OUTER�����Ѵ�.

(�ܺ�����)
SELECT B.PROD_ID AS ��ǰ��ȣ,
       B.PROD_NAME AS ��ǰ��,
       COUNT(A.CART_PROD) AS �Ǹ�Ƚ��,
       NVL(SUM(A.CART_QTY * B.PROD_PRICE), 0) AS �����
  FROM CART A, PROD B
 WHERE A.CART_PROD(+) = B.PROD_ID
--   AND A.CART_NO LIKE '200506%' �Ϲ������� �������� ��� �������ʴ´�.
 GROUP BY B.PROD_ID, B.PROD_NAME
 ORDER BY 1;

-- COUNT ���� *�� ����ϸ� �ȵȴ�. ���������� NULL �̶� 1�� �Ǳ⶧����
-- �ݵ�� �÷����� ����Ѵ�.

-- ��ǰ��ȣ�� NULL�̵��ִ� ������ CART�� NULL�� �־�Z�⶧���� CART���� ����ϸ� NULL�̳��´�.
-- �����÷��� �����Ѵٸ� ū���� ����ؾ��Ѵ�. A.CART_PROD -> B.PROD_ID

-- (+)�� �������ʿ� ��´�.

-- NVL�� �̿��Ͽ� ������� NULL�̸� 0�� ��µǵ����Ѵ�.


��) ��ٱ��� ���̺��� 2005�� 4�� ��� ȸ���� ������Ȳ�� ��ȸ�Ͻÿ� --�Ϲ�����
    Alias�� ȸ����ȣ, ȸ����, ����Ƚ��, ���űݾ� --MEMBER CART PROD ����

(��������) -- ���°��� �����ع�����.
SELECT A.CART_MEMBER AS ȸ����ȣ,
       B.MEM_NAME AS ȸ����,
       COUNT(*) AS ����Ƚ��,
       SUM(A.CART_QTY*C.PROD_PRICE)AS ���űݾ�
  FROM CART A, MEMBER B, PROD C
 WHERE A.CART_MEMBER = B.MEM_ID --��������(ȸ���� ����)
   AND A.CART_PROD = C.PROD_ID --��������(��ǰ�� �ܰ�����)
   AND A.CART_NO LIKE '200504%'
 GROUP BY A.CART_MEMBER, B.MEM_NAME
 ORDER BY 1;

(�Ϲ� �ܺ����� ��� ����) --�������ΰ� �������.. ������ ������ 0�� ������ ���;��Ѵ�.
SELECT A.CART_MEMBER AS ȸ����ȣ,
       B.MEM_NAME AS ȸ����,
       COUNT(*) AS ����Ƚ��,
       SUM(A.CART_QTY*C.PROD_PRICE)AS ���űݾ�
  FROM CART A, MEMBER B, PROD C
 WHERE A.CART_MEMBER(+) = B.MEM_ID --�ѹ�Ȯ��Ǹ� �� Ȯ��ɼ� ����
   AND A.CART_PROD = C.PROD_ID 
   AND A.CART_NO LIKE '200504%' -- �Ϲ������� �ο��Ǿ������ �Ϲݿܺ������������δ� �ذ��Ҽ� ����.
 GROUP BY A.CART_MEMBER, B.MEM_NAME
 ORDER BY 1;

(ANSI �ܺ�����)
SELECT B.MEM_ID AS ȸ����ȣ,
       B.MEM_NAME AS ȸ����,
       COUNT(A.CART_MEMBER) AS ����Ƚ��, -- �ƿ��������� *����ȵǰ� ����ǵǴ� ���̺��� PK���
       NVL(SUM(A.CART_QTY*C.PROD_PRICE),0) AS ���űݾ�
  FROM CART A
 RIGHT OUTER JOIN MEMBER B ON (A.CART_MEMBER = B.MEM_ID AND A.CART_NO LIKE '200504%')
  LEFT OUTER JOIN PROD C ON (A.CART_PROD = C.PROD_ID)
 GROUP BY B.MEM_ID, B.MEM_NAME
 ORDER BY 1;
 
 
��) ��ٱ��� ���̺��� 2005�� 4�� ��� ��ǰ�� ������Ȳ�� ��ȸ�Ͻÿ� 
    Alias�� ��ǰ�ڵ�, ��ǰ��, ����Ƚ��, ���űݾ�
    
SELECT B.PROD_ID AS ��ǰ�ڵ�,
       B.PROD_NAME AS ��ǰ��,
       COUNT(A.CART_MEMBER) AS ����Ƚ��,
       NVL(SUM(A.CART_QTY*B.PROD_PRICE),0) AS ���űݾ�
  FROM CART A
 RIGHT OUTER JOIN PROD B ON (A.CART_PROD = B.PROD_ID 
   AND A.CART_NO LIKE '200504%')
 GROUP BY B.PROD_ID, B.PROD_NAME
 ORDER BY 1;


��)2005�� 6�� ��ü ��ǰ�� ����, ������Ȳ�� ��ȸ�Ͻÿ�
  Alias�� ��ǰ�ڵ�, ��ǰ��, ���Աݾ��հ�, ����ݾ��հ�
  ��, ������Աݾ��� ������ '0'���� ����ϰ� ��ǰ��ȣ������ ���

(ANSI �ܺ�����)
SELECT A.PROD_ID AS ��ǰ�ڵ�,
       A.PROD_NAME AS ��ǰ��,
       NVL(SUM(B.BUY_QTY * A.PROD_COST),0) AS ���Աݾ��հ�,
       NVL(SUM(C.CART_QTY * A.PROD_PRICE),0) AS ����ݾ��հ�
  FROM PROD A   
  LEFT OUTER JOIN BUYPROD B ON (B.BUY_PROD = A.PROD_ID
   AND BUY_DATE BETWEEN TO_DATE('20050601') AND TO_DATE('20050630'))
  LEFT OUTER JOIN CART C ON (A.PROD_ID = C.CART_PROD
   AND C.CART_NO LIKE '200506%')
 GROUP BY A.PROD_ID, A.PROD_NAME
 ORDER BY 1;
 
 (SUBQUERY)
SELECT A.PROD_ID AS ��ǰ�ڵ�,
       A.PROD_NAME AS ��ǰ��,
       NVL(B.IAMT,0) AS ���Աݾ��հ�,
       NVL(C.OAMT,0) AS ����ݾ��հ�
  FROM PROD A,
       -- 2005�� 6�� ��ǰ�� ��������(��������)
     ( SELECT BUY_PROD, 
              SUM(BUY_QTY*BUY_COST) AS IAMT
         FROM BUYPROD
        WHERE BUY_DATE BETWEEN TO_DATE('20050601') AND TO_DATE('20050630')
        GROUP BY BUY_PROD) B,
       -- 2005�� 5�� ��ǰ�� ��������(��������)
     ( SELECT CART_PROD,
              SUM(CART_QTY*PROD_PRICE) AS OAMT
         FROM CART, PROD 
        WHERE PROD_ID = CART_PROD
          AND CART_NO LIKE '200506%'
        GROUP BY CART_PROD) C
 WHERE A.PROD_ID = B.BUY_PROD(+)
   AND A.PROD_ID = C.CART_PROD(+)
 ORDER BY 1;

��) 2005�� 1�� ��� �ŷ�ó�� ������Ȳ�� ��ȸ�Ͻÿ�
    Alias�� �ŷ�ó��, ���Աݾ��̸� �ŷ�ó ������ ����Ͻÿ�
    
SELECT A.BUYER_NAME AS �ŷ�ó��,     
       NVL(SUM(C.BUY_QTY*B.PROD_COST),0) AS ���Աݾ�
  FROM BUYER A
  LEFT OUTER JOIN PROD B ON (A.BUYER_ID = B.PROD_BUYER)
  LEFT OUTER JOIN BUYPROD C ON (C.BUY_PROD = B.PROD_ID
   AND C.BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050131'))
 GROUP BY A.BUYER_NAME
 ORDER BY 1; 