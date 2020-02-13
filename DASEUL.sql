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


DDL(index 실습 idx4)
SELECT *
FROM emp;
SELECT *
FROM dept;


--1
EXPLAIN PLAN FOR
SELECT *
FROM emp_test3
WHERE empno = :empno;

SELECT *
FROM TABLE(dbms_xplan.display);

empno(=)
--2
EXPLAIN PLAN FOR
SELECT *
FROM dept_test3
WHERE deptno = :deptno;

SELECT *
FROM TABLE(dbms_xplan.display);

deptno(=)

--3
EXPLAIN PLAN FOR
SELECT *
FROM emp_test3, dept_test3
WHERE emp_test3.deptno = dept_test3.deptno
AND emp_test3.deptno = :deptno
AND emp_test3.deptno LIKE :deptno || '%';

SELECT *
FROM TABLE(dbms_xplan.display);
deptno(=)
deptno(LIKE 직원번호 %)

--4
EXPLAIN PLAN FOR
SELECT *
FROM emp_test3
WHERE sal BETWEEN :st_sal AND :ed_sal
AND deptno = :deptno;

SELECT *
FROM TABLE(dbms_xplan.display);

deptno(=)
sal(BETWEEN)

--5
EXPLAIN PLAN FOR
SELECT *
FROM emp_test3, dept_test3
WHERE emp_test3.deptno = dept_test3.deptno
AND emp_test3.deptno = :deptno
AND dept_test3.loc = :loc;

SELECT *
FROM TABLE(dbms_xplan.display);

deptno(=)
loc(=)

------------------------------

--1
table : emp
empno(=)
--2
table : dept
deptno(=)
--3
table : emp, dept
deptno(=)
deptno(LIKE 직원번호 %)
--4
table : emp
deptno(=)
sal(BETWEEN)
--5
table : emp, dept
deptno(=)
dept.loc(=)

--> 
empno
deptno,sal,loc

CREATE INDEX idx_n_emp_test3_01 ON emp_test3 (empno); --1,
CREATE INDEX idx_n_dept_test3_02 ON dept_test3 (deptno); --2,3,5
CREATE INDEX idx_n_emp_test3_03 ON emp_test3 (deptno); --3,4,5
--CREATE INDEX idx_n_dept_test3_04 ON dept_test3 (loc); 



DROP INDEX idx_n_emp_test3_01;
DROP INDEX idx_n_dept_test3_01;
DROP INDEX idx_n_emp_test3_02;
DROP INDEX idx_n_dept_test3_02;


CREATE TABLE DEPT_TEST3 AS
SELECT * 
FROM DEPT
WHERE 1 = 1;
