  PL/SQL
  - Procedure Language SQL�� ����
  - �⺻ SQL�� ���, ����, ��� ���� ����� �������� �ʾ� ������� ����
  - �⺻ SQL�� ����� Ȯ���ϰ� ���ȭ, ĸ��ȭ ��� ����
  - �͸�ҷ�, ��������� �Լ�, �������ν���, Ʈ����, ��Ű�� ���� ����
  
  
1. �͸���(Anomymous Block)
  - �̸��� ���� ���� ���� ���
  - PL/SQL�� �⺻�� �Ǵ� ����
  - �ܼ���ũ��Ʈ���� ����ǵ� ������ ������� ����
  
 1) ����
 DECLARE
    �����(����, ���, Ŀ�� ����);
 BEGIN
    �����(�����Ͻ� ������ ó���ϱ� ���� SQL��);
    
    [EXCEPTION
        ����ó����;]
 END;
 
  (1) ����
     . �Ϲ� ���߾���� ������ ���� ��� �����͸� ��ú��� --�ϳ� ������ü ���̺���ü
     . SCLAR ���� - �ϳ��� �����͸� ����
     . REFERENCE ���� - ������ ���̺��� COLOMN�̳� ROW�� ������ �� �ִ� ����
     . COMPOSITE ���� - �迭������ RECORD TYPE�� TABLE TYPE�� ���� 
     . BIND ����(�Ű�����) - IN , OUT, INPUT���� ���Ǵ� �Ű�����
     
     --LEFT VALUE ������ �´� ��� ����  =  RIGHT VALUE 
     --ROWTYPE�� ����������
     (����/��� ���� ����)
     ����[���]�� [CONSTANT]������Ÿ�� | ���̺��.�÷���%TYPE | ���̺��%ROWTYPE 
        [ũ��][:= �ʱⰪ]
     . �ʱⰪ ������ ������ ��� ������ null�� �ʱ�ȭ��.
      
      -- �ʱⰪ�� �������� ������ ��� ������ null�� ����.
      -- ���ڵ����� �ϸ� �⺻������ �ʱⰪ������ ������Ѵ�.
      
��) �⵵�� �Է� �޾� �������� ��������� �Ǻ��ϴ� �͸����� �ۼ��Ͻÿ�
 DECLARE 
    V_YEAR NUMBER(4) := 0;
    V_MESSAGE VARCHAR2(50);
 BEGIN
    SELECT EXTRACT(YEAR FROM MEM_BIR) INTO V_YEAR
        FROM MEMBER
        WHERE LOWER(MEM_ID) = 'f001';
        
    IF (MOD(V_YEAR,4)=0 AND MOD(V_YEAR,100)!=0) OR
       (MOD(V_YEAR,400)=0) THEN
        V_MESSAGE := V_YEAR||'�� �����Դϴ�.';
    ELSE
        V_MESSAGE := V_YEAR||'�� ����Դϴ�.';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(V_MESSAGE);
 END;
 

��)��ǰ���̺��� ���� ū �ǸŰ��� ���� ��ǰ��ȣ, ��ǰ��, �з���, ������ ����ϴ� ���ν����� �ۼ��Ͻÿ�

DECLARE
  V_PROD_ID    PROD.PROD_ID%TYPE;
  V_PROD_NAME  PROD.PROD_NAME%TYPE;
  V_LPROD_NM   LPROD.LPROD_NM%TYPE;
  V_PRICE      PROD.PROD_PRICE%TYPE;
  
  V_MESSAGE    VARCHAR2(100);
BEGIN
  SELECT * INTO V_PROD_ID,V_PROD_NAME,V_LPROD_NM,V_PRICE
    FROM (SELECT PROD_ID,PROD_NAME,LPROD_NM,PROD_PRICE 
            FROM PROD, LPROD
           WHERE PROD_LGU=LPROD_GU
        ORDER BY PROD_PRICE DESC) A
  WHERE ROWNUM=1;
  
  V_MESSAGE:=V_PROD_ID||', '||V_PROD_NAME||', '||V_LPROD_NM||', '||V_PRICE;
  DBMS_OUTPUT.PUT_LINE(V_MESSAGE);
END;





















      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      