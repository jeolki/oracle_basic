�б⹮
1) IF ��
  - ���α׷��־���� IF���� ���� ��� ���� 
  (�������-1)
  IF ���� THEN
     ��ɹ�;
  ELSE 
     ��ɹ�;
  END IF;   
  
  (�������-2)
  IF ���� THEN
     ��ɹ�;
  ELSIF ���� THEN
     ��ɹ�;
  ELSIF ���� THEN
     ��ɹ�;
  ELSE 
     ��ɹ�;
  END IF;  
  
  (�������-3)
  IF ���� THEN
     IF ���� THEN
        ��ɹ�;
     ELSE 
        ��ɹ�;
     END IF;   
  ELSE 
     ��ɹ�;
  END IF;  
  
��)Ű����� ���� �Է� �޾� �ش� �������� ����ϴ� �͸� ����� �ۼ��Ͻÿ�  

ACCEPT P_BASE PROMPT '�������� ���Է�(2-9) : '
DECLARE
  V_BASE NUMBER := TO_NUMBER('&P_BASE');
  
BEGIN
  FOR I IN 1..9 LOOP
    DBMS_OUTPUT.PUT_LINE(V_BASE||'*'||I||'='||V_BASE*i);
    END LOOP;
END;


��)������ �μ��ڵ�(10-110)�� �����Ͽ� �ش�μ��� ���� ��� �� ù��°�� �˻��Ǵ� ���������
   �ش� ����� �޿��� �̿��Ͽ�
    1 ~ 3000 �����̸� '���ӱ� ���',
    3001 ~ 6000 �����̸� '�߰��ӱ� ���'
    6001 �̻��̸� '���ӱ� ���' �޼����� ��� ����Ͻÿ�
    ��, ����� ��������� �����ȣ, �����, �μ���, �޿�, ���
    --����������õ� �÷�������ŭ ��������
    
DECLARE
  V_EMP_ID  EMPLOYEES.EMPLOYEE_ID%TYPE;
  V_EMP_NAME EMPLOYEES.EMP_NAME%TYPE;
  V_DEPT_NAME DEPARTMENTS.DEPARTMENT_NAME%TYPE;
  V_DEPT_ID DEPARTMENTS.DEPARTMENT_ID%TYPE;
  V_SAL EMPLOYEES.SALARY%TYPE;
  V_REMARKS VARCHAR2(50);

BEGIN
  --�μ���ȣ ����
  V_DEPT_ID :=ROUND(DBMS_RANDOM.VALUE(10,120),-1);
  
  SELECT A.EMPLOYEE_ID, A.EMP_NAME, B.DEPARTMENT_NAME, A.SALARY
    INTO V_EMP_ID,V_EMP_NAME,V_DEPT_NAME,V_SAL
    FROM EMPLOYEES A, DEPARTMENTS B
   WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID
     AND A.DEPARTMENT_ID=V_DEPT_ID
     AND ROWNUM=1;

  IF V_SAL BETWEEN 1 AND 3000 THEN
     V_REMARKS := '���ӱ� ���';
  ELSIF V_SAL BETWEEN 3001 AND 6000 THEN
     V_REMARKS := '�߰��ӱ� ���';
  ELSE 
     V_REMARKS := '���ӱ� ���'; 
  END IF;   
  
  DBMS_OUTPUT.PUT_LINE('�����ȣ : ' ||V_EMP_ID);
  DBMS_OUTPUT.PUT_LINE('����� : ' ||V_EMP_NAME);
  DBMS_OUTPUT.PUT_LINE('�μ��� : ' ||V_DEPT_NAME);
  DBMS_OUTPUT.PUT_LINE('�޿� : ' ||V_SAL);
  DBMS_OUTPUT.PUT_LINE('��� : ' ||V_REMARKS);    
  DBMS_OUTPUT.PUT_LINE('------------------------');
  
END;
    

��)�������̺�(CART)���� 2005�� 6�� ��������踦 ��ȸ�Ͽ�
   ������� 1-50���� �̸� ���ϸ����� 30��
          50���� �ʰ� 100���� �����̸� 50��
          100���� �ʰ� 200���� �̸� 70��
          �� �̻��̸� 100���� �߰� �����ϴ� �͸����� �ۼ��Ͻÿ�
--ȸ����ȣ�� ����� ����ؼ� ������Ʈ �ɹ����̺��� ��ȸ�������� ���ϸ��� ������ �ױ����� ���� ����
  
(2005�� 6�� ȸ���� ��������� Ŀ��)--Ŀ������ ���پ������� ���� 
CURSOR CUR_MILE
IS
    SELECT CART_MEMBER,
           SUM(CART_QTY*PROD_PRICE)
      FROM CART, PROD
     WHERE CART_PROD=PROD_ID
       AND CART_NO LIKE '200506%'
     GROUP BY CART_MEMBER;  
     


----------------------------------

DECLARE
  V_PMILE  MEMBER.MEM_MILEAGE%TYPE;
  V_UMILE  MEMBER.MEM_MILEAGE%TYPE;
  CURSOR CUR_MILE
  IS
    SELECT CART_MEMBER,
           SUM(CART_QTY*PROD_PRICE) AS AMT
      FROM CART, PROD
     WHERE CART_PROD=PROD_ID
       AND CART_NO LIKE '200506%'
     GROUP BY CART_MEMBER;  
BEGIN
  FOR REC IN CUR_MILE LOOP
    SELECT MEM_MILEAGE INTO V_PMILE
      FROM MEMBER
     WHERE MEM_ID=REC.CART_MEMBER; 
    IF REC.AMT <= 500000 THEN
       V_UMILE:=V_PMILE+30;
    ELSIF REC.AMT <= 1000000 THEN
       V_UMILE:=V_PMILE+50;
    ELSIF REC.AMT <= 2000000 THEN
       V_UMILE:=V_PMILE+70;  
    ELSE
       V_UMILE:=V_PMILE+100;
    END IF;
    
    UPDATE MEMBER
       SET MEM_MILEAGE=V_UMILE
     WHERE MEM_ID=REC.CART_MEMBER;  
     
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('ȸ����ȣ : '||REC.CART_MEMBER);
    DBMS_OUTPUT.PUT_LINE('������ ���ϸ��� : '||V_PMILE);
    DBMS_OUTPUT.PUT_LINE('������ ���ϸ��� : '||V_UMILE);
    DBMS_OUTPUT.PUT_LINE('-----------------------');
  END LOOP;
END;  

2) CASE WHEN ��
  - ���ߺб�
  - ���α׷��־���� SWITCH ~ CASE�� ����
  
 (�������)
 CASE WHEN ����1 THEN
        ��ɹ�1;
      WHEN ����2 THEN
        ��ɹ�2;
           :
      ELSE
        ��ɹ�n;
 END CASE;

 (�������-2)
 CASE ���� WHEN ��1 THEN
         ��ɹ�1;
      WHEN ��2 THEN
         ��ɹ�2;
            :
      ELSE
         ��ɹ�n;
 END CASE;

��)Ű����� ����(0-100)�� �Է� �޾�
  90-100 : '��'
  80-89  : '��'
  70-79  : '��'
  �� ���� : '�� �� �����'�� ����ϴ� �͸��� �ۼ�
  
ACCEPT P_SCORE PROMPT '���� �Է�(0-100) : '
DECLARE
  V_SCORE NUMBER := TO_NUMBER('&P_SCORE');
  V_JUM NUMBER := TRUNC(V_SCORE/10);  
BEGIN
  CASE V_JUM WHEN 10 THEN
         DBMS_OUTPUT.PUT_LINE(V_SCORE||'-> ��');
       WHEN 9 THEN 
         DBMS_OUTPUT.PUT_LINE(V_SCORE||'-> ��');
       WHEN 8 THEN 
         DBMS_OUTPUT.PUT_LINE(V_SCORE||'-> ��');
       WHEN 7 THEN 
         DBMS_OUTPUT.PUT_LINE(V_SCORE||'-> ��');
       ELSE
         DBMS_OUTPUT.PUT_LINE(V_SCORE||'-> �� �� �����');
  END CASE;
END;

3)LOOP ��
 - ���α׷������ DO���� �ش�
 - �ݺ����� �⺻ ������ ����
 (�������)
 LOOP
   �ݺ�ó����;
   [EXIT WHEN ����;]
 END LOOP;
 
  - 'EXIT WHEN ����' �� ������ �����Ǹ� �ݺ��� ���
  
��)1-100������ ���� Ȧ���� �հ� ¦���� ���� ����Ͻÿ�
DECLARE 
  V_CNT NUMBER:=0;  --1~100������ ���� ����
  V_EVEN NUMBER:=0;  --¦���� ��
  v_ODD NUMBER:=0; --Ȧ���� ��
BEGIN
  LOOP
    V_CNT:=V_CNT+1;
    EXIT WHEN V_CNT>100;
    IF MOD(V_CNT,2)=0 THEN
      V_EVEN:=V_EVEN+V_CNT;
    ELSE
      V_ODD:=V_ODD+V_CNT;
    END IF;
  END LOOP;
  
  DBMS_OUTPUT.PUT_LINE('Ȧ���� �� : '||V_ODD);
  DBMS_OUTPUT.PUT_LINE('¦���� �� : '||V_EVEN);  
END;


4)WHILE ��
  - ���α׷������ WHILE ��ɰ� ���� ��� ����
  (�������)
  WHILE ���� LOOP
    �ݺ����;
  END LOOP;
    .'����'�� ���̸� �ݺ� ����� �����ϰ� �����̸� END LOOP ���� ����� ����


(WHILE������ ����)

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
  
  OPEN CUR_EMP02(TO_NUMBER('&P_DEPT_ID')); --�������ְ�
  FETCH CUR_EMP02 INTO V_EMP_ID,V_EMP_NAME,V_SAL; --����ó���� �ݺ����������� �����ϴ°�// ����� �ִ��� �������°�
  WHILE CUR_EMP02%FOUND LOOP  -- �ڷᰡ �ִ� �ϸ� ���� (ù���)  �ѻ���ۿ� ���ϱ⶧���� FETCH�� �ΰ� ����Ͼ���

    V_BONUS:=ROUND(V_SAL*0.3,1);
    V_MESSAGE:=V_EMP_ID||', '||V_EMP_NAME||', '||V_SAL||', '||V_BONUS;
    DBMS_OUTPUT.PUT_LINE(V_MESSAGE);
    
    FETCH CUR_EMP02 INTO V_EMP_ID,V_EMP_NAME,V_SAL; --ù��°��� �ϰ� �ι�°����� �����;��� 
    
  END LOOP;
   DBMS_OUTPUT.PUT_LINE('ó���Ǽ� : '||CUR_EMP02%ROWCOUNT); --Ŀ���� ���� ��ü ���Ǽ�
END;

��)�������� 2�ܺ��� 9�ܱ��� ��� ����ϴ� ����� WHILE���� �̿��Ͽ� �ۼ��Ͻÿ�
DECLARE
  V_BASE NUMBER:=2;
  V_CNT NUMBER:=1;
  
BEGIN
  WHILE V_BASE<10 LOOP
    DBMS_OUTPUT.PUT_LINE('**'||V_BASE||'�� **');
    V_CNT:=1;
    WHILE V_CNT<10 LOOP
      DBMS_OUTPUT.PUT_LINE(V_BASE||'*'||V_CNT||'='||V_BASE*V_CNT);
      V_CNT:=V_CNT+1;
    END LOOP;
    V_BASE:=V_BASE+1;
  END LOOP;
END;


5)FOR ��
 - ���α׷� ���߾���� FOR���� ���� ��� ����
 (�������)
 FOR ���ؽ� IN[REVERSE] �ʱⰪ.. ������ LOOP
   �ݺ�ó�����;
 END LOOP;
  . '�ε���'�� �ý��ۿ��� �ڵ����� ����
  . ������ �ݺ�ó�� �ϴ� ��� REVERSE�� �߰�
  
  
  
��) 1-50�������� FIBONACCI NUMBER�� ���Ͻÿ� --�˻��Ҷ� �����͸� ã���� ���
