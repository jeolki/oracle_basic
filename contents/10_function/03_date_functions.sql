��¥�Լ�
1. SYSDATE
  - �ý����� �����ϴ� ��¥����(��,��,��,��,��,��)
  - ������ ������ ����� �� �� �ִ�.('/'�� '*'�� ������ ����)
  - ����� ����ϱ����� ���(�ú��ʱ��� ����ϱ� ���Ͽ� TO_CHAR�Լ��� �ʿ�)

��)������� �Ի����� �������� ���ó�¥���� �Ѵ� �̳��� �Ի��� ����鿡�� 
   Ư�� �󿩱��� �����Ϸ��Ѵ�. 
   Alias�� �����ȣ, �̸�, �μ���ȣ, �޿�, �󿩱�, ���޾�
   ��, �󿩱��� ������ 10%�̴�.
   
SELECT EMPLOYEE_ID AS �����ȣ,
       EMP_NAME AS �̸�,
       DEPARTMENT_ID AS �μ���ȣ,
       HIRE_DATE AS �Ի���,
       SALARY AS �޿�,
       SALARY *0.1 AS �󿩱�,
       SALARY + (SALARY*0.1) AS���޾�
  FROM EMPLOYEES
 WHERE EXTRACT(MONTH FROM HIRE_DATE) = EXTRACT(MONTH FROM SYSDATE); -- ��¥�� ���� ���� �����ϼ���
 
��)
SELECT SYSDATE, SYSDATE-10, SYSDATE+10 FROM DUAL;

SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS'),   -- �ú��ʱ��� ����ϱ����ؼ� TO_CHAR ����Ѵ�.
       TO_CHAR(SYSDATE-10,'YYYY-MM-DD HH24:MI:SS'),
       TO_CHAR(SYSDATE+10,'YYYY-MM-DD HH24:MI:SS') 
  FROM DUAL;


2. ADD_MONTHS
  - �־��� ��¥ ������ �������� ���� ��¥�� ��ȯ
  (�������)
  ADD_MONTHS(d, n)
   . 'd'���� 'n'������ ���� ��¥ ��ȯ

��) ȸ������ ������ ��ȸ�Ͽ� ����ް� �Ѵ���, �Ѵ��� ������ ȸ���� ��ȸ�Ͻÿ�
    Alias�� ȸ����, �������, ���ϸ���
    
SELECT MEM_NAME AS ȸ����,
       MEM_BIR AS �������,
       MEM_MILEAGE AS ���ϸ���
  FROM MEMBER
 WHERE EXTRACT(MONTH FROM MEM_BIR) =
       EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE, -1))  -- �Ѵ���
    OR EXTRACT(MONTH FROM MEM_BIR) =
       EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE, 1))  -- �Ѵ��� 
    OR EXTRACT(MONTH FROM MEM_BIR) =
       EXTRACT(MONTH FROM SYSDATE); 
 
��) ������� �Ի����� �̿��Ͽ� ������������ �߷ɵ� ���ڸ� ��ȸ�Ͻÿ�
    ���� �߷����� �Ի� �� 3������ �����Ⱓ�� ���� �����̴�.
    Alias�� �����ȣ, �����, �Ի���, �߷���, �μ���ȣ
    
SELECT EMPLOYEE_ID AS �����ȣ,
       EMP_NAME AS �����,
       HIRE_DATE AS �Ի���,
       ADD_MONTHS (HIRE_DATE, 3) AS �߷���,
       DEPARTMENT_ID AS �μ���ȣ
  FROM EMPLOYEES
    
3. EXTRACT
  - �־��� ��¥�������� �ʿ�� �κ�(��,��,��,��,��,��)�� �����Ҷ� ���
  (�������)
  EXTRACT(fmt FROM d)
   . 'fmt' : YEAR, MONTH, DAY, HOUR, MINUTE, SECOND �̴�.
   
��)������ 2010�� 6�� 15���̶� �����ϰ� ������̺��� 5���̻� �ټ���
   ��������� �����Ͻÿ�
   Alias�� �����ȣ, �����, �Ի���, �μ��ڵ�, �����ڵ��̴�.
  
SELECT EMPLOYEE_ID AS �����ȣ,
       EMP_NAME AS �����,
       HIRE_DATE AS �Ի���,
       DEPARTMENT_ID AS �μ��ڵ�,
       JOB_ID AS �����ڵ�
  FROM EMPLOYEES
 WHERE EXTRACT(YEAR FROM TO_DATE('20100615')) - EXTRACT(YEAR FROM HIRE_DATE) >= 5;

-- WHERE (EXTRACT(YEAR FROM SYSDATE)-10) - EXTRACT(YEAR FROM HIRE_DATE) >= 5;

4. MONTHS_BETWEEN
  - �־��� �� ��¥ ������ ������ �������� ��ȯ
  (�������)
  MONTHS_BETWEEN(d1, d2)
  
��) ȸ������ �������(MEM_BIR)�ڷ�� ���ó�¥�� �̿��Ͽ� ���̸� �������� ��ȸ�Ͻÿ�
    Alias�� �̸�, �������, ����Ȱ�����
    
SELECT MEM_NAME AS �̸�,
       MEM_BIR AS �������,
       ROUND(MONTHS_BETWEEN(SYSDATE, MEM_BIR)) AS ����Ȱ�����,
       TRUNC(ROUND(MONTHS_BETWEEN(SYSDATE, MEM_BIR))/12) AS ����
  FROM MEMBER;








