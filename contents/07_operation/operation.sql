1.������

1). ��� ������.
 - ���� ���α׷������ ��������ڿ� ���� �� ����� ����
 - ��ȸ�Ǵ� �÷��� ���� ������� ������
 - +,-,/,*,()�� ����
 
��) ȸ�����̺��� ȸ���鿡�� ���ϸ����� 1000�� �߰� �����Ϸ� �Ѵ�.
    Alias �� ȸ����ȣ, ȸ����, �������ϸ���, �������ϸ���
    
    SELECT MEM_ID AS ȸ����ȣ,          --Ǯ���� ; �α��ΰ���, ���̺�� 
           MEM_NAME AS ȸ����,
           MEM_MILEAGE AS "���� ���ϸ���",         --������ ���� ""�κ���
           MEM_MILEAGE+1000 AS "���� ���ϸ���"       --������ �÷��� ,������
      FROM MEMBER;
      
��) �����ڷ�(BUYPROD)���� 2005�� 1�� 16�� ���������� ��ȸ�Ͻÿ� --������ �־��� 
    Alias�� ��ǰ�ڵ�, ����, �ܰ�, �ݾ��̴�
    �ݾ��� ���� * �ܰ� �̴�.

    SELECT BUY_PROD AS ��ǰ�ڵ�, 
           BUY_QTY AS ����,
           BUY_COST AS �ܰ�,
           BUY_QTY * BUY_COST AS �ݾ�
      FROM BUYPROD
     WHERE BUY_DATE=TO_DATE('20050116') --���� , �־��� ���ڿ��� ��¥Ÿ������ ��ȯ TO_DATE


��) ������̺�(EMPLOYEES)���� ������� ��������(COMMISSION_PCT)
    �� ���� ���ʽ��� ����Ͽ� ���޾��� ��ȸ�Ϸ��Ѵ�.
    ���ʽ� = ���� * ��������
    ���޾� = ���� + ���ʽ�

    Alias�� �����ȣ, �����, �μ��ڵ�, ����, ���ʽ�, ���޾��̴�.

    SELECT EMPLOYEE_ID AS �����ȣ,
           EMP_NAME AS �����
           DEPARTMENT_ID AS �μ��ڵ�
           SALARY AS ����
           NVL(SALARY * COMMISSION_PCT,0) AS ���ʽ�, -- NULL ���� �̾ INT��NULL�� ���NULL// NVLó�����ش�.
           SALARY + NVL((SALARY * COMMISSION_PCT),0) AS ���޾� 
     FORM  EMPLOYES;
    
��) ȸ�����̺��� ȸ������ �ֹε�Ϲ�ȣ�� �̿��Ͽ� ���̸� ����Ͻÿ�
    Alisa�� ȸ����ȣ, ȸ����, �ֹι�ȣ1, ����, ����
    
    SELECT MEM_ID AS ȸ����ȣ, 
           MEM_NAME AS ȸ����, 
           MEM_REGNO1 AS �ֹι�ȣ1,
           EXTRACT(YEAR FROM SYSDATE)-               -- SYSDATE���� YEAR ������ ��������
             TO_NUMBER('19'||SUBSTR(MEM_REGNO1,1,2)) AS ����,   -- ���ڿ����� ����� 19�� �տ��� ���Ѱ� + =>|| �� ���ڷκ���
           MEM_JOB AS ����   
      FROM MEMBER;
    
2). ���� ������
 - �׸��� ��Ұ��踦 ��
 - >,<,=,>=,<=,!=(<>) 
 - ����� TRUE, FALSE -- SELECT �������� ������ ������������ ��� ����Ŭ�� BOOLEAN �� ���� 
 - WHERE, HAVING�� �� ǥ���� CASE WHEN ~ THEN ���� ���� ����� ���
 
��) ������̺��� �޿��� 5000�̻��� ����� ��ȸ�Ͻÿ�  --ũ�ų� ����
    Alias �����ȣ, �����, ��å�ڵ�, �޿�

    SELECT EMPLOYEE_ID AS �����ȣ, 
           EMP_NAME AS �����,
           JOB_ID AS ��å�ڵ�,
           SALARY AS �޿�
      FROM EMPLOYEES
     WHERE SALARY >= 5000;     --�ݵ�� �ε�ȣ�� �� >=, <=

��) 234567 * 94754 / 23�� ���Ͻÿ�  -- ������ ���̺� DUAL ����Ѵ�
    SELECT 234567 * 94754 / 23
      FROM DUAL;  
    
    
��) ȸ�����̺��� ����ȸ�������� ��ȸ�Ͻÿ�
    Alias�� ȸ����ȣ, ȸ����, ���ϸ���, ���
    ����� '����ȸ��'�̶�� �޽����� ����Ͻÿ�
    
    SELECT MEM_ID AS ȸ����ȣ,
           MEM_NAME AS ȸ����,
           MEM_MILEAGE AS ���ϸ���,
           '����ȸ��' AS ���   -- ���̺� ����� ĭ�̾����� ������ �ٷ� �־��ش�.
      FROM MEMBER
     WHERE SUBSTR(MEM_REGNO2,1,1)='2'  -- ���ڿ��̱⶧���� �񱳴�� ���ڰ� �Ǿ���Ѵ�.
        OR SUBSTR(MEM_REGNO2,1,1)='4';
    
��) ȸ�����̺��� ȸ�������� ��ȸ�Ͻÿ�
    Alias�� ȸ����ȣ, ȸ����, ���ϸ���, ����
    �������� '����ȸ��' �Ǵ� '����ȸ��'�� ����Ͻÿ�  --�����̾���. -- CASE WHEN THEN ELSE END���

    SELECT MEM_ID AS ȸ����ȣ,
           MEM_NAME AS ȸ����,
           MEM_MILEAGE AS ���ϸ���,
           CASE WHEN (SUBSTR(MEM_REGNO2,1,1)='2' OR
                      SUBSTR(MEM_REGNO2,1,1)='4') THEN '����ȸ��'
                ELSE '����ȸ��' END AS ����  
      FROM MEMBER;


3). �� ������
  - ������ 2�� �̻� ����Ǵ� ��� ���(AND,OR)
  - ������ ����� �����ϴ� ���(NOT)
  (����ǥ)
---------------------------
   �Է�          ���
  A   B      AND    OR     
---------------------------  
  F   F       F     F
  F   T       F     T
  T   F       F     T
  T   T       T     T
  

��) Ű����� ������ ����⵵�� �Է��ϸ� �������� ������� �����Ͽ�
    '����Դϴ�' �Ǵ� '�����Դϴ�'��� �޽����� ����ϴ� �����ۼ�
    
ACCEPT P_YEAR PROMPT '����⵵ : ' --�����ݷ� �ȵ�
DECLARE
  V_YEAR  NUMBER := TO_NUMBER('&P_YEAR');
  V_MESSAGE VARCHAR2(50);
BEGIN
  IF (MOD(V_YEAR,4)=0  AND MOD(V_YEAR,100)!=0) OR (MOD(V_YEAR,400)=0) THEN --MOD ������
     V_MESSAGE := V_YEAR||' �⵵�� �����Դϴ�';  -- || ���ڿ����ϱ�
  ELSE
     V_MESSAGE := V_YEAR||' �⵵�� ����Դϴ�';
  END IF;
  
  DBMS_OUTPUT.PUT_LINE(V_MESSAGE);  --����޴����� DBMS���â Ȱ��ȭ������� �Ѵ�.
END;















  
  