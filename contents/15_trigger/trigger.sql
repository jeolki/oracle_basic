 Ʈ����(Trigger)
 - ������ �̺�Ʈ (INSERT, UPDATE, DELETE)�� �߻��Ǳ� �� �Ǵ� �߻� �� 
 �ٸ� ���̺��� �ڵ� ������ �ǵ��� �ϱ� ���� ���Ǵ� ���ν���
 (�������)
 CREATE OR REPLACE TRIGGER Ʈ���Ÿ� 
  AFTER | BEFORE  [INSERT | UPDATE | DELETE ]
  ON ���̺��
  [FOR EACH ROW][WHEN ����] --��) 5�� �μ�Ʈ�Ѵ� �ϸ� ����� �ٸ��� �ؾ��ؼ�
 BEGIN
  SQL ����;
  
 END;  
 
 
1)Ÿ�̹�
  - BEFORE�� AFTER
  - BEFORE : �̺�Ʈ�� �߻��Ǳ����� BEGIN ~ END ����� SQL���� ����
  - AFTER : �̺�Ʈ�� �߻��� �Ŀ� BEGIN ~ END ����� SQL���� ����

2)EVENT
  - Ʈ���� �߻� �����̵Ǵ� DML��
  - OR �����ڷ� ���� ��� ����(ex) INSERT OR UPDATE OR DELETE
  
3)WHEN ���� : ����� Ʈ���ſ����� ��� ����(�̺�Ʈ�� �߻��ɶ� ��ü���� �˻� ���� ���)
     -- ������ ���� ���� Ʈ���� ����
     
** Ʈ���� �ǻ� ���ڵ�
---------------------------------------------------------
�ǻ緹�ڵ�              ��       ��
--------------------------------------------------------
 : NEW    �����Ͱ� ����(����)�ɶ� ���� �Էµ� ��
          INSERT/UPDATE �̺�Ʈ�� ���� Ʈ���ſ���
          �� ���(DELETE �̺�Ʈ������ NULL��)
 : OLD    �����Ͱ� ����(����)�ɶ� ���� �Էµ� ��
          DELETE/UPDATE �̺�Ʈ�� ���� Ʈ���ſ���
          �� ���(INSERT �̺�Ʈ������ NULL��)
----------------------------------------------------------

** Ʈ���� �Լ�
  (1) INSERTING : Ʈ���� ������ INSERT�̸� TRUE
  (2) UPDATTING : Ʈ���� ������ UPDATE�̸� TRUE
  (3) DELETING : Ʈ���� ������ DELETE�̸� TRUE
  
  
  
��) ��ǰ�ڵ� 'p101000001' ��ǰ�� �� 'c001' ���� '20050810'��
    10���� �����ߴٰ� �����ϰ� ������ ���̺��� �����ϴ� Ʈ���� �ۼ�
    
DECLARE
  V_CNT NUMBER:=0;
BEGIN
  SELECT COUNT(*)INTO V_CNT
    FROM CART
   WHERE CART_NO LIKE '20050810%';
   
   IF V_CNT=0 THEN
     INSERT INTO CART VALUES('c001','2005081000001','p101000001',10);
   END IF
END;

(Ʈ���� ����)
CREATE OR REPLACE TRIGGER TG_CART01
  AFTER INSERT ON CART
  FOR EACH ROW
DECLARE
  V_QTY NUMBER:=0;
  V_PROD PROD.PROD_ID%TYPE;
BEGIN
  V_QTY:=:NEW.CART_QTY;
  V_PROD:=:NEW.CART_PROD;
  UPDATE REMAIN
     SET REMAIN_O = REMAIN_O+V_QTY,
         REMAIN_J_99 = REMAIN_J_99-V_QTY,
         REMAIN_DATE='20050810'
   WHERE REMAIN_PROD=V_PROD;
END;
    
    
 INSERT INTO CART VALUES('c001','200508100001','P101000001',10);    
    
    
    
    
    
          