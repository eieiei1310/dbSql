synonym : ���Ǿ�
1. ��ü ��Ī�� �ο�
    ==> �̸��� �����ϰ� ǥ��
    
sem ����ڰ� �ڽ��� ���̺� emp ���̺��� ����ؼ� ���� v_emp view
hr ����ڰ� ����� �� �ְԲ� ������ �ο�

v_emp : �ΰ��� ���� sal, comm�� ������ view;

hr ����� v_emp�� ����ϱ� ���� ������ ���� �ۼ�

SELECT *
FROM sem.v_emp;

hr��������
synonym sem.v_emp == > v_emp
v_emp == sem.v_emp

SELECT *
FROM v_emp;

1. sem �������� v_emp�� hr �������� ��ȸ�� �� �ֵ��� ��ȸ���� �ο�;

GRANT SELECT ON v_emp TO hr;

2. hr ���� v_emp ��ȸ�ϴ� �� ���� (���� 1 ������ �޾ұ� ������)
    ���� �ش� ��ü�� �����ڸ� ��� : sem.v_emp
    �����ϰ� sem.v_emp ==> v_emp ����ϰ� ���� ��Ȳ
    synonym ����
    
CREATE SYNONYM �ó�� �̸� FOR �� ��ü��;

------------------------------------hr �������� �۾��� ����-----------
SELECT *
FROM DASEUL.v_emp;

SELECT *
FROM v_emp;

CREATE SYNONYM v_emp FOR DASEUL.v_emp;

SELECT *
FROM v_emp;
--> ���� ����� ���� �ο����� �ʾƵ� �� ���´�.


-------------------------------------------------------------------
SYNONYM ����
DROP SYNONYM �ó�� �̸�;


GRANT CONNECT TO DASEUL;
GRANT SELECT ON ��ü�� TO HR;

���� ����
1. �ý��� ���� : TABLE�� ����, VIEW ���� ����...
2. ��ü ���� : Ư�� ��ü�� ���� SELECT, UPDATE, INSERT, DELETE...

ROLE : ������ ��Ƴ��� ����
����ں��� ���� ������ �ο��ϰ� �Ǹ� ������ �δ�.
Ư�� ROLE �� ������ �ο��ϰ� �ش� ROLE ����ڿ��� �ο�
�ش� ROLE �� �����ϰ� �Ǹ� ROLE �� ���� �ִ� ��� ����ڿ��� ����

���� �ο�/ ȸ��
�ý��� ���� : GRANT ���� �̸� TO ����� | ROLE;
            REVOKE �����̸� FROM ����� | ROLE;
��ü ���� : GRANT �����̸� ON ��ü�� TO ����� | ROLE;
            REVOKE �����̸� ON ��ü�� FROM ����� | ROLE;
            
            
----------------------

date dictionary: ����ڰ� �������� �ʰ�, dbms �� ��ü������ �����ϴ�
                 �ý��� ������ ���� view;
                 
date dictionary ���ξ�
1. USER : �ش� ����ڰ� ������ ��ü
2. ALL : �ش� ����ڰ� ������ ��ü + �ٸ� ����ڷκ��� ������ �ο����� ��ü
3. DBA : ��� ������� ��ü

* V$ Ư�� VIEW;

SELECT *
FROM USER_TABLES;(���⿡ USER-> �̺κ��� ���ξ�);

SELECT *
FROM ALL_TABLES;

SELECT *
FROM DBA_TABLES; --> �Ϲ� ����ڴ� �� �� ����.

dictionary ���� Ȯ�� : SYS.DICTIONARY;

SELECT *
FROM DICTIONARY;

SELECT *
FROM USER_OBJECTS;
--> OBJECT_TYPE ���� ���� � ��ü���� �� �� �ִ�. �ַ� TABLE, INDEX

��ǥ���� dictionary
OBJECTS : ��ü ���� ��ȸ (���̺�, �ε���, VIEW, SYNONYM ...)
TABLES : ���̺� ������ ��ȸ
TAB_COLUMNS : ���̺��� �÷� ���� ��ȸ
INDEXES : �ε��� ���� ��ȸ         --�߿�
IND_COLUMNS : �ε��� ���� �÷� ��ȸ --�߿�
CONSTRAINTS : �������� ��ȸ
CONS_COLUMNS : �������� ���� �÷� ��ȸ
TAB_COMMENTS : ���̺� �ּ�       --�߿�
COL_COMMENTS : ���̺��� �÷� �ּ� --�߿�
;


---------DICTIONARY �ǽ�------------------

emp, dept ���̺��� �ε����� �ε��� �÷� ���� ��ȸ;
USER_INDEXES, USER_IND_COLUMNS JOIN
���̺��, �ε��� ��, �÷���
emp  ind_n_emp_04  ename
emp  ind_n_emp_04  job

SELECT *
FROM USER_INDEXES;

SELECT table_name, index_name, column_name
FROM USER_IND_COLUMNS
ORDER BY table_name, index_name, column_position;

--------------------------------------- �⺻���� SQL Ȱ�� �� -----------------------------

multiple insert : �ϳ��� insert �������� ���� ���̺� �����͸� �Է��ϴ� DML

SELECT *
FROM dept_test;


SELECT *
FROM dept_test2;

������ ���� ���� ���̺� ���� �Է��ϴ� multiple insert;
INSERT ALL
    INTO dept_test
    INTO dept_test2
SELECT 98, '���', '�߾ӷ�' FROM dual UNION ALL 
SELECT 97, 'IT','����' FROM dual;


���̺� �Է��� �÷��� �����Ͽ� multiple insert;
ROLLBACK;
INSERT ALL
    INTO dept_test (deptno, loc) VALUES (deptno, loc) -->���� 2���� �ְڴ�.
    INTO dept_test2 -->���� ��� �ְڴ�. 
SELECT 98 deptno , '���' dname , '�߾ӷ�' loc FROM dual UNION ALL  -->�÷����� ù��° ���� as�� ����.
SELECT 97, 'IT','����' FROM dual;

��� : dept_test ���� dname �� �� ����.
      dept_test2 ���� ��� ���� ����. 


���̺� �Է��� �����͸� ���ǿ� ���� multiple insert
CASE --�� ����
    WHEN ���� ��� THEN 
END;

ROLLBACK;
INSERT ALL
    WHEN deptno = 98 THEN 
         INTO dept_test (deptno, loc) VALUES (deptno, loc) -->���� 2���� �ְڴ�.
    ELSE 
         INTO dept_test2
SELECT 98 deptno , '���' dname , '�߾ӷ�' loc FROM dual UNION ALL  -->�÷����� ù��° ���� as�� ����.
SELECT 97, 'IT','����' FROM dual;

SELECT *
FROM dept_test;


SELECT *
FROM dept_test2;

ROLLBACK;
INSERT ALL
    WHEN deptno = 98 THEN 
         INTO dept_test (deptno, loc) VALUES (deptno, loc)
         INTO dept_test2 --> INTO �� �ΰ� ���� �͵� ����
    ELSE 
         INTO dept_test2
SELECT 98 deptno , '���' dname , '�߾ӷ�' loc FROM dual UNION ALL  -->�÷����� ù��° ���� as�� ����.
SELECT 97, 'IT','����' FROM dual;

SELECT *
FROM dept_test;


SELECT *
FROM dept_test2;



 ������ �����ϴ� ù��° insert �� �����ϴ� multiple insert

ROLLBACK;
INSERT FIRST --> ������ �����ϴ� ù��°���� �Է��� �Ѵ�. 
    WHEN deptno >= 98 THEN 
         INTO dept_test (deptno, loc) VALUES (deptno, loc)
    WHEN deptno >= 97 THEN 
         INTO dept_test2
    ELSE 
        INTO dept_test2
SELECT 98 deptno , '���' dname , '�߾ӷ�' loc FROM dual UNION ALL  -->�÷����� ù��° ���� as�� ����.
SELECT 97, 'IT','����' FROM dual;

SELECT *
FROM dept_test;


SELECT *
FROM dept_test2;

����Ŭ ��ü : ���̺� ���� ���� ������ ��Ƽ������ ����
���̺� �̸��� �����ϳ� ���� ������ ���� ����Ŭ ���������� ������
�и��� ������ �����͸� ����;
 
dept_test == > dept_test_20200201 �̷�������...
--�ܺ������δ� ��ȭ�� ������ ���������� �и��Ѵ�.
--��ƼŬ�� ������. �츮�� ���� �� ����� ����

 --���࿡ SKó�� ���ڿ� ���� ��� �����Ͱ� �þ�� ���̶��...
ROLLBACK;
INSERT FIRST --> ������ �����ϴ� ù��°���� �Է��� �Ѵ�. 
    WHEN deptno >= 98 THEN 
         INTO dept_test_2020020 --< ���� �̷��� ���̺���� �ٲ� �ʿ䰡 ����. 
    WHEN deptno >= 97 THEN 
         INTO dept_test_2020021
    ELSE 
        INTO dept_test_2020022
        --....
        
SELECT 98 deptno , '���' dname , '�߾ӷ�' loc FROM dual UNION ALL  -->�÷����� ù��° ���� as�� ����.
SELECT 97, 'IT','����' FROM dual;


-------------------------------------


MERGE : ����
���̺� �����͸� �Է�/���� �Ϸ��� ��.
1. ���� �Է��Ϸ��� �ϴ� �����Ͱ� �����ϸ� 
    ==> ������Ʈ
2. ���� �Է��Ϸ��� �ϴ� �����Ͱ� �������� ������
    ==> INSERT
    

1. SELECT ����
2-1. SELECT ���� ����� 0 ROW �̸� INSERT
2-2. SELECT ���� ����� 1 ROW �̸� UPDATE

MERGE ������ ����ϰ� �Ǹ� SELECT �� ���� �ʾƵ� �ڵ����� ������ ������ ����
INSERT Ȥ�� UPDATE �� �����Ѵ�.

2���� ������ 1������ �ٿ� �ش�. --> MERGE

MERGE INTO ���̺�� [alias ] -->�Ϲ������� AS�� ��.
USING (TABLE | VIEW | IN-LINE-VIEW )
ON (��������)
WHEN MATCHED THEN 
    UPDATE SET col1 = �÷���, col2 = �÷���....
WHEN NOT MATCHED THEN
    INSERT (�÷�1, �÷�2, �÷�3....)VALUES (�÷���1, �÷���2....);
    
SELECT *
FROM emp_test;
SELECT *
FROM emp;
--�ϴ� emp_test ���� �����ϱ�

DELETE emp_test;
�α׸� �� ����� ==> ������ �ȵȴ� ==> �׽�Ʈ������...
TRUNCATE TABLE emp_test;

emp ���̺��� emp_test���̺�� �����͸� ���� (7369 -SMITH);

INSERT INTO emp_test
SELECT empno, ename, deptno, '010'
FROM emp
WHERE empno = 7369;

�����Ͱ� �� �ԷµǾ����� Ȯ���Ѵ�. 
SELECT *
FROM emp_test;

UPDATE emp_test SET ename = 'brown'
WHERE empno = 7369;

COMMIT;

emp ���̺��� ��� ������ emp_test ���̺�� ����
emp ���̺��� ���������� emp_test ���� �������� ������ insert
emp ���̺��� �����ϰ� emp_test ���� �����ϸ� ename, deptno �� update;

emp ���̺� �����ϴ� 14���� ������ �� emp_test ���� �����ϴ� 7369�� ������ 13���� �����Ͱ�
emp_test ���̺� �űԷ� �Է��� �ǰ�
emp_test�� �����ϴ� 7369���� �����ʹ� ename(brown)�� emp ���̺� �����ϴ� �̸��� SMITH�� ����

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

�ش� ���̺� �����Ͱ� ������ insert, ������ update
emp_test ���̺� ����� 9999���� ����� ������ ���Ӱ� insert
������ update
(9999, 'brown',10, '010')


INSERT INTO dept_test VALUES (9999, 'brown',10, '010');
UPDATE dept_test SET ename = 'brown'
                     deptno = 10
                    hp = '010'
WHERE empno = 9999;
--> �̰� �ΰ��� ���ÿ� �ϴ� �� merge

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
--> ����� 9999�� �ڷᰡ �����Ƿ� insert�� �ȴ�. 

MERGE INTO emp_test
USING dual 
ON (empno = 9999)
WHEN MATCHED THEN 
    UPDATE SET ename = ename || '_u',
               deptno = 10,
               hp = '010'
WHEN NOT MATCHED THEN 
    INSERT VALUES (9999, 'brown', 10, '010');

--> ����� 9999�� �ڷᰡ �����Ƿ� update �� �ȴ�. 

SELECT *
FROM emp_test;

------------------------

--�ǽ� GROUP_AD1

----�� �� (����)
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


-------------�������� ��
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
����� : GROUP BY ROLLUP (�÷�1, �÷�2...)
SUBGROUP�� �ڵ������� ����
SUBGROUP�� �����ϴ� ��Ģ : ROLLUP�� ����� �÷��� [������]�������� �ϳ��� �����ϸ鼭
                         SUB GROUP �� ����;
EX : GROUP BY ROLLUP (deptno)
==> 
ù��° sub group : GROUP BY deptno
�ι�° sub group : GROUP BY NULL ==> ��ü ���� ���

GROUP_AD1�� GROUP BY ROLLUP ���� ����Ͽ� �ۼ�;

SELECT deptno, SUM(sal)
FROM emp
GROUP BY ROLLUP (deptno);

SELECT job, deptno, 
        GROUPING(job), GROUPING(deptno), --> GROUPING? : 
        SUM(sal + NVL(comm, 0)) sal
FROM emp
GROUP BY ROLLUP (job, deptno);

-->������ ����
1. GROUP BY job, deptno :��� ���� �μ��� �޿���
2. GROUP BY job : �������� �޿���
3. GROUP BY :��ü �޿���

--�ǽ� GROUP_AD2

SELECT job, deptno, 
        SUM(sal + NVL(comm, 0)) sal
FROM emp
GROUP BY ROLLUP (job, deptno);

--����(Ʋ����)
SELECT NVL(job,'�Ѱ�') JOB,
       deptno, 
       SUM(sal + NVL(comm, 0)) sal
FROM emp
GROUP BY ROLLUP (job, deptno);

--������ ��

SELECT 
    CASE WHEN GROUPING(job) = 1 AND GROUPING(deptno) = 1 THEN '�Ѱ�'
        else job
        END job,
        deptno, 
        SUM(sal + NVL(comm, 0)) sal
FROM emp
GROUP BY ROLLUP (job, deptno);


--�ٽ� �ǽ� decode�� �ٲ㺸��(����)

SELECT 
    DECODE(GROUPING(job), 1, DECODE(GROUPING(deptno), 1,'�Ѱ�')
                        ,0,job) JOB,
        deptno, 
        SUM(sal + NVL(comm, 0)) sal
FROM emp
GROUP BY ROLLUP (job, deptno);



--�ǽ� GROUP_AD2-1

SELECT 
    CASE WHEN GROUPING(job) = 1 AND GROUPING(deptno) = 1 THEN '��'
        else job
        END job,
        
    CASE WHEN TO_CHAR(GROUPING(job)) = '0' AND TO_CHAR(GROUPING(deptno)) = '1' THEN '�Ұ�'
        WHEN TO_CHAR(GROUPING(job)) = '1' AND  TO_CHAR(GROUPING(deptno)) = '1' THEN '��'
        else TO_CHAR(deptno)
        END deptno, 
        
        SUM(sal + NVL(comm, 0)) sal
FROM emp 
GROUP BY ROLLUP (job, deptno);








--������ ���ö� �޶� ����ϰ� �ٽø���

DROP TABLE emp_test;

CREATE TABLE emp_test(
    empno NUMBER(4),
    ename VARCHAR2(10),
    deptno NUMBER(2),
    hp VARCHAR2(10) DEFAULT '010'
    );
    
    
