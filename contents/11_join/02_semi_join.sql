����(SEMI) ����
 - ���������� ����Ͽ� ���������� ����� �����ϴ� �����͸� ������������ �����ϴ� ���� ���
 - IN�� EXISTS �����ڰ� ����
 
 
��) ������̺��� �޿��� 5000�̻��� ����� �����ϴ� �μ���ȣ�� �μ����� �����Ͻÿ�
-- ����κ��� �������� ����κ��� ����� �����Ұ����� �Ǵ�������Ѵ�.
-- �������������ϴ� �κ��� ���������̴�.
-- �ڷḦ �������ִ°��� ���������� �Ǵ°�. 

(�������� - �μ���ȣ�� �μ����� ����)

SELECT A.DEPARTMENT_ID AS �μ���ȣ,
       A.DEPARTMENT_NAME AS �μ���
  FROM DEPARTMENTS A
 WHERE A.DEPARTMENT_ID IN ( �������� ) ;
 
(�������� - �޿��� 5000�̻��� ����������ϴ� �μ���ȣ)

SELECT DISTINCT B.DEPARTMENT_ID 
  FROM EMPLOYEES B
 WHERE SALARY >= 5000
 ORDER BY 1;
 
(IN �����ڻ��)

SELECT A.DEPARTMENT_ID AS �μ���ȣ,
       A.DEPARTMENT_NAME AS �μ���
  FROM DEPARTMENTS A
 WHERE A.DEPARTMENT_ID IN ( SELECT DISTINCT B.DEPARTMENT_ID
                              FROM EMPLOYEES B
                             WHERE B.SALARY >= 5000 )
 ORDER BY 1;
 
 
(EXISTS ������ ���)
  - ���������� ��� �� ���̶� �����ϸ� ���� ��ȯ
  
SELECT A.DEPARTMENT_ID AS �μ���ȣ,
       A.DEPARTMENT_NAME AS �μ���
  FROM DEPARTMENTS A
 WHERE EXISTS (SELECT 1
                 FROM EMPLOYEES B
                WHERE B.SALARY >= 5000 
                  AND A.DEPARTMENT_ID = B.DEPARTMENT_ID)
 ORDER BY 1; 
 
 -- SEMI JOIN�� �ߺ��� �߻����� ���� 
(�������� ���) -- �ߺ��� �߻��ؼ� DISTINCT ���

SELECT DISTINCT A.DEPARTMENT_ID AS �μ���ȣ,
       A.DEPARTMENT_NAME AS �μ���
  FROM DEPARTMENTS A, EMPLOYEES B
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
   AND B.SALARY >= 5000                 
 ORDER BY 1; 
 
 ** ���������� ���������� ����� �ߺ��� �ڷᰡ �־ ���� ����� ��µǴ� 
    ������������ �ߺ��� �����ȴ�.
    
    
��) ������̺��� ��ձ޿����� �޿��� ���� ����� �Ҽӵ� �μ��ڵ�� �μ����� ��ȸ�Ͻÿ�

SELECT A.DEPARTMENT_ID AS �μ���ȣ,
       A.DEPARTMENT_NAME AS �μ���
  FROM DEPARTMENTS A
 WHERE EXISTS (SELECT 1
                 FROM EMPLOYEES B
                WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
                  AND B.SALARY >=(SELECT AVG(SALARY)
                                    FROM EMPLOYEES))
 ORDER BY 1;
 

��)�μ����̺��� MANAGER_ID�� NULL�� �ƴ� �μ��� ���� ������� ��ȸ�Ͻÿ� 

(�������� : �����)
SELECT COUNT(*)
  FROM EMPLOYEES A
 WHERE EXISTS ( ��������)


(�������� : �μ����̺��� MANAGER_ID�� NULL�� �ƴ� �μ��� ���� �μ��ڵ�)
SELECT DEPARTMENT_ID
  FROM DEPARTMENTS
 WHERE MANAGER_ID IS NOT NULL;
 
 
(����) 

SELECT COUNT(*) AS �����
  FROM EMPLOYEES A
 WHERE EXISTS (SELECT 1
                 FROM DEPARTMENTS B
                WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
                  AND B.MANAGER_ID IS NOT NULL); 
 
 
 
 