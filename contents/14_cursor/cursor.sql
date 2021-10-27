**CURSOR
  - SQL ������� ����޴� ����� ����
  - ������ Ŀ��/����� Ŀ��

1)������ Ŀ��
  - ����ڰ� SQL ���� ���� ��Ű�� �ڵ����� �����Ǵ� Ŀ��
  - �̸��� ���� OPEN�� ���ÿ� CLOSE�Ǿ���(����ڰ� Ŀ�� ���ճ��� �ڷḦ ACCESS�� �� ����)
  (Ŀ���Ӽ�)
------------------------------------------------------------
  Ŀ���Ӽ�           �ǹ�
------------------------------------------------------------
  SQL%FOUND        ������ճ��� �ϳ��� ���̶� �����ϸ� �� ��ȯ       
  SQL%NOTFOUND     ������ճ��� �ϳ��� ���̶� �����ϸ� ���� ��ȯ   
  SQL%ROWCOUNT     ��ȯ�� ��(����� ��)�� �� 
  SQL%ISOPEN       Ŀ���� OPEN �� �����̸� �� ��ȯ(�׻� ����)
------------------------------------------------------------
--��) ��ǰ�ڵ带�Է��Ҷ� �ִ���������Ȯ��.
--    Ư���� ��ǰ�з��� ������ ��� 20%�� ���ϰٴ�.
--    �ϳ��� �����Ҽ��� �ִ� FOUND�� ���϶��� ������Ʈ


��)
DECLARE
  V_DEPT EMPLOYEES.DEPARTMENT_ID%TYPE:=50;
BEGIN
  UPDATE EMPLOYEES
     SET SALARY = SALARY
   WHERE DEPARTMENT_ID=V_DEPT;
   
   DBMS_OUTPUT.PUT_LINE('�޿��� ����� ��� �� : '||SQL%ROWCOUNT);  
END;

  
2)����� Ŀ��
  - ����ڰ� CURSOR �������� ������ Ŀ��
  - Ŀ���� ����� Ŀ������->Ŀ��OPEN->Ŀ��FETCH->Ŀ��CLOSE�� 4�ܰ谡 �ʿ�
  
  (1)Ŀ�� ����(����)
    . ����ο��� ���
    (��������)
    CURSOR Ŀ����[(�Ű����� Ÿ��,...)] --OPEN ���� �����͸� �־��ָ� ���� �޾Ƶ帱 �������� �Ű������� ����// �� �Ű�����
    IS
      SELECT ��;
      
  (2)Ŀ�� OPEN
    . ���࿵��(BEGIN ~END;)���� ���
    . ����� Ŀ���� ���¸� ���� ���� ���·� ����
    (�������)
    OPEN Ŀ����[(�Ű�����1,....)]; --�� �Ű����� �Ѱ��� ���� ������
    
  (3)Ŀ�� FETCH
    . OPEN �� Ŀ�� ���� �ڷḦ ������� �о�� --������ �о ������ �־���
    . ���� �ݺ���� ���ο� ���
    (�������)
    FETCH Ŀ���� INTO ������1,...
     . Ŀ���� SELECT ���� �÷� ���� INTO ���� ������ �Ҵ�
     . SELECT ���� �÷��� ����, Ÿ��, ������ INTO ������ --�����Ŀ���� �����ϴ� SELECT��
       ������ ����, Ÿ��, ������ ��ġ�ؾ� ��
       
  (4)Ŀ�� CLOSE
    . ����� ����� Ŀ���� �ݵ�� CLOSE�Ǿ�� �� --�Ųٷδ� �ȵǼ� Ŭ�����ϰ� �ٽÿ����ؾ���
    (�������)
    CLOSE Ŀ����; 
  
  
��)������̺��� �Էµ� �μ���ȣ�� ���� ������� �޿��� 30%�� ���ʽ��� �����Ͽ����Ѵ�.
  �����ȣ, �����, �޿�, ���ʽ� �ݾ��� ����ϴ� �͸����� Ŀ���� ����Ͽ� �����Ͻÿ�
  --Ŀ���� �����ؾ��Ұ� �����ȣ ����� �׻���� �޿�
  --���ʽ��� �׻���� �޿��� �����ͼ� 0,3�� ���ؼ� ����ϴ°�
  
ACCEPT P_DEPT_ID PROMPT '�μ��ڵ�(10~110) �Է� : '
DECLARE
  V_BONUS NUMBER :=0;
  V_EMP_ID EMPLOYEES.EMPLOYEE_ID%TYPE;
  V_EMP_NAME EMPLOYEES.EMP_NAME%TYPE;
  V_SAL EMPLOYEES.SALARY%TYPE;
  V_MESSAGE VARCHAR2(100);
  
  CURSOR CUR_EMP02(CP_DEPT_ID EMPLOYEES.DEPARTMENT_ID%TYPE)
  IS 
    SELECT EMPLOYEE_ID, EMP_NAME, SALARY
      FROM EMPLOYEES
     WHERE DEPARTMENT_ID=CP_DEPT_ID;
  
BEGIN
  OPEN CUR_EMP02(TO_NUMBER('&P_DEPT_ID'));
  
  LOOP
    FETCH CUR_EMP02 INTO V_EMP_ID,V_EMP_NAME,V_SAL;
    EXIT WHEN CUR_EMP02%NOTFOUND; --���̻� ���ᰡ������ ��
    V_BONUS:=ROUND(V_SAL*0.3,1);
    V_MESSAGE:=V_EMP_ID||', '||V_EMP_NAME||', '||V_SAL||', '||V_BONUS;
    DBMS_OUTPUT.PUT_LINE(V_MESSAGE);
    
 
  END LOOP;
  CLOSE CUR_EMP02;
END;
  
--Ŀ���� ����ϴ� ���� �Լ��� ���ν����� ����������� �� ������ ����ȭ �ϱ� ���ؼ�








  