������ �Լ�
1. �������Լ�
   ABS(n), SIGN(n), POWER(n,m), SQRT(n)
-- ���밪 / ����(-1) 0 ���(1)/ n^m �ŵ����� / ����(��Ʈ)

��)
SELECT ABS(-205),
       SIGN(50000),
       SIGN(-0.0006),
       SIGN(0),
       POWER(2,10),
       SQRT(56*3)
  FROM DUAL;
  
2.GREATEST, LEAST
 - �־��� �ڷ� �� �ּҰ�, �ִ밪 ��ȯ
 (��뿹)
 SELECT GREATEST('���ѹα�','�̱�','�Ϻ�','�ʸ���') FROM DUAL; --�����ټ����� ó��
 -- GREATEST�� �̹̾˰��ִ� �ڷ��� �ִ밪�� ���ϴ°� --���� �Ⱦ�
 -- MAX ��Ư�� �ڷ�� �� ���� ū���� ���ϴ°�
 
 ȸ�����̺��� ���� ū ���ϸ��� ���� ��ȸ�Ͻÿ�
 -- GREATEST�� ,�� ����������Ѵ�.
 
 SELECT MAX (MEM_MILEAGE) FROM MEMBER;
 
 
 --�����Լ��� �ݵ�� �Ϲ��׸��� ���̳��;� �׷���̻���ؾ��Ѵ� 
 
 
 SELECT MEM_NAME,
        MAX(MEM_MILEAGE)
   FROM MEMBER
 GROUP BY MEM_NAME;
 
 
  SELECT MEM_NAME,
         A.MAXMILE
   FROM SELECT MAX(MEM_MILEAGE) AS A.MAXMLLE,
        FORM MOMBER, MEMBER 9
  WHERE A.MAXILL=B.MEM_MILAGAE
 
 
 SELECT LEAST(1000,800,3200,8700) FROM DUAL;
 
 ����]ȸ�����̺��� ���ϸ����� 1000���� ������� 1000���� �����Ͽ� ��ȸ�Ͻÿ�
     Alias�� ȸ����ȣ, ȸ����, ����, ���ϸ���, ����ȸ��ϸ��� 
 
 SELECT MEM_ID AS ȸ����ȣ,
        MEM_NAME AS ȸ����,
        MEM_JOB AS ����,
        MEM_MILEAGE AS ���ϸ���,
        GREATEST(MEM_MILEAGE, 1000) AS ����ȸ��ϸ���  -- �������� 1000������ ����ȴ�. ū���� �״�����
   FROM MEMBER ;


3.ROUND, TRUNC
 - �ݿø�(ROUND)�� ����(TRUNC)�� ���� ��ȯ
 1)ROUND(n[,m])
   . m�� ���� ������ ��� n�� �� �� �Ҽ��� m+1�ڸ����� �ݿø��Ͽ� m�ڸ����� ���� ��ȯ
   . m�� �����Ǹ� 0���� ����
   . m�� �����̸� �Ҽ��� �̻�(�����κ�) m�ڸ����� �ݿø�(�Ҽ������ϴ� ����)
 2)TRUNC(n[,m])
   . m�� ���� ������ ��� n�� �� �� �Ҽ��� m+1�ڸ����� �����Ͽ� m�ڸ����� ���� ��ȯ
   . m�� �����Ǹ� 0���� ����
   . m�� �����̸� �Ҽ��� �̻�(�����κ�) m�ڸ����� ����(�Ҽ������ϴ� ����)
 
 ��)������̺��� �޿��� ���޿������� �����ϰ� �ֱ����� �޿��� �����Ϸ� �Ѵ�.
    ����鿡�� ������ �ֱ޾��� ����Ͽ� �ֱ��� 1000�̻��� ����� ��ȸ�Ͻÿ�
    �ֱ޾��� �Ҽ��� 2�ڸ����� �ݿø��Ͻÿ�
    Alias�� �����ȣ, �����, ���޿���, �ֱ޾�, �����ڵ�

SELECT EMPLOYEE_ID AS �����ȣ,
       EMP_NAME AS �����,
       SALARY AS ���޿���,
       ROUND(SALARY/4,1) AS �ֱ޾�,
       JOB_ID AS �����ڵ�
  FROM EMPLOYEES
 WHERE ROUND(SALARY/4,1) >= 1000;
  

��)��ǰ���̺��� �з��ڵ� 'P202'�� ���� ��ǰ���� �����Ǹ� �Ϸ��Ѵ�.
   �������� 18%�϶� �� ��ǰ�� ���� �ǸŰ��� ��ȸ�Ͻÿ�
   Alias�� ��ǰ��, ����������, �����İ���, ���ΰ���
   ��, ���ΰ����� 10���������� ���
   
SELECT PROD_NAME AS ��ǰ��,
       PROD_PRICE AS ����������,
       PROD_PRICE - ROUND((PROD_PRICE*0.013),-1) AS "�����İ���(ROUND)",
       PROD_PRICE - TRUNC((PROD_PRICE*0.013),-1) AS "�����İ���(TRUNC)",
       ROUND((PROD_PRICE*0.013),-1) AS "���ΰ���(ROUND)",
       TRUNC((PROD_PRICE*0.013),-1) AS "���ΰ���(TRUNC)",
       PROD_PRICE*0.013 AS ���ΰ���
  FROM PROD 
 WHERE UPPER(PROD_LGU)='P202';  -- ��������Ÿ�������� �÷����� �ٲ��ش�.
 
 ��)�� ��ǰ�� ���ͷ��� ��ȸ�Ͻÿ�
    ���ͷ�(�����ͷ�)=(���Ⱑ-���԰�)/���԰�
    ���ͷ��� �Ҽ�2�ڸ����� ���Ͽ�(�ݿø�) %������ ���
    Alias�� ��ǰ��, ���԰�, ���Ⱑ, ������, ���ͷ� 
 
 SELECT PROD_NAME AS ��ǰ��,
        PROD_COST AS ���԰�,
        PROD_PRICE AS ���Ⱑ,
        PROD_PRICE - PROD_COST AS ������,
        ROUND(((PROD_PRICE - PROD_COST)/PROD_COST),2)*100 || '%' AS ���ͷ�
   FROM PROD;
 
4. CEIL, FLOOR
  - ���� ����� ������ ���ϴ� �Լ� 
  - ����, �޿��� �ݾ׿� ���õ� ��꿡 �ַ� ���
 
  1) CEIL(n)
   . n�� ���ų� ū �ʿ��� ���� ����� ������ ��ȯ�Ѵ�.
  ��)
  SELECT CEIL(10.34), CEIL(10), CEIL(-10.34) FROM DUAL; -- ū�ʿ��� ���� ���� ������ ����

  2) FLOOR(n)
   . n�� ���ų� �����ʿ��� ���� ����� ���� ��ȯ�Ѵ�.
  ��)
  SELECT FLOOR(10.34), FLOOR(10), FLOOR(-10.34) FROM DUAL;  -- �����ʿ��� ���� ���� ������ ����
 
5. MOD, REMAINDER
  - �������� ���Ҷ� ���
  - �ڹ��� '%'������ ��Ȱ
  - ���������� ���� ����� �ٸ�
  (1) MOD
    MOD(n, c) = n - c * FLOOR(n / c)  -- n�� c�� ���� ������
    ��) MOD(14 , 5)            -- ���������� FLOOR ���ȴ�
        = 14 - 5 * FLOOR(14/5)
        = 14 - 5 * FLOOR(2.8)
        = 14 - 5 * 2
        = 4
    SELECT MOD(14, 5) FROM DUAL; 
          
 (2) REMAINDER(n, c)
    REMAINDER(n, c) = n - c * ROUND(n / c)  -- ROUND(10) �Ҽ� ù��¥������ �ݿø� = ROUND(10, 0)
    ��) REMAINDER(14, 5)    -- ���� 3�̵Ǳ����ؼ� ���������� ��??
        = 14 - 5 * ROUND(14/5)
        = 14 - 5 * ROUND(2.8)
        = 14 - 5 * 3
        = 14 - 15
        = -1
   
       REMAINDER(12, 5)    
        = 12 - 5 * ROUND(12/5)
        = 12 - 5 * ROUND(2.4)
        = 12 - 5 * 2
        = 12 - 10
        = 2 
 
       REMAINDER(13, 5)    
        = 13 - 5 * ROUND(12/5)
        = 13 - 5 * ROUND(2.6)
        = 13 - 5 * 3
        = 13 - 15
        = -2  
 
  SELECT REMAINDER(14, 5), REMAINDER(13, 5), REMAINDER(12, 5) FROM DUAL;
 
 
6. WIDTH_BUCKET
  - �־��� �ڷῡ ���Ͽ� ������ ���ϰ� ��� ������ �־��� ���� ���ϴ� ���� ��ȯ
  (�������)
  WIDTH_BUCKET(c, min, max, b) 
   . c : �־��� �� �Ǵ� �÷���
   . min : ������ ���� ��
   . max : ������ ���� ��
   . b : ������ ����
   
 ��) ȸ�����̺��� ���ϸ����� 1000~9000������ ������ 9���� ������ ��
     ȸ������ ���ϸ����� ��� ������ ���ϴ����� ��ȸ�Ͻÿ�
     Alias�� ȸ����, ���ϸ���, ���
     ����� ��ȯ�� �������� '���'���ڿ��� �����Ͽ� ���
     
 SELECT MEM_NAME AS ȸ����,
        MEM_MILEAGE AS ���ϸ���,
        WIDTH_BUCKET(MEM_MILEAGE, 9000, 1000, 9) ||'���' AS ��� 
                    -- ���Ѱ��� ���Ѱ��� ��ġ�� �ݴ�����ָ� �������� �������ִ�.
   FROM MEMBER;   -- ��üȸ���̴ϱ� WHERE�� ���ʿ�   
     
 ��) ȸ�����̺��� ���ϸ����� 500~9000������ ������ 4���� ������ ��
     ȸ������ ���ϸ����� ��� ������ ���ϴ����� ��ȸ�Ͻÿ�
     Alias�� ȸ����, ���ϸ���, ���
     ����� ��ȯ�� �������� 1�̸� 'vip ȸ��' 2�̸� '��ȸ��' 
                        3�̸� '��ȸ��' 4�̸� '����ȸ��'�̶�� ���     
     
 SELECT MEM_NAME AS ȸ����,
        MEM_MILEAGE AS ���ϸ���,
   CASE WHEN WIDTH_BUCKET(MEM_MILEAGE, 9000, 500, 4) = 1 THEN 'vipȸ��'
        WHEN WIDTH_BUCKET(MEM_MILEAGE, 9000, 500, 4) = 2 THEN '��ȸ��'
        WHEN WIDTH_BUCKET(MEM_MILEAGE, 9000, 500, 4) = 3 THEN '��ȸ��'
        ELSE '����ȸ��'       
        END AS ���                     
   FROM MEMBER;     
 
 
 
 
 