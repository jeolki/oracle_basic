## 1\. TRIGGER ( 트리거 )

-   임의의 이벤트 (INSERT, UPDATE, DELETE)가 발생되기 전 또는 발생 후 다른 테이블이 자동 변경이 되도록 하기 위해 사용되는 프러시저

( 사용 형식 )

```sql
 CREATE OR REPLACE TRIGGER 트리거명 
  AFTER | BEFORE  [INSERT | UPDATE | DELETE ]
  ON 테이블명
  [FOR EACH ROW][WHEN 조건] --예) 5번 인서트한다 하면 써야함 줄마다 해야해서
 BEGIN
  SQL 구문;
  
 END;
```

   

  

   

### 1) 타이밍

-   BEFORE와 AFTER
-   BEFORE : 이벤트가 발생되기 전에 BEGIN ~ END 블록의 SQL문을 실행
-   AFTER : 이벤트가 발생된 후에 BEGIN ~ END 블록의 SQL문을 실행

​    

   

​    

### 2) EVENT

-   트리거 발생 원인이 되는 DML문
-   OR 연산자로 복합 사용 가능(ex) INSERT OR UPDATE OR DELETE

   

​    

​    

### 3) WHEN 조건

-   행단 위 트리거에서만 사용 가능(이벤트가 발생될 때 구체적인 검색 조건 기술)
-   ⇒ 조건이 맞을 때만 트리거 동작

```sql
** 트리거 의사 레코드
---------------------------------------------------------
의사레코드              내       용
--------------------------------------------------------
 : NEW    데이터가 상입(갱신)될때 새로 입력된 값
          INSERT/UPDATE 이벤트에 의한 트리거에서
          만 사용(DELETE 이벤트에서는 NULL값)
 : OLD    데이터가 삭제(갱신)될때 새로 입력된 값
          DELETE/UPDATE 이벤트에 의한 트리거에서
          만 사용(INSERT 이벤트에서는 NULL값)
----------------------------------------------------------

** 트리거 함수
  (1) INSERTING : 트리거 문장이 INSERT이면 TRUE
  (2) UPDATTING : 트리거 문장이 UPDATE이면 TRUE
  (3) DELETING : 트리거 문장이 DELETE이면 TRUE
```

​    

​    

​    s

예제) 상품코드 'p101000001' 상품을 고객 'c001' 고객이 '20050810'에  
        10개를 구매했다고 가정하고 재고 수불 테이블을 수정하는 트리거 작성

```sql
DECLARE
  V_CNT NUMBER:=0;
BEGIN
  SELECT COUNT(*)INTO V_CNT
    FROM CART
   WHERE CART_NO LIKE '20050810%';
   
   IF V_CNT=0 THEN
     INSERT INTO CART VALUES('c001','2005081000001','p101000001',10);
   END IF
END;

(트리거 생성)
CREATE OR REPLACE TRIGGER TG_CART01
  AFTER INSERT ON CART
  FOR EACH ROW
DECLARE
  V_QTY NUMBER:=0;
  V_PROD PROD.PROD_ID%TYPE;
BEGIN
  V_QTY:=:NEW.CART_QTY;
  V_PROD:=:NEW.CART_PROD;
  UPDATE REMAIN
     SET REMAIN_O = REMAIN_O+V_QTY,
         REMAIN_J_99 = REMAIN_J_99-V_QTY,
         REMAIN_DATE='20050810'
   WHERE REMAIN_PROD=V_PROD;
END;
    
    
 INSERT INTO CART VALUES('c001','200508100001','P101000001',10);
```