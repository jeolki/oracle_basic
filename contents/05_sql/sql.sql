 1. SQL ���
 - Structured Query language�� ����
 - ������ ����̱� ������ ��, �ݺ����� �������� ����
 - ���� ����� ������ ����
 
1) ����
 (1) DML(Data Manupulaion Language)
    - ���̺��� �ڷḦ �����ϴ� ��ɹ�
    - INSERT, UPDATE, DELETE
 (2) DCL(Data Control Language)
    - grant, commit, rollback, revoke
    - ����, ����, ������ ���� ��� ����
 (3) DDL(Data Defintion Language)
    - ������ ���Ǿ�
    - CREATE, ALTER, DROP
 (4) ���Ǿ�
    - ������ ��ȸ��� ����
    - SELECT 
    
2. �ڷ���
 - ����Ŭ���� �����ϴ� ������ Ÿ�����δ� ������, ������, ��¥��, ��Ÿ
1) ������
 - ���ڿ��� ������ �� �ִ� �ڷ���
 - ���ڿ��� ''�� ��� ó��
 (1) CHAR
   . �������� ���ڿ� �ڷ� ����
   . �����Ͱ� ���ǵ� �������� ������ ���ʺ��� ����ǰ� ���� ������(������)
     �� ������ ���� -- �������̴� ���� �����͸�ŭ���� ���°����� �ݳ�ó���Ѵ�.
     -- ������ �����ϸ� ����������� �����Ұ� ���ڶ� �����߻�
   . �ַ� KEY�׸� ���
   . 2000BYTE ���� ��밡��
   (�������)
   �÷��� CHAR(ũ��[BYTE|CHAR])
     - �⺻���� BYTE��
     - �ѱ� �� ���ڴ� 3 BYTE�� ó��
     EX) COL1 CHAR(2000 CHAR) -- 2000 ���ڸ� �ʰ��Ҽ� ����.

CREATE TABLE TEMP01(
  COL1 CHAR(10),
  COL2 CHAR(10 BYTE),
  COL3 CHAR(10 CHAR));

INSERT INTO TEMP01(COL1, COL2, COL3)
  VALUES ('����','����','����');

SELECT * FROM TEMP01;

SELECT LENGTHB(COL1),LENGTHB(COL2),LENGTHB(COL3) FROM TEMP01; 
-- LENGTHB ���̸� BYTE�� ��Ÿ�����
-- COL1,COL2�� 10BYTE // COL3�� 14BYTE�� ���´�.
-- 10ĭ�� ������ 2ĭ�� �����Ѵ� �ѱ�2ĭ => 6BYTE , ����ĭ 8ĭ => 8BYTE  6+8= 14BYTE

INSERT INTO TEMP01(COL1, COL2, COL3)
  VALUES ('KOR','KOR','KOR');

SELECT LENGTHB(COL1),LENGTHB(COL2),LENGTHB(COL3) FROM TEMP01; 
-- 10 // 10 // 10 �� ���Ӵ�
-- KOR = 3BYTE + ������ 7BYTE = 10BYTE
-- ������� �����ִ� ��������

INSERT INTO TEMP01(COL1, COL2, COL3)
  VALUES ('����ȭ ���� �Ǿ����ϴ�','����ȭ ','����ȭ ���� �Ǿ���');
-- 10BYTE�� �Ѵ°� �Է�
-- ������� �ʴ´�
-- value too large for column "HJG"."TEMP01"."COL1" (actual: 32, maximum: 10)
-- ����س����� 32�ε� �������ִ°��� 10����Ʈ

INSERT INTO TEMP01(COL1, COL2, COL3)
  VALUES ('����','����ȭ ','����ȭ ���� �Ǿ���');

SELECT * FROM TEMP01; 
-- COL3�� CHAR �̱⶧���� 10�����̱⸸�ϸ��.
SELECT LENGTHB(COL1),LENGTHB(COL2),LENGTHB(COL3) FROM TEMP01; 
-- 10 / 10 / 26
-- COL3�� 10���� ���� 26BYTE����
-- COL1�� �������� �̱⶧���� �����Ƶ� 10BYTE

-- 'ȫ�浿' �� 'ȫ�浿 ' �� �ٸ���.
-- ������ �ƽ�Ű�ڵ�� �����Ǳ� ������ ���鵵 �������⶧�����ٸ���

-- ������ �߰��ؼ� ���̸� ���س����� ��������
-- char (30) -> 30BYTE ����
-- char (30char) ->30�������� �ѱ��Է½� �ִ� 90BYTE
-- 2000byte�� ������ʰ��Ҽ�����.
-- char (2000char) �ص� �ѱ��� 2000byte �ʰ����Ѵ�.







