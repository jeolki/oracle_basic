 1. Create
 - ���̺� ����
 - ���̺��� ����Ŭ ��ü�̱� ������ 'create'��ɻ��
 
 (�������)
 CREATE TABLE ���̺��( 
   �÷���1 TYPE [(ũ��)] [DEFAULT ��][NOT NULL],
  [�÷���2 TYPE [(ũ��)] [DEFAULT ��][NOT NULL],]
            :
  [�÷���n TYPE [(ũ��)] [DEFAULT ��][NOT NULL],]
  
  [CONSTRAINT Ű��Ű������ PRIMARY KEY(�÷���1[,�÷���2,....]),]
  [CONSTRAINT �ܷ�Ű������ FOREIGN KEY(�÷���1[,�÷���2,....])
      REFERENCES ���̺��(�÷���1[,�÷���2,...])]
  );
  
��)�ѱ��Ǽ��� ���� erd�� �����Ͽ� ���̺��� �����Ͻÿ�
 1) EMP (�������) ���̺� ����
 
CREATE TABLE EMP( 
  EMP_ID CHAR(12),
  EMP_NAME VARCHAR2(30) NOT NULL,
  ADDRESS VARCHAR2(100),
  TEL_NUM VARCHAR2(30),
  JOB_TITLE VARCHAR2(10) NOT NULL,
  DEPT_NAME VARCHAR2(30),
  
  CONSTRAINT pk_emp PRIMARY KEY(EMP_ID));
  
CREATE TABLE CONST_SITE(
  SITE_ID           CHAR(5),
  SITE_NAME         VARCHAR2(30) NOT NULL,
  SITE_ADDRESS      VARCHAR2(50) NOT NULL,
  SITE_TEL_NUM      VARCHAR2(20),
  CONST_AMT         NUMBER(12) DEFAULT 0,
  INPUT_PERSON_AMT  NUMBER(4),
  CONST_DATE        DATE DEFAULT SYSDATE,
  EST_COMP_DATE     DATE,
  COMP_DATE         DATE,
  REMARKS           CHAR(1),
  
  CONSTRAINT pk_const_site PRIMARY KEY(SITE_ID));
  
CREATE TABLE CONST_MATERIALS( 
  MAT_ID    CHAR(10),
  MAT_NAME  VARCHAR2(30) NOT NULL,
  MAT_QTY   NUMBER(5),
  MAT_PRICE NUMBER(8),
  MAT_PDATE DATE,
  SITE_ID   CHAR(5),
  
  CONSTRAINT pk_const_materisls PRIMARY KEY(MAT_ID),
  CONSTRAINT fk_const_materials FOREIGN KEY(SITE_ID)
     REFERENCES CONST_SITE(SITE_ID));
  
CREATE TABLE WORK(
  SITE_ID    CHAR(5) NOT NULL,
  EMP_ID     CHAR(12),
  START_DATE DATE,
  JOB_TITLE  VARCHAR2(20) NOT NULL,
  END_DATE   DATE,
  
  CONSTRAINT pk_work PRIMARY KEY(SITE_ID,EMP_ID),
  CONSTRAINT fk_work_emp FOREIGN KEY(EMP_ID)
     REFERENCES EMP(EMP_ID),
  CONSTRAINT fk_work_const_site FOREIGN KEY(SITE_ID)
     REFERENCES CONST_SITE(SITE_ID));
