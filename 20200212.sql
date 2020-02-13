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
   
-->  access�� idx2 ��, filter�� �Ÿ�

   
   
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
   
--> c�� �����ϴ°��� �ε����� �Ÿ�
--> ppt 88ó�� �����ڸ� �˻��� ��� ���̺��� ��ü �� ���� �Ѵ�.

SELECT job, ename, rowid
FROM emp
ORDER BY job;


1. table full
2. idx2 : empno
3. idx2 : job
4. idx3 : job + ename
5. idx4 : ename + job;

CREATE INDEX idx_n_emp_04 ON emp (ename, job);
--> 4���� ������ ���� ������ �ٸ�-> ����� �ٸ��� ����.
SELECT ename, job, rowid
FROM emp
ORDER BY ename, job;
(�ε����� ���);

3��° �ε����� ������.
3,4��° �ε����� �÷� ������ �����ϰ� ������ �ٸ��Ƿ�, ��Ȯ�� �񱳸� ���� 3�� ����;

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

--����� �� �ִ� ����
emp -table full, pk_emp(empno)
dept - table full, pk_dept(deptno)

--����� �� 
(emp - table full, dept-table full)
(dept-table full, emp - table full)

(emp - table full, dept-pk_dept)
(dept-pk_dept,emp - table full)

(emp - pk_emp, dept - table full)
(dept - table full,emp - pk_emp)

(emp - pk_emp, dept - pk_dept)
(dept - pk_dept, emp - pk_emp)

--> ����Ŭ�� ��� ����� ���� �� ���� �ʴ´�. (������ ���� ���� �� �߿��ϱ� ����)

SELECT ename, dname, loc
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.empno = 7788;

1 ����
2�� ���̺� ����
������ ���̺� �ε��� 5�� �� �ִٸ�
�� ���̺� ���� ���� : 6
36 * 2 = 72


ORACLE - �ǽð� ���� : OLTP (ON LINE TRANSACTION PROCESSING) --�츮�� �ϴ� ��.
         ��ü ó���ð� : OLAP (ON LINE ANALYSIS PROCESSING) - ������ ������ �����ȹ�� ����� �� 
                                                            30M~1H) --������ ���� �ϴ� �ͺ��� ���� �����ϴ� ���� �� �켱��
                                                            
  
emp ���� ������ dept ���� ������?? -> ���� ��ȹ�� �������� �� �� �ִ�.

EXPLAIN PLAN FOR
SELECT ename, dname, loc
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.empno = 7788;
        
SELECT *
FROM TABLE(dbms_xplan.display);

4 - 3 - 5 - 2 - 6 - 1 - 0
--�д¹� �����Ѱ� �ڽ�, �ڽĺ��� �д´�. (���� ���� ����� �κк���)

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
   
   ppt 97 index�� full access ����
   


DDL�ǽ� idx1


CREATE TABLE DEPT_TEST2 AS
SELECT * 
FROM DEPT
WHERE 1 = 1;
--> 1 �� 1�̴ٰ� ������???? -->�÷������� �ƴ� �׳� ������ ����
--> ���̺��� �����ϸ� ���������� ���簡 �� �ǳ���?? -> �ϳ� ���� �� �ȴ�� ����...���� ��m�ٴµ�...����ϰ� ��ﳯ������
--        CTAS
--         �������� ���簡 NOT NULL�� �ȴ�. ����̳�, �׽�Ʈ������;


SELECT *
FROM dept_test2;

--1 deptno �÷����� ����ũ
CREATE UNIQUE INDEX idx_u_dept_test_01 ON dept_test2 (deptno);
--2 dname �÷����� ������ũ
CREATE INDEX idx_n_dept_test_02 ON dept_test2 (dname);
--3 deptno, dname �÷����� ������ũ
CREATE INDEX idx_n_dept_test_03 ON dept_test2 (deptno, dname);


DDL�ǽ� idx2

DROP INDEX idx_u_dept_test_01;
DROP INDEX idx_n_dept_test_02;
DROP INDEX idx_n_dept_test_03;

SELECT *
FROM EMP
WHERE empno = :empno;


DDL�ǽ� idx3

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
--2�� �߰����� 
--CREATE INDEX idx_n_emp_test3_02_01 ON emp_test3 (empno,ename);

CREATE INDEX idx_n_emp_test3_03 ON emp_test3 (deptno, empno);
--CREATE INDEX idx_n_emp_test3_04 ON emp_test3 (sal, deptno);
--4�� �߰�����
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
--2�� �߰����� 
--DROP INDEX idx_n_emp_test3_02_01;
DROP INDEX idx_n_emp_test3_03;
--DROP INDEX idx_n_emp_test3_04;
--4�� �߰� ����
--DROP INDEX idx_n_emp_test3_04_01;
--DROP INDEX idx_n_emp_test3_05;
--DROP INDEX idx_n_emp_test3_06;
--DROP INDEX idx_n_emp_test3_07;
--DROP INDEX idx_n_emp_test3_08;
--DROP INDEX idx_n_emp_test3_09;
--DROP INDEX idx_n_emp_test3_10;


--��!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
access pattern
--1
empno (=)
--2
enmae (=)
--3
deptno(=), empno(LIKE ������ȣ%)
--4
deptno(=),sal(BETWEEN)
--5
deptno(=)/ mgr �����ϸ� ����,
empno(=)
--6
deptno, hiredate�� �ε����� �����ϸ� ����

access pattern �м� 2
empno (=)
ename (=)
--��ü�� �� ����

deptno(=), empno(LIKE ������ȣ%) 
        ==> empno, deptno ���� ���� ����, �׷��� empno ����
deptno(=),sal(BETWEEN)                 (deptno,sal)
deptno(=)/ mgr �����ϸ� ����,            (deptno,mgr)
deptno, hiredate�� �ε����� �����ϸ� ���� (deptno, hiredate)
        ==> deptno, sal, mgr, hiredate




