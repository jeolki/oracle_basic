1. ���ǽ�
 - �ϳ� �̻��� ǥ���İ� ���迬����(��������)�� ���յ� ��
 - �����ڴ� ��������, ���迬����, ��Ÿ������(IN, ANY, SOME, ALL, EXISTS,
   LIKE, BETWEEN)  --LIKE ���Ϻ񱳿����� �ɼ������� �Ⱦ�
 
1) IN ������
 - �־��� �� �� ���׸��� ���ԵǸ� TRUE�� ��ȯ�ϴ� ������
 - SOME, ANY�� ���� ���
 - OR �����ڷ� ��ġ ���� --OR �����ں��� �ܼ�����
 - WHERE ���� ���
 (�������)
 �÷��� IN(��1, ��2,...) 
��) ��ǰ���̺��� �з��ڵ尡 'P101', 'P201', 'P301' �� ��� �� �з��� ����
    ��ǰ������ ����Ͻÿ�
    Alias�� ��ǰ�ڵ�, ��ǰ��, �з��ڵ�, �ǸŰ���
    
    (OR ������ ���)
    SELECT PROD_ID AS ��ǰ�ڵ�,
           PROD_NAME AS ��ǰ��,
           PROD_LGU AS �з��ڵ�,
           PROD_PRICE AS �ǸŰ���
      FROM PROD
     WHERE PROD_LGU = 'P101'
        OR PROD_LGU = 'P201'
        OR PROD_LGU = 'P301'
  ORDER BY PROD_LGU ASC; -- �÷��� ���
  -- ORDER BY 3 ASC;     -- �÷��ε��� ��� SELECT���� ����Ǿ������� ASC �Ƚ��൵�� 
  -- ORDER BY PROD_LGU ASC, PROD_PRICE DESC ; �з��ڵ尡 �Ȱ��� ���� �׾ȿ��� ������ ������������ �����Ѵ�.
    
   (IN ������ ���)
    SELECT PROD_ID AS ��ǰ�ڵ�,
           PROD_NAME AS ��ǰ��,
           PROD_LGU AS �з��ڵ�,
           PROD_PRICE AS �ǸŰ���
      FROM PROD
     WHERE PROD_LGU IN('P101', 'P201','P301') 
-- WHERE PROD_LGU NOT IN('P101', 'P201','P301') ������ IN�տ� NOT
  ORDER BY PROD_LGU ASC;    
    
     (ANY ������ ���)
    SELECT PROD_ID AS ��ǰ�ڵ�,
           PROD_NAME AS ��ǰ��,
           PROD_LGU AS �з��ڵ�,
           PROD_PRICE AS �ǸŰ���
      FROM PROD
     WHERE PROD_LGU =ANY('P101', 'P201','P301')  -- ANY�� SUM�� ���迬���ڰ� �ٴ´� , IN�� ���迬���ڰ� ���� �ʴ´�.
 --        NOT PROD_LGU =ANY ('P101', 'P201','P301')  ������ ��ü���� �������ƴ� ������ ��ǰ��
  ORDER BY PROD_LGU ASC;        
  
   (SOME ������ ���)
    SELECT PROD_ID AS ��ǰ�ڵ�,
           PROD_NAME AS ��ǰ��,
           PROD_LGU AS �з��ڵ�,
           PROD_PRICE AS �ǸŰ���
      FROM PROD
     WHERE /*NOT*/ PROD_LGU =SOME ('P101', 'P201','P301') 
  ORDER BY PROD_LGU ASC;   
  
  
��) �����̷����̺�{JOB_HISTORY)�� �����ϴ� ��������� ��ȸ�Ͻÿ�
    Alias�� �����ȣ, �����, �����ڵ�, �޿�
(JOIN�� �̿�) --�����÷����� FROM�� ���̺�ΰ� --������ ��� ���̺�-1�� 
SELECT DISTINCT A.EMPLOYEE_ID AS �����ȣ, --�ߺ��Ȱ��� ���ֱ� ����
       A.EMP_NAME AS �����,
       A.JOB_ID AS �����ڵ�,
       A.SALARY AS �޿�
  FROM EMPLOYEES A, JOB_HISTORY B      --��Ī���
 WHERE A.EMPLOYEE_ID = B.EMPLOYEE_ID;  --��Ī���̿� �Ҽ��߰�

(IN�� �̿�)
SELECT EMPLOYEE_ID AS �����ȣ, 
       EMP_NAME AS �����,
       JOB_ID AS �����ڵ�,
       SALARY AS �޿�
  FROM EMPLOYEES   
 WHERE EMPLOYEE_ID IN (SELECT EMPLOYEE_ID 
                         FROM JOB_HISTORY);


(EXISTS�� �̿�)
SELECT A.EMPLOYEE_ID AS �����ȣ, 
       EMP_NAME AS �����,
       A.JOB_ID AS �����ڵ�,
       SALARY AS �޿�
  FROM EMPLOYEES A  
 WHERE EXISTS (SELECT 1   --1�� �ǹ̾���, 
                 FROM JOB_HISTORY B
                WHERE A.EMPLOYEE_ID=B.EMPLOYEE_ID);
                
                
2)LIKE ������
 - ������ ���� �� ����ϴ� ������
 - ��ġ ���ڿ�(���ϵ�ī��) '%', '_'�� ���
 - '%'�� �ش繮�ڿ��� ���� ��ġ ���Ŀ� �����ϴ� ��� ���ڿ��� ������
   ex) '��%' ->'��'���� �����ϴ� ��� ���ڿ��� ����
       '%��' ->'��'���� ������ ��� ���ڿ��� ����
 - '_'�� �ش繮�ڿ��� ���� ��ġ�� �ϳ��� ���ڿ� ������
   ex) '��_��' ->'��'���� �����ϰ� 3���ڷ� �����Ǹ� ���ڸ����� '��'�� �;� ������
       '_��' ->2���ڷ� �����Ǿ� ������ '��'���� ������ ���ڿ��� ����
 - ���ڿ� �񱳿��� ��� �� ��
 - �ʹ� ���̻�� ���� �� �� 
 (�������)
 �÷��� LIKE '���Ϲ��ڿ�'
 
 ��} ȸ�����̺��� �ּ����� '����'�� ȸ�������� ��ȸ�Ͻÿ�
    Alias�� ȸ����ȣ, ȸ����, �ּ�, ����ȭ��ȣ
  SELECT MEM_ID AS ȸ����ȣ,
         MEM_NAME AS ȸ����,
         MEM_ADD1||' '||MEM_ADD2 AS �ּ�,  -- ���ڿ��� ���� ||�����Ѵ�. ���̿� ��ĭ���� �ְٴ�
         MEM_HOMETEL AS ����ȭ��ȣ
    FROM MEMBER
   WHERE MEM_ADD1 LIKE '����%'
 
 ��) �����ڷ�(CART)���� 2005�� 6�� ���������� ��ȸ�Ͻÿ� 
    Alias�� ��¥, ��ǰ�ڵ�, �Ǹż����̴�.
  SELECT TO_CHAR(TO_DATE(SUBSTR(CART_NO,1,8)),'YYYY"��" MM"��"DD"��"') AS ��¥, 
      -- TO_DATE(SUBSTR(CART_NO,1,8)) AS ��¥, /�� ���еǾ ���´� 
         CART_PROD AS ��ǰ�ڵ�,
         CART_QTY AS �Ǹż���
    FROM CART
   WHERE CART_NO LIKE '200506%';
 
 
 ����] �������̺�(BUYPROD)���� 2005�� 3-5�� ���������� ��ȸ�Ͻÿ� --��¥�� �Ҷ����� LIKE ������ �������ƶ�
      Alias�� ����, ��ǰ�ڵ�, ���Լ���, ���Դܰ�, ���Աݾ��̴�.
 
  SELECT BUY_DATE AS ����,
         BUY_PROD AS ��ǰ�ڵ�,
         BUY_QTY AS ���Լ���,
         BUY_COST AS ���Դܰ�,
         BUY_QTY * BUY_COST AS ���Աݾ�
    FROM BUYPROD
   WHERE BUY_DATE >= '20050301' AND BUY_DATE <= '20050531';
   -- ���ڿ��� ��¥���� �ٲ����
   -- �����ʹ� NLS���� ������ ��¥�� ���������� ��ü ���߾�� ������ �ٲ��.
   -- ��¥ Ÿ���� LIKE ��������ʰ� ��¥ Ÿ���̳� �̿Ͱ��� �������� �����ش�.
   -- BUY_DATE >= TO_DATE('20050301') AND BUY_DATE <= TO_DATE('20050531');
   
   (BETWEEN ������ ���)
  SELECT BUY_DATE AS ����,
         BUY_PROD AS ��ǰ�ڵ�,
         BUY_QTY AS ���Լ���,
         BUY_COST AS ���Դܰ�,
         BUY_QTY * BUY_COST AS ���Աݾ�
    FROM BUYPROD
   WHERE BUY_DATE BETWEEN '20050301' AND '20050531';
   

 ����] �������̺�(BUYPROD)���� 2005�� 4�� ���������� ��ȸ�Ͻÿ� 
      Alias�� ����, ��ǰ�ڵ�, ���Լ���, ���Դܰ�, ���Աݾ��̴�.
 
   SELECT BUY_DATE AS ����,
          BUY_PROD AS ��ǰ�ڵ�,
          BUY_QTY AS ���Լ���,
          BUY_COST AS ���Դܰ�,
          BUY_QTY * BUY_COST AS ���Աݾ�
     FROM BUYPROD
    WHERE TO_CHAR(BUY_DATE) LIKE '2005_04%'; 
    -- /�� ������ �����Ͱ� �ȳ��´�
    -- �����ͺ��̽��� NLS�� ��¥ ������ �ٲ��ָ� �� �ȳ��´�.
    -- �Ⱦ��°� ����  ���̿� _�� ���ָ� ����
 
   SELECT TO_CHAR(BUY_DATE) FROM BUYPROD;
   
   
3)BETWEEN ������
 - ������ ���� ���� ǥ���� �� ���
 - AND �����ڸ� ����� �� ����
 
 (�������)
 �÷��� BETWEEN ��1 AND ��2; --%���ϵ�ī�� ������
 
��)ȸ�����̺��� 40�� ����ȸ�������� ��ȸ�Ͻÿ�
  Alias�� ȸ����ȣ, ȸ����, �ֹι�ȣ, ����, ���ϸ���
  ��, �ֹι�ȣ�� ��������� xxxxxx-xxxxxxx �̴�.
   
  SELECT MEM_ID AS ȸ����ȣ,
         MEM_NAME AS ȸ����,
         MEM_REGNO1||'-'||MEM_REGNO2 AS �ֹι�ȣ,
         EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR) AS ����,  -- EXTRACT("YEAR,NONTH,DAY ���" FROM SYSDATE)
         MEM_MILEAGE AS ���ϸ��� 
    FROM MEMBER
   WHERE EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR) BETWEEN 40 AND 49
     AND (SUBSTR(MEM_REGNO2,1,1)='2' OR SUBSTR(MEM_REGNO2,1,1)='4') ; -- NOR AND OR ���̶� ��ȣ ������Ѵ�.















  
  
  