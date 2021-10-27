 1. �ڷ���
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

2. �������� ������ -- ������ ũ�⺸�� �����ڷḦ �����Ҷ� ���������� �ǵ����ش�.
 1) VARCHAR
   - ����ڰ� ������ ������ ���� ��ŭ ������ ���.
   (�������)
   �÷��� VARCHAR(ũ�� [BYTE|CHAR])
    . 4000 BYTE ���� ���� ����
    . [BYTE|CHAR] : �Է°����� ������ Default�� BYTE��
    
��)
CREATE TABLE TEMP02 (
  COL1 CHAR(20),
  COL2 VARCHAR(20),
  COL3 VARCHAR(20 CHAR));
  
INSERT INTO TEMP02 VALUES('����ȭ','����ȭ','����ȭ');
INSERT INTO TEMP02 VALUES ('PERSIMON','BANANA','APPLE');

SELECT * FROM TEMP02;

SELECT LENGTHB(COL1)    ��������,  -- AS "�÷��� ��Ī" -- Ư�����ڵ��� ""�� ���´�.
       LENGTHB(COL2) AS "��������(BYTE)",  -- LENGTHB BYTEũ�� ���
       LENGTHB(COL3)    "��������(CHAR)" -- AS�� �����ʾƵ� ������ ���°� ����
  FROM TEMP02;
-���� ������ �ݳ�

2) VARCHAR2
  - VARCHAR�� ����� ����
  - ����Ŭ������ ���Ǵ� ������ Ÿ��(����Ŭ���� ���ǰ�)
  
3) LONG
  - �������� ���ڿ��� �����Ҷ� ���
  - 2gbũ���� �ڷ� ���� ����
  - �� ���̺� �ϳ��� LONG Ÿ������ ���� ����
  - SELECT���� SELECT��, UPDATE���� SET��, INSERT���� VALUES��
    ���� ��� ����
   (�������)
   �÷��� LONG; -- ����� ������ �ʴ´�-- �����̺� ���÷��� LONGŸ���� ����Ҽ��־ ��������ʴ´�.
   . LONG Ÿ���� ��������� �����
   . CLOB, NCLOB ������� ��ġ

��)
CREATE TABLE TEMP03(
  COL1 LONG,
  COL2 CLOB,
  COL3 CLOB);
  

INSERT INTO TEMP03 VALUES('������Ƽ��','ILPOSTINO','������Ƽ��');  
  
SELECT * FROM TEMP03; 

SELECT --LEBGTHB(COL1), --2gb�� ���̸� üũ�Ҽ� ����.
       DBMS_LOB.GETLENGTH(COL2),
       DBMS_LOB.GETLENGTH(COL3)
  FROM TEMP03;
       
4) CLOB  
  - �������� ���ڿ� ����
  - �ִ� 4gb ���ڿ� ���� ����
  - LONG Ÿ���� ������ ������ Ÿ��
  - �� ���̺� ������ �÷����� CLOBŸ�� ����� ����
  - �Ϻ� ��ɵ�(����, �κй��ڿ� ����)�� DEMS_LOB API�� ������ Ȱ��
  (�������)
  �÷���  CLOB; --LONG Ÿ�԰� ���������� ���̸� ���������ʴ´�. MAX 4gb�ȿ��ִ� ����ڷ� ����
  
��)
CREATE TABLE TEMP04(
  COL1  CLOB,
  COL2  CLOB,
  COL3  VARCHAR2(4000));
  
INSERT INTO TEMP04 
  VALUES('DM MODELING�� OracleSQL','������ �߱� ���ﵿ 500',
         '����ȭ ���� �Ǿ����ϴ�');
  
select * from temp04;

SELECT DBMS_LOB.SUBSTR(COL1,5,3) AS ����1,
       SUBSTR(COL2,5,3) AS ����2,
       SUBSTR(COL3,5,3) AS ����3 
  FROM TEMP04;
-- DEMS_LOB.SUBSTR(�κй��ڿ�����) �ڸ������ϴ¹��ڿ�, 5���ڼ�(����), 3��°��������
-- SUBSTE �� 5��° �ڸ����� 3����

5) NVARCHAR2, NCLOB
  - �ٱ��� ��� ���� ����(National)
  - UTF-8, UTF-16������ �ڵ�� ��ȯ�Ͽ� ����
  - ������ ����� VARCHAR2, CLOB�� ����





