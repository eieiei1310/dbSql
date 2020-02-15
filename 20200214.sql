------------------------------------������
(�ǽ� GROUP_AD2-1); ����� : 2�� decode, case
DECODE (���� (����X);


SELECT DECODE(GROUPING(job) || GROUPING(deptno) , '11', '��',
                                                  '00', job,
                                                  '01', job) job,
       DECODE(GROUPING(job) || GROUPING(deptno) , '11','��',
                                                  '00', deptno,
                                                  '01','�Ұ�')deptno,
        SUM(sal + NVL(comm,0)) sal
        
FROM emp
GROUP BY ROLLUP (job, deptno);


----------------------------
����;
MERGE : SELECT �ϰ� ���� �����Ͱ� ��ȸ�Ǹ� UPDATE
        SELECT �ϰ� ���� �����Ͱ� ��ȸ���� ������ INSERT
        
SELECT + UPDATE / SELECT + INSERT ==> MERGE;

REPORT GROUP FUNCTION
1. ROLLUP
    -GROUP BY ROLLUP (�÷�1, �÷�2)
    -ROLLUP ���� ����� �÷��� �����ʿ��� �ϳ��� ������ �÷����� SUBGROUP
    -GROUP BY �÷�1, �÷�2
     UNION
     GROUP BY �÷�1
     UNION
     GROUP BY
2. CUBE
3. GROUPING SETS;

GROUP_AD3

SELECT deptno, job, SUM(sal + NVL(comm,0)) sal
FROM emp
GROUP BY ROLLUP (deptno, job);

--�������� �ٸ� ������ε� Ǯ���� �� :
SELECT a.deptno, a.job, a.c
FROM
(SELECT deptno, job , SUM(sal + NVL(comm, 0)) c
 FROM emp 
 GROUP BY ROLLUP (deptno, job)) a, dept b
WHERE a.deptno = b.deptno(+);      
--->���̺��� �������� �� ���ο� �����ϴ��� ������� ������ �ϴ� ����-> outer ����


GROUP_AD4

SELECT dname, job , SUM(sal + NVL(comm, 0)) sal
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
GROUP BY ROLLUP (dname, job)
ORDER BY dname, job DESC;      


GROUP_AD5
--1 CASE ��
SELECT  CASE 
            WHEN(GROUPING (dname) = 1) AND (GROUPING (job) = 1)
            THEN '����'
            ELSE dname
        END dname,
       job, 
       SUM(sal + NVL(comm, 0)) sal
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
GROUP BY ROLLUP (dname, job)
ORDER BY dname, job DESC;

--1 CASE �� �Ұ赵 �־��.

SELECT  CASE 
            WHEN(GROUPING (dname) = 1) AND (GROUPING (job) = 1)
            THEN '����'
            ELSE dname
        END dname,
        CASE 
            WHEN(GROUPING (dname) = 0) AND (GROUPING (job) = 1)
            THEN '�Ұ�'
            WHEN(GROUPING (dname) = 1) AND (GROUPING (job) = 1)
            THEN '��'
            ELSE job
        END job,
       SUM(sal + NVL(comm, 0)) sal
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
GROUP BY ROLLUP (dname, job)
ORDER BY dname, job DESC;

--2 DECODE ��

SELECT DECODE(GROUPING(dname) || GROUPING(job) , '11', '����',
                                                  '00', dname,
                                                  '01', dname) dname,
       job, 
       SUM(sal + NVL(comm, 0)) sal
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
GROUP BY ROLLUP (dname, job)
ORDER BY dname, job DESC;


--2 DECODE �� �Ұ赵 �־� ����

SELECT DECODE(GROUPING(dname) || GROUPING(job) , '11', '����',
                                                  '00', dname,
                                                  '01', dname) dname,
       DECODE(GROUPING(dname) || GROUPING(job) , '11', '��',
                                                  '00', job,
                                                  '01', '�Ұ�') job, 
       SUM(sal + NVL(comm, 0)) sal
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
GROUP BY ROLLUP (dname, job)
ORDER BY dname, job DESC;


REPORT GROUP FUNCTION
1. ROLLUP
2. CUB
3. GROUPING SETS

Ȱ�뵵:
3,1 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>CUBE;


GROUPING SETS
������ ������� ����׷��� ����ڰ� ���� ����
����� : GROUP BY GROUPING SETS(co1, col2...)
GROUP BY GROUPING SETS(co1, col2)
==>
GROUP BY col1
UNION ALL
GROUP BY col2

GROUP BY GROUPING SETS((co1, col2), col3, col4)
==>
GROUP BY co1, col2
UNION ALL
GROUP BY col3
UNION ALL
GROUP BY col4


GROUP BY GROUPING SETS(co1, col2)
GROUP BY GROUPING SETS(co2, col1)
==> ������ �ٲ� ���� ����. GROUPING SETS�� ��� �÷� ��� ������ ������ ��ġ�� �ʴ´�.
    ROLLUP�� �÷� ��� ������ ����� ������ ��ģ��.




SELECT job, deptno, SUM(sal) sal
FROM emp
GROUP BY GROUPING SETS(job, deptno);

GROUP BY GROUPING SETS(job, deptno)
==>
GROUP BY  job
UNION ALL
GROUP BY deptno;

--UNION ALL�� �ϴ��� UNION�� �ϴ��� ��� �Ƴ���?
SELECT job, SUM(sal) sal
FROM emp
GROUP BY GROUPING SETS(job, job);
--> ���� �ɷ� �ؼ� ����� ������......�ٽ� Ȯ���غ��� �ҵ� ���� �� ����


job, deptno �� GROUP BY �� �����
mgr �� GROUP BY �� ����� ��ȸ�ϴ� SQL�� GROUPING SETS�� �޿��� SUM(sal)�ۼ�;


SELECT job, deptno, mgr , SUM(sal) sal
FROM emp
GROUP BY GROUPING SETS((job, deptno),mgr );


CUBE
������ ��� �������� �÷��� ������ SUB GROUP �� �����Ѵ�.
�� ����� �÷��� ������ ��Ų��.

EX : GROUP BY CUBE (col1, col2);

(col1, col2) == > 
(null, col2) == GROUP BY col2
(null, null) == GROUP BY ��ü
(col1, null) == GROUP BY col1
(col1, col2) == GROUP BY col1, col2;

���� �÷� 3���� CUBE ���� ����� ���, ���� �� �ִ� ��������??
8����

SELECT job, deptno, SUM(sal) sal
FROM emp
GROUP BY CUBE(job, deptno);



ȥ��-------------------------------------------


SELECT job, deptno, SUM(sal) sal
FROM emp
GROUP BY job , ROLLUP(deptno), CUBE(mgr);


GROUP BY job, deptno, mgr = GROUP BY job, deptno, mgr
GROUP BY job, deptno = GROUP BY job, deptno
GROUP BY job, null, mgr = GROUP BY job, mgr
GROUP BY job, null, null = GROUP BY job


�������� UPDATE
1. emp_test ���̺��� drop
2. emp ���̺��� �̿��ؼ� emp_test ���̺� ����(��� �࿡ ���� ctas)
3. emp_test ���̺� dname VARCHAR2(14)�÷� �߰�
4. emp_test.dname �÷��� dept ���̺��� �̿��ؼ� �μ����� ������Ʈ;

DROP TABLE emp_test;

CREATE TABLE emp_test AS
SELECT *
FROM emp;

ALTER TABLE emp_test ADD (dname VARCHAR2(14));

SELECT * 
FROM emp_test;

UPDATE emp_test SET dname = (SELECT dname
                             FROM dept
                             WHERE dept.deptno = emp_test.deptno);
SELECT * 
FROM emp_test;

COMMIT;

�������� �ǽ� sub_a1;

DROP TABLE dept_test;

CREATE TABLE dept_test AS
SELECT *
FROM dept;

ALTER TABLE dept_test ADD (empcnt NUMBER);

SELECT *
FROM dept_test;

UPDATE dept_test SET empcnt = 0; --���� �̷��� �Ѵٸ�?

SELECT deptno, COUNT(*) cmt
FROM emp
GROUP BY deptno;


--����(Ʋ����)--
UPDATE dept_test SET empcnt = (SELECT COUNT(dept.deptno)
                               FROM dept LEFT OUTER JOIN emp ON (dept.deptno = emp.deptno)
                               GROUP BY dept.deptno);


--������ Ǯ��

UPDATE dept_test SET empcnt = NVL((SELECT COUNT(*) cnt
                                FROM emp
                                WHERE deptno = dept_test.deptno
                                GROUP BY deptno),0);
                                
SELECT *
FROM dept_test;  


�ǽ�sub_a2;

dept_test ���̺� �ִ� �μ� �߿� ������ ������ ���� �μ� ������ ����
*dept_test.empcnt �÷��� ������� �ʰ�
emp ���̺��� �̿��Ͽ� ����;

INSERT INTO dept_test VALUES (99,'it1','daejeon',0);
INSERT INTO dept_test VALUES (99,'it2','daejeon',0);
COMMIT;


SELECT *
FROM dept_test;

-->(�� Ǯ��, Ʋ����) ������ ������ ���� �μ��� ��ȣ
SELECT d.deptno
FROM emp e RIGHT OUTER JOIN dept d ON (e.deptno = d.deptno) 
WHERE e.deptno IS NULL ;

DELETE dept_test
WHERE(SELECT d.deptno
        FROM emp e RIGHT OUTER JOIN dept d ON (e.deptno = d.deptno) 
        WHERE e.deptno IS NULL );
------------------------������ Ǯ��
������ ������ ���� �μ� ���� ��ȸ?
���� �ִ� ����?
10�� �μ��� ������ �ִ� ����?

SELECT COUNT(*)
FROM emp
WHERE deptno = 40;

SELECT *
FROM dept_test
WHERE 0 = (SELECT COUNT(*)
           FROM emp
           WHERE deptno = dept_test.deptno);


DELETE dept_test
WHERE 0 = (SELECT COUNT(*)
           FROM emp
           WHERE deptno = dept_test.deptno);
           
SELECT *
FROM dept_test;

-----------------------�ǽ� sub_a3-------------

������ ���� �μ��� ��� �޿����� �޿��ڰ� ���� ������ �޿� <<�� ���� ���� ��.

UPDATE emp_test a SET sal = sal + 200
WHERE sal > (SELECT AVG(sal)
             FROM emp_test b
             WHERE a.deptno = b.deptno);
             
SELECT *
FROM emp_test;             
ROLLBACK;

---------------------------------
WITH ��
�ϳ��� �������� �ݺ��Ǵ� SUBQUERY�� ���� ��
�ش� SUBQUERY�� ������ �����Ͽ� ����
MAIN ������ ����� �� WITH ������ ���� ���� �޸𸮿� �ӽ������� ����
==>MAIN ������ ����Ǹ� �޸� ����

SUBQUERY �ۼ��ÿ��� �ش� SUBQUERY�� ����� ��ȸ�ϱ� ���ؼ� I/O �ݺ������� �Ͼ����
WTIH���� ���� �����ϸ� �ѹ��� SUBQUERY�� ����ǰ� �� ����� �޸𸮿� ������ ���� �� ��� �Ѵ�.
��, �ϳ��� �������� ������ SUBQUERY�� �ݺ������� ������ ���� �߸� �ۼ��� SQL�� Ȯ���� ����.

WITH ��������̸� AS (
    ��������
)

SELECT *
FROM ��������̸�;

������ �μ��� �޿� ����� ��ȸ�ϴ� ��������� WITH���� ���� ����;

WITH sal_avg_dept AS (
    SELECT deptno, ROUND(AVG(sal),2) sal
    FROM emp
    GROUP BY deptno
),
    dept_empcnt AS (
    SELECT deptno, COUNT(*) empcnt
    FROM emp
    GROUP BY deptno )

SELECT *
FROM sal_avg_dept a, dept_empcnt b
WHERE a.deptno = b.deptno; 


inline view �� with���� ������:
���ڴ� �ѹ� �÷� ������ �����͸� �ѹ��� �Ӥ����´�.
���ڴ� ���� ������ �� �� �о�� �Ѵ�.


WITH ���� �̿��� �׽�Ʈ ���̺� �ۼ�;
WITH temp AS (
    SELECT sysdate - 1 FROM dual UNION ALL
    SELECT sysdate - 2 FROM dual UNION ALL
    SELECT sysdate - 3 FROM dual)
SELECT *
FROM temp;


--> �̰� �ζ��� ��� �����

SELECT *
FROM (SELECT sysdate - 1 FROM dual UNION ALL
     SELECT sysdate - 2 FROM dual UNION ALL
        SELECT sysdate - 3 FROM dual);
�� �ؾ� �ϴµ� �׷� �ʹ� ��� ��������... �׷��� WITH ���� ����.


�޷¸����;
CONNECT BY LEVEL <[=] ����
�ش� ���̺��� ���� ������ŭ �����ϰ�, ������ ���� �����ϱ� ���ؼ� LEVEL�� �ο�
LEVEL�� 1���� ����;

SELECT dummy, LEVEL
FROM dual
CONNECT BY LEVEL <= 10;

SELECT dept.*, LEVEL
FROM dept
CONNECT BY LEVEL <= 5;

�Ϲ������δ� dual ���̺��� �մϴ�.;

2020�� 2���� �޷��� ����
:dt = 202002, 202003
1. 
�޷�
�� �� ȭ �� �� �� ��

SELECT TO_DATE('202002','YYYYMM') + (LEVEL -1) "��¥",
     TO_CHAR ((TO_DATE('202002','YYYYMM') + (LEVEL -1)),'D') "����",
     DECODE (TO_CHAR ((TO_DATE('202002','YYYYMM') + (LEVEL -1)),'D'),
             1, TO_DATE('202002','YYYYMM') +  (LEVEL -1)) s,
     DECODE (TO_CHAR ((TO_DATE('202002','YYYYMM') + (LEVEL -1)),'D'),
             2, TO_DATE('202002','YYYYMM') +  (LEVEL -1)) m,
     DECODE (TO_CHAR ((TO_DATE('202002','YYYYMM') + (LEVEL -1)),'D'),
             3, TO_DATE('202002','YYYYMM') +  (LEVEL -1)) t,
     DECODE (TO_CHAR ((TO_DATE('202002','YYYYMM') + (LEVEL -1)),'D'),
             4, TO_DATE('202002','YYYYMM') +  (LEVEL -1)) s,
     DECODE (TO_CHAR ((TO_DATE('202002','YYYYMM') + (LEVEL -1)),'D'),
             5, TO_DATE('202002','YYYYMM') +  (LEVEL -1)) t2,
     DECODE (TO_CHAR ((TO_DATE('202002','YYYYMM') + (LEVEL -1)),'D'),
             6, TO_DATE('202002','YYYYMM') +  (LEVEL -1)) f,
     DECODE (TO_CHAR ((TO_DATE('202002','YYYYMM') + (LEVEL -1)),'D'),
             7, TO_DATE('202002','YYYYMM') +  (LEVEL -1)) s2        
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('202002','YYYYMM')),'DD');

-->���� ������ ��¥�� �ҷ����� ����
SELECT TO_CHAR(LAST_DAY(TO_DATE('202002','YYYYMM')),'DD')
FROM dual;


