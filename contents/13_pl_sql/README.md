## 1\. PL/SQL

-   Procedure Language SQL의 약자
-   기본 SQL이 제어문, 변수, 상수 등의 기능을 제공하지 않아 제약사항 존재
-   기본 SQL의 기능을 확장하고 모듈화, 캡슐화 기능 제공
-   익명 블록, 사용자 정의 함수, 저장 프러시저, 트리거, 패키지 등이 제공

​    

​    

​    

## 2\. 익명블록(Anomymous Block)

-   이름을 갖고 있지 않은 블록
-   PL/SQL의 기본이 되는 구조
-   단순 스크립트에서 실행돼도 서버에 저장되지 않음

  

  

### 1) 구조

```sql
DECLARE
    선언부(변수, 상수, 커서 선언);
 BEGIN
    실행부(비지니스 로직을 처리하기 위한 SQL문);
    
    [EXCEPTION
        예외처리부;]
 END;
```

   

   ### 2) 변수

```sql
 . 일반 개발언어의 변수와 같은 기능 데이터를 잠시보관 --하나 한행전체 테이블전체
 . SCLAR 변수 - 하나의 데이터만 저장
 . REFERENCE 변수 - 지정된 테이블의 COLOMN이나 ROW를 참조할 수 있는 변수
 . COMPOSITE 변수 - 배열변수로 RECORD TYPE과 TABLE TYPE이 있음 
 . BIND 변수(매개변수) - IN , OUT, INPUT에서 사용되는 매개변수
 
 --LEFT VALUE 변수만 온다 상수 못옴  =  RIGHT VALUE 
 --ROWTYPE은 행으로저장
 (변수/상수 선언 형식)
 변수[상수]명 [CONSTANT]데이터타입 | 테이블명.컬럼명%TYPE | 테이블명%ROWTYPE 
    [크기][:= 초기값]
 . 초기값 설정이 없으면 모든 변수는 null로 초기화됨.
  
  -- 초기값을 설정하지 않으면 모든 변수에 null이 들어간다.
  -- 숫자등으로 하면 기본값으로 초기값설정을 해줘야한다.
```

​    

​    

   

예제) 년도를 입력 받아 윤년인지 평년인지를 판별하는 익명 블록을 작성하시오

```sql
 DECLARE 
    V_YEAR NUMBER(4) := 0;
    V_MESSAGE VARCHAR2(50);
 BEGIN
    SELECT EXTRACT(YEAR FROM MEM_BIR) INTO V_YEAR
        FROM MEMBER
        WHERE LOWER(MEM_ID) = 'f001';
        
    IF (MOD(V_YEAR,4)=0 AND MOD(V_YEAR,100)!=0) OR
       (MOD(V_YEAR,400)=0) THEN
        V_MESSAGE := V_YEAR||'는 윤년입니다.';
    ELSE
        V_MESSAGE := V_YEAR||'는 평년입니다.';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(V_MESSAGE);
 END;
```

​    

   

   

예제) 상품테이블에서 가장 큰 판매가를 가진 상품번호, 상품명, 분류명, 가격을 출력하는 프러시저를 작성하시오

```sql
DECLARE
  V_PROD_ID    PROD.PROD_ID%TYPE;
  V_PROD_NAME  PROD.PROD_NAME%TYPE;
  V_LPROD_NM   LPROD.LPROD_NM%TYPE;
  V_PRICE      PROD.PROD_PRICE%TYPE;
  
  V_MESSAGE    VARCHAR2(100);
BEGIN
  SELECT * INTO V_PROD_ID,V_PROD_NAME,V_LPROD_NM,V_PRICE
    FROM (SELECT PROD_ID,PROD_NAME,LPROD_NM,PROD_PRICE 
            FROM PROD, LPROD
           WHERE PROD_LGU=LPROD_GU
        ORDER BY PROD_PRICE DESC) A
  WHERE ROWNUM=1;
  
  V_MESSAGE:=V_PROD_ID||', '||V_PROD_NAME||', '||V_LPROD_NM||', '||V_PRICE;
  DBMS_OUTPUT.PUT_LINE(V_MESSAGE);
END;
```

