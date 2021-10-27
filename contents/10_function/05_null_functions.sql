 1.NULLó�� �Լ�
 - ���̺� ����� ������ �� NULL �ڷ� ���� ���� �� ������ ���� 
 - NVL, NVL2, NULLIF, IS NULL(IS NOT NULL) ������ NULL���� ó��
   --  = NULL �ϸ� ó�����Ѵ�. IS NULL �μ� ������Ѵ�.
 
1) NVL(expr1, expr2)
  - 'expr1'�� ���� NULL �̸� 'expr2'�� ��ȯ�ϰ�
    'expr1'�� ���� NULL �� �ƴϸ� �ڱ��ڽ��� �� ('expr1')�� ��ȯ
  - 'expr1'�� 'expr2'�� ���� ������ Ÿ���̾�� �� 
 
��)������̺��� ������� ���ʽ��� ����Ͽ� ��ȸ�Ͻÿ�
   ��, 80���� 50�� �μ��� ���� ����� ��ȸ�Ͻÿ�
   ���ʽ� = ���� * ��������(COMMISSION_PCT)�� 30%�̴�.
   Alias�� �����ȣ, �����, �޿�, ���ʽ�

SELECT EMPLOYEE_ID AS �����ȣ,
       EMP_NAME AS �����,
       SALARY AS �޿�,
       NVL(SALARY * COMMISSION_PCT*0.3, 0) * 0.3 AS ���ʽ�,
       SALARY + NVL(SALARY * COMMISSION_PCT*0.3, 0) AS ���޾�
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID = 80
    OR DEPARTMENT_ID = 50;
   
    -- NVL(SALARY * COMMISSION_PCT*0.3, '����') * 0.3 AS ���ʽ� -- ��������
    -- ������ ��� ���� Ÿ���̿��� �Ѵ�.
    -- NVL(TO_CHAR(SALARY * COMMISSION_PCT*0.3), '����') * 0.3 AS ���ʽ�,
    -- Ÿ���� �����ָ� �����Ѵ�.
   

��) ��ٱ������̺�(CART)���� 2005�� 6�� �Ǹ������� �̿��Ͽ� ��� ��ǰ�� �Ǹ���Ȳ�� ��ȸ�Ͻÿ� 
    -- ��� -> OUTER JOIN -- ��ǰ�� --> GROUP BY
    -- �⺻�̵Ǵ� ���̺� ��ڷᰡ ����ִ��� ���� �ľ��Ѵ�.
    -- CART_NO �� 2005�� 6���� �Ǹŵ��̶�� ���ǿ� ���ɰ��̴�
    -- CART_PROD ��ǰ�ڵ�
    -- CART_QTY �����հ�
    -- ��ǰ��� �Ǹűݾ��հ�� CART���̺� ���������ʴ� �͵��̴�.
    -- PROD ���̺����� PROD_NAME�� �ְ� PROD_PRICE�� �ִ�. 
    -- �ΰ��� ���̺��� ���Ǿ������̴� ����Ǿ��� �÷��� �־�� ������ �߻�
    -- PROD_ID�� CART_PROD �� ����
    -- PROD ���̺��� ��� ��ǰ�� ���� ������ ��������� ã�Ƽ� ��ǰ��� �Ǹűݾ��� ã�Ƴ���.
    -- ����ǰ�� ���ؼ� --> �ܺ�����
   Alias�� ��ǰ�ڵ�, ��ǰ��, �Ǹż����հ�, �Ǹűݾ��հ�

SELECT B.PROD_ID AS ��ǰ�ڵ�,
       B.PROD_NAME AS ��ǰ��,
       NVL(SUM(A.CART_QTY), 0) AS �Ǹż����հ�,
       NVL(SUM(A.CART_QTY*B.PROD_PRICE), 0) AS �Ǹűݾ��հ�  
  FROM CART A 
 RIGHT OUTER JOIN PROD B ON(A.CART_PROD=B.PROD_ID
   AND A.CART_NO LIKE '200506%')
 GROUP BY B.PROD_ID, B.PROD_NAME
 ORDER BY 1;
 

2) NVL2(expr1, expr2, expr3)
  - 'expr1'�� NULL�̸� 'expr3'�� ��ȯ�ϰ�, NULL�� �ƴϸ� 'expr2'�� ��ȯ�Ѵ�.
  - 'expr2'�� 'expr3'�� ���� ������ Ÿ�� �̾�� ��
 
��)������̺��� ������� ���ʽ��� ����Ͽ� ��ȸ�Ͻÿ�
   ��, 80���� 50�� �μ��� ���� ����� ��ȸ�Ͻÿ� (NVL2 ���)
   ���ʽ� = ���� * ��������(COMMISSION_PCT)�� 30%�̴�.
   Alias�� �����ȣ, �����, �޿�, ���ʽ�, ���޾�

SELECT EMPLOYEE_ID AS �����ȣ,
       EMP_NAME AS �����,
       SALARY AS �޿�,
       NVL2(SALARY * COMMISSION_PCT*0.3, SALARY * COMMISSION_PCT*0.3, 0) * 0.3 AS ���ʽ�,
       SALARY + NVL2(SALARY * COMMISSION_PCT*0.3, SALARY * COMMISSION_PCT*0.3, 0) AS ���޾�
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID = 80
    OR DEPARTMENT_ID = 50; 
 
��)ȸ�����̺��� ���ϸ����� 1000�̸��� ȸ������ ���ϸ����� NULL�� �����϶�

UPDATE MEMBER
   SET MEM_MILEAGE = NULL
 WHERE MEM_MILEAGE < 1000;
 
����1] ȸ�����̺��� ���ϸ����� NULL�� ȸ����
      ȸ����ȣ, ȸ����, �̸����ּҸ� ��ȸ�Ͻÿ�
      
SELECT MEM_ID AS ȸ����ȣ,
       MEM_NAME AS ȸ����,
       MEM_MAIL AS �̸����ּ�
  FROM MEMBER
 WHERE MEM_MILEAGE IS NULL;   -- NULL ���� �ƴ��� ���Ҷ� IS ���
 
��) ȸ������ ���ϸ����� ��ȸ�Ͽ� �� ���� NULL�̸� '��Ȱ��ȸ��',
    NULL�� �ƴϸ� '����ȸ��' �̶�� �޽����� ����� ����Ͻÿ�
    Alias�� ȸ����ȣ, ȸ����, ���ϸ���, ���

SELECT MEM_ID AS ȸ����ȣ,
       MEM_NAME AS ȸ����,
       NVL(MEM_MILEAGE, 0) AS ���ϸ���,
       NVL2(MEM_MILEAGE, '����ȸ��', '��Ȱ��ȸ��') AS ���
  FROM MEMBER ;
  
ROLLBACK;
COMMIT;

3) NULLIF(c1, c2)
  - c1 �� c2�� ���Ͽ� �� ���� ������ NULL ��ȯ�ϰ� �ٸ��� c1���� ��ȯ

��) ��ǰ���̺��� �з���ȣ 'P301'�� ���� �ڷ��� PROD_SALE ���� 
    PROD_PRICE������ �����Ͻÿ�

UPDATE PROD
   SET PROD_SALE = PROD_PRICE
 WHERE UPPER(PROD_LGU) = 'P301';  -- �� �� ������ �̵��� UPPER ���

��) ��ǰ���̺��� �ǸŰ��� ���ΰ��� ������(���ε��� �ʴ� ��ǰ) ��ǰ�� ��ȸ�Ͻÿ�
    Alias�� ��ǰ��ȣ, ��ǰ��, �ǸŰ�, ���ΰ�

SELECT PROD_ID AS ��ǰ��ȣ,
       PROD_NAME AS ��ǰ��,
       PROD_PRICE AS �ǸŰ�,
       PROD_SALE AS ���ΰ�
  FROM PROD
 WHERE NULLIF(PROD_PRICE, PROD_SALE) IS NULL ;
 
 ROLLBACK;
  