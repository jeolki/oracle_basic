�׷��Լ�
1. ROLLUP
  - �׷캰 �Ұ�� �Ѱ踦 ��ȯ
  (�������)
  SELECT �÷���1, �÷���2, �����Լ�
    FROM ���̺��
  [WHERE ����]
   GROUP BY [�÷���...]ROLLUP(�÷���,...)
   . ROLLUP���� ( )�ȿ� ����� ������ ���� (������->����) ������ ����ó���� ��ȯ
   . ROLLUP���� ( )�ȿ� n���� �÷��� ���� ��� n+1���� ���� ��ŭ �����ȯ
   EX)ROLLUP(PERIOD,REGION,GUBUN)�� ����� ���
      'GUBUN'�� �������� ���� �� �� 'REGION,GUBUN'���� ���� ��
      'PERIOD,REGION,GUBUN'���� ���踦 ��ȯ�� �� ��ü���� ��ȯ
      
      
��)KOR_LOAN_STATUS ���̺��� ROLLUP�� ����Ͽ� �Ⱓ, ������ �����ܾ� ���踦 ��ȸ�Ͻÿ�
(�Ϲ� GROUP BY�� ���)
SELECT PERIOD AS �Ⱓ,
       REGION AS ����,
       GUBUN AS ���ⱸ��,
       SUM(LOAN_JAN_AMT) AS �����ܾ�
  FROM KOR_LOAN_STATUS
 WHERE SUBSTR(PERIOD,1,4)='2011'
 GROUP BY PERIOD, REGION,GUBUN
 ORDER BY 1;

(ROLLUP GROUP BY�� ���)
SELECT PERIOD AS �Ⱓ,
       REGION AS ����,
       GUBUN AS ���ⱸ��,
       SUM(LOAN_JAN_AMT) AS �����ܾ�
  FROM KOR_LOAN_STATUS
 WHERE SUBSTR(PERIOD,1,4)='2011'
 GROUP BY ROLLUP(PERIOD, REGION, GUBUN)
 ORDER BY 1;

SELECT PERIOD AS �Ⱓ,
       REGION AS ����,
       GUBUN AS ���ⱸ��,
       SUM(LOAN_JAN_AMT) AS �����ܾ�
  FROM KOR_LOAN_STATUS
 WHERE SUBSTR(PERIOD,1,4)='2011'
 GROUP BY PERIOD, ROLLUP(REGION, GUBUN)
 ORDER BY 1;
 -- �κ� ROLLUP



2. CUBE
  - ROLLUP �� ��������� ����
  - CUBE���� ( )�ȿ� ���� �÷��� ���� ������ ����� ���� ������ �����ȯ
    (��� ����� ���������� ��� ��ȯ)
  (�������)

-- CUBE ���
SELECT PERIOD AS �Ⱓ,
       REGION AS ����,
       GUBUN AS ���ⱸ��,
       SUM(LOAN_JAN_AMT) AS �����ܾ�
  FROM KOR_LOAN_STATUS
 WHERE SUBSTR(PERIOD,1,4)='2011'
 GROUP BY CUBE(PERIOD, REGION, GUBUN)
 ORDER BY 1;
--2^3 8������ ����ó��

