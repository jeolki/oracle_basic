 1. insert
 - �ڷ��Է�
 - ������ ���̺��� ���ο� �ڷḦ �����ϴ� ����
 (�������)
 
INSERT INTO ���̺���[(�÷���1,�÷���2,...)]
  VALUES(��1, ��2,...);

 . '�÷���'�� '��'�� ������ ����, ������ Ÿ���� ��ġ�ؾ� �Ѵ�
 . '(�÷���1,�÷���2,...)'�� ����ϴ� ��� �÷��Ӽ��� 'NOT NULL'�� ���
   '�÷���'�� ������ �� ����(�÷��Ӽ��� 'NOT NULL'�� �ƴ� ��� '�÷���'�� ������ �� ������
   �ش� �÷��� �����Ǵ� '��'�� �����ؾ� �Ѵ�.
 . '(�÷���1,�÷���2,...)'�� �����Ǹ� ���̺��� ����� �÷� ������ ������ŭ '��'�� ����ؾ��Ѵ�.
 
 
 ��)������̺��� ���� �ڷḦ �Է��Ͻÿ�
    [�ڷ�]
    ���ID  201703010003              200908050012              202001050001
    �����   ȫ�浿                     �̹̳�                     ������
    �ּ�    ������ �߱� ���ﵿ           ������ ������ ������          ����� ���ϱ� ������
    ��ȭ��ȣ 010-1234-5678             042-234-6789              010-0987-1234
    ������   ����                       ����                      ����
    �μ���   �ѹ���                     �λ��                     ���ߺ�

 
INSERT INTO EMP
 VALUES('201703010003','ȫ�浿','������ �߱� ���ﵿ',
        '010-1234-5678','����','�ѹ���');
        
INSERT INTO EMP(EMP_ID,ADDRESS,EMP_NAME,JOB_TITLE)
 VALUES('200908050012','������ ������ ������','�̹̳�','����');       
 
INSERT INTO EMP (EMP_ID,EMP_NAME,ADDRESS,TEL_NUM,JOB_TITLE,DEPT_NAME)
 VALUES('202001050001','������','����� ���ϱ� ������',
        '010-0987-1234','����','���ߺ�');
 

UPDATE EMP
   SET TEL_NUM='042-234-6789',
       DEPT_NAME='�λ��'
 WHERE EMP_ID='200908050012';
 

��) ��������̺�(CONST_SITE)�� �����ڷḦ �����Ͻÿ�
[�ڷ�]
������ȣ : W1001
������ : �ٻ�ƽ������Ʈ ����
������ּ� : ������ ����� ���� 345-10
�������ȭ��ȣ : 042-6667-8889
����ݾ� : 
�����ο� : 3,456��
�ð����� : ���ó�¥
����ϰ��� : 
�ϰ����� : 
��� : ������

INSERT INTO CONST_SITE(SITE_ID,SITE_NAME,SITE_ADDRESS,SITE_TEL_NUM,
                       INPUT_PERSON_AMT,REMARKS)
       VALUES('W1001', '�ٻ�ƾ���Ʈ','������ ����� ���� 345-10','042-6667-8889', 3456, '0');
       
       
-- NOT NULL �ΰ��� �ݵ�� �����Ѵ�. �÷����� ���� �����Ǿ����� ����.
-- �������� NULLALB �̱⶧���� �����Ǿ������ִ�. �÷����� ������� �ʾƵ��ȴ�.
-- ���̺� ������� �÷��� �̸��� �Ȱ��� �ؾ��Ѵ�.

-- STIE_NAME�� 20BYTE�� ��ƇJ�µ� ũ�Ⱑ �Ѿ�� ����������Ѵ�.
-- �ѱ��� ���ڴ� 3BYTE 
-- VARCHAR(50)�Ѱ��� 30�������ϸ� VARCHAR2�� 20�� �ݳ��ϰԵȴ�.

-- NUMBER(�����ڸ���, �Ҽ��ڸ���)
-- ���ڴ� ''�� ������ �ʴ´�.
-- ����� 0���� ������ǥ��

-- ������ Ȯ���Ѵ�.

-- DEFAULT�� SYSDATE�� �����ʾƵ� ���ó��ڰ� ����.
-- NULLABLE �ε� DEFAULT ���� �������������� ������ NULL�̵���
-- ����ݾ��� DEFAULT���� 0���εǾ��־� �Է����������� 0��������ȴ�.

��) �ٹ����̺�(WORK) '�̴̹�'��������� �Է��Ͻÿ�
�����ȣ : '200908050012'
�����ID : 'W1001'
�ٹ������� : ����
�ٹ������� : ��
���� : ����

-- JOB_TITLE�� ���� ���̺��� �����ִ�. �Ѱ������� ����Ǹ� ������Ʈ��븻���� �߻� �������� �ϰ����� �ı��ɼ��ִ�.
-- Į���� �پ����� �ٷ� VALUES. ���̺������� �Է��� �÷��� ������� �����͸� �Է����ش�.
-- �𸣴°��� ''�� �Է��Ѵ� WHITE SPACE = NULL������ ó���ȴ�. ����Ŭ������

INSERT INTO WORK VALUES('W1001','200908050012',SYSDATE,'����','');

SELECT * FROM WORK;  -- � �����Ͱ� �ԷµǾ����� Ȯ��
 
 
 
 