1.ǥ����
 - �ϳ��̻��� ���� ������, �Լ����� ���յ� ��
1) CASE WHEN THEN
  . Ư�� ���ǿ� ���� ���� ������ �� �ִ� ����(ǥ����)
  . �ַ� SELECT������ ���
  
  (�������)
  CASE WHEN ����1 THEN ��1
       WHEN ����2 THEN ��2
              : 
       ELSE ��n
  END
  
  
��) ������̺��� 80�� �μ� ������� �޿��� ��ȸ�Ͽ� �޿���
    15000 �̻��̸� 'A���',
    5000-14999 �����̸� 'B ���',
    5000 �̸��̸� 'C ���'���� ��� ǥ���Ͻÿ�
   Alias�� �����ȣ, �����, �޿�, ���
  
  SELECT EMPLOYEE_ID AS �����ȣ,
         EMP_NAME AS �����,
         SALARY AS �޿�,
         CASE WHEN SALARY >= 15000 THEN 'A���'
              WHEN SALARY >= 5000 AND SALARY < 15000 THEN 'B���' 
                   -- SALARY BETWEEN 5000 AND 14999 THEN
              ELSE 'C���'      
         END AS ���
    FROM EMPLOYEES
   WHERE DEPARTMENT_ID = 80; -- ���� ����
  


















  
  
  