분기문
1) IF 문
  - 프로그래밍언어의 IF문과 동일 기능 제공 
  (사용형식-1)
  IF 조건 THEN
     명령문;
  ELSE 
     명령문;
  END IF;   
  
  (사용형식-2)
  IF 조건 THEN
     명령문;
  ELSIF 조건 THEN
     명령문;
  ELSIF 조건 THEN
     명령문;
  ELSE 
     명령문;
  END IF;  
  
  (사용형식-3)
  IF 조건 THEN
     IF 조건 THEN
        명령문;
     ELSE 
        명령문;
     END IF;   
  ELSE 
     명령문;
  END IF;  
  
예)키보드로 단을 입력 받아 해당 구구단을 출력하는 익명 블록을 작성하시오  

ACCEPT P_BASE PROMPT '구구단의 단입력(2-9) : '
DECLARE
  V_BASE NUMBER := TO_NUMBER('&P_BASE');
  
BEGIN
  FOR I IN 1..9 LOOP
    DBMS_OUTPUT.PUT_LINE(V_BASE||'*'||I||'='||V_BASE*i);
    END LOOP;
END;


예)임의의 부서코드(10-110)를 생성하여 해당부서에 속한 사원 중 첫번째로 검색되는 사원정보와
   해당 사원의 급여를 이용하여
    1 ~ 3000 사이이면 '저임금 사원',
    3001 ~ 6000 사이이면 '중간임금 사원'
    6001 이상이면 '고임금 사원' 메세지를 비고에 출력하시오
    단, 출력할 사원정보는 사원번호, 사원명, 부서명, 급여, 비고
    --죄종출력제시된 컬럼개수만큼 변수선언
    
DECLARE
  V_EMP_ID  EMPLOYEES.EMPLOYEE_ID%TYPE;
  V_EMP_NAME EMPLOYEES.EMP_NAME%TYPE;
  V_DEPT_NAME DEPARTMENTS.DEPARTMENT_NAME%TYPE;
  V_DEPT_ID DEPARTMENTS.DEPARTMENT_ID%TYPE;
  V_SAL EMPLOYEES.SALARY%TYPE;
  V_REMARKS VARCHAR2(50);

BEGIN
  --부서번호 생성
  V_DEPT_ID :=ROUND(DBMS_RANDOM.VALUE(10,120),-1);
  
  SELECT A.EMPLOYEE_ID, A.EMP_NAME, B.DEPARTMENT_NAME, A.SALARY
    INTO V_EMP_ID,V_EMP_NAME,V_DEPT_NAME,V_SAL
    FROM EMPLOYEES A, DEPARTMENTS B
   WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID
     AND A.DEPARTMENT_ID=V_DEPT_ID
     AND ROWNUM=1;

  IF V_SAL BETWEEN 1 AND 3000 THEN
     V_REMARKS := '저임금 사원';
  ELSIF V_SAL BETWEEN 3001 AND 6000 THEN
     V_REMARKS := '중간임금 사원';
  ELSE 
     V_REMARKS := '고임금 사원'; 
  END IF;   
  
  DBMS_OUTPUT.PUT_LINE('사원번호 : ' ||V_EMP_ID);
  DBMS_OUTPUT.PUT_LINE('사원명 : ' ||V_EMP_NAME);
  DBMS_OUTPUT.PUT_LINE('부서명 : ' ||V_DEPT_NAME);
  DBMS_OUTPUT.PUT_LINE('급여 : ' ||V_SAL);
  DBMS_OUTPUT.PUT_LINE('비고 : ' ||V_REMARKS);    
  DBMS_OUTPUT.PUT_LINE('------------------------');
  
END;
    

예)매출테이블(CART)에서 2005년 6월 매출액집계를 조회하여
   매출액이 1-50만원 이면 마일리지를 30점
          50만원 초과 100만원 이하이면 50점
          100만원 초과 200만원 이면 70점
          그 이상이면 100점을 추가 지급하는 익명블록을 작성하시오
--회원번호별 매출액 계산해서 업데이트 맴버테이블을 그회원에가서 마일리지 꺼내서 그구간에 따라서 넣음
  
(2005년 6월 회원별 매출액집계 커서)--커서에서 한줄씩꺼내서 쓴다 
CURSOR CUR_MILE
IS
    SELECT CART_MEMBER,
           SUM(CART_QTY*PROD_PRICE)
      FROM CART, PROD
     WHERE CART_PROD=PROD_ID
       AND CART_NO LIKE '200506%'
     GROUP BY CART_MEMBER;  
     


----------------------------------

DECLARE
  V_PMILE  MEMBER.MEM_MILEAGE%TYPE;
  V_UMILE  MEMBER.MEM_MILEAGE%TYPE;
  CURSOR CUR_MILE
  IS
    SELECT CART_MEMBER,
           SUM(CART_QTY*PROD_PRICE) AS AMT
      FROM CART, PROD
     WHERE CART_PROD=PROD_ID
       AND CART_NO LIKE '200506%'
     GROUP BY CART_MEMBER;  
BEGIN
  FOR REC IN CUR_MILE LOOP
    SELECT MEM_MILEAGE INTO V_PMILE
      FROM MEMBER
     WHERE MEM_ID=REC.CART_MEMBER; 
    IF REC.AMT <= 500000 THEN
       V_UMILE:=V_PMILE+30;
    ELSIF REC.AMT <= 1000000 THEN
       V_UMILE:=V_PMILE+50;
    ELSIF REC.AMT <= 2000000 THEN
       V_UMILE:=V_PMILE+70;  
    ELSE
       V_UMILE:=V_PMILE+100;
    END IF;
    
    UPDATE MEMBER
       SET MEM_MILEAGE=V_UMILE
     WHERE MEM_ID=REC.CART_MEMBER;  
     
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('회원번호 : '||REC.CART_MEMBER);
    DBMS_OUTPUT.PUT_LINE('변경전 마일리지 : '||V_PMILE);
    DBMS_OUTPUT.PUT_LINE('변경후 마일리지 : '||V_UMILE);
    DBMS_OUTPUT.PUT_LINE('-----------------------');
  END LOOP;
END;  

2) CASE WHEN 문
  - 다중분기
  - 프로그래밍언어의 SWITCH ~ CASE과 유사
  
 (사용형식)
 CASE WHEN 조건1 THEN
        명령문1;
      WHEN 조건2 THEN
        명령문2;
           :
      ELSE
        명령문n;
 END CASE;

 (사용형식-2)
 CASE 변수 WHEN 값1 THEN
         명령문1;
      WHEN 값2 THEN
         명령문2;
            :
      ELSE
         명령문n;
 END CASE;

예)키보드로 점수(0-100)를 입력 받아
  90-100 : '수'
  80-89  : '우'
  70-79  : '미'
  그 이하 : '좀 더 노력해'를 출력하는 익명블록 작성
  
ACCEPT P_SCORE PROMPT '점수 입력(0-100) : '
DECLARE
  V_SCORE NUMBER := TO_NUMBER('&P_SCORE');
  V_JUM NUMBER := TRUNC(V_SCORE/10);  
BEGIN
  CASE V_JUM WHEN 10 THEN
         DBMS_OUTPUT.PUT_LINE(V_SCORE||'-> 수');
       WHEN 9 THEN 
         DBMS_OUTPUT.PUT_LINE(V_SCORE||'-> 수');
       WHEN 8 THEN 
         DBMS_OUTPUT.PUT_LINE(V_SCORE||'-> 우');
       WHEN 7 THEN 
         DBMS_OUTPUT.PUT_LINE(V_SCORE||'-> 미');
       ELSE
         DBMS_OUTPUT.PUT_LINE(V_SCORE||'-> 좀 더 노력해');
  END CASE;
END;

3)LOOP 문
 - 프로그램언어의 DO문에 해당
 - 반복문의 기본 구조를 제공
 (사용형식)
 LOOP
   반복처리문;
   [EXIT WHEN 조건;]
 END LOOP;
 
  - 'EXIT WHEN 조건' 의 조건이 만족되면 반복을 벗어남
  
예)1-100사이의 수중 홀수의 합과 짝수의 합을 출력하시오
DECLARE 
  V_CNT NUMBER:=0;  --1~100사이의 수를 보관
  V_EVEN NUMBER:=0;  --짝수의 합
  v_ODD NUMBER:=0; --홀수의 합
BEGIN
  LOOP
    V_CNT:=V_CNT+1;
    EXIT WHEN V_CNT>100;
    IF MOD(V_CNT,2)=0 THEN
      V_EVEN:=V_EVEN+V_CNT;
    ELSE
      V_ODD:=V_ODD+V_CNT;
    END IF;
  END LOOP;
  
  DBMS_OUTPUT.PUT_LINE('홀수의 합 : '||V_ODD);
  DBMS_OUTPUT.PUT_LINE('짝수의 합 : '||V_EVEN);  
END;


4)WHILE 문
  - 프로그램언어의 WHILE 명령과 같은 기능 제공
  (사용형식)
  WHILE 조건 LOOP
    반복명령;
  END LOOP;
    .'조건'이 참이면 반복 명령을 수행하고 거짓이면 END LOOP 다음 명령을 수행


(WHILE문으로 변경)

ACCEPT P_DEPT_ID PROMPT '부서코드(10~110) 입력 : '
DECLARE
  V_BONUS NUMBER :=0;
  V_EMP_ID EMPLOYEES.EMPLOYEE_ID%TYPE;
  V_EMP_NAME EMPLOYEES.EMP_NAME%TYPE;
  V_SAL EMPLOYEES.SALARY%TYPE;
  V_MESSAGE VARCHAR2(100);
  
  CURSOR CUR_EMP02(CP_DEPT_ID EMPLOYEES.DEPARTMENT_ID%TYPE)
  IS 
    SELECT EMPLOYEE_ID, EMP_NAME, SALARY
      FROM EMPLOYEES
     WHERE DEPARTMENT_ID=CP_DEPT_ID;
  
BEGIN
  
  OPEN CUR_EMP02(TO_NUMBER('&P_DEPT_ID')); --오픈해주고
  FETCH CUR_EMP02 INTO V_EMP_ID,V_EMP_NAME,V_SAL; --조건처리가 반복을할지말지 결정하는것// 어떤것이 있는지 가져오는것
  WHILE CUR_EMP02%FOUND LOOP  -- 자료가 있다 하면 실행 (첫사람)  한사람밖에 못하기때문에 FETCH를 두개 사용하애함

    V_BONUS:=ROUND(V_SAL*0.3,1);
    V_MESSAGE:=V_EMP_ID||', '||V_EMP_NAME||', '||V_SAL||', '||V_BONUS;
    DBMS_OUTPUT.PUT_LINE(V_MESSAGE);
    
    FETCH CUR_EMP02 INTO V_EMP_ID,V_EMP_NAME,V_SAL; --첫번째사람 하고 두번째사람을 가져와야함 
    
  END LOOP;
   DBMS_OUTPUT.PUT_LINE('처리건수 : '||CUR_EMP02%ROWCOUNT); --커서에 속한 전체 행의수
END;

예)구구단을 2단부터 9단까지 모두 출력하는 블록을 WHILE문을 이용하여 작성하시오
DECLARE
  V_BASE NUMBER:=2;
  V_CNT NUMBER:=1;
  
BEGIN
  WHILE V_BASE<10 LOOP
    DBMS_OUTPUT.PUT_LINE('**'||V_BASE||'단 **');
    V_CNT:=1;
    WHILE V_CNT<10 LOOP
      DBMS_OUTPUT.PUT_LINE(V_BASE||'*'||V_CNT||'='||V_BASE*V_CNT);
      V_CNT:=V_CNT+1;
    END LOOP;
    V_BASE:=V_BASE+1;
  END LOOP;
END;


5)FOR 문
 - 프로그램 개발언어의 FOR문과 같은 기능 제공
 (사용형식)
 FOR 인텍스 IN[REVERSE] 초기값.. 최종값 LOOP
   반복처리명령;
 END LOOP;
  . '인덱스'는 시스템에서 자동으로 선언
  . 역으로 반복처리 하는 경우 REVERSE만 추가
  
  
  
예) 1-50까지에서 FIBONACCI NUMBER를 구하시오 --검색할때 데이터를 찾을때 사용
