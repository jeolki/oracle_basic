## 1\. DROP ( 개체삭제 )

-   오라클 개체 삭제 명령
-   ROLLBACK의 대상이 아님 (삭제는 ROLLBACK의 대상이 아니다)

(사용형식)

```
DROP 개체종류 개체명;
```

예제) EMP 테이블을 제거하시오

```
DROP TABLE EMP;
```

⇒ 실행하면 삭제가 되지않는다.

⇒ 오류 : An attempt was made to drop a table with unique or primary keys referenced by foreign keys in another table.

⇒ 방법1. 연관되어있는 하위 테이블부터 드롭시키고 관계가 모두 짤린다음에 드롭시킬수있다  
⇒ 방법2. 드롭으로 왜래키설정을 지워서 관계를 자르고 드롭시킬수있다.  
⇒ 방법3. 리커시블, 관계를 맺고있는 하위의 테이블 부터 모두 지워버린다. (쓰지말아야함)

⇒ 같은 컬럼은 DATA\_TYPE 과 수까지 같아야한다. 공백도 안됨.

## 2\. DELETE ( 테이블 내의 자료 삭제 )

-   DELETE 문 사용
-   외부테이블에서 참조된 행을 삭제 불가
-   ROLLBACK이 적용됨 ⇒ **직전의 COMMIT 상태로 돌아감**

⇒ WORK 테이블에서 이미나는 삭제가능 EMP 에서 이미나는 삭제불가능 WORK테이블에 참조되고있어서  
⇒ 부모테이블의 참조되어지는 행은 삭제가 불가능하다.

(사용형식)

```
DELETE 테이블명 
 [WHERE 조건];
 . WHERE 절이 생략되면 '테이블'의 모든자료 삭제
```

예제) 사원테이블에서 '이미나'사원정보를 제거하시오

```
DELETE EMP
 WHERE EMP_NAME='이미나';
```

⇒ 삭제되지 않는다 integrity constraint (HJG.FK\_WORK\_EMP) violated - child record found  
⇒ WORK에서 참조하고 있기 때문에 삭제되지 않는다.

예제) 사원테이블에서 '강감찬'사원정보를 제거하시오

```
DELETE EMP
 WHERE EMP_NAME='강감찬';
```

⇒ 삭제가 된다.

```
SELECT * FROM EMP;
```

⇒ 강감찬이 삭제된것을 확인할 수 있다.

```
ROLLBACK;
```

⇒ 삭제되었던 것을 다시 되돌린다.  
⇒ DROP, CREATE 는 롤백적용이안된다.

```
DROP TABLE WORK;
```

⇒ WORK TABLE이 삭제됨

```
ROLLBACK;
```

⇒ 롤백이 되지않는다.  
⇒ WORK TABLE을 삭제했기때문에 EMP CONST\_SITE 모두 삭제할수 있다.  
⇒ 참조중인것을 삭제했기 때문에