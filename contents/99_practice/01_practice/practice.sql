DB TEST)
1) ��ǰ ���̺�κ��� ��� row�� column�� �˻�

SELECT * FROM PROD;

2) ȸ�� ���̺�κ��� ��� row�� column�� �˻�

SELECT * FROM MEMBER;

3) ��ǰ ���̺�κ��� ��ǰ�ڵ�� ��ǰ���� �˻�

SELECT PROD_ID AS ��ǰ�ڵ�,
       PROD_NAME AS ��ǰ��
  FROM PROD;

4) ȸ�� ���̺��� ���ϸ����� 12�� ���� ���� �˻�

SELECT MEM_MILEAGE/12 AS ���ϸ���
  FROM MEMBER;

5) ��ǰ ���̺��� ��ǰ�ڵ�, ��ǰ��, �Ǹűݾ��� �˻�
(�Ǹűݾ��� = �ǸŴܰ� * 55 �� ���)

SELECT PROD_ID AS ��ǰ�ڵ�,
       PROD_NAME AS ��ǰ��,
       ROUND(PROD_PRICE * 55) AS �Ǹűݾ�
  FROM PROD;

6) ȸ�� ���̺��� ���ϸ����� 12�� ���� ���� ��������� ���� �˻�

SELECT ROUND(MEM_MILEAGE/12) AS �����
  FROM MEMBER ;

7) ��ǰ���̺��� PROD_ID, PROD_NAME, PROD_BUYER�� �˻�
(��, Column __________�� ��ǰ�ڵ�, ��ǰ��, �ŷ�ó�ڵ�� ����)

SELECT PROD_ID AS ��ǰ�ڵ�,
       PROD_NAME AS ��ǰ��,
       PROD_BUYER AS �ŷ�ó�ڵ�
  FROM PROD;

8) ��ǰ ���̺��� ��ǰ�з��� �ߺ����� �ʰ� �˻�----

SELECT DISTINCT(PROD_LGU) AS  ��ǰ�з�
  FROM PROD;
 
9) ��ǰ ���̺��� �ŷ�ó�ڵ带 �ߺ����� �ʰ� �˻�
(Alias�� �ŷ�ó)

SELECT DISTINCT(PROD_BUYER) AS �ŷ�ó
  FROM PROD;

10) ȸ�����̺��� ȸ��ID, ȸ����, ����, ���ϸ��� �˻�

SELECT MEM_ID AS ȸ��ID,
       MEM_NAME AS ȸ����,
       MEM_BIR AS ����,
       MEM_MILEAGE AS ���ϸ���
  FROM MEMBER;

��. ȸ��ID �÷����� �������� ����

SELECT MEM_ID AS ȸ��ID,
       MEM_NAME AS ȸ����,
       MEM_BIR AS ����,
       MEM_MILEAGE AS ���ϸ���
  FROM MEMBER
 ORDER BY 1;

��. �����̶�� ALIAS�� ���� �������� ����

SELECT MEM_ID AS ȸ��ID,
       MEM_NAME AS ȸ����,
       MEM_BIR AS ����,
       MEM_MILEAGE AS ���ϸ���
  FROM MEMBER
 ORDER BY 2;

��. 3��° �÷����� �������� ����

SELECT MEM_ID AS ȸ��ID,
       MEM_NAME AS ȸ����,
       MEM_BIR AS ����,
       MEM_MILEAGE AS ���ϸ���
  FROM MEMBER
 ORDER BY 3 DESC;

��. ���ϸ��� �÷����� ������������ 1�� ���� �� 1��° �÷����� ������������ 2�� ����---

SELECT MEM_ID AS ȸ��ID,
       MEM_NAME AS ȸ����,
       MEM_BIR AS ����,
       MEM_MILEAGE AS ���ϸ���
  FROM MEMBER
 ORDER BY 4, 1;

11) ��ǰ �� �ǸŰ��� 170,000���� ��ǰ ��ȸ

SELECT PROD_NAME AS ��ǰ��
  FROM PROD
 WHERE PROD_PRICE = 170000;

12) ��ǰ �� �ǸŰ��� 170,000���� �ƴ� ��ǰ ��ȸ----

SELECT PROD_NAME AS ��ǰ��
  FROM PROD
 WHERE PROD_PRICE != 170000;

13) ��ǰ �� �ǸŰ��� 170,000�� �ʰ� �Ǵ� �̸��� ��ǰ ��ȸ

SELECT PROD_NAME AS ��ǰ��
  FROM PROD
 WHERE 170000 < PROD_PRICE OR PROD_PRICE < 170000;

14) ��ǰ �� �ǸŰ��� 170,000���̻� �Ǵ� ������ ��ǰ ��ȸ

SELECT PROD_NAME AS ��ǰ��
  FROM PROD
 WHERE 170000 <= PROD_PRICE OR PROD_PRICE <= 170000;

15) ��ǰ �� ���԰��� 200,000�� ������ ��ǰ�� �˻�
( Alias�� ��ǰ�ڵ�, ��ǰ��, ���԰� )

SELECT PROD_ID AS ��ǰ�ڵ�,
       PROD_NAME AS ��ǰ��,
       PROD_COST AS ���԰�
  FROM PROD
 WHERE PROD_COST <= 200000;

16) ȸ�� �� 76�⵵ 1�� 1�� ���Ŀ� �¾ ȸ���� �˻�
- �ֹε�Ϲ�ȣ ���ڸ��� ��
( Alias�� ȸ��ID, ȸ�� ��, �ֹε�Ϲ�ȣ ���ڸ� )

SELECT MEM_ID AS ȸ��ID,
       MEM_NAME AS "ȸ�� ��",
       MEM_REGNO1 AS "�ֹε�Ϲ�ȣ ���ڸ�"
  FROM MEMBER
 WHERE TO_NUMBER(MEM_REGNO1) > 760101;

17) ��ǰ �� ��ǰ�з��� P201(���� ĳ���)�̰�, �ǸŰ��� 170,000���� ��ǰ ��ȸ

SELECT PROD_NAME AS ��ǰ��
  FROM PROD
 WHERE PROD_LGU = 'P201' AND PROD_PRICE = 170000;

18) ��ǰ �� ��ǰ�з��� P201(���� ĳ���)�̰ų� �ǸŰ��� 170,000���� ��ǰ ��ȸ

SELECT PROD_NAME AS ��ǰ��
  FROM PROD
 WHERE PROD_LGU = 'P201' OR PROD_PRICE = 170000;

19) ��ǰ �� ��ǰ�з��� P201(���� ĳ���)�� �ƴϰ� �ǸŰ��� 170,000���� �ƴ� ��ǰ ��ȸ

SELECT PROD_NAME AS ��ǰ��
  FROM PROD
 WHERE PROD_LGU != 'P201' AND PROD_PRICE != 170000;

20) ��ǰ �� �ǸŰ��� 300,000�� �̻�, 500,000�� ������ ��ǰ�� �˻�
( Alias�� ��ǰ�ڵ�, ��ǰ��, �ǸŰ� )

SELECT PROD_ID AS ��ǰ�ڵ�,
       PROD_NAME AS ��ǰ��,
       PROD_PRICE AS �ǸŰ�
  FROM PROD
 WHERE PROD_PRICE >= 300000 
   AND PROD_PRICE <= 500000; 

21) ��ǰ �� �ǸŰ��� 150,000��,170,000��, 330,000���� ��ǰ ��ȸ

SELECT PROD_ID AS ��ǰ�ڵ�,
       PROD_NAME AS ��ǰ��,
       PROD_PRICE AS �ǸŰ�
  FROM PROD
 WHERE PROD_PRICE IN(150000, 170000, 330000); 


22) ȸ�����̺��� ȸ��ID�� C001, F001, W001 �� ȸ���� �˻�
( Alias�� ȸ��ID, ȸ���� )

SELECT MEM_ID AS ȸ��ID,
       MEM_NAME AS ȸ����
  FROM MEMBER
 WHERE MEM_ID IN ('c001', 'f001', 'w001');

23) ��ǰ �з����̺��� ���� ��ǰ���̺� �����ϴ� �з��� �˻�  -----
( Alias�� �з��ڵ�, �з��� )

SELECT DISTINCT(A.LPROD_GU) AS �з��ڵ�,
       A.LPROD_NM AS �з���
  FROM LPROD A, PROD B
 WHERE A.LPROD_GU = B.PROD_LGU
 ORDER BY 1;
 
24) ��ǰ �з����̺�(LPROD)���� ���� ��ǰ���̺� (PROD) �� �������� �ʴ� �з��� �˻�  -------------------------
( Alias�� �з��ڵ�, �з��� )

SELECT DISTINCT(A.LPROD_GU) AS �з��ڵ�,
       A.LPROD_NM AS �з���
  FROM LPROD A, PROD B
 WHERE  A.LPROD_GU NOT IN (SELECT PROD_LGU FROM PROD)
 ORDER BY 1;

25) ��ǰ �� �ǸŰ��� 100,000�� ���� 300,000�� ������ ��ǰ ��ȸ

SELECT PROD_NAME AS ��ǰ��
  FROM PROD
 WHERE PROD_PRICE BETWEEN 100000 AND 300000 ;

26) ȸ�� �� ������ 1975-01-01���� 1976-12-31���̿� �¾ ȸ���� �˻� --
( Alias�� ȸ��ID, ȸ�� ��, ���� )

SELECT MEM_ID AS ȸ��ID,
       MEM_NAME AS "ȸ�� ��",
       MEM_BIR AS ����
  FROM MEMBER
 WHERE MEM_BIR BETWEEN TO_DATE('19750101') AND TO_DATE('19761231');

27) ��ǰ �� ���԰��� 300,000~1,500,000�̰� �ǸŰ��� 800,000~2,000,000 �� ��ǰ�� �˻�
( Alias�� ��ǰ��, ���԰�, �ǸŰ� )

SELECT PROD_NAME AS ��ǰ��,
       PROD_COST AS ���԰�,
       PROD_PRICE AS �ǸŰ�
  FROM PROD
 WHERE PROD_COST BETWEEN TO_NUMBER(300000) AND TO_NUMBER(1500000)
   AND PROD_PRICE BETWEEN TO_NUMBER(800000) AND TO_NUMBER(2000000);

28) ȸ�� �� ������ 1975�⵵ ���� �ƴ� ȸ���� �˻�
( Alias�� ȸ��ID, ȸ�� ��, ����)

SELECT MEM_ID AS ȸ��ID,
       MEM_NAME AS "ȸ�� ��",
       MEM_BIR AS ����
  FROM MEMBER
 WHERE SUBSTR(MEM_BIR, 1, 4) != '1975';

29) ȸ�����̺��� �达 ���� ���� ȸ���� �˻�( Alias�� ȸ��ID, ���� )

SELECT MEM_ID AS ȸ��ID,
       MEM_NAME AS ����
  FROM MEMBER
 WHERE MEM_NAME LIKE '��%';

30) ȸ�����̺��� �ֹε�Ϲ�ȣ ���ڸ��� �˻��Ͽ� 1975����� ������ ȸ���� �˻�
( Alias�� ȸ��ID, ����, �ֹε�Ϲ�ȣ )

SELECT MEM_ID AS ȸ��ID,
       MEM_NAME AS ����,
       MEM_REGNO1 || '-' || MEM_REGNO2 AS �ֹε�Ϲ�ȣ
  FROM MEMBER
 WHERE SUBSTR(MEM_REGNO1, 1, 2) != '75';

31) ȸ�����̺��� ȸ��ID�� �빮�ڷ� ��ȯ�Ͽ� �˻�(Alias���� ��ȯ ��ID, ��ȯ ��ID )

SELECT MEM_ID AS "��ȯ ��ID",
       UPPER(MEM_ID) AS "��ȯ ��ID"
  FROM MEMBER;

32) ȸ�����̺��� ���� ��ȸ

SELECT SUBSTR(MEM_NAME,1,1) AS ����
  FROM MEMBER;
  
33) ��ǰ���̺��� ��ǰ���� 4° �ڸ����� 2���ڰ� 'Į��' �� ��ǰ�� ��ǰ�ڵ�, ��ǰ���� �˻�
( Alias���� ��ǰ�ڵ�, ��ǰ�� )

SELECT PROD_ID AS ��ǰ�ڵ�,
       PROD_NAME AS ��ǰ��
  FROM PROD
 WHERE SUBSTR(PROD_NAME,4,2) = 'Į��';

34) ��ǰ���̺��� ��ǰ�ڵ忡�� ����4�ڸ�, ������6�ڸ��� �˻� -----
(Alias���� ��ǰ�ڵ�, ��з�, ���� )

SELECT PROD_ID AS ��ǰ�ڵ�,
       SUBSTR(PROD_ID,1,4) AS ��з�,
       SUBSTR(PROD_ID,-6,6) AS ����
  FROM PROD;
    
35) �ŷ�ó ���̺��� �ŷ�ó�� �� '��' --> '��' ���� ġȯ

SELECT REPLACE(BUYER_NAME, '��','��') AS �ŷ�ó��
  FROM BUYER;

36) ȸ�����̺��� ȸ������ �� '��' --> '��' �� ġȯ �˻�
(Alias���� ȸ����, ȸ����ġȯ )

SELECT MEM_NAME AS ȸ����,
       REPLACE(MEM_NAME, '��', '��') AS ȸ����ġȯ
  FROM MEMBER;

37) ȸ�� ���̺��� ���ϸ����� 12�� ���� ���� �˻�
(�Ҽ�3°�ڸ� �ݿø�, ����)

SELECT ROUND(MEM_MILEAGE/12,2) AS "�Ҽ�3°�ڸ� �ݿø�",
       TRUNC(MEM_MILEAGE/12) AS ����
  FROM MEMBER;

38) ��ǰ���̺��� ��ǰ��, ������( ���԰� / �ǸŰ� )�� ����(%)��(�ݿø� ���� �Ͱ� �Ҽ� ù°�ڸ� �ݿø� ��) �˻�(Alias�� ��ǰ��, ������1, ������2)

SELECT PROD_NAME AS ��ǰ��,
       (PROD_COST/PROD_PRICE)*100 || '%' AS ������1,
       ROUND((PROD_COST/PROD_PRICE)*100,1) || '%' AS ������2
  FROM PROD;

39) ��ǰ���̺��� ��ǰ�԰����� '2008-09-28' �������� ������ �˻�
(Alias ��ǰ��, ��ǰ�ǸŰ�, �԰���)

SELECT PROD_NAME AS ��ǰ��,
       PROD_PRICE AS ��ǰ�ǸŰ�,
       REPLACE(PROD_INSDATE, '/', '-') AS �԰���
  FROM PROD;



---------------------------------------------------------------------



1) ��ǰ���̺�(PROD)�� ��ǰ�з�(PROD_LGU)�� ���԰���(PROD_COST) ��� ��
(�Ҽ��� 2�ڸ� �ݿø�)

SELECT PROD_LGU AS ��ǰ�з�,
       ROUND(AVG(PROD_COST),1) AS ���԰������
  FROM PROD
 GROUP BY PROD_LGU
 ORDER BY 1;

2) ��ǰ���̺�(PROD)�� �� �ǸŰ���(PROD_SALE) ��� ��
(Alias�� ��ǰ���ǸŰ������)

SELECT ROUND(AVG(PROD_SALE),1) AS ��ǰ���ǸŰ������
  FROM PROD
  
3) ��ǰ���̺�(PROD)�� ��ǰ�з���(PROD_LGU) �ǸŰ���(PROD_SALE) ��� ��
(Alias�� ��ǰ�з�, ��ǰ�з����ǸŰ������)

SELECT PROD_LGU AS ��ǰ�з�,
       ROUND(AVG(PROD_SALE),1) AS ��ǰ���ǸŰ������
  FROM PROD
 GROUP BY PROD_LGU
 ORDER BY 1;

4) ȸ�����̺�(MEMBER)�� �������(MEM_LIKE)���� COUNT����
( Alias�� ��������� )

SELECT COUNT(MEM_LIKE) AS ���������
  FROM MEMBER;

5) ȸ�����̺�(MEMBER)�� ���(MEM_LIKE)�� COUNT����
( Alias�� ���, �ڷ��, �ڷ��(*) )

SELECT MEM_LIKE AS ���,
       COUNT(MEM_LIKE) AS �ڷ��,
       COUNT(*) AS "�ڷ��(*)"
  FROM MEMBER
 GROUP BY MEM_LIKE;

6) ȸ�����̺�(MEMBER)�� ��������(MEM_JOB)���� COUNT����
( Alias�� ���������� )

SELECT COUNT(MEM_JOB) AS ����������
  FROM MEMBER;

7) ��ٱ������̺�(CART)�� ȸ���� �ִ뱸�ż���(CART_QTY)�� �˻�
( Alias�� ȸ��ID(CART_MEMBER), �ִ����, �ּҼ��� )

SELECT CART_MEMBER AS ȸ��ID, 
       MAX(CART_QTY) AS �ִ����,
       MIN(CART_QTY) AS �ּҼ���
  FROM CART
 GROUP BY CART_MEMBER;

8) ������ 2005�⵵7��11���̶� �����ϰ� ��ٱ������̺�(CART)�� �߻��� �߰��ֹ���ȣ(CART_NO)�� �˻� ----
( Alias�� �ְ�ġ�ֹ���ȣ, �߰��ֹ���ȣ )

SELECT MAX(CART_NO) AS �ְ�ġ�ֹ���ȣ,
       TO_NUMBER(MAX(CART_NO)) + 1 AS �߰��ֹ���ȣ
  FROM CART
 WHERE TO_DATE(SUBSTR(CART_NO,1,8)) = TO_DATE('20050711');

9) ��ǰ���̺�(PROD)�� ��ǰ�з�(PROD_LGU)�� �ǸŰ�(PROD_SALE) �հ� ��

SELECT PROD_LGU AS ��ǰ�з�,
       SUM(PROD_SALE) AS �Ǹ��հ�
  FROM PROD
 GROUP BY PROD_LGU;

10) ��ǰ�԰����̺�(BUYPROD)�� ��ǰ(BUY_PROD)�� �԰����(BUY_QTY)�� �հ� ��

SELECT BUY_PROD AS ��ǰ,
       SUM(BUY_QTY) AS "�԰���� �հ�"
  FROM BUYPROD
 GROUP BY BUY_PROD;

11) ��ٱ������̺�(CART)�� ��ǰ�з�(CART_PROD ���� ���ڸ�)�� �Ǹż���(CART_QTY)�� �հ� ��
( Alias�� ��ǰ, �Ǹż����հ� )

SELECT SUBSTR(CART_PROD,1,4) AS ��ǰ�з�,
       SUM(CART_QTY) AS "�Ǹż��� �հ�"
  FROM CART
 GROUP BY SUBSTR(CART_PROD,1,4);

12) ȸ�����̺�(MEMBER)�� ȸ����ü�� ���ϸ���(MEM_MILEAGE) ���, ���ϸ��� �հ�,
�ְ� ���ϸ���, �ּ� ���ϸ���,�ο����� �˻� 
(Alias�� ���ϸ������, ���ϸ����հ�,�ְ��ϸ���, �ּҸ��ϸ���,�ο���)

SELECT ROUND(AVG(MEM_MILEAGE),1) AS ���ϸ������,
       SUM(MEM_MILEAGE) AS ���ϸ����հ�,
       MAX(MEM_MILEAGE) AS �ְ��ϸ���,
       MIN(MEM_MILEAGE) AS �ּҸ��ϸ���,
       COUNT(*) AS �ο���
  FROM MEMBER;

13) ��ǰ���̺�(PROD)���� �ŷ�ó(PROD_BUYER), ��ǰ�з�(PROD_LGU)���� �ְ��ǸŰ�(PROD_SALE),
�ּ��ǸŰ�, �ڷ� ���� �˻�

SELECT PROD_BUYER AS �ŷ�ó,
       PROD_LGU AS ��ǰ�з�,
       MAX(PROD_SALE) AS �ְ��ǸŰ�,
       MIN(PROD_SALE) AS �ּ��ǸŰ�,
       COUNT(*) AS �ڷ��
  FROM PROD
 GROUP BY PROD_BUYER, PROD_LGU;

14) ��ٱ������̺�(CART)���� ȸ��(CART_MEMBER), ��ǰ�з�(CART_PROD ���� ���ڸ�)���� ���ż���(CART_QTY)���,
���ż����հ�, �ڷ���� �˻�
( Alias�� ȸ��ID, ��ǰ�з�, ���ż������, ���ż����հ�, �ڷ�� )
(ȸ��ID(CART_MEMBER), ��ǰ�з� ������ SORT�Ͻÿ�)

SELECT CART_MEMBER AS ȸ��ID,
       SUBSTR(CART_PROD,1,4) AS ��ǰ�з�,
       ROUND(AVG(CART_QTY),1) AS ���ż������,
       SUM(CART_QTY) AS ���ż����հ�,
       COUNT (*) AS �ڷ��
  FROM CART
 GROUP BY CART_MEMBER, SUBSTR(CART_PROD,1,4)
 ORDER BY 2;

15) ȸ�����̺�(MEMBER)���� ����(�ּ�1(MEM_ADD1)�� 2�ڸ�),���ϳ⵵(MEM_BIR)���� ���ϸ���(MEM_MILEAGE)���, ���ϸ����հ�,
�ְ��ϸ���, �ּҸ��ϸ���, �ڷ���� �˻�
( Alias�� ����, ���Ͽ���, ���ϸ������, ���ϸ����հ�, �ְ��ϸ���,�ּҸ��ϸ���, �ڷ�� )

SELECT SUBSTR(MEM_ADD1,1,2) AS ����,
       MEM_BIR AS ���ϳ⵵,
       ROUND(AVG(MEM_MILEAGE),1) AS ���ϸ������,
       SUM(MEM_MILEAGE) AS ���ϸ����հ�,
       MAX(MEM_MILEAGE) AS �ְ��ϸ���,
       MIN(MEM_MILEAGE) AS �ּҸ��ϸ���,
       COUNT(*) AS �ڷ��
  FROM MEMBER
 GROUP BY SUBSTR(MEM_ADD1,1,2), MEM_BIR;

16) �ŷ�ó(BUYER_NAME) �����(BUYER_CHARGER)�� NULL�� �ڷ� �˻� 
(alias�� �ŷ�ó, �����)

SELECT BUYER_NAME AS �ŷ�ó,
       BUYER_CHARGER AS �����
  FROM BUYER
 WHERE BUYER_CHARGER IS NULL;

16-1) �ŷ�ó(BUYER_NAME) �����(BUYER_CHARGER)�� NULL�� �ƴ� �ڷ� �˻�
(alias�� �ŷ�ó, �����)

SELECT BUYER_NAME AS �ŷ�ó,
       BUYER_CHARGER AS �����
  FROM BUYER
 WHERE BUYER_CHARGER IS NOT NULL;

17) �ŷ�ó(BUYER_NAME) �����(BUYER_CHARGER)�� ���� ��� �����١��� ġȯ�Ͽ� �ڷ� �˻�(alias�� �ŷ�ó, �����)

SELECT BUYER_NAME AS �ŷ�ó,
       NVL(BUYER_CHARGER, '����') AS �����
  FROM BUYER;

18) ��ǰ �з�(PROD_LGU) �� ���� �� ���ڰ� 'P1' �̸� �ǸŰ�(PROD_SALE)�� 10%�λ��ϰ� 'P2' �̸� �ǸŰ��� 15%�λ��ϰ�
, �������� ���� �ǸŰ��� �˻�   
(DECODE �Լ� ���, Alias�� ��ǰ��(PROD_NAME), �ǸŰ�, �����ǸŰ� )

SELECT PROD_NAME AS ��ǰ��,
       PROD_SALE AS �ǸŰ�,
       DECODE(SUBSTR(PROD_LGU,1,2), 'P1', PROD_SALE*1.1, 'P2', PROD_SALE*1.15) AS �����ǸŰ�
  FROM PROD

19) ȸ���������̺�(MEMBER)�� �ֹε�� ���ڸ�(MEM_REGNO2)(7�ڸ� �� ù°�ڸ�)���� ���� ������ �˻�
( CASE ���� ���, Alias�� ȸ����,�ֹε�Ϲ�ȣ(�ֹ�1-�ֹ�2), ���� )

SELECT MEM_NAME AS ȸ����,
       MEM_REGNO1 ||'-'|| MEM_REGNO2 AS �ֹε�Ϲ�ȣ,
       CASE WHEN SUBSTR(MEM_REGNO2,1,1)= '1'  THEN '����' ELSE '����' END AS ����
  FROM MEMBER;


----------------------------------------------------------------------

1) ��ǰ���̺��� ��ǰ�ڵ�, ��ǰ��, �з����� ��ȸ.
��. �⺻����
SELECT A.PROD_ID ��ǰ�ڵ�, A.PROD_NAME ��ǰ��, B.LPROD_NM �з���
  FROM PROD A, LPROD B
 WHERE A.PROD_LGU = B.LPROD_GU

��. ANSI����
SELECT A.PROD_ID ��ǰ�ڵ�, A.PROD_NAME ��ǰ��, B.LPROD_NM �з���
  FROM PROD A
 INNER JOIN LPROD B ON A.PROD_LGU = B.LPROD_GU

2) ��ǰ���̺��� ��ǰ�ڵ�, ��ǰ��, �з���, �ŷ�ó ���� ��ȸ

��. ���̺�� ���
SELECT A.PROD_ID, A.PROD_NAME, B.LPROD_NM, C.BUYER_NAME
  FROM PROD A, LPROD B, BUYER C
 WHERE A.PROD_LGU = B.LPROD_GU
   AND A.PROD_LGU = C.BUYER_LGU

��. Alias ���
SELECT A.PROD_ID ��ǰ�ڵ�, A.PROD_NAME ��ǰ��, B.LPROD_NM �з���, C.BUYER_NAME �ŷ�ó��
  FROM PROD A, LPROD B, BUYER C
 WHERE A.PROD_LGU = B.LPROD_GU
   AND A.PROD_LGU = C.BUYER_LGU

��. ANSI����
SELECT A.PROD_ID ��ǰ�ڵ�, A.PROD_NAME ��ǰ��, B.LPROD_NM �з���, C.BUYER_NAME �ŷ�ó��
  FROM PROD A
 INNER JOIN LPROD B ON A.PROD_LGU = B.LPROD_GU
 INNER JOIN BUYER C ON A.PROD_LGU = C.BUYER_LGU
 

3) ��ǰ���̺��� �ŷ�ó�� '�Ｚ����' �� �ڷ��� ��ǰ�ڵ�, ��ǰ��, �ŷ�ó ���� ��ȸ
SELECT A.PROD_ID ��ǰ�ڵ�, A.PROD_NAME ��ǰ��, C.BUYER_NAME �ŷ�ó��
  FROM PROD A, BUYER C
 WHERE A.PROD_LGU = C.BUYER_LGU
   AND C.BUYER_NAME = '�Ｚ����'

4) ��ǰ���̺��� �ŷ�ó�� '�Ｚ����' �� �ڷ��� ��ǰ�ڵ�, ��ǰ��, �ŷ�ó ���� ��ȸ
SELECT A.PROD_ID ��ǰ�ڵ�, A.PROD_NAME ��ǰ��, C.BUYER_NAME �ŷ�ó��
  FROM PROD A, BUYER C
 WHERE A.PROD_LGU = C.BUYER_LGU
   AND C.BUYER_NAME = '�Ｚ����'


5) ��ǰ���̺��� ��ǰ�ڵ�, ��ǰ��, �з���, �ŷ�ó��, �ŷ�ó�ּҸ� ��ȸ.

- �ǸŰ����� 10���� ���� �̰�
SELECT A.PROD_ID ��ǰ�ڵ�, A.PROD_NAME ��ǰ��, B.LPROD_NM �з���, C.BUYER_NAME �ŷ�ó��, C.BUYER_ADD1 �ŷ�ó�ּ�
  FROM PROD A, LPROD B, BUYER C
 WHERE A.PROD_LGU = B.LPROD_GU
   AND A.PROD_LGU = C.BUYER_LGU
   AND A.PROD_PRICE <= 100000

- �ŷ�ó �ּҰ� �λ��� ��츸 ��ȸ
SELECT A.PROD_ID ��ǰ�ڵ�, A.PROD_NAME ��ǰ��, B.LPROD_NM �з���, C.BUYER_NAME �ŷ�ó��, C.BUYER_ADD1 �ŷ�ó�ּ�
  FROM PROD A, LPROD B, BUYER C
 WHERE A.PROD_LGU = B.LPROD_GU
   AND A.PROD_LGU = C.BUYER_LGU
   AND A.PROD_PRICE <= 100000
   AND C.BUYER_ADD1 LIKE '�λ�%'

6) ��ǰ �з��� ������ǰ(P102 )�� ��ǰ�� ��ǰ�ڵ�, ��ǰ��, �з���, �ŷ�ó ���� ��ȸ.
SELECT A.PROD_ID ��ǰ�ڵ�, A.PROD_NAME ��ǰ��, B.LPROD_NM �з���, C.BUYER_NAME �ŷ�ó��
  FROM PROD A, LPROD B, BUYER C
 WHERE A.PROD_LGU = B.LPROD_GU
   AND A.PROD_LGU = C.BUYER_LGU
   AND B.LPROD_GU = 'P102'


7) ��ǰ�԰����̺�(BUYPROD)�� 2005�⵵ 1���� �ŷ�ó��(�ŷ�ó�ڵ�, �ŷ�ó��) ���Աݾ��� �˻�( ���Աݾ� = ���Լ��� * ���Դܰ� )
( Alias�� �ŷ�ó�ڵ�, �ŷ�ó��, ���Աݾ� )

��. EQUAL JOIN ���
SELECT C.BUYER_ID �ŷ�ó�ڵ�, C.BUYER_NAME �ŷ�ó��, SUM(A.BUY_QTY*A.BUY_COST) ���Աݾ�
  FROM BUYPROD A, PROD B, BUYER C
 WHERE BUY_DATE BETWEEN '20050101' AND '20050131'
   AND A.BUY_PROD = B.PROD_ID
   AND B.PROD_LGU = C.BUYER_LGU
 GROUP BY C.BUYER_ID, C.BUYER_NAME

��) INNER JOIN ���
SELECT C.BUYER_ID �ŷ�ó�ڵ�, C.BUYER_NAME �ŷ�ó��, SUM(A.BUY_QTY*A.BUY_COST) ���Աݾ�
  FROM BUYPROD A
 INNER JOIN PROD B ON A.BUY_PROD = B.PROD_ID
 INNER JOIN BUYER C ON B.PROD_LGU = C.BUYER_LGU
 WHERE BUY_DATE BETWEEN '20050101' AND '20050131'
 GROUP BY C.BUYER_ID, C.BUYER_NAME


8) ��ٱ������̺��� 2005�⵵ 5���� ȸ���� ���űݾ��� �˻�( ���űݾ� = ���ż��� * �ǸŰ� )
( Alias�� ȸ��ID, ȸ����, ���űݾ� )

(Equi Join ��İ� Inner Join ��� �� ����)
SELECT B.MEM_ID ȸ��ID, B.MEM_NAME ȸ����, SUM(C.PROD_PRICE*A.CART_QTY) ���űݾ�
  FROM CART A, MEMBER B, PROD C
 WHERE A.CART_MEMBER = B.MEM_ID
   AND C.PROD_ID = A.CART_PROD
   AND A.CART_NO LIKE '200505%'
 GROUP BY B.MEM_ID, B.MEM_NAME

9) OUTER JOIN 

10) ��ü �з��� ��ǰ�ڷ� �� �� �˻� ��ȸ( Alias�� �з��ڵ�, �з���, ��ǰ�ڷ�� )

��. �з����̺� ��ȸ
SELECT *
  FROM LPROD

��. EQUAL JOIN
SELECT A.LPROD_GU, A.LPROD_NM, COUNT(PROD_ID)
  FROM LPROD A, PROD B
 WHERE A.LPROD_GU = B.PROD_LGU
 GROUP BY A.LPROD_GU, A.LPROD_NM

��. OUTER JOIN
SELECT A.LPROD_GU, A.LPROD_NM, COUNT(PROD_ID)
  FROM LPROD A, PROD B
 WHERE A.LPROD_GU = B.PROD_LGU(+)
 GROUP BY A.LPROD_GU, A.LPROD_NM

��. ANSI OUTER JOIN
SELECT A.LPROD_GU, A.LPROD_NM, COUNT(PROD_ID)
  FROM LPROD A
  LEFT OUTER JOIN PROD B ON A.LPROD_GU = B.PROD_LGU(+)
 GROUP BY A.LPROD_GU, A.LPROD_NM


11) ��ü��ǰ�� 2005�� 1�� �԰������ �˻� ��ȸ( Alias�� ��ǰ�ڵ�, ��ǰ��, �԰���� )
SELECT A.PROD_ID ��ǰ�ڵ�, A.PROD_NAME ��ǰ��, SUM(B.BUY_QTY) �԰����
  FROM PROD A, BUYPROD B
 WHERE A.PROD_INSDATE BETWEEN '20050101' AND '20050131'
   AND A.PROD_ID = B.BUY_PROD
 GROUP BY A.PROD_ID, A.PROD_NAME


12) ��ü ��ǰ�� 2005�⵵ 1�� 5���� �԰�.�����Ȳ ��ȸ(��ǰ�ڵ�, ��ǰ��, �԰������ ��, �Ǹż����� �� )

- �԰� Ȯ��(Equi Join)
SELECT A.PROD_ID ��ǰ�ڵ�, A.PROD_NAME ��ǰ��, SUM(B.BUY_QTY) �԰����, SUM(C.CART_QTY) �Ǹż���
  FROM PROD A, BUYPROD B, CART C 
 WHERE A.PROD_INSDATE = '20050105'
   AND A.PROD_ID = B.BUY_PROD
   AND A.PROD_ID = C.CART_PROD
 GROUP BY A.PROD_ID, A.PROD_NAME

- �Ǹ� Ȯ��(Inner Join)
SELECT A.PROD_ID ��ǰ�ڵ�, A.PROD_NAME ��ǰ��, SUM(B.BUY_QTY) �԰����, SUM(C.CART_QTY) �Ǹż���
  FROM PROD A
 INNER JOIN BUYPROD B ON A.PROD_ID = B.BUY_PROD
 INNER JOIN CART C ON A.PROD_ID = C.CART_PROD
 WHERE A.PROD_INSDATE = '20050105'
 GROUP BY A.PROD_ID, A.PROD_NAME

13) �ŷ�ó�� 2005�⵵ 1���� �ŷ�ó�� ���ں� ������Ȳ ��ȸ ( �ŷ�ó��, ��������, ���Աݾ� )
SELECT C.BUYER_NAME, B.BUY_DATE, SUM(B.BUY_QTY*B.BUY_COST)
  FROM PROD A, BUYPROD B, BUYER C
 WHERE A.PROD_ID = B.BUY_PROD
   AND A.PROD_BUYER = C.BUYER_ID
   AND B.BUY_DATE BETWEEN '20050101' AND '20050131'
 GROUP BY C.BUYER_NAME, B.BUY_DATE


14) 2005�⵵ ���� �Ǹ� ��Ȳ�� �˻�
(Alias�� �Ǹſ�, �Ǹż���, �Ǹűݾ�(�Ǹż���*��ǰ���̺��� �ǸŰ�))
SELECT SUBSTR(A.CART_NO, 5,2), SUM(A.CART_QTY), SUM(A.CART_QTY*B.PROD_PRICE)
  FROM CART A, PROD B
 WHERE A.CART_PROD = B.PROD_ID
 GROUP BY SUBSTR(A.CART_NO, 5,2)


15) ��ǰ�з��� ��ǻ����ǰ('P101')�� ��ǰ�� 2005�⵵ ���ں� �Ǹ� ��ȸ
( �Ǹ���, �Ǹűݾ�(5,000,000�ʰ��� ��츸), �Ǹż��� )
SELECT A.CART_NO, SUM(A.CART_QTY), SUM(A.CART_QTY*B.PROD_PRICE)
  FROM CART A, PROD B
 WHERE A.CART_PROD = B.PROD_ID
   AND B.PROD_LGU = 'P101'
 GROUP BY A.CART_NO
 HAVING SUM(A.CART_QTY*B.PROD_PRICE) > 5000000



