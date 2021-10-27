1.기타자료형
1)RAW
  - 상대적으로 작은양의 2진자료 저장
  - 2000BYTE까지 자료저장
  - 이미지 등의 자료를 정해 사용된다.
  - 인덱스 처리 가능  --사용거의안함 사진용량이 커서 부족하다.
 (사용형식)
 컬럼명 RAW(크기)
 
 
2)LONG RAW
  - 이진자료 저장
  - 2GB까지 저장가능 / 인덱스처리 불가능 --사용거의 안함
  - 기존의 자요형과 호환성을 위해 존치되고 있는 자료형
 컬럼명 LONG RAW;
 
 
3)BFILE
  - 이진자료를 저장하고 처리
  - 이진자료(원본자료)를 데이터베이스 외부에 저장 --외부에 저장된 디텍토리 반드시지정
  - 디렉토리 별칭은 30BYTE, 파일명은 256BYTE 를 초과할 수 없음
컬럼명 BFILE;

예)
 - 디렉토리 생성
CREATE DIRECTORY 별칭 AS '절대경로명';
CREATE DIRECTORY TEST_DIR AS 'D:\A_TeachingMaterial\2.Oracle\20200608';

 - 테이블 생성
CREATE TABLE TEMP09(
  COL1 BFILE);

 - 그림파일 경로 저장(INSERT문 사용)
INSERT INTO TEMP09 VALUES(BFILENAME('TEST_DIR','pixabay.JPG')); 

SELECT * FROM TEMP09;



4)BLOB
  - 이진자료를 저장하고 처리함
  - 이진자료(원본자료)를 데이터베이스 내부에 저장 --사진자료들이 자주변경되는경우는 BFILE이 더 좋다
  - 최대 4GB자료 처리 가능
  (사용형식)
  컬럼명 BLOB;
  
예)
- 테이블 생성
CREATE TABLE TEMP10(
  COL1 BLOB);

- 테이블에 그림파일을 삽입하는 익명블록 작성
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

(확인)
SELECT * FROM TEMP10;  --디스플레이 하는것은 오라클에서는 할수없다. 

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




