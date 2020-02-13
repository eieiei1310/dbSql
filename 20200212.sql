1. table full
2. idx1 : empno
3. idx2 : job;


EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE 'C%';

SELECT *
FROM TABLE(dbms_xplan.display);

Plan hash value: 1112338291
 
--------------------------------------------------------------------------------------------
| Id  | Operation                   | Name         | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |              |     1 |    38 |     2   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS BY INDEX ROWID| EMP          |     1 |    38 |     2   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN          | IDX_N_EMP_02 |     3 |       |     1   (0)| 00:00:01 |
--------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("ENAME" LIKE 'C%')
   2 - access("JOB"='MANAGER')
   
-->  access는 idx2 로, filter로 거름

   
   
CREATE INDEX idx_n_emp_03 ON emp (job, ename);

EXPLAIN PLAN FOR 
SELECT *
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE 'C%';

SELECT *
FROM TABLE(dbms_xplan.display);

--------------------------------------------------------------------------------------------
| Id  | Operation                   | Name         | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |              |     1 |    38 |     2   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP          |     1 |    38 |     2   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN          | IDX_N_EMP_03 |     1 |       |     1   (0)| 00:00:01 |
--------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("JOB"='MANAGER' AND "ENAME" LIKE 'C%')
       filter("ENAME" LIKE 'C%')
   
--> c로 시작하는것을 인덱스로 거름
--> ppt 88처름 끝글자를 검색할 경우 테이블을 전체 다 봐야 한다.

SELECT job, ename, rowid
FROM emp
ORDER BY job;


1. table full
2. idx2 : empno
3. idx2 : job
4. idx3 : job + ename
5. idx4 : ename + job;

CREATE INDEX idx_n_emp_04 ON emp (ename, job);
--> 4번과 나열된 조건 순서가 다름-> 결과도 다르게 나옴.
SELECT ename, job, rowid
FROM emp
ORDER BY ename, job;
(인덱스의 모습);

3번째 인덱스를 지우자.
3,4번째 인덱스가 컬럼 구성이 동일하고 순서만 다르므로, 정확한 비교를 위해 3를 삭제;

DROP INDEX idx_n_emp_03;


EXPLAIN PLAN FOR 
SELECT *
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE 'C%';

SELECT *
FROM TABLE(dbms_xplan.display);

Plan hash value: 1173072073
 
--------------------------------------------------------------------------------------------
| Id  | Operation                   | Name         | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |              |     1 |    38 |     2   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP          |     1 |    38 |     2   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN          | IDX_N_EMP_04 |     1 |       |     1   (0)| 00:00:01 |
--------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("ENAME" LIKE 'C%' AND "JOB"='MANAGER')
       filter("JOB"='MANAGER' AND "ENAME" LIKE 'C%')

--사용할 수 있는 도구
emp -table full, pk_emp(empno)
dept - table full, pk_dept(deptno)

--경우의 수 
(emp - table full, dept-table full)
(dept-table full, emp - table full)

(emp - table full, dept-pk_dept)
(dept-pk_dept,emp - table full)

(emp - pk_emp, dept - table full)
(dept - table full,emp - pk_emp)

(emp - pk_emp, dept - pk_dept)
(dept - pk_dept, emp - pk_emp)

--> 오라클이 모든 경우의 수를 다 보진 않는다. (응답이 빠른 것이 더 중요하기 때문)

SELECT ename, dname, loc
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.empno = 7788;

1 순서
2개 테이블 조인
각각의 테이블에 인덱스 5개 씩 있다면
한 테이블에 접근 전략 : 6
36 * 2 = 72


ORACLE - 실시간 응답 : OLTP (ON LINE TRANSACTION PROCESSING) --우리가 하는 것.
         전체 처리시간 : OLAP (ON LINE ANALYSIS PROCESSING) - 복잡한 쿼리의 실행계획을 세우는 데 
                                                            30M~1H) --응답을 빨리 하는 것보다 빨리 실행하는 것을 더 우선시
                                                            
  
emp 부터 읽을까 dept 부터 읽을까?? -> 실행 계획을 봐야지만 알 수 있다.

EXPLAIN PLAN FOR
SELECT ename, dname, loc
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.empno = 7788;
        
SELECT *
FROM TABLE(dbms_xplan.display);

4 - 3 - 5 - 2 - 6 - 1 - 0
--읽는법 띄어쓰기한게 자식, 자식부터 읽는다. (가장 많이 띄어쓰기된 부분부터)

| Id  | Operation                     | Name         | Rows  | Bytes | Cost (%CPU)| Time     |
----------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT              |              |     1 |    33 |     3   (0)| 00:00:01 |
|   1 |  NESTED LOOPS                 |              |       |       |            |          |
|   2 |   NESTED LOOPS                |              |     1 |    33 |     3   (0)| 00:00:01 |
|   3 |    TABLE ACCESS BY INDEX ROWID| EMP          |     1 |    13 |     2   (0)| 00:00:01 |
|*  4 |     INDEX RANGE SCAN          | IDX_N_EMP_01 |     1 |       |     1   (0)| 00:00:01 |
|*  5 |    INDEX UNIQUE SCAN          | PK_DEPT      |     1 |       |     0   (0)| 00:00:01 |
|   6 |   TABLE ACCESS BY INDEX ROWID | DEPT         |     1 |    20 |     1   (0)| 00:00:01 |
----------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   4 - access("EMP"."EMPNO"=7788)
   5 - access("EMP"."DEPTNO"="DEPT"."DEPTNO")
   
   ppt 97 index와 full access 참조
   


DDL실습 idx1


CREATE TABLE DEPT_TEST2 AS
SELECT * 
FROM DEPT
WHERE 1 = 1;
--> 1 은 1이다가 뭔데요???? -->컬럼정보가 아닌 그냥 논리적인 조건
--> 테이블을 복사하면 제약조건은 복사가 안 되나요?? -> 하나 빼고 안 된대용 ㅎㅎ...어제 배웟다는데...희미하게 기억날랑말랑
--        CTAS
--         제약조건 복사가 NOT NULL만 된다. 백업이나, 테스트용으로;


SELECT *
FROM dept_test2;

--1 deptno 컬럼으로 유니크
CREATE UNIQUE INDEX idx_u_dept_test_01 ON dept_test2 (deptno);
--2 dname 컬럼으로 논유니크
CREATE INDEX idx_n_dept_test_02 ON dept_test2 (dname);
--3 deptno, dname 컬럼으로 논유니크
CREATE INDEX idx_n_dept_test_03 ON dept_test2 (deptno, dname);


DDL실습 idx2

DROP INDEX idx_u_dept_test_01;
DROP INDEX idx_n_dept_test_02;
DROP INDEX idx_n_dept_test_03;

SELECT *
FROM EMP
WHERE empno = :empno;


DDL실습 idx3

CREATE TABLE EMP_TEST3 AS
SELECT * 
FROM EMP
WHERE 1 = 1;

SELECT *
FROM emp_test3;
--------------------------------------------
--1
EXPLAIN PLAN FOR
SELECT *
FROM emp_test3
WHERE empno = 7369;

SELECT *
FROM TABLE(dbms_xplan.display);
--2
EXPLAIN PLAN FOR
SELECT *
FROM emp_test3
WHERE ename = 'SMITH';

SELECT *
FROM TABLE(dbms_xplan.display);
--3
EXPLAIN PLAN FOR
SELECT *
FROM emp_test3, dept
WHERE emp_test3.deptno = dept.deptno
AND emp_test3.deptno = 20
AND emp_test3.empno LIKE 7369 || '%';

SELECT *
FROM TABLE(dbms_xplan.display);
--4
EXPLAIN PLAN FOR
SELECT *
FROM emp_test3
WHERE sal BETWEEN :st_sal AND :ed_sal
AND deptno = 20;

SELECT *
FROM TABLE(dbms_xplan.display);
--5
EXPLAIN PLAN FOR
SELECT B.*
FROM emp_test3 A, emp_test3 B
WHERE A.mgr = B.empno
AND A.deptno = 30;

SELECT *
FROM TABLE(dbms_xplan.display);
--6
EXPLAIN PLAN FOR
SELECT deptno, TO_CHAR(hiredate, 'yyyymm'),
       COUNT(*) cnt
FROM emp_test3
GROUP BY deptno, TO_CHAR(hiredate, 'yyyymm');

SELECT *
FROM TABLE(dbms_xplan.display);

--CREATE INDEX idx_n_emp_test3_00 ON emp_test3 (mgr);

CREATE INDEX idx_n_emp_test3_01 ON emp_test3 (empno);
CREATE INDEX idx_n_emp_test3_02 ON emp_test3 (ename);
--2번 추가버전 
--CREATE INDEX idx_n_emp_test3_02_01 ON emp_test3 (empno,ename);

CREATE INDEX idx_n_emp_test3_03 ON emp_test3 (deptno, empno);
--CREATE INDEX idx_n_emp_test3_04 ON emp_test3 (sal, deptno);
--4번 추가버전
--CREATE INDEX idx_n_emp_test3_04_01 ON emp_test3 (deptno);

--CREATE INDEX idx_n_emp_test3_05 ON emp_test3 (empno, deptno);
--CREATE INDEX idx_n_emp_test3_06 ON emp_test3 (deptno);

--CREATE INDEX idx_n_emp_test3_07 ON emp_test3 (hiredate);
--CREATE INDEX idx_n_emp_test3_08 ON emp_test3 (mgr, deptno);
--CREATE INDEX idx_n_emp_test3_09 ON emp_test3 (mgr, empno, deptno);
--CREATE INDEX idx_n_emp_test3_10 ON emp_test3 (deptno, hiredate);

--DROP INDEX idx_n_emp_test3_00;
DROP INDEX idx_n_emp_test3_01;
DROP INDEX idx_n_emp_test3_02;
--2번 추가버전 
--DROP INDEX idx_n_emp_test3_02_01;
DROP INDEX idx_n_emp_test3_03;
--DROP INDEX idx_n_emp_test3_04;
--4번 추가 버전
--DROP INDEX idx_n_emp_test3_04_01;
--DROP INDEX idx_n_emp_test3_05;
--DROP INDEX idx_n_emp_test3_06;
--DROP INDEX idx_n_emp_test3_07;
--DROP INDEX idx_n_emp_test3_08;
--DROP INDEX idx_n_emp_test3_09;
--DROP INDEX idx_n_emp_test3_10;


--답!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
access pattern
--1
empno (=)
--2
enmae (=)
--3
deptno(=), empno(LIKE 직원번호%)
--4
deptno(=),sal(BETWEEN)
--5
deptno(=)/ mgr 동반하면 유리,
empno(=)
--6
deptno, hiredate가 인덱스에 존재하면 유리

access pattern 분석 2
empno (=)
ename (=)
--대체할 수 없음

deptno(=), empno(LIKE 직원번호%) 
        ==> empno, deptno 으로 선택 가능, 그럴시 empno 삭제
deptno(=),sal(BETWEEN)                 (deptno,sal)
deptno(=)/ mgr 동반하면 유리,            (deptno,mgr)
deptno, hiredate가 인덱스에 존재하면 유리 (deptno, hiredate)
        ==> deptno, sal, mgr, hiredate




