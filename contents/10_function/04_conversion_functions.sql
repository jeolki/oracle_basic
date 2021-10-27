 ��ȯ�Լ�
 - �������� �� ��ȯ�� ���
 - CAST, TO_DATE, TO_CHAR, TO_NUMBER


SELECT * FROM EMPLOYEES
 WHERE HIRE_DATE >= '20050101'  
 -- ���ڿ��� ��¥Ÿ���̸���// ���׿����� ����ɴ뿡�� �����ں��� ������ ������Ÿ���� ��ġ��Ű�°��� �����Ͼ 
 -- '20050101'�� ��¥������ ����ȯ �Ŀ� �񱳰� �Ͼ��. ���������� ������ -- ����Ŭ�� ���ڿ��� �켱�̾ƴϴ�
 -- ����Ŭ������ ���ڰ� �켱�̴�.
 
SELECT '20'+7 FROM dual;    --27
 -- ���ڿ��� ���ڷ� ���ϰ� ������ �̷������ -- ������ ����ȯ
 
 1) CAST
  . ����� �� ��ȯ �Լ�
  (�������)
  CAST(expr  AS  type)
  . 'expr'�� ǥ���� �����͸� 'type'������ �ڷ�� ��ȯ  
  -- expr�� ����,�÷���,�Լ�,������,���ڿ� �ٵɼ��ִ�
  -- ����Ŭ���� ���Ǵ� ������Ÿ���� �������� �ڷḦ ��ȯ
  
��)�з����̺�(LPROD)�� �з�����(LPROD_ID)�� CHAR(5)�� ��ȯ�Ͻÿ�

SELECT LPROD_ID AS ���� , CAST(LPROD_ID AS CHAR(5)) AS ���� FROM LPROD;  
-- ���±����� ������ ����� 4�ڸ��� ��
-- ���ڴ� ����������
-- ���ڴ� ��������


 2) TO_CHAR
  . ���ڳ� ��¥ Ÿ���� �����͸� ���ڿ��� ��ȯ
  (�������)
  TO_CHAR(d [,fmt])   -- ȭ���ȣ�� �繫��ǥǥ�� ��ȣǥ�� 
   - 'fmt' ��ȯ�� �������� ���ڿ�
   ** ��¥ ��ȯ����
----------------------------------------------------------------
     format              ����                  ��뿹
----------------------------------------------------------------
    AM, A.M.             ����            TO_CHAR(SYSDATE, 'AM')
    PM, P.M.             ����            TO_CHAR(SYSDATE, 'PM') 
 Y, YY, YYY, YYYY        �⵵            TO_CHAR(SYSDATE, 'YY') 
   MONTH, MON             ��             TO_CHAR(SYSDATE, 'MONTH')  --> 6��
    MM               01-12������ ��       TO_CHAR(SYSDATE, 'MM')  --> 06
    D                 ������ ����          TO_CHAR(SYSDATE, 'D') -->ȭ����-> 3 //�Ͽ��� = 1
    DD                ������ ����          TO_CHAR(SYSDATE, 'DD') --> 16 ������ ����
    DDD               ������ ����          TO_CHAR(SYSDATE, 'DDD') --> 1��1�ϱ��� ����������
    DL               ��������+����        TO_CHAR(SYSDATE, 'DL') 
    BC, AD, CC           ����             TO_CHAR(SYSDATE, 'CC')   --> 21
    Q                    �б�             TO_CHAR(SYSDATE, 'Q')  --> 2
  HH, HH12, HH24         �ð�             TO_CHAR(SYSDATE, 'HH') -- HH=HH12
    MI                    ��              TO_CHAR(SYSDATE, 'MI')
    SS                    ��              TO_CHAR(SYSDATE, 'SS')
------------------------------------------------------------------
 ** ��������� ���ڿ��� " "��  ���� ���� �ؾ���   
         
    
 SELECT TO_CHAR(SYSDATE, 'PM') FROM DUAL; -- AM�� ���Ĵ�� ����϶� -- ���� ���� �Ǻ��ؼ� ����϶� 
 SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') FROM DUAL; --���鵵 �ϳ��� ���ڿ��� �ν�
 
 SELECT TO_CHAR(SYSDATE, 'YYYY"��" MM"��" DD"��" HH24:MI:SS') FROM DUAL; --���ڿ��߰����� ""�� ��� ����
 
 
 SELECT TO_CHAR(SYSDATE, 'Y-MONTH PM'), -- �������� ���ջ���ص� �������.
        TO_CHAR(SYSDATE, 'YY-MON PM'),      -- ȯ�漳�� �����ͺ��̽��� NLS���� ǥ�þ������� �ٲ��ָ� ǥ�õǴ°͵� �ٲ��.
        TO_CHAR(SYSDATE, 'YYYY-MM DD DDD PM'),
        TO_CHAR(SYSDATE, 'YYYY/MM/DD'),
        TO_CHAR(SYSDATE, 'DL PM'),
        TO_CHAR(SYSDATE, 'CC'),
        TO_CHAR(SYSDATE, 'Q')
   FROM DUAL; 


    
   ** ���� ��ȯ����
----------------------------------------------------------------
     format                       ����                   
----------------------------------------------------------------
       9           �����Ǵ� �����Ͱ� ��ȿ �����̸� ��ȿ���ڸ�
                   ��ȿ�� '0'�̸� ������ ���
       0           �����Ǵ� �����Ͱ� ��ȿ �����̸� ��ȿ���ڸ�
                   ��ȿ�� '0'�̸� '0'�� ���
   ,(COMMA)        3�ڸ� ���� �ڸ������� ���� �ڸ���
   .(�Ҽ���)        �Ҽ��� ǥ��
       PR          ���� ǥ���� '< >'�� ���� ǥ��
       $, L        ȭ���ȣ�� �����Ͽ� ��� -- �޷������� ���� ���ʿ� ���� // L�� NLS���� ������ ȭ���ȣ
      
      
                   
��) ��ǰ���̺��� ��ǰ�� ������ ��ȸ�Ͻÿ�
   SELECT PROD_NAME,
          TO_CHAR(PROD_PRICE,'99,999,999.99') AS ����1, -- 8�ڸ��� ����ϼ��� ���� �𸣴� �˳���
          TO_CHAR(PROD_PRICE,'00,000,000.00') AS ����2   -- �տ� 0�� ��µȴ�.
     FROM PROD
    WHERE PROD_LGU = 'P101';

   SELECT TO_CHAR(0, '999') FROM DUAL;  -- 0 �� �ϳ� ��ȿ�� 0�̶�� ó��

��) KOR_LOAN_STATUS ���̺��� 2013�⵵ 10�� �� �õ��� �����ܾ��� ��ȸ�Ͻÿ�
 SELECT REGION, GUBUN, 
        TO_CHAR(LOAN_JAN_AMT, 'L99,999,999.9') AS �����ܾ�  -- ��ȭȭ����� ���
   FROM KOR_LOAN_STATUS
  WHERE PERIOD = '201310'
  ORDER BY 1 ; -- �÷��ε��� 1���� REGION�� ������ ASC ������������ �����Ͻʽÿ� ASC �����Ȱ�

��) KOR_LOAN_STATUS ���̺��� 2013�⵵ 10�� 
    �� �õ��� ��մ����ܾװ� ��� �����ܾװ��� ������ ����Ͽ� ��ȸ
 
 (2013�⵵ 10�� �� �õ��� ��մ����ܾ�)
 SELECT PERIOD,
        ROUND(AVG(LOAN_JAN_AMT),1) AS LAVG
   FROM KOR_LOAN_STATUS
  WHERE PERIOD = '201310'
  GROUP BY PERIOD;
 
 (2013�⵵ 10�� �� �õ��� �����ܾ� �հ�)
 SELECT REGION, PERIOD,
        SUM(LOAN_JAN_AMT) AS LSUM
   FROM KOR_LOAN_STATUS
  WHERE PERIOD = '201310'
  GROUP BY REGION, PERIOD
  ORDER BY 1;
        
 (�� �õ��� ����)
 SELECT REGION AS ����,
        TO_CHAR(TBLA.LSUM, '9,999,999.9') AS �����ܾ��հ�,
        TO_CHAR(TBLB.LAVG, '99,999.9') AS ��մ����ܾ�,
        TO_CHAR(TBLB.LAVG-TBLA.LSUM, '9,999,999.9PR') AS ���� -- PR ����� ��
   FROM ( SELECT REGION, PERIOD,
                 SUM(LOAN_JAN_AMT) AS LSUM
            FROM KOR_LOAN_STATUS
           WHERE PERIOD = '201310'
           GROUP BY REGION, PERIOD
           ORDER BY 1 ) TBLA,
        ( SELECT PERIOD,
                 ROUND(AVG(LOAN_JAN_AMT),1) AS LAVG
            FROM KOR_LOAN_STATUS
           WHERE PERIOD = '201310'
           GROUP BY PERIOD ) TBLB
  WHERE TBLA.PERIOD = TBLB.PERIOD; 
 
 3) TO_NUMBER
  . ���ڿ��� �ڷḦ ���ڷ� ��ȯ
  . �����ڷ�(���ڿ�)�� ���ڷ� ��ȯ�� �� ���� ��ȣ�� ���ڰ� ����� �� -- ���ڷ� ��ȯ������ �����͸�
  (�������)
  TO_NUMBER(d [,fmt])
  - 'fmt'�� TO_CHAR�� ���ں�ȯ���İ� ����
  
��) ������̺��� ��ȭ��ȣ('PHONE_NUMBER')�� ���ڷ� ��ȯ�Ͻÿ�
SELECT TO_NUMBER(REPLACE(PHONE_NUMBER, '.')) AS ��ȭ��ȣ
  FROM EMPLOYEES;

��) ��ǰ�з��ڵ� 'P102'�� ���� ���ο� ��ǰ�� ��ǰ���̺�(PROD)�� ���
    �Ϸ��� �Ѵ�. �̶� ���ο� ��ǰ�� ��ǰ�ڵ带 �����Ͻÿ� 

SELECT CONCAT('P102',TRIM(TO_CHAR((TO_NUMBER(SUBSTR(MAX(PROD_ID),5,6))+1),'000000'))) AS ��ǰ�ڵ�
--     'P102'||TRIM(TO_CHAR((TO_NUMBER(SUBSTR(MAX(PROD_ID),5,6))+1),'000000')) AS ��ǰ�ڵ�
  FROM PROD
 WHERE PROD_LGU = 'P102';
--     PROD_ID LIKE 'P102%';


 4) TO_DATE
  . ���ڿ� �ڷḦ �⺻ ��¥��(�����)���� ��ȯ
  . �ݵ�� 8���� �ʿ� -- ��¥�� ��ȯ�Ǿ����� �ִ� ���ڿ� // �����̿��� �ٸ� ���� �����ϸ� �ȵ�
  (�������)
  TO_DATE(d [,fmt])
  
 ��) �Ǹ��������̺�(CART)���� ī���ȣ�÷�(CART_NO)�� �̿��Ͽ� �Ǹ����� ���ϰ� 
     2005�� 4�� 1�Ϻ��� 4�� 15�� ���̿� �߻��� �Ǹ� �Ǽ��� ���Ͻÿ�.
SELECT COUNT(*) AS �ǸŰǼ�  -- ���� ���� 
  FROM CART
 WHERE TO_DATE(SUBSTR(CART_NO, 1, 8)) BETWEEN TO_DATE('20050401') AND TO_DATE('20050415') ;

 (����ȸ����)
SELECT COUNT(DISTINCT(CART_MEMBER)) AS ����ȸ����  -- ���� ���� -- �ߺ����� DISTINCT
  FROM CART
 WHERE TO_DATE(SUBSTR(CART_NO, 1, 8)) BETWEEN TO_DATE('20050401') AND TO_DATE('20050415') ; 
 
 
 (����ȸ��)
SELECT DISTINCT(CART_MEMBER) AS ����ȸ��  --  �ߺ����� DISTINCT
  FROM CART
 WHERE TO_DATE(SUBSTR(CART_NO, 1, 8)) BETWEEN TO_DATE('20050401') AND TO_DATE('20050415') 
 ORDER BY 1;
 
 
    