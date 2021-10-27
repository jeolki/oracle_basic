 1.��¥��
 - ��¥�ڷ����� �⺻���� DATE�� 
   �ð��� ������ �����ϴ� TIMESTAMPŸ���� ����

1) DATE
  - �⺻ ��������(��,��,��,��,��,��:'YYYY/MM/DD HH24:MI:SS')�� ����
  - -4712�� 1�� 1��~9999�� 12�� 31�ϱ��� ����
 (�������)
 �÷��� DATE;
   . ��¥ ������ �÷��� ��Ģ���� �� '+'�� '-'������ ����

��)
CREATE TABLE TEMP06(
  COL1  DATE,
  COL2  DATE);
  
INSERT INTO TEMP06(COL1,COL2) VALUES(SYSDATE, TO_DATE('20190605')); 
-- ���ڿ��� ��¥Ÿ������ �ڵ� ����ȯ�Ǿ�����.
-- ��ȯ�Լ� TO_DATE �Ƚᵵ �ȴ�. ���ڿ��ȿ� ����� �ڷᰡ �ٵ�������� ����

INSERT INTO TEMP06(COL1,COL2) VALUES(SYSDATE+30,SYSDATE-30); 

SELECT * FROM TEMP06;
SELECT COL1 - COL2  FROM TEMP06;  
-- �� ��¥ ������ ����� �ϼ� 
-- �Ҽ����� �������� : �ú��ʱ��� �ֱ⶧���� '20190605' 0��0��0�ʷ� ���Ǿ����⶧����

SELECT TO_CHAR(COL1, 'YYYY-MM-DD HH24:MI:SS'),
       TO_CHAR(COL2, 'YYYY-MM-DD HH24:MI:SS'),
       COL1 - COL2
  FROM TEMP06;


CREATE TABLE TEMP07(
  COL1 TIMESTAMP WITH TIME ZONE);
  
INSERT INTO TEMP07 VALUES(SYSDATE);
  
SELECT * FROM TEMP07;

SELECT * FROM TEMP06;
DELETE TEMP06;

INSERT INTO TEMP06 VALUES ('19940305','00010101');

SELECT * FROM TEMP06;

SELECT CASE WHEN MOD((COL1 - COL2-1),7)=0 THEN '�Ͽ���' 
            WHEN MOD((COL1 - COL2-1),7)=1 THEN '������' 
            WHEN MOD((COL1 - COL2-1),7)=2 THEN 'ȭ����' 
            WHEN MOD((COL1 - COL2-1),7)=3 THEN '������' 
            WHEN MOD((COL1 - COL2-1),7)=4 THEN '�����' 
            WHEN MOD((COL1 - COL2-1),7)=5 THEN '�ݿ���' 
            ELSE '�����' END "����"                             
  FROM TEMP06;

2020-06-08)
2) TIMESTAMP
  - �ð���(TIME ZONE)������ 10����� 1�� ������ ���� ���� ����
(�������)
 �÷��� TIMESTAMP;
 �÷��� TIMESTAMP WITH TIME ZONE;
 �÷��� TIMESTAMP WITH LOCAL TIME ZONE;

��)
CREATE TABLE TEMP08(
  COL1 TIMESTAMP,
  COL2 TIMESTAMP WITH TIME ZONE,
  COL3 TIMESTAMP WITH LOCAL TIME ZONE);

INSERT INTO TEMP08 VALUES(SYSDATE, SYSDATE, SYSDATE);
SELECT * FROM TEMP08;


















