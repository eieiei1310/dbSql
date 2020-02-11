�������� Ȯ�� ���

1. tool
2. dictionary view

�������� : USER_CONSTRAINTS
�������� -�÷� : USER_CONS_COLUMNS
���������� ��� �÷��� ���õǾ� �ִ��� �� �� ���� ������ ���̺��� ������ �и��Ͽ� ����
1. ������

SELECT *
FROM USER_CONSTRAINTS
WHERE table_name IN ('EMP', 'DEPT', 'EMP_TEST','DEPT_TEST');

EMP, DEPT PK, FK ������ �������� ����

2.EMP : PK(empno)
3.      FK(deptno) - dept.deptno 
        (FK ������ �����ϱ� ���ؼ��� �����ϴ� ���̺� �÷��� �ε����� �����ؾ� �Ѵ�.)
      
1. dept : pk(deptno)


ALTER TABLE dept ADD CONSTRAINT PK_dept PRIMARY KEY (deptno);

ALTER TABLE emp ADD CONSTRAINT PK_emp PRIMARY KEY (empno);

ALTER TABLE emp ADD CONSTRAINT FK_emp_dept FOREIGN KEY (deptno) REFERENCES dept(deptno);

���̺�, �÷� �ּ� : DICTIONARY Ȯ�� ����
���̺� �ּ� : USER_TAB_COMMENTS
�÷� �ּ� : USER_COL_COMMENTS;

�ּ� ����
���̺� �ּ� : COMMENT ON TABLE ���̺�� IS '�ּ�'
�÷� �ּ� : COMMENT ON COLUMN ���̺�.�÷� IS '�ּ�';

emp : ����;
dept : �μ�;

COMMENT ON TABLE emp IS '����';
COMMENT ON TABLE dept IS '�μ�';

SELECT *
FROM USER_TAB_COMMENTS
WHERE TABLE_NAME IN ('EMP','DEPT');


SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME IN ('EMP' , 'DEPT');

DEPT DEPTNO : �μ���ȣ
DEPT DNAME : �μ���
DEPT LOC : �μ���ġ
EMP EMPNO : ������ȣ
EMP ENAME : �����̸�
EMP JOB : ������
EMP MGR : �Ŵ��� ������ȣ
EMP HIREDATE : �Ի����� 
EMP SAL : �޿�
EMP COMM : ������
EMP DEPTNO : �ҼӺμ���ȣ

COMMENT ON COLUMN dept.deptno IS '�μ���ȣ';
COMMENT ON COLUMN dept.dname IS '�μ���';
COMMENT ON COLUMN dept.loc IS '�μ���ġ';
COMMENT ON COLUMN emp.empno IS '������ȣ';
COMMENT ON COLUMN emp.ename IS '�����̸�';
COMMENT ON COLUMN emp.job IS '������';
COMMENT ON COLUMN emp.mgr IS '�Ŵ��� ������ȣ';
COMMENT ON COLUMN emp.hiredate IS '�Ի�����';
COMMENT ON COLUMN emp.sal IS '�޿�';
COMMENT ON COLUMN emp.comm IS '������';
COMMENT ON COLUMN emp.deptno IS '�ҼӺμ���ȣ';

DESC emp;

SELECT *
FROM user_tab_comments;

SELECT *
FROM user_col_comments ;


--����

--ANSI 
SELECT *
FROM user_tab_comments a JOIN user_col_comments b ON (a.table_name = b.table_name)
WHERE a.table_name IN ('CUSTOMER' , 'PRODUCT', 'CYCLE', 'DAILY');

--ORACLE
SELECT *
FROM user_tab_comments a ,user_col_comments b
WHERE a.table_name =  b.table_name
AND a.table_name IN ('CUSTOMER' , 'PRODUCT', 'CYCLE', 'DAILY');

VIEW = QUERY
VIEW �� ���̺��̴� (X) --���� �ƴ�, �� ����;
TABLE ó�� DBMS �� �̸� �ۼ��� ��ü
==> �ۼ����� �ʰ� QUERY���� �ٷ� �ۼ��� VIEW : IN-LINE VIEW ==> �̸��� ���� ������ ��Ȱ���� �Ұ�.

��� ����
1. ���� ����(Ư�� �÷��� �����ϰ� ������ ����� �����ڿ� ����)
2. INLINE - VIEW �� VIEW�� �����Ͽ� ��Ȱ��
    . ���� ���� ����;
    
�������
CREATE [OR REPLACE] VIEW �� ��Ī [(column1, column2 ....) ]AS 
SUBQURY;

emp ���̺��� 8���� �÷� �� sal, comm �÷��� ������ 6�� �÷��� �����ϴ� v_emp VIEW ����;


CREATE OR REPLACE VIEW v_emp AS 
SELECT empno, ename, job, mgr, hiredate, deptno
FROM emp;
--> ����, �ý��� ������ ������ �������־�� ��.

�ý��� �������� DASEUL �������� VIEW �������� �߰�;
GRANT CREATE VIEW TO DASEUL;

CREATE OR REPLACE VIEW v_emp AS 
SELECT empno, ename, job, mgr, hiredate, deptno
FROM emp;
--> �ٽ� �ϸ� �� ��.

���� �ζ��� ��� �ۼ���;
SELECT *
FROM (SELECT empno, ename, job, mgr, hiredate, deptno
      FROM emp );
      
VIEW ��ü Ȱ��;
SELECT *
FROM v_emp;
      
      
emp ���̺��� �μ����� ���� ==> dept ���̺�� ������ ����ϰ� ����
���ε� ����� view �� ���� �� ������ �ڵ带 �����ϰ� �ۼ��ϴ� ���� ����;

VIEW : v_emp_dept
dname(�μ���), ������ȣ(empno), ename(�����̸�), job(������), hiredate(�Ի�����);


CREATE OR REPLACE VIEW v_emp_dept AS
SELECT dept.dname, emp.empno, emp.ename, emp.job, emp.hiredate 
FROM emp, dept
WHERE emp.deptno = dept.deptno;

�ζ��� ��� �ۼ�
SELECT *
FROM (SELECT dept.dname, emp.empno, emp.ename, emp.job, emp.hiredate 
      FROM emp, dept
      WHERE emp.deptno = dept.deptno);
      
VIEW Ȱ���;
SELECT *
FROM v_emp_dept;


SMITH ���� ���� �� v_emp_dept view �� �� ��ȭ�� Ȯ��;
DELETE emp
WHERE ename = 'SMITH';

--PPT 55 ����
--VIEW �� ������.
--�������� �����Ͱ� �ƴϴ�, ������ ������ ���� ����(SQL)
--VIEW �� �����ϴ� ���̺��� �����ϸ� VIEW ���� ������ ��ģ��.

ROLLBACK;
      
SEQUENCE : ������ - �ߺ����� �ʴ� �������� �������ִ� ����Ŭ ��ü
CREATE SEQUENCE ������_�̸�;
[OPTION......]
����Ģ : SEQ_���̺��

emp ���̺��� ����� ������ ����;

CREATE SEQUENCE seq_emp;

������ ���� �Լ�
NEXTVAL : ���������� ���� ���� ������ �� ��� 
CURRVAL : NEXTVAL�� ����ϰ� ���� ���� �о���� ���� ��Ȯ��

SELECT seq_emp.NEXTVAL
FROM dual;


SELECT seq_emp.CURRVAL
FROM dual;

SELECT *
FROM emp_test;

INSERT INTO emp_test VALUES (9999,'brown',99);

INSERT INTO emp_test VALUES (seq_emp.NEXTVAL, 'james',99);

������ ������ 
ROLLBACK �� �ϴ��� NEXTVAL �� ���� ���� ���� �������� �ʴ´�.
NEXTVAL �� ���� ���� �޾ƿ��� �� ���� �ٽ� ����� �� ����.;

INDEX;

SELECT ROWID, emp.*
FROM emp;

SELECT *
FROM emp
WHERE ROWID = 'AAAE5gAAFAAAACLAAH';


�ε����� ���� �� empno ������ ��ȸ�ϴ� ���;
emp ���̺��� PK_emp ���������� �����Ͽ� empno �÷����� �ε����� �������� �ʴ� ȯ���� ����;

ALTER TABLE emp DROP CONSTRAINT PK_emp;

explain plan for
SELECT *
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);


emp ���̺��� empno �÷����� PK ������ �����ϰ� ������ SQL �� ����
PK : UNIQUE + NOT NULL
     (UNIQUE �ε����� �������ش�)
==> empno �÷����� unique �ε����� ������

�ε����� SQL�� �����ϰ� �Ǹ� �ε����� ���� ���� ��� �ٸ� �� �������� Ȯ��;

ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);

SELECT rowid, emp.*
FROM emp;


SELECT empno, rowid
FROM emp
ORDER BY empno;

explain plan for 
SELECT *
FROM emp
WHERE empno = 7792;

SELECT *
FROM TABLE(dbms_xplan.display);

--> PRIMARY KEY �� ���� ��� �ٷ� �ε������� ��ȸ�Ѵ�.

SELECT *
FROM emp
WHERE ename = 'SMITH'; --> �ε����� empno �� �Ǿ� �����Ƿ� �ε����� ����ص� �ſ� ��ȿ�����̴�.

SELECT ��ȸ�÷��� ���̺� ���ٿ� ��ġ�� ����
SELECT * FROM emp WHERE empno = 7782
==>
SELECT empno FROM emp WHRE empno = 7782;

EXPLAIN PLAN FOR 
SELECT empno --> (������ �����ȹ�� ���غ���) ��ü ���̺� ����Ʈ�� �ƴϹǷ� ���� INDEX�� Ȯ���ϰ� ������. 
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);

UNIQUE VS NON-UNIQUE �ε����� ���� Ȯ��;

1. PK_EMP ����
2. empno �÷����� NON-UNIQUE �ε��� ����
3. �����ȹ Ȯ��;

ALTER TABLE emp DROP CONSTRAINT pk_emp;
CREATE INDEX idx_n_emp_01 ON emp (empno);

--> empno ���� ���� �� ������� �� ����. 


EXPLAIN PLAN FOR 
SELECT * 
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);
--> 7782�ٷ� �Ʒ��� �о�� �ƴϸ� ����.

--nonunique index�� �ϳ� �� �ִٸ�?

emp ���̺� job �÷��� �������� �ϴ� ���ο� non-unique �ε����� ����;

CREATE INDEX idx_n_emp_02 ON emp (job);

SELECT job, rowid
FROM emp
ORDER BY job;

���ð����� ����
1. emp ���̺��� ��ü �б�
2. idx_n_emp_01 (empno)�ε��� Ȱ��
2. idx_n_emp_02 (job)�ε��� Ȱ��;
--> ���� ȿ������ ������ ����Ŭ�� ����

SELECT *
FROM emp
WHERE job = 'MANAGER';

EXPLAIN PLAN FOR 
SELECT *
FROM emp
WHERE job = 'MANAGER';

SELECT *
FROM TABLE(dbms_xplan.display);

Plan hash value: 1112338291
 
--------------------------------------------------------------------------------------------
| Id  | Operation                   | Name         | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |              |     3 |   114 |     2   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP          |     3 |   114 |     2   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN          | IDX_N_EMP_02 |     3 |       |     1   (0)| 00:00:01 |
--------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("JOB"='MANAGER')
   
   
   