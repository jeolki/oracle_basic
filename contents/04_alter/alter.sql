 1.alter
 -���̺� ����(ALTER)
 - ���̺��� ����(�÷� �߰�, �÷��Ӽ� ����, �÷� ����, ������� ����/����/�߰�)
 
1)���̺� �̸� ����
 ALTER TABLE ���̺��
   RENAME TO �ű����̺��
  . '���̺��'�� '�ű����̺��'���� ����
  
��) EMP���̺� �̸��� MYEMP�� ��ȯ�Ͻÿ�
ALTER TABLE EMP RENAME TO MYEMP;

2)�÷��� �߰�
 ALTER TABLE ���̺��
   ADD �÷��� TYPE[(ũ��)] [DEFAULT ��] [NOT NULL];
   
��)������̺�(MYEMP)�� �޿��÷�(SALARY)�� �߰��Ͻÿ�
   �޿��÷��� ���� 9�ڸ��� �����Ǹ� NULL�� ����Ѵ�.
ALTER TABLE MYEMP
  ADD SALARY NUMBER(9);
-- SALARY �ʵ尡 �߰���

3)�÷��� ����
ALTER TABLE ���̺��
  RENAME COLUMN �÷���1 TO �÷���2;
  . �÷���1�� �÷���2�� ����
  
��)������̺�(MYENP)���� �ּ��÷�(ADDRESS)���� EMP_ADDR�� �����Ͻÿ�
ALTER TABLE MYEMP
  RENAME COLUMN ADDRESS TO EMP_ADDR;
  
4)�÷��Ӽ�(������Ÿ��, ũ��, �������) ����
 ALTER TABLE ���̺��
   MODIFY �÷��� TYPE[(ũ��)] [DEFAULT ��] [NOT NULL];
 . �ش� '�÷���'�� �Ӽ��� �缳�� 

��)������̺�(MYEMP)���� ����� �ּ�(EMP_ADDR)�� �Ӽ��� NOT NULL��
   �������� 60BYTE�� �����Ͻÿ�  -- �������� CHAR
ALTER TABLE MYEMP
  MODIFY EMP_ADDR CHAR(60) NOT NULL;
  
5)�÷� ����
ALTER TABLE ���̺��
  DROP COLUMN �÷���;
 .'�÷���'���� ���ǵ� �÷� ����
 
��)������̺��� �޿��÷��� ����
ALTER TABLE MYEMP
  DROP COLUMN SALARY;

6) ���̺� ������� ����/����/����
ALTER TABLE ���̺��
  ADD|MODIFY|DROP CONSTRAINT �⺻Ű|�ܷ�Ű ������
  [PRIMARY KEY|FOREIGN KEY (�÷���)
   [REFERENCES ���̺��(�÷���)]] 
-- []�� ADD�� MODIFY������ �ٿ��ش� DROP�� �ʿ���� �����̸�������
-- ������ ������ ����� ���� ������ �����Ͱ� �����ؼ��¾ȵ� �ߺ��̹߻��Ǿ�����.

ALTER TABLE CONST_MATERIALS
  DROP CONSTRAINT FK_CONST_MATERIALS
-- �ܷ�Ű�� �����ȴ�
-- CONST_SITE�� DROP ��ų���ִ�.

DROP TABLE CONST_SITE;
-- ���� �����ϴ�. �ָ�Ű���踦 �߶���Ǳ� ������
  
ALTER TABLE MOVIE_BOOK
  ADD CONSTRAINT FK_
  [PRIMARY KEY|FOREIGN KEY (�÷���)
   [REFERENCES ���̺��(�÷���)]] 







  
  
  
  
  
  
  
  
  