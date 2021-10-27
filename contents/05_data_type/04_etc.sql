1.��Ÿ�ڷ���
1)RAW
  - ��������� �������� 2���ڷ� ����
  - 2000BYTE���� �ڷ�����
  - �̹��� ���� �ڷḦ ���� ���ȴ�.
  - �ε��� ó�� ����  --�����Ǿ��� �����뷮�� Ŀ�� �����ϴ�.
 (�������)
 �÷��� RAW(ũ��)
 
 
2)LONG RAW
  - �����ڷ� ����
  - 2GB���� ���尡�� / �ε���ó�� �Ұ��� --������ ����
  - ������ �ڿ����� ȣȯ���� ���� ��ġ�ǰ� �ִ� �ڷ���
 �÷��� LONG RAW;
 
 
3)BFILE
  - �����ڷḦ �����ϰ� ó��
  - �����ڷ�(�����ڷ�)�� �����ͺ��̽� �ܺο� ���� --�ܺο� ����� �����丮 �ݵ������
  - ���丮 ��Ī�� 30BYTE, ���ϸ��� 256BYTE �� �ʰ��� �� ����
�÷��� BFILE;

��)
 - ���丮 ����
CREATE DIRECTORY ��Ī AS '�����θ�';
CREATE DIRECTORY TEST_DIR AS 'D:\A_TeachingMaterial\2.Oracle\20200608';

 - ���̺� ����
CREATE TABLE TEMP09(
  COL1 BFILE);

 - �׸����� ��� ����(INSERT�� ���)
INSERT INTO TEMP09 VALUES(BFILENAME('TEST_DIR','pixabay.JPG')); 

SELECT * FROM TEMP09;



4)BLOB
  - �����ڷḦ �����ϰ� ó����
  - �����ڷ�(�����ڷ�)�� �����ͺ��̽� ���ο� ���� --�����ڷ���� ���ֺ���Ǵ°��� BFILE�� �� ����
  - �ִ� 4GB�ڷ� ó�� ����
  (�������)
  �÷��� BLOB;
  
��)
- ���̺� ����
CREATE TABLE TEMP10(
  COL1 BLOB);

- ���̺� �׸������� �����ϴ� �͸��� �ۼ�
DECLARE
  L_DIR VARCHAR2(50) := 'TEST_DIR';
  L_FILE VARCHAR2(20) := 'pixabay.JPG';
  L_BFILE BFILE;
  L_BLOB BLOB;
BEGIN
  INSERT INTO TEMP10 VALUES(EMPTY_BLOB())
    RETURN COL1 INTO L_BLOB;

  L_BFILE := BFILENAME(L_DIR,L_FILE);
  DBMS_LOB.FILEOPEN(L_BFILE,DBMS_LOB.FILE_READONLY);
  DBMS_LOB.LOADFROMFILE(L_BLOB,L_BFILE,DBMS_LOB.GETLENGTH(L_BFILE));
  DBMS_LOB.FILECLOSE(L_BFILE);
   
  COMMIT;
END;

(Ȯ��)
SELECT * FROM TEMP10;  --���÷��� �ϴ°��� ����Ŭ������ �Ҽ�����. 

DROP TABLE TEMP01;
DROP TABLE TEMP02;
DROP TABLE TEMP03;
DROP TABLE TEMP04;
DROP TABLE TEMP05;
DROP TABLE TEMP05;
DROP TABLE TEMP06;
DROP TABLE TEMP07;
DROP TABLE TEMP08;
DROP TABLE TEMP09;
DROP TABLE TEMP10;

DROP TABLE MYEMP;
DROP TABLE CONST_MATERIALS;




