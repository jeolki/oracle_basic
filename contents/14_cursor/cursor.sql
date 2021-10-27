**CURSOR
  - SQL 명령으로 영향받는 행들의 집합
  - 묵시적 커서/명시적 커서

1)묵시적 커서
  - 사용자가 SQL 문을 수행 시키면 자동으로 생성되는 커서
  - 이름이 없고 OPEN과 동시에 CLOSE되어짐(사용자가 커서 집합내의 자료를 ACCESS할 수 없음)
  (커서속성)
------------------------------------------------------------
  커서속성           의미
------------------------------------------------------------
  SQL%FOUND        결과집합내에 하나의 행이라도 존재하면 참 반환       
  SQL%NOTFOUND     결과집합내에 하나의 행이라도 존재하면 거짓 반환   
  SQL%ROWCOUNT     반환된 행(결과의 행)의 수 
  SQL%ISOPEN       커서가 OPEN 된 상태이면 참 반환(항상 거짓)
------------------------------------------------------------
--예) 제품코드를입력할때 있는지없는지확인.
--    특정한 제품분류의 가격을 모두 20%씩 업하겟다.
--    하나씩 수정할수도 있다 FOUND가 참일때만 업데이트


예)
DECLARE
  V_DEPT EMPLOYEES.DEPARTMENT_ID%TYPE:=50;
BEGIN
  UPDATE EMPLOYEES
     SET SALARY = SALARY
   WHERE DEPARTMENT_ID=V_DEPT;
   
   DBMS_OUTPUT.PUT_LINE('급여가 변경된 사원 수 : '||SQL%ROWCOUNT);  
END;

  
2)명시적 커서
  - 사용자가 CURSOR 구문으로 생성한 커서
  - 커서의 사용은 커서생성->커서OPEN->커서FETCH->커서CLOSE의 4단계가 필요
  
  (1)커서 생성(선언)
    . 선언부에서 기술
    (선언형식)
    CURSOR 커서명[(매개변수 타입,...)] --OPEN 에서 데이터를 넣어주면 값을 받아드릴 기억공간인 매개변수로 선언// 가 매개변수
    IS
      SELECT 문;
      
  (2)커서 OPEN
    . 실행영역(BEGIN ~END;)에서 기술
    . 사용할 커서의 상태를 접근 가능 상태로 변경
    (사용형식)
    OPEN 커서명[(매개변수1,....)]; --실 매개변수 넘겨줄 실제 데이터
    
  (3)커서 FETCH
    . OPEN 된 커서 내의 자료를 행단위로 읽어옴 --한행을 읽어서 변수에 넣어줌
    . 보통 반복명령 내부에 기술
    (사용형식)
    FETCH 커서명 INTO 변수명1,...
     . 커서의 SELECT 절의 컬럼 값을 INTO 다음 변수에 할당
     . SELECT 절의 컬럼의 갯수, 타입, 순서와 INTO 다음의 --명시적커서를 구성하는 SELECT절
       변수의 갯수, 타입, 순서는 일치해야 함
       
  (4)커서 CLOSE
    . 사용이 종료된 커서는 반드시 CLOSE되어야 함 --거꾸로는 안되서 클로즈하고 다시오픈해야함
    (사용형식)
    CLOSE 커서명; 
  
  
예)사원테이블에서 입력된 부서번호에 속한 사원들의 급여에 30%를 보너스로 지급하여야한다.
  사원번호, 사원명, 급여, 보너스 금액을 출력하는 익명블록을 커서를 사용하여 구성하시오
  --커서로 구성해야할것 사원번호 사원명 그사람의 급여
  --보너스는 그사원의 급여를 꺼내와서 0,3을 곱해서 출력하는것
  
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
  OPEN CUR_EMP02(TO_NUMBER('&P_DEPT_ID'));
  
  LOOP
    FETCH CUR_EMP02 INTO V_EMP_ID,V_EMP_NAME,V_SAL;
    EXIT WHEN CUR_EMP02%NOTFOUND; --더이상 차료가없으면 참
    V_BONUS:=ROUND(V_SAL*0.3,1);
    V_MESSAGE:=V_EMP_ID||', '||V_EMP_NAME||', '||V_SAL||', '||V_BONUS;
    DBMS_OUTPUT.PUT_LINE(V_MESSAGE);
    
 
  END LOOP;
  CLOSE CUR_EMP02;
END;
  
--커서를 사용하는 이유 함수나 프로시져로 만들었을때에 등 정보를 은닉화 하기 위해서








  