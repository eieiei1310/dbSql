synonym : 동의어
1. 객체 별칭을 부여
    ==> 이름을 간단하게 표현
    
sem 사용자가 자신의 테이블 emp 테이블을 사용해서 만든 v_emp view
hr 사용자가 사용할 수 있게끔 권한을 부여

v_emp : 민감한 정보 sal, comm를 제외한 view;

hr 사용자 v_emp를 사용하기 위해 다음과 같이 작성

SELECT *
FROM sem.v_emp;

hr계정에서
synonym sem.v_emp == > v_emp
v_emp == sem.v_emp

SELECT *
FROM v_emp;

1. sem 계정에서 v_emp를 hr 계정에서 조회할 수 있도록 조회권한 부여;

GRANT SELECT ON v_emp TO hr;

2. hr 계정 v_emp 조회하는 게 가능 (권한 1 번에서 받았기 때문에)
    사용시 해당 객체의 소유자를 명시 : sem.v_emp
    간단하게 sem.v_emp ==> v_emp 사용하고 싶은 상황
    synonym 생성
    
CREATE SYNONYM 시노님 이름 FOR 원 객체명;

------------------------------------hr 계정에서 작업한 내역-----------
SELECT *
FROM DASEUL.v_emp;

SELECT *
FROM v_emp;

CREATE SYNONYM v_emp FOR DASEUL.v_emp;

SELECT *
FROM v_emp;
--> 이제 사용자 명을 부여하지 않아도 잘 나온다.


-------------------------------------------------------------------
SYNONYM 삭제
DROP SYNONYM 시노님 이름;


GRANT CONNECT TO DASEUL;
GRANT SELECT ON 객체명 TO HR;

권한 종류
1. 시스템 권한 : TABLE을 생성, VIEW 생성 권한...
2. 객체 권한 : 특정 객체에 대해 SELECT, UPDATE, INSERT, DELETE...

ROLE : 권한을 모아놓은 집합
사용자별로 개별 권한을 부여하게 되면 관리의 부담.
특정 ROLE 에 권한을 부여하고 해당 ROLE 사용자에게 부여
해당 ROLE 을 수정하게 되면 ROLE 을 갖고 있는 모든 사용자에게 영향

권한 부여/ 회수
시스템 권한 : GRANT 권한 이름 TO 사용자 | ROLE;
            REVOKE 권한이름 FROM 사용자 | ROLE;
객체 권한 : GRANT 권한이름 ON 객체명 TO 사용자 | ROLE;
            REVOKE 권한이름 ON 객체명 FROM 사용자 | ROLE;
            
            
----------------------

date dictionary: 사용자가 관리하지 않고, dbms 가 자체적으로 관리하는
                 시스템 정보를 담은 view;
                 
date dictionary 접두어
1. USER : 해당 사용자가 소유한 객체
2. ALL : 해당 사용자가 소유한 객체 + 다른 사용자로부터 권한을 부여받은 객체
3. DBA : 모든 사용자의 객체

* V$ 특수 VIEW;

SELECT *
FROM USER_TABLES;(여기에 USER-> 이부분이 접두어);

SELECT *
FROM ALL_TABLES;

SELECT *
FROM DBA_TABLES; --> 일반 사용자는 볼 수 없다.

dictionary 종류 확인 : SYS.DICTIONARY;

SELECT *
FROM DICTIONARY;

SELECT *
FROM USER_OBJECTS;
--> OBJECT_TYPE 쪽을 보면 어떤 객체인지 알 수 있다. 주로 TABLE, INDEX

대표적인 dictionary
OBJECTS : 객체 정보 조회 (테이블, 인덱스, VIEW, SYNONYM ...)
TABLES : 테이블 정보만 조회
TAB_COLUMNS : 테이블의 컬럼 정보 조회
INDEXES : 인덱스 정보 조회         --중요
IND_COLUMNS : 인덱스 구성 컬럼 조회 --중요
CONSTRAINTS : 제약조건 조회
CONS_COLUMNS : 제약조건 구성 컬럼 조회
TAB_COMMENTS : 테이블 주석       --중요
COL_COMMENTS : 테이블의 컬럼 주석 --중요
;


---------DICTIONARY 실습------------------

emp, dept 테이블의 인덱스와 인덱스 컬럼 정보 조회;
USER_INDEXES, USER_IND_COLUMNS JOIN
테이블명, 인덱스 명, 컬럼명
emp  ind_n_emp_04  ename
emp  ind_n_emp_04  job

SELECT *
FROM USER_INDEXES;

SELECT table_name, index_name, column_name
FROM USER_IND_COLUMNS
ORDER BY table_name, index_name, column_position;

--------------------------------------- 기본적인 SQL 활용 끝 -----------------------------

multiple insert : 하나의 insert 구문으로 여러 테이블에 데이터를 입력하는 DML

SELECT *
FROM dept_test;


SELECT *
FROM dept_test2;

동일한 값을 여러 테이블에 동시 입력하는 multiple insert;
INSERT ALL
    INTO dept_test
    INTO dept_test2
SELECT 98, '대덕', '중앙로' FROM dual UNION ALL 
SELECT 97, 'IT','영민' FROM dual;


테이블에 입력할 컬럼을 지정하여 multiple insert;
ROLLBACK;
INSERT ALL
    INTO dept_test (deptno, loc) VALUES (deptno, loc) -->값을 2개만 넣겠다.
    INTO dept_test2 -->값을 모두 넣겠다. 
SELECT 98 deptno , '대덕' dname , '중앙로' loc FROM dual UNION ALL  -->컬럼명은 첫번째 행의 as를 따라감.
SELECT 97, 'IT','영민' FROM dual;

결과 : dept_test 에는 dname 이 비어서 들어간다.
      dept_test2 에는 모든 값이 들어간다. 


테이블에 입력할 데이터를 조건에 따라 multiple insert
CASE --와 유사
    WHEN 조건 기술 THEN 
END;

ROLLBACK;
INSERT ALL
    WHEN deptno = 98 THEN 
         INTO dept_test (deptno, loc) VALUES (deptno, loc) -->값을 2개만 넣겠다.
    ELSE 
         INTO dept_test2
SELECT 98 deptno , '대덕' dname , '중앙로' loc FROM dual UNION ALL  -->컬럼명은 첫번째 행의 as를 따라감.
SELECT 97, 'IT','영민' FROM dual;

SELECT *
FROM dept_test;


SELECT *
FROM dept_test2;

ROLLBACK;
INSERT ALL
    WHEN deptno = 98 THEN 
         INTO dept_test (deptno, loc) VALUES (deptno, loc)
         INTO dept_test2 --> INTO 가 두개 들어가는 것도 가능
    ELSE 
         INTO dept_test2
SELECT 98 deptno , '대덕' dname , '중앙로' loc FROM dual UNION ALL  -->컬럼명은 첫번째 행의 as를 따라감.
SELECT 97, 'IT','영민' FROM dual;

SELECT *
FROM dept_test;


SELECT *
FROM dept_test2;



 조건을 만족하는 첫번째 insert 만 실행하는 multiple insert

ROLLBACK;
INSERT FIRST --> 조건을 만족하는 첫번째에만 입력을 한다. 
    WHEN deptno >= 98 THEN 
         INTO dept_test (deptno, loc) VALUES (deptno, loc)
    WHEN deptno >= 97 THEN 
         INTO dept_test2
    ELSE 
        INTO dept_test2
SELECT 98 deptno , '대덕' dname , '중앙로' loc FROM dual UNION ALL  -->컬럼명은 첫번째 행의 as를 따라감.
SELECT 97, 'IT','영민' FROM dual;

SELECT *
FROM dept_test;


SELECT *
FROM dept_test2;

오라클 객체 : 테이블에 여러 개의 구역을 파티션으로 구분
테이블 이름은 동일하나 값의 종류에 따라 오라클 내부적으로 별도의
분리된 영역에 데이터를 저장;
 
dept_test == > dept_test_20200201 이런식으로...
--외부적으로는 변화가 없지만 내부적으로 분리한다.
--파티클은 유료임. 우리가 쓰는 건 무료라서 못씀

 --만약에 SK처럼 일자에 따라 상담 데이터가 늘어나는 곳이라면...
ROLLBACK;
INSERT FIRST --> 조건을 만족하는 첫번째에만 입력을 한다. 
    WHEN deptno >= 98 THEN 
         INTO dept_test_2020020 --< 굳이 이렇게 테이블명을 바꿀 필요가 없다. 
    WHEN deptno >= 97 THEN 
         INTO dept_test_2020021
    ELSE 
        INTO dept_test_2020022
        --....
        
SELECT 98 deptno , '대덕' dname , '중앙로' loc FROM dual UNION ALL  -->컬럼명은 첫번째 행의 as를 따라감.
SELECT 97, 'IT','영민' FROM dual;


-------------------------------------


MERGE : 통합
테이블에 데이터를 입력/갱신 하려고 함.
1. 내가 입력하려고 하는 데이터가 존재하면 
    ==> 업데이트
2. 내가 입력하려고 하는 데이터가 존재하지 않으면
    ==> INSERT
    

1. SELECT 실행
2-1. SELECT 실행 결과가 0 ROW 이면 INSERT
2-2. SELECT 실행 결과가 1 ROW 이면 UPDATE

MERGE 구문을 사용하게 되면 SELECT 를 하지 않아도 자동으로 데이터 유무에 따라
INSERT 혹은 UPDATE 를 실행한다.

2번의 쿼리를 1번으로 줄여 준다. --> MERGE

MERGE INTO 테이블명 [alias ] -->일반적으로 AS가 옴.
USING (TABLE | VIEW | IN-LINE-VIEW )
ON (조인조건)
WHEN MATCHED THEN 
    UPDATE SET col1 = 컬럼값, col2 = 컬럼값....
WHEN NOT MATCHED THEN
    INSERT (컬럼1, 컬럼2, 컬럼3....)VALUES (컬럼값1, 컬럼값2....);
    
SELECT *
FROM emp_test;
SELECT *
FROM emp;
--일단 emp_test 내용 삭제하기

DELETE emp_test;
로그를 안 남긴다 ==> 복구가 안된다 ==> 테스트용으로...
TRUNCATE TABLE emp_test;

emp 테이블에서 emp_test테이블로 데이터를 복사 (7369 -SMITH);

INSERT INTO emp_test
SELECT empno, ename, deptno, '010'
FROM emp
WHERE empno = 7369;

데이터가 잘 입력되었는지 확인한다. 
SELECT *
FROM emp_test;

UPDATE emp_test SET ename = 'brown'
WHERE empno = 7369;

COMMIT;

emp 테이블의 모든 직원은 emp_test 테이블로 통합
emp 테이블에는 존재하지만 emp_test 에는 존재하지 않으면 insert
emp 테이블에는 존재하고 emp_test 에도 존재하면 ename, deptno 를 update;

emp 테이블에 존재하는 14건의 데이터 중 emp_test 에도 존재하는 7369를 제외한 13건의 데이터가
emp_test 테이블에 신규로 입력이 되고
emp_test에 존재하는 7369번의 데이터는 ename(brown)이 emp 테이블에 존재하는 이름인 SMITH로 갱신

MERGE INTO emp_test a
USING emp b
ON (a.empno = b.empno)
WHEN MATCHED THEN 
    UPDATE SET a.ename = b.ename, 
               a.deptno = b.deptno
WHEN NOT MATCHED THEN 
    INSERT (empno, ename, deptno) VALUES (b.empno, b.ename, b.deptno);

SELECT *
FROM emp_test;

해당 테이블에 데이터가 있으면 insert, 없으면 update
emp_test 테이블에 사번이 9999번인 사람이 없으면 새롭게 insert
있으면 update
(9999, 'brown',10, '010')


INSERT INTO dept_test VALUES (9999, 'brown',10, '010');
UPDATE dept_test SET ename = 'brown'
                     deptno = 10
                    hp = '010'
WHERE empno = 9999;
--> 이거 두개를 동시에 하는 게 merge

MERGE INTO emp_test
USING dual 
ON (empno = 9999)
WHEN MATCHED THEN 
    UPDATE SET ename = 'brown',
               deptno = 10,
               hp = '010'
WHEN NOT MATCHED THEN 
    INSERT VALUES (9999, 'brown', 10, '010');


SELECT *
FROM emp_test;
--> 사번이 9999인 자료가 없으므로 insert가 된다. 

MERGE INTO emp_test
USING dual 
ON (empno = 9999)
WHEN MATCHED THEN 
    UPDATE SET ename = ename || '_u',
               deptno = 10,
               hp = '010'
WHEN NOT MATCHED THEN 
    INSERT VALUES (9999, 'brown', 10, '010');

--> 사번이 9999인 자료가 있으므로 update 가 된다. 

SELECT *
FROM emp_test;

------------------------

--실습 GROUP_AD1

----내 답 (맞음)
SELECT deptno , SUM(sal)
FROM emp
GROUP BY deptno
--ORDER BY SUM(sal);

UNION ALL 

SELECT null , SUM(a) 
FROM
    (SELECT deptno , SUM(sal) a
     FROM emp
    GROUP BY deptno
    ORDER BY SUM(sal))b;


-------------임종원씨 답
SELECT deptno, SUM(sal) sal
FROM emp
GROUP BY deptno

UNION ALL

SELECT NULL, SUM(sal) sal
FROM emp
ORDER BY deptno;

I/O
CPU CACHE > RAM >SSD > HDD > NETWORK;

REPORT GROUP FUNCTION
ROLLUP
CUBE
GROUPING ;

ROLLUP 
사용방법 : GROUP BY ROLLUP (컬럼1, 컬럼2...)
SUBGROUP을 자동적으로 생성
SUBGROUP을 생성하는 규칙 : ROLLUP에 기술한 컬럼을 [오른쪽]에서부터 하나씩 제거하면서
                         SUB GROUP 을 생성;
EX : GROUP BY ROLLUP (deptno)
==> 
첫번째 sub group : GROUP BY deptno
두번째 sub group : GROUP BY NULL ==> 전체 행을 대상

GROUP_AD1을 GROUP BY ROLLUP 절을 사용하여 작성;

SELECT deptno, SUM(sal)
FROM emp
GROUP BY ROLLUP (deptno);

SELECT job, deptno, 
        GROUPING(job), GROUPING(deptno), --> GROUPING? : 
        SUM(sal + NVL(comm, 0)) sal
FROM emp
GROUP BY ROLLUP (job, deptno);

-->실행결과 예측
1. GROUP BY job, deptno :담당 업무 부서별 급여합
2. GROUP BY job : 담당업무별 급여합
3. GROUP BY :전체 급여합

--실습 GROUP_AD2

SELECT job, deptno, 
        SUM(sal + NVL(comm, 0)) sal
FROM emp
GROUP BY ROLLUP (job, deptno);

--내답(틀렸음)
SELECT NVL(job,'총계') JOB,
       deptno, 
       SUM(sal + NVL(comm, 0)) sal
FROM emp
GROUP BY ROLLUP (job, deptno);

--선생님 답

SELECT 
    CASE WHEN GROUPING(job) = 1 AND GROUPING(deptno) = 1 THEN '총계'
        else job
        END job,
        deptno, 
        SUM(sal + NVL(comm, 0)) sal
FROM emp
GROUP BY ROLLUP (job, deptno);


--다시 실습 decode로 바꿔보기(과제)

SELECT 
    DECODE(GROUPING(job), 1, DECODE(GROUPING(deptno), 1,'총계')
                        ,0,job) JOB,
        deptno, 
        SUM(sal + NVL(comm, 0)) sal
FROM emp
GROUP BY ROLLUP (job, deptno);



--실습 GROUP_AD2-1

SELECT 
    CASE WHEN GROUPING(job) = 1 AND GROUPING(deptno) = 1 THEN '총'
        else job
        END job,
        
    CASE WHEN TO_CHAR(GROUPING(job)) = '0' AND TO_CHAR(GROUPING(deptno)) = '1' THEN '소계'
        WHEN TO_CHAR(GROUPING(job)) = '1' AND  TO_CHAR(GROUPING(deptno)) = '1' THEN '계'
        else TO_CHAR(deptno)
        END deptno, 
        
        SUM(sal + NVL(comm, 0)) sal
FROM emp 
GROUP BY ROLLUP (job, deptno);








--선생님 예시랑 달라서 드롭하고 다시만듬

DROP TABLE emp_test;

CREATE TABLE emp_test(
    empno NUMBER(4),
    ename VARCHAR2(10),
    deptno NUMBER(2),
    hp VARCHAR2(10) DEFAULT '010'
    );
    
    
